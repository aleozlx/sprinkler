#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;

use std::collections::HashMap;
use std::thread;
use std::sync::{mpsc, Arc, Mutex};
use futures::future::{self, Either};
use tokio::prelude::*;
mod sprinkler;
use sprinkler::*;

const FNAME_CONFIG: &str = "/etc/sprinkler.conf";

fn setup_logger(verbose: u64) -> Result<(), fern::InitError> {
    fern::Dispatch::new()
        .format(|out, message, record| {
            out.finish(format_args!(
                "{} {} {}",
                chrono::Local::now().format("[%Y-%m-%d %H:%M:%S]"),
                record.level(),
                message
            ))
        })
        .level(match verbose {
            0 => log::LevelFilter::Info,
            1 => log::LevelFilter::Info,
            2 => log::LevelFilter::Debug,
            3 => log::LevelFilter::Trace,
            _ => log::LevelFilter::Trace
        })
        .chain(std::io::stderr())
        .apply()?;
    Ok(())
}

// #[derive(Clone)]
// struct DockerOOM {
//     hostname: String
// }

// impl Sprinkler for DockerOOM {
//     fn activate_master(&self) -> std::thread::JoinHandle<()> {
//         unimplemented!();
//         // new thread
//         // ssh & run docker events
//         // detect oom
//         // lookup pod
//     }

//     fn deactivate(&self) {
//         // stop thread
//     }

//     // fn trigger(&self) {
//     //     // kill pod, kill continer, rm --force
//     // }
// }

/// Basic communication checking, logging connection state changes
#[derive(Clone)]
struct CommCheck {
    _id: usize,
    _hostname: String,
    _deactivate: Arc<Mutex<bool>>
}

impl CommCheck {
    fn new(id: usize, hostname: String) -> Self {
        CommCheck {
            _id: id,
            _hostname: hostname,
            _deactivate: Arc::new(Mutex::new(false))
        }
    }
}

impl Sprinkler for CommCheck {
    fn id(&self) -> usize {
        self._id
    }

    fn hostname(&self) -> &str {
        &self._hostname
    }

    fn activate_master(&self) -> mpsc::Sender<String> {
        let clone = self.clone();
        let (tx, rx) = mpsc::channel();
        thread::spawn(move || {
            let mut state = false;
            loop {
                let state_recv = rx.try_recv().is_ok();
                if state != state_recv {
                    state = state_recv;
                    info!(
                        "sprinkler[{}] (CommCheck) {} => {}",
                        clone.id(), clone.hostname(), if state {"online"} else {"offline"}
                    );
                }
                thread::sleep(std::time::Duration::from_secs(3));
                if *clone._deactivate.lock().unwrap() { break; }
                else { trace!("sprinkler[{}] heartbeat", clone.id()); }
            }
        });
        tx
    }

    fn activate_agent(&self) {
        let clone = self.clone();
        thread::spawn(move || loop {
            let addr = "127.0.0.1:3777";
            if let Ok(mut stream) = std::net::TcpStream::connect(&addr) {
                let buf = SprinklerProto::buffer(&clone, String::from("COMMCHK"));
                if let Err(e) = stream.write_all(&buf) {
                    error!("Failed to send the master thread a message: {}", e);
                    thread::sleep(std::time::Duration::from_secs(20));
                }
            }
            else {
                error!("Connection error.");
                thread::sleep(std::time::Duration::from_secs(20));
            }
            thread::sleep(std::time::Duration::from_secs(3));
        });
    }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }
}

fn main() {
    let args = clap_app!(sprinkler =>
            (version: crate_version!())
            (author: crate_authors!())
            (about: crate_description!())
            (@arg AGENT: --("agent") "Agent mode")
            (@arg VERBOSE: --verbose -v ... "Logging verbosity")
        ).get_matches();
    
    setup_logger(args.occurrences_of("VERBOSE")).expect("Logger Error.");

    // parse FNAME_CONFIG and add triggers
    let triggers = vec![
        // DockerOOM { hostname: String::from("k-prod-cpu-1.dsa.lan") }
        CommCheck::new(0, String::from("latitude-5289")),
        CommCheck::new(1, String::from("localhost"))
    ];

    if args.is_present("AGENT") {
        if let Ok(hostname) = sys_info::hostname() {
            for i in triggers.iter().filter(|&i| i.hostname() == hostname) {
                i.activate_agent();
                info!("sprinkler[{}] activated.", i.id());
            }
            loop { thread::sleep(std::time::Duration::from_secs(300)); }
        }
        else {
            error!("Cannot obtain hostname.");
            std::process::exit(-1);
        }
    }
    else {
        let switch = Arc::new(Mutex::new(HashMap::new()));
        let switch_clone = switch.clone();

        let addr = "0.0.0.0:3777".parse().unwrap();
        let listener = tokio::net::TcpListener::bind(&addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each(move |s| {
                // Rust is absolute savage!
                let switch_clone2 = switch_clone.clone();
                let proto = SprinklerProto::new(s);
                let handle_conn = proto
                    .into_future()
                    .map_err(|(e, _)| e)
                    .and_then(move |(header, proto)| {
                        if let Some(header) = header {
                            Either::A(SprinklerRelay{ proto, header, switch: switch_clone2 })
                        }
                        else {
                            Either::B(future::ok(())) // Connection dropped?
                        }
                    })
                    // Task futures have an error of type `()`, this ensures we handle the
                    // error. We do this by printing the error to STDOUT.
                    .map_err(|e| {
                        error!("connection error = {:?}", e);
                    });
                tokio::spawn(handle_conn)
            });
        {
            let mut swith_init = switch.lock().unwrap();
            for i in triggers {
                swith_init.insert(i.id(), i.activate_master());
            }
        }
        tokio::run(server);
    }
}
