#![allow(unused_imports)]

#[macro_use]
extern crate log;
use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use bytes::{BufMut, BytesMut};
use tokio::net::TcpStream;
use byteorder::{ByteOrder, BigEndian};
use futures::try_ready;
use futures::future::Either;
use tokio::prelude::*;
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

#[cfg(feature = "master")]
type EncryptedStream = tokio_tls::TlsStream<TcpStream>;

/// A TCP stream adapter to convert between byte stream and objects
#[cfg(feature = "master")]
#[derive(Debug)]
pub struct SprinklerProto {
    socket: EncryptedStream,
    read_buffer: BytesMut,
}

#[cfg(feature = "master")]
impl SprinklerProto {
    pub fn new(socket: EncryptedStream) -> Self {
        SprinklerProto {
            socket,
            read_buffer: BytesMut::new(),
        }
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

/// Encode a message and place it in a write buffer
pub fn compose_message(from: usize, msg: String) -> BytesMut {
    let mut write_buffer = BytesMut::new();
    write_buffer.reserve(512);
    write_buffer.put_u16_be(from as u16);
    write_buffer.put_i64_be(chrono::Local::now().timestamp());
    write_buffer.put_u16_be(msg.len() as u16);
    write_buffer.put(msg);
    write_buffer
}

/// Message header
#[derive(Clone, Debug)]
pub struct SprinklerProtoHeader {
    id: u16,
    timestamp: i64,
    len: u16
}

#[cfg(feature = "master")]
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

    pub fn connect_all<'a, I: IntoIterator<Item=&'a Box<dyn Sprinkler>> + Copy>(&self, sprinklers: I) {
        let mut switch_init = self.inner.lock().unwrap();
        for i in sprinklers {
            match i.activate_master() {
                ActivationResult::RealtimeMonitor(monitor) => { switch_init.insert(i.id(), Transmitter::Synchronous(monitor)); },
                ActivationResult::AsyncMonitor(monitor) => { switch_init.insert(i.id(), Transmitter::Asynchronous(monitor)); }
            }
        }
    }
}

/// Message relay between master threads and TCP sockets connected to remote agents
#[cfg(feature = "master")]
pub struct SprinklerRelay {
    pub proto: SprinklerProto,
    pub header: SprinklerProtoHeader,
    pub switch: Switch
}

#[cfg(feature = "master")]
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

#[derive(PartialEq, Debug, Copy, Clone)]
pub enum Anomaly {
    Negative,       // No anomaly has been detected
    Positive,       // Anomaly has occurred
    Fixing(usize),  // Has attempted to intervene N times
    OutOfControl    // Has given up trying because the programmed strategy will not work
}

impl Anomaly {
    pub fn get_retry_unchecked(&self) -> usize {
        match self {
            Anomaly::Negative | Anomaly::Positive => 0,
            Anomaly::Fixing(n) => *n,
            Anomaly::OutOfControl => std::usize::MAX
        }
    }

    pub fn escalate(&self, max_retry: usize) -> AnomalyTransition {
        match self {
            Anomaly::Negative => (*self >> Anomaly::Positive).unwrap(),
            Anomaly::Positive => (*self >> Anomaly::Fixing(1)).unwrap(),
            Anomaly::Fixing(n) => if *n < max_retry {
                AnomalyTransition::Fixing
            } else {
                (*self >> Anomaly::OutOfControl).unwrap()
            },
            Anomaly::OutOfControl => (*self >> Anomaly::OutOfControl).unwrap(),
        }
    }

    pub fn diminish(&self) -> AnomalyTransition {
        (*self >> Anomaly::Negative).unwrap()
    }
}

#[derive(PartialEq, Debug, Copy, Clone)]
pub enum AnomalyTransition {
    Normal,         // Negative -> Negative
    Occurred,       // Negative -> Positive
    Unhandled,      // Positive -> Positive
    Disappeared,    // Positive | OutOfControl -> Negative
    Fixed,          // Fixing(_) -> Negative
    Fixing,         // Positive -> Fixing(1) || Fixing(n) -> Fixing(n+1)
    GaveUp,         // Fixing(m) -> OutOfControl
    HasGivenUp      // OutOfControl -> OutOfControl
}

use std::ops::Shr;
use std::ops::ShrAssign;
impl Shr for Anomaly {
    type Output = Option<AnomalyTransition>;
    fn shr(self, rhs: Self) -> Option<AnomalyTransition> {
        match (self, rhs) {
            (Anomaly::Negative, Anomaly::Negative) => Some(AnomalyTransition::Normal),
            (Anomaly::Negative, Anomaly::Positive) => Some(AnomalyTransition::Occurred),
            (Anomaly::Positive, Anomaly::Positive) => Some(AnomalyTransition::Unhandled),
            (Anomaly::Positive, Anomaly::Negative) => Some(AnomalyTransition::Disappeared),
            (Anomaly::Positive, Anomaly::Fixing(1)) => Some(AnomalyTransition::Fixing),
            (Anomaly::Fixing(i), Anomaly::Fixing(j)) if i+1==j => Some(AnomalyTransition::Fixing),
            (Anomaly::Fixing(_), Anomaly::Negative) => Some(AnomalyTransition::Fixed),
            (Anomaly::Fixing(_), Anomaly::OutOfControl) => Some(AnomalyTransition::GaveUp),
            (Anomaly::OutOfControl, Anomaly::Negative) => Some(AnomalyTransition::Disappeared),
            (Anomaly::OutOfControl, Anomaly::OutOfControl) => Some(AnomalyTransition::HasGivenUp),
            _ => None
        }
    }
}

impl Shr<AnomalyTransition> for Anomaly {
    type Output = Anomaly;
    fn shr(self, rhs: AnomalyTransition) -> Anomaly {
        match (self, rhs) {
            (Anomaly::Negative, AnomalyTransition::Occurred) => Anomaly::Positive,
            (Anomaly::Positive, AnomalyTransition::Disappeared) => Anomaly::Negative,
            (Anomaly::OutOfControl, AnomalyTransition::Disappeared) => Anomaly::Negative,
            (Anomaly::Fixing(_), AnomalyTransition::Fixed) => Anomaly::Negative,
            (Anomaly::Positive, AnomalyTransition::Fixing) => Anomaly::Fixing(1),
            (Anomaly::Fixing(n), AnomalyTransition::Fixing) => Anomaly::Fixing(n+1),
            (Anomaly::Fixing(_), AnomalyTransition::GaveUp) => Anomaly::OutOfControl,
            _ => self
        }
    }
}

impl ShrAssign<AnomalyTransition> for Anomaly {
    fn shr_assign(&mut self, rhs: AnomalyTransition) {
        let next = *self >> rhs;
        *self = next;
    }
}

/// Create a TLS acceptor
#[cfg(feature = "master")]
fn init_tls() -> native_tls::Result<tokio_tls::TlsAcceptor> {
    let der = include_bytes!("/etc/sprinkler.conf.d/master.p12");
    // TODO key loading is hard coded.
    let mut keybuffer = Vec::new();
    std::fs::File::open("/root/.sprinkler.key").expect("cannot read key").read_to_end(&mut keybuffer).expect("cannot read key");
    let cert = native_tls::Identity::from_pkcs12(der, &String::from_utf8_lossy(&keybuffer))?;
    Ok(tokio_tls::TlsAcceptor::from(native_tls::TlsAcceptor::builder(cert).build()?))
}

/// Starts a tokio server bound to the specified address
#[cfg(feature = "master")]
pub fn server(addr: &std::net::SocketAddr, switch: &Switch) {
    /*
    Self-signed cert
    openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out sprinkler.crt -keyout sprinkler.key
    openssl pkcs12 -export -out identity.p12 -inkey sprinkler.key -in sprinkler.crt
    echo "$KEY_PASSWORD" | tr -d '\n' > identity.txt
    chown root:root identity.txt
    chmod 600 identity.txt
    */
    if let Ok(tls_acceptor) = init_tls() {
        let listener = tokio::net::TcpListener::bind(addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each({ let switch = switch.clone(); move |s| {
                let tls_accept = tls_acceptor
                .accept(s)
                .and_then({ let switch = switch.clone(); move |s| {
                    let proto = SprinklerProto::new(s);
                    let handle_conn = proto.into_future()
                        .map_err(|(e, _)| e)
                        .and_then({ let switch = switch.clone(); move |(header, proto)| {
                            match header {
                                Some(header) => Either::A(SprinklerRelay{ proto, header, switch }),
                                None => Either::B(future::ok(())) // Connection dropped?
                            }
                        }})
                        // Task futures have an error of type `()`, this ensures we handle the
                        // error. We do this by printing the error to STDOUT.
                        .map_err(|e| {
                            error!("connection error = {:?}", e);
                        });
                    tokio::spawn(handle_conn);
                    Ok(())
                }})
                .map_err(|err| {
                    debug!("TLS accept error: {:?}", err);
                });
                tokio::spawn(tls_accept)
            }});
        tokio::spawn(server);
    }
    else {
        error!("cannot initialize tls");
    }
}

/// Activates sprinklers agents based on hostname
pub fn agent<'a, I: IntoIterator<Item=&'a Box<dyn Sprinkler>> + Copy>(sprinklers: I) {
    if let Ok(hostname) = sys_info::hostname() {
        for i in sprinklers.into_iter().filter(|&i| i.hostname() == hostname) {
            i.activate_agent();
            info!("sprinkler[{}] activated.", i.id());
        }
    }
    else {
        error!("Cannot obtain hostname.");
        std::process::exit(-1);
    }
}

pub fn loop_forever() -> ! {
    loop { std::thread::sleep(std::time::Duration::from_secs(600)); }
}
