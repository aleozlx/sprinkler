#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;
extern crate fern;
extern crate sys_info;
extern crate tokio;
// extern crate bytes;

use std::thread;
use std::sync::mpsc;
use std::sync::{Arc, Mutex};
use byteorder::{ByteOrder, BigEndian};
use bytes::{BufMut, Bytes, BytesMut};
use futures::future::{self, Either};
// use futures::sync::mpsc;
use futures::try_ready;
use tokio::prelude::*;
use tokio::net::{TcpListener, TcpStream};

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

#[derive(Debug)]
struct SprinklerProto {
    socket: TcpStream,
    read_buffer: BytesMut,
    // write_buffer: BytesMut,
}

impl SprinklerProto {
    fn new(socket: TcpStream) -> Self {
        SprinklerProto {
            socket,
            read_buffer: BytesMut::new(),
            // write_buffer: BytesMut::new(),
        }
    }

    /// Update read buffer
    fn refill(&mut self) -> Poll<(), std::io::Error> {
        loop {
            self.read_buffer.reserve(1024);
            let n = try_ready!(self.socket.read_buf(&mut self.read_buffer));
            if n == 0 {
                return Ok(Async::Ready(()));
            }
        }
    }
}

#[derive(Clone, Debug)]
struct SprinklerProtoHeader {
    id: u16,
    len: u16
}

impl Stream for SprinklerProto {
    type Item = SprinklerProtoHeader;
    type Error = std::io::Error;

    fn poll(&mut self) -> Poll<Option<Self::Item>, Self::Error> {
        let sock_closed = self.refill()?.is_ready();        
        if self.read_buffer.len() > 4 {
            Ok(Async::Ready(Some(SprinklerProtoHeader {
                id: BigEndian::read_u16(&self.read_buffer.split_to(2)),
                len: BigEndian::read_u16(&self.read_buffer.split_to(2))
            })))
        }
        else {
            if sock_closed { Ok(Async::Ready(None)) }
            else { Ok(Async::NotReady) }
        }
    }
}

#[derive(Debug)]
struct SprinklerMessage {
    id: usize,
    msg: String
}

struct SprinklerMessageDispatcher {
    // proto: 
}

impl SprinklerMessageDispatcher {
    fn new(proto: SprinklerProto, header: SprinklerProtoHeader) -> Self {

    }
}

impl Future for SprinklerMessageDispatcher {
    type Item = ();
    type Error = std::io::Error;

    fn poll(&mut self) -> Poll<Self::Item, Self::Error> {

    }
}

trait Sprinkler: Clone {
    fn id(&self) -> usize;
    fn hostname(&self) -> &str;
    fn activate_master(&self) -> std::thread::JoinHandle<()>;
    // fn activate_agent(&self) -> mpsc::Sender<String>;
    fn deactivate(&self);
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

    fn addr_external(&self) {

    }
}

impl Sprinkler for CommCheck {
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
                        "[{}] (CommCheck) has detected {} becoming {}",
                        clone.id(), clone.hostname(), if state {"online"} else {"offline"}
                    );
                }
                thread::sleep(std::time::Duration::from_secs(3));
                if *clone._deactivate.lock().unwrap() { break; }
                else { trace!("[{}] heartbeat", clone.id()); }
            }
        })
    }

    // fn activate_agent(&self) -> mpsc::Sender<String> {
    //     // let clone = self.clone();
    //     // let (sender, receiver) = mpsc::channel();
    //     // thread::spawn(move || {
            
    //     // });
    //     // sender
    // }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }
}

// struct CommCheckFeeder {

// }

// impl CommCheckFeeder {
//     fn new() -> Self {
//         CommCheckFeeder {}
//     }
// }

// impl Future for CommCheckFeeder {
//     type Item = ();
//     type Error = io::Error;

//     fn poll(&mut self) -> Poll<(), io::Error> {
//     }
// }

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
                // i.activate_agent();
                info!("[{}] activated.", i.id());
            }
            
        }
        else {
            error!("Cannot obtain hostname.");
            std::process::exit(-1);
        }
    }
    else {
        let addr = "0.0.0.0:3777".parse().unwrap();
        let listener = TcpListener::bind(&addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each(|s| {
                let proto = SprinklerProto::new(s);
                let handle_conn = proto
                    .into_future()
                    .map_err(|(e, _)| e)
                    .and_then(|(header, proto)| {
                        if let Some(header) = header {
                            Either::B(SprinklerMessageDispatcher::new(proto, header))
                        }
                        else {
                            Either::A(future::ok(()))
                        }
                    })
                    // Task futures have an error of type `()`, this ensures we handle the
                    // error. We do this by printing the error to STDOUT.
                    .map_err(|e| {
                        println!("connection error = {:?}", e);
                    });
                tokio::spawn(handle_conn)
            });
        tokio::run(server);


        // for i in triggers {
        //     i.activate_master();
        // }
    }
    loop { thread::sleep(std::time::Duration::from_secs(300)); }
}
