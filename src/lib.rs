#[macro_use]
extern crate log;

use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use byteorder::{ByteOrder, BigEndian};
use bytes::{BufMut, BytesMut};
use futures::try_ready;
use tokio::prelude::*;
use tokio::net::TcpStream;
use chrono::naive::NaiveDateTime;

mod commcheck;
pub use commcheck::CommCheck;

#[derive(Clone)]
pub struct SprinklerOptions {
    pub heart_beat: u64,
    pub retry_delay: u64,
    pub master_addr: String,
    pub _id: usize,
    pub _hostname: String,
}

impl Default for SprinklerOptions {
    fn default() -> Self {
        SprinklerOptions {
            heart_beat: 3,
            retry_delay: 20,
            master_addr: String::from("localhost"),
            _id: 0,
            _hostname: String::from("localhost")
        }
    }
}

/// Sprinkler Builder
pub struct SprinklerBuilder {
    params: SprinklerOptions,
    counter: usize
}

impl SprinklerBuilder {
    pub fn new(params: SprinklerOptions) -> Self {
        SprinklerBuilder {
            params,
            counter: 0
        }
    }
}

impl SprinklerBuilder {
    pub fn build<T: Sprinkler>(&mut self, hostname: String) -> T {
        let next = self.counter;
        self.counter += 1;
        T::build(SprinklerOptions {
            _id: next,
            _hostname: hostname,
            ..self.params.clone()
        })
    }
}

/// A TCP stream adapter to convert between byte stream and objects
#[derive(Debug)]
pub struct SprinklerProto {
    socket: TcpStream,
    read_buffer: BytesMut,
}

impl SprinklerProto {
    pub fn new(socket: TcpStream) -> Self {
        SprinklerProto {
            socket,
            read_buffer: BytesMut::new(),
        }
    }

    /// Encode a message and place it in a write buffer
    pub fn buffer<S: Sprinkler>(sprinkler: &S, msg: String) -> BytesMut {
        let mut write_buffer = BytesMut::new();
        write_buffer.reserve(512);
        write_buffer.put_u16_be(sprinkler.id() as u16);
        write_buffer.put_i64_be(chrono::Local::now().timestamp());
        write_buffer.put_u16_be(msg.len() as u16);
        write_buffer.put(msg);
        write_buffer
    }

    /// Update read buffer
    fn check(&mut self) -> Poll<(), std::io::Error> {
        loop { // Why do I have a loop here? I forgot??
            self.read_buffer.reserve(512);
            let n = try_ready!(self.socket.read_buf(&mut self.read_buffer));
            if n == 0 {
                return Ok(Async::Ready(()));
            }
        }
    }
}

/// Message header
#[derive(Clone, Debug)]
pub struct SprinklerProtoHeader {
    id: u16,
    timestamp: i64,
    len: u16
}

impl Stream for SprinklerProto {
    type Item = SprinklerProtoHeader;
    type Error = std::io::Error;

    fn poll(&mut self) -> Poll<Option<Self::Item>, Self::Error> {
        let sock_closed = self.check()?.is_ready();
        if self.read_buffer.len() > 12 {
            Ok(Async::Ready(Some(SprinklerProtoHeader {
                id: BigEndian::read_u16(&self.read_buffer.split_to(2)),
                timestamp: BigEndian::read_u64(&self.read_buffer.split_to(8)) as i64,
                len: BigEndian::read_u16(&self.read_buffer.split_to(2))
            })))
        }
        else {
            if sock_closed { Ok(Async::Ready(None)) }
            else { Ok(Async::NotReady) }
        }
    }
}

#[derive(Clone)]
pub enum Transmitter<T> {
    /// Synchronous Sender
    Synchronous(std::sync::mpsc::Sender<T>),
    /// Asynchronous Sender
    Asynchronous(futures::sync::mpsc::Sender<T>)
}

impl<T> Transmitter<T> where T: 'static + Send {
    /// Send a message through the underlying Sender
    pub fn send(&self, t: T) -> Result<(), ()> {
        match self {
            Transmitter::Synchronous(sender) => sender.send(t).map_err(|_| ()),
            Transmitter::Asynchronous(sender) => {
                tokio::spawn({
                    let sender = sender.clone();
                    sender.send(t).into_future().map(|_| ()).map_err(|_| ())
                });
                Ok(())
            }
        }
    }
}

#[derive(Clone)]
pub struct Switch {
    pub inner: Arc<Mutex<HashMap<usize, Transmitter<Message>>>>
}

impl Switch {
    pub fn new() -> Self {
        Switch { inner: Arc::new(Mutex::new(HashMap::new())) }
    }
}

/// Message relay between master threads and TCP sockets connected to remote agents
pub struct SprinklerRelay {
    pub proto: SprinklerProto,
    pub header: SprinklerProtoHeader,
    pub switch: Switch
}

impl Future for SprinklerRelay {
    type Item = ();
    type Error = std::io::Error;

    fn poll(&mut self) -> Poll<Self::Item, Self::Error> {
        let sock_closed = self.proto.check()?.is_ready();
        if self.proto.read_buffer.len() >= self.header.len as usize {
            if let Ok(msgbody) = String::from_utf8(self.proto.read_buffer.to_vec()) {
                if let Some(tx) = self.switch.inner.lock().unwrap().get(&(self.header.id as usize)) {
                    if let Err(_) = tx.send(Message{
                        timestamp: NaiveDateTime::from_timestamp(self.header.timestamp, 0),
                        body: msgbody
                    }) {
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

pub enum ActivationResult {
    /// A realtime algorithm based master thread that monitors agent threads
    RealtimeMonitor(std::sync::mpsc::Sender<Message>),

    /// An asynchronous master thread that monitors agent threads
    AsyncMonitor(futures::sync::mpsc::Sender<Message>)
}

/// DoS prevention mechanisms, which are consisted of distributed agent threads monitored by master threads, identifiable by a systemwide id.
/// The agent threads, at a remote location, will independently detect system anomalies and intervene while notifying master threads,
/// so that there will not be a single point of failure.
/// The master threads, gathered at a single reachable networking endpoint, may participate in DoS prevention from a control plane angle or only record system anomalies.
/// The systemwide configuration is done by replicating the same config file and executable.
pub trait Sprinkler {
    /// Build a new sprinkler
    fn build(options: SprinklerOptions) -> Self where Self: Sized;

    /// Get systemwide id
    fn id(&self) -> usize;

    /// Get the hostname, where the agent would be deployed
    fn hostname(&self) -> &str;

    /// Start the master thread, returning a sender (to the master thread) on a intraprocess communication channel
    fn activate_master(&self) -> ActivationResult;

    /// Start the agent thread
    fn activate_agent(&self);

    /// Kill the master thread. Note: there is no way to reach out and kill any agent threads.
    fn deactivate(&self);
}

/// Sprinkler thread level message format
#[derive(Clone)]
pub struct Message {
    pub timestamp: NaiveDateTime,
    pub body: String
}
