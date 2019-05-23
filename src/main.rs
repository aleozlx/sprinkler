#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;
extern crate fern;
extern crate sys_info;
extern crate tokio;

use std::collections::HashMap;
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

    fn buffer<S: Sprinkler>(sprinkler: &S, msg: String) -> BytesMut {
        let mut write_buffer = BytesMut::new();
        write_buffer.reserve(512);
        write_buffer.put_u16_be(sprinkler.id() as u16);
        write_buffer.put_u16_be(msg.len() as u16);
        write_buffer.put(msg);
        write_buffer
    }

    /// Update read buffer
    fn check(&mut self) -> Poll<(), std::io::Error> {
        loop {
            self.read_buffer.reserve(512);
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
        let sock_closed = self.check()?.is_ready();
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

struct SprinklerRelay {
    proto: SprinklerProto,
    header: SprinklerProtoHeader,
    switch: Arc<Mutex<HashMap<usize, mpsc::Sender<String>>>>
}

impl Future for SprinklerRelay {
    type Item = ();
    type Error = std::io::Error;

    fn poll(&mut self) -> Poll<Self::Item, Self::Error> {
        let sock_closed = self.proto.check()?.is_ready();
        if self.proto.read_buffer.len() >= self.header.len as usize {
            if let Ok(msgbody) = String::from_utf8(self.proto.read_buffer.to_vec()) {
                if let Some(tx) = self.switch.lock().unwrap().get(&(self.header.id as usize)) {
                    if let Err(_) = tx.send(msgbody) {
                        warn!("Failed to relay the message.");
                    }
                }
                Ok(Async::Ready(()))
            }
            else {
                warn!("Failed to decode message.");
                Ok(Async::Ready(()))
            }
        }
        else {
            if sock_closed {
                warn!("Message was lost.");
                Ok(Async::Ready(()))
            }
            else { Ok(Async::NotReady) }
        }
    }
}

trait Sprinkler: Clone {
    fn id(&self) -> usize;
    fn hostname(&self) -> &str;
    fn activate_master(&self) -> mpsc::Sender<String>;
    fn activate_agent(&self);
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
        thread::spawn(move || {
            let addr = "127.0.0.1:3777".parse().unwrap();
            let client = TcpStream::connect(&addr)
                .and_then(move |stream| {
                    let buf = SprinklerProto::buffer(&clone, String::from("COMMCHK"));
                    tokio::io::write_all(stream, buf).then(|_| {
                        Ok(())
                    })
                })
                .map_err(|err| {
                    error!("connection error = {:?}", err);
                });
            tokio::run(client);
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
        let listener = TcpListener::bind(&addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each(move |s| {
                let switch_clone2 = switch_clone.clone();
                let proto = SprinklerProto::new(s);
                let handle_conn = proto
                    .into_future()
                    .map_err(|(e, _)| e)
                    .and_then(move |(header, proto)| {
                        if let Some(header) = header {
                            Either::B(SprinklerRelay{ proto, header, switch: switch_clone2 })
                        }
                        else {
                            Either::A(future::ok(())) // Connection dropped?
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
