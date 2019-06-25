use std::io::Write;
use std::thread;
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
            let master_addr = clone.options.master_addr.clone();
            if let Ok(socket) = std::net::TcpStream::connect(&clone.options.master_addr) {
                let mut tlsbuilder = native_tls::TlsConnector::builder();
                tlsbuilder.add_root_certificate(native_tls::Certificate::from_pem(include_bytes!("/etc/sprinkler.conf.d/master.crt")).unwrap());
                let connector = tlsbuilder.build().expect("failed to build a TLS connector");
                let mut stream = connector.connect(&master_addr.split(":").take(1).collect::<Vec<&str>>()[0], socket).expect("failed to establish a TLS stream");
                let buf = super::compose_message(clone.id(), String::from(COMMCHK));
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
