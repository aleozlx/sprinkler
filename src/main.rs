#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;
extern crate fern;

use std::path::Path;
use std::thread;
use nng::{Message, Protocol, Socket};

const FNAME_CONFIG: &str = "/etc/sprinkler.conf";

fn setup_logger(verbose: u64) -> Result<(), fern::InitError> {
    let ref log_dir = Path::new("/var/log");
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
        // .chain(fern::log_file(log_dir.join("sprinkler.log"))?)
        .chain(std::io::stderr())
        .apply()?;
    Ok(())
}

trait Sprinkler: Clone {
    fn activate(&self) -> std::thread::JoinHandle<()>;
    fn deactivate(&self);
}

#[derive(Clone)]
struct DockerOOM {
    host: String
}

impl Sprinkler for DockerOOM {
    fn activate(&self) -> std::thread::JoinHandle<()> {
        unimplemented!();
        // new thread
        // ssh & run docker events
        // detect oom
        // lookup pod
    }

    fn deactivate(&self) {
        // stop thread
    }

    // fn trigger(&self) {
    //     // kill pod, kill continer, rm --force
    // }
}

#[derive(Clone)]
struct Ping {
    id: usize,
    host: String
}

impl Ping {
    fn new(id: usize, host: String) -> Ping {
        Ping {
            id: id,
            host: host
        }
    }
}

impl Sprinkler for Ping {
    fn activate(&self) -> std::thread::JoinHandle<()> {
        let clone = self.clone();
        let addr = format!("inproc://sprinkler-{}/control", self.id);
        thread::spawn(move || {
            let mut state = false;
            let mut s = Socket::new(Protocol::Rep0).expect("nng: failed to create local socket");
            s.set_nonblocking(true);
            s.listen(&addr).expect("nng: failed to listen to local socket");
            loop {
                // send message
                // receive message
                let state_recv = false;
                if state != state_recv {
                    state = state_recv;
                    info!(
                        "[{}] (Ping) has detected {} becoming {}",
                        clone.id, clone.host, if state {"online"} else {"offline"}
                    );
                }
                thread::sleep(std::time::Duration::from_secs(3));
                match s.recv() {
                    Ok(_) => { break; } // deactivate trigger
                    Err(_) => { trace!("[{}] heartbeat", clone.id) }
                }
            }
        })
    }

    fn deactivate(&self) {
        let addr = format!("inproc://sprinkler-{}/control", self.id);
        let mut s = Socket::new(Protocol::Req0).expect("nng: failed to create local socket");
        let msg: &[u8] = &[0x1B, 0xEF];
        s.dial(&addr).expect("nng: failed to connect to trigger");
        match s.send(Message::from(msg)) {
            Ok(_) => info!("[{}] has been deactivated", self.id),
            Err(e) => error!("failed to deactivate trigger: {:?}", e)
        }
    }
}

fn main() {
    let args = clap_app!(sprinkler =>
            (version: crate_version!())
            (author: crate_authors!())
            (about: crate_description!())
            (@arg RESUME: --("agent") "Agent mode")
            (@arg VERBOSE: --verbose -v ... "Logging verbosity")
        ).get_matches();
    
    setup_logger(args.occurrences_of("VERBOSE")).expect("Logger Error.");

    // parse FNAME_CONFIG and add triggers
    let triggers = vec![
        // DockerOOM { host: String::from("k-prod-cpu-1.dsa.lan") }
        Ping::new(0, String::from("localhost")),
        Ping::new(1, String::from("localhost"))
    ];

    for i in triggers {
        i.activate();
    }

    loop { thread::sleep(std::time::Duration::from_secs(10)); }
}
