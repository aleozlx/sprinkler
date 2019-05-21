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

trait Sprinkler {
    fn activate(&mut self);
    fn deactivate(&mut self);
    fn trigger(&self);
}

struct DockerOOM {
    host: String
}

impl Sprinkler for DockerOOM {
    fn activate(&mut self) {
        // new thread
        // ssh & run docker events
        // detect oom
        // lookup pod
    }

    fn deactivate(&mut self) {
        // stop thread
    }

    fn trigger(&self) {
        // kill pod, kill continer, rm --force
    }
}

struct Ping {
    id: usize,
    host: String,
    state: bool,
    join_handle: Option<thread::JoinHandle<()>>,
    socket_internal: Option<Socket>
}

impl Ping {
    fn new(id: usize, host: String) -> Ping {
        Ping {
            id: id,
            host: host,
            state: false,
            join_handle: None,
            socket_internal: None
        }
    }
}

impl Sprinkler for Ping {
    fn activate(&mut self) {
        let tid = self.id;
        let addr = format!("inproc://sprinkler-{}/control", tid);
        let p = thread::spawn(move || {
            let mut s = Socket::new(Protocol::Rep0).expect("nng: failed to create local socket");
            s.set_nonblocking(true);
            s.listen(&addr).expect("nng: failed to listen to local socket");
            loop {
                // send message
                // receive message
                let state_recv = false;
                if self.state != state_recv {
                    self.state = state_recv;
                    self.trigger();
                }
                // if state changes, trigger
                thread::sleep(std::time::Duration::from_secs(3));
                match s.recv() {
                    Ok(msg) => { break; } // deactivate trigger
                    Err(e) => {eprintln!("{}", tid)} // no msg
                }
            }
        });
        self.join_handle = Some(p);
    }

    fn deactivate(&mut self) {
        let tid = self.id;
        let addr = format!("inproc://sprinkler-{}/control", tid);
        let mut s = Socket::new(Protocol::Req0).expect("nng: failed to create local socket");
        let msg: &[u8] = &[0x1B, 0xEF];
        s.dial(&addr).expect("nng: failed to connect to trigger");
        match s.send(Message::from(msg)) {
            Ok(_) => info!("[{}] has been deactivated", tid),
            Err(e) => error!("failed to deactivate trigger: {:?}", e)
        }
    }

    fn trigger(&self) {
        info!("[{}] (Ping) has detected {} becoming {}", self.id, self.host, if self.state {"online"} else {"offline"});
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
    let mut triggers = vec![
        // DockerOOM { host: String::from("k-prod-cpu-1.dsa.lan") }
        Ping::new(0, String::from("localhost")),
        Ping::new(1, String::from("localhost"))
    ];

    for i in triggers.iter_mut() {
        i.activate();
    }

    loop { thread::sleep(std::time::Duration::from_secs(10)); }
}
