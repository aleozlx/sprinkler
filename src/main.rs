#[macro_use]
extern crate clap;

use std::thread;
// use std::sync::mpsc;
// use std::net::{IpAddr, Ipv4Addr};
use nng::{Message, Protocol, Socket};

const FNAME_CONFIG: &str = "/etc/sprinkler.conf";
const STOP: i32 = -1;

trait Trigger {
    fn activate(&mut self);
    fn deactivate(&mut self);
    fn signal(&self);
}

struct DockerOOM {
    host: String
}

impl Trigger for DockerOOM {
    fn activate(&mut self) {
        // new thread
        // ssh & run docker events
        // detect oom
        // lookup pod
    }

    fn deactivate(&mut self) {
        // stop thread
    }

    fn signal(&self) {
        // kill pod, kill continer, rm --force
    }
}

struct Ping {
    host: String,
    state: bool,
    join_handle: Option<thread::JoinHandle<()>>,
    socket_internal: Option<Socket>
}

impl Ping {
    fn new(host: String) -> Ping {
        Ping { host: host, state: false, join_handle: None, socket_internal: None }
    }
}

impl Trigger for Ping {
    fn activate(&mut self) {
        let addr = "inproc://sprinkler/0/control";
        let p = thread::spawn(move || {
            let mut s = Socket::new(Protocol::Rep0).expect("nng: failed to create local socket");
            s.set_nonblocking(true);
            s.listen(addr.clone()).expect("nng: failed to listen to local socket");
            loop {
                // send message
                // receive message
                // if state changes, signal
                thread::sleep(std::time::Duration::from_secs(3));
                match s.recv() {
                    Ok(msg) => { break; } // deactivate signal
                    Err(e) => {println!(".")} // no msg
                }
            }
        });
        self.join_handle = Some(p);
    }

    fn deactivate(&mut self) {
        let addr = "inproc://sprinkler/0/control";
        let mut s = Socket::new(Protocol::Rep0).expect("nng: failed to create local socket");
        let msg: &[u8] = &[0x1B, 0xEF];
        s.send(nng::Message::from(msg));
    }

    fn signal(&self) {
        // log going online/offline
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

    // parse FNAME_CONFIG and add triggers
    let mut triggers = vec![
        // DockerOOM { host: String::from("k-prod-cpu-1.dsa.lan") }
        Ping::new(String::from("localhost"))
    ];

    for mut i in triggers.iter_mut() {
        i.activate();
    }

    for i in 0..2 {
        thread::sleep(std::time::Duration::from_secs(10));
        triggers[0].deactivate();
    }
}
