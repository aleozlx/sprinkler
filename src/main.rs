#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;
extern crate fern;
extern crate sys_info;
extern crate tokio;
// extern crate bytes;

use std::thread;
// use std::sync::mpsc;
use std::sync::{Arc, Mutex};
use byteorder::{ByteOrder, BigEndian};
use bytes::{BufMut, Bytes, BytesMut};
use futures::future::{self, Either};
use futures::sync::mpsc;
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
enum SprinklerProtoState {
    //    0     2     4
    Init, Meta, Body, End
}

impl SprinklerProtoState {
    fn transition(&mut self) {
        let new_state = match self {
            SprinklerProtoState::Init => Some(SprinklerProtoState::Meta),
            SprinklerProtoState::Meta => Some(SprinklerProtoState::Body),
            SprinklerProtoState::Body => Some(SprinklerProtoState::End),
            SprinklerProtoState::End => None
        };
        if let Some(new_state) = new_state {
            *self = new_state;
        }
    }
}

#[derive(Debug)]
struct SprinklerProto {
    socket: TcpStream,
    state: SprinklerProtoState,
    id: Option<u16>,
    msglen: u16,
    read_buffer: BytesMut,
    write_buffer: BytesMut,
}

#[derive(Debug)]
struct SprinklerMessage {
    id: usize,
    msg: String
}

impl SprinklerProto {
    fn new(socket: TcpStream) -> Self {
        SprinklerProto {
            socket,
            state: SprinklerProtoState::Init,
            id: None,
            msglen: 0,
            read_buffer: BytesMut::new(),
            write_buffer: BytesMut::new(),
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

impl Future for SprinklerProto {
    type Item = SprinklerMessage;
    type Error = std::io::Error;

    fn poll(&mut self) -> Poll<Self::Item, Self::Error> {
        let sock_closed = self.refill()?.is_ready();        
        match self.state {
            SprinklerProtoState::Init => {
                self.state.transition();
                let id_bin = self.read_buffer.split_to(2);
                self.id = BigEndian::read_u16(&id_bin);
                Ok(Async::Ready(Some(id_bin)))
            },
            SprinklerProtoState::SprinklerId => {
                self.state.transition();
                let len_bin = self.read_buffer.split_to(2);
                self.msglen = BigEndian::read_u16(&len_bin);
                Ok(Async::Ready(Some(len_bin)))
            },
            SprinklerProtoState::MessageLength => {
                if self.msglen > 0 {

                    let msg = self.read_buffer.take();
                }
                self.state.transition();
                Ok(Async::Ready(Some(self.read_buffer.split_to(2))))
            },
            SprinklerProtoState::MessageBody => {
                Ok(Async::Ready(None))
            }
        }

        // if sock_closed {
        //     Ok(Async::Ready(None))
        // } else {
        //     Ok(Async::NotReady)
        // }

        // if let Some(pos) = pos {
        //     // Remove the line from the read buffer and set it to `line`.
        //     let mut line = self.read_buffer.split_to(pos + 2);

        //     // Drop the line-ending
        //     line.split_off(pos);

        //     // Return the line
        //     return Ok(Async::Ready(Some(line)));
        // }

        
    }
}

trait Sprinkler: Clone {
    fn id(&self) -> usize;
    fn hostname(&self) -> &str;
    fn addr_internal(&self) -> String {
        format!("inproc://sprinkler-{}/control", self.id())
    }
    fn activate_master(&self) -> std::thread::JoinHandle<()>;
    fn activate_agent(&self) -> mpsc::Sender<String>;
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
struct CommCheck {
    _id: usize,
    _hostname: String,
    _deactivate: Arc<Mutex<bool>>
}

impl CommCheck {
    fn new(id: usize, host: String) -> Self {
        CommCheck {
            _id: id,
            _hostname: host,
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

    fn activate_agent(&self) -> mpsc::Sender<String> {
        // let clone = self.clone();
        // let (sender, receiver) = mpsc::channel();
        // thread::spawn(move || {
            
        // });
        // sender
    }

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
        // DockerOOM { host: String::from("k-prod-cpu-1.dsa.lan") }
        CommCheck::new(0, String::from("latitude-5289")),
        CommCheck::new(1, String::from("localhost"))
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
        let addr = "0.0.0.0:3777".parse().unwrap();
        let listener = TcpListener::bind(&addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each(|s| {
                let proto = SprinklerProto::new(s);
                let handle_conn = proto
                    .and_then(|msg| {
                        // let feeder = CommCheckFeeder::new();
                        Either::A(future::ok(()))
                        // Either::B(peer)
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
