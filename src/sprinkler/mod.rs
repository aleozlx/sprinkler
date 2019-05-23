use std::collections::HashMap;
use std::sync::{mpsc, Arc, Mutex};
use byteorder::{ByteOrder, BigEndian};
use bytes::{BufMut, BytesMut};
use futures::try_ready;
use tokio::prelude::*;
use tokio::net::TcpStream;

pub mod commcheck;
pub use commcheck::*;

pub const HEART_BEAT: u64 = 3;
pub const RETRY_DELAY: u64 = 20;
pub const MASTER_ADDR: &str = "127.0.0.1:3777";

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

/// Message header
#[derive(Clone, Debug)]
pub struct SprinklerProtoHeader {
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

#[derive(Clone)]
pub struct Switch {
    pub inner: Arc<Mutex<HashMap<usize, mpsc::Sender<String>>>>
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

/// System recovery mechanisms, which are consisted of distributed agent threads monitored by master threads, identifiable by a systemwide id.
/// The agent threads, at a remote location, will individually detect system anomalies and attempt recovery after (trying to) notify master threads,
/// so that there will not be a single point of failure.
/// The master threads, gathered at a single reachable networking endpoint, may participate in any system recovery orchestration.
/// The systemwide configuration is done by replicating the same config file and executable.
pub trait Sprinkler: Clone {
    /// Get systemwide id
    fn id(&self) -> usize;

    /// Get the hostname, where the agent would be deployed
    fn hostname(&self) -> &str;

    /// Start the master thread, returning a sender (to the master thread) on a intraprocess communication channel
    fn activate_master(&self) -> mpsc::Sender<String>;

    /// Start the agent thread
    fn activate_agent(&self);

    /// Kill the master thread. Note: there is no way to reach out and kill any agent threads.
    fn deactivate(&self);
}
