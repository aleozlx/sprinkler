#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;
extern crate fern;
extern crate sys_info;

use std::thread;
use std::sync::{Arc, Mutex};

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

trait Sprinkler: Clone {
    fn id(&self) -> usize;
    fn hostname(&self) -> &str;
    fn addr_internal(&self) -> String {
        format!("inproc://sprinkler-{}/control", self.id())
    }
    fn activate_master(&self) -> std::thread::JoinHandle<()>;
    fn activate_agent(&self) -> std::thread::JoinHandle<()>;
    fn deactivate(&self);
}

// #[derive(Clone)]
// struct DockerOOM {
//     host: String
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

#[derive(Clone)]
struct Ping {
    _id: usize,
    _hostname: String,
    _deactivate: Arc<Mutex<bool>>
}

impl Ping {
    fn new(id: usize, host: String) -> Ping {
        Ping {
            _id: id,
            _hostname: host,
            _deactivate: Arc::new(Mutex::new(false))
        }
    }

    fn addr_external(&self) {

    }
}

impl Sprinkler for Ping {
    fn id(&self) -> usize {
        self._id
    }

    fn hostname(&self) -> &str {
        &self._hostname
    }

    fn activate_master(&self) -> std::thread::JoinHandle<()> {
        let clone = self.clone();
        thread::spawn(move || {
            let mut state = false;
            loop {
                // send message
                // receive message
                let state_recv = false;
                if state != state_recv {
                    state = state_recv;
                    info!(
                        "[{}] (Ping) has detected {} becoming {}",
                        clone.id(), clone.hostname(), if state {"online"} else {"offline"}
                    );
                }
                thread::sleep(std::time::Duration::from_secs(3));
                if *clone._deactivate.lock().unwrap() { break; }
                else { trace!("[{}] heartbeat", clone.id()); }
            }
        })
    }

    fn activate_agent(&self) -> std::thread::JoinHandle<()> {
        let clone = self.clone();
        thread::spawn(move || {
        })
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
        // DockerOOM { host: String::from("k-prod-cpu-1.dsa.lan") }
        Ping::new(0, String::from("latitude-5289")),
        Ping::new(1, String::from("localhost"))
    ];

    if args.is_present("AGENT") {
        if let Ok(hostname) = sys_info::hostname() {
            for i in triggers.iter().filter(|&i| i.hostname() == hostname) {
                i.activate_agent();
                info!("[{}] activated.", i.id());
            }
        }
        else {
            error!("Cannot obtain hostname.");
            std::process::exit(-1);
        }
    }
    else {
        for i in triggers {
            i.activate_master();
        }
    }
    loop { thread::sleep(std::time::Duration::from_secs(300)); }
}
