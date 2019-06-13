use std::io::Write;
use std::thread;
use std::net::ToSocketAddrs;
use std::sync::{Arc, Mutex};
use super::*;

const COMMCHK: &str = "COMMCHK";

/// Basic communication checking, logging connection state changes
#[derive(Clone)]
pub struct CommCheck {
    options: Arc<SprinklerOptions>,
    _deactivate: Arc<Mutex<bool>>
}

impl Sprinkler for CommCheck {
    fn build(options: SprinklerOptions) -> Self {
        CommCheck {
            options: Arc::new(options),
            _deactivate: Arc::new(Mutex::new(false))
        }
    }

    fn id(&self) -> usize {
        self.options._id
    }

    fn hostname(&self) -> &str {
        &self.options._hostname
    }

    fn activate_master(&self) -> ActivationResult {
        let clone = self.clone();
        let (tx, rx) = std::sync::mpsc::channel::<Message>();
        thread::spawn(move || {
            let mut state = false;
            let mut last_seen = chrono::Local::now(); //chrono::naive::NaiveDateTime::from_timestamp(chrono::Local::now().timestamp(), 0);
            loop {
                let state_recv = if let Ok(message) = rx.try_recv() {
                    // last_seen = message.timestamp;
                    last_seen = chrono::Local::now();
                    message.body == COMMCHK
                } else {
                    if state {
                        // Tolerance (secs) for accumulated network delays
                        const TOLERANCE: i64 = 2;
                        if chrono::Local::now() - last_seen < chrono::Duration::seconds((clone.options.heart_beat as i64)+TOLERANCE)  {
                            debug!("sprinkler[{}] (CommCheck) on {} may be delayed.", clone.id(), clone.hostname());
                            true
                        }
                        else { false }
                    }
                    else { false }
                };
                if state != state_recv {
                    state = state_recv;
                    info!(
                        "sprinkler[{}] (CommCheck) {} => {}",
                        clone.id(), clone.hostname(), if state {"online"} else {"offline"}
                    );
                }
                thread::sleep(std::time::Duration::from_secs(clone.options.heart_beat));
                if *clone._deactivate.lock().unwrap() { break; }
                else { trace!("sprinkler[{}] heartbeat", clone.id()); }
            }
        });
        ActivationResult::RealtimeMonitor(tx)
    }

    fn activate_agent(&self) {
        let clone = self.clone();
        thread::spawn(move || loop {
            let runtime = tokio::runtime::Runtime::new().expect("failed to initialize a tokio runtime");
            let addr = clone.options.master_addr
                .to_socket_addrs().unwrap()
                .next().unwrap();
            let socket = TcpStream::connect(&addr);
            let cx = native_tls::TlsConnector::builder().build().expect("failed to build a TLS connector");
            let cx = tokio_tls::TlsConnector::from(cx);

            let tls_handshake = socket.and_then(move |socket| {
                cx.connect("www.rust-lang.org", socket)
                    .map_err(|e| io::Error::new(io::ErrorKind::Other, e))
            });


            if let Ok(mut stream) = std::net::TcpStream::connect(&clone.options.master_addr) {
                let buf = SprinklerProto::buffer(&clone, String::from(COMMCHK));
                if let Err(e) = stream.write_all(&buf) {
                    debug!("Failed to send the master thread a message: {}", e);
                    thread::sleep(std::time::Duration::from_secs(clone.options.retry_delay));
                }
            }
            else {
                debug!("Connection error, will retry after {} seconds.", clone.options.retry_delay);
                thread::sleep(std::time::Duration::from_secs(clone.options.retry_delay));
            }
            thread::sleep(std::time::Duration::from_secs(clone.options.heart_beat));
        });
    }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }
}
