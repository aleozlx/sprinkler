use std::io::Write;
use std::thread;
use std::sync::{mpsc, Arc, Mutex};
use super::{Sprinkler, SprinklerProto, Message};

const COMMCHK: &str = "COMMCHK";

/// Basic communication checking, logging connection state changes
#[derive(Clone)]
pub struct CommCheck {
    _id: usize,
    _hostname: String,
    _deactivate: Arc<Mutex<bool>>
}

impl CommCheck {
    pub fn new(id: usize, hostname: String) -> Self {
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

    fn activate_master(&self) -> mpsc::Sender<Message> {
        let clone = self.clone();
        let (tx, rx) = mpsc::channel::<Message>();
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
                        if chrono::Local::now() - last_seen < chrono::Duration::seconds((super::HEART_BEAT as i64)+TOLERANCE)  {
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
                thread::sleep(std::time::Duration::from_secs(super::HEART_BEAT));
                if *clone._deactivate.lock().unwrap() { break; }
                else { trace!("sprinkler[{}] heartbeat", clone.id()); }
            }
        });
        tx
    }

    fn activate_agent(&self) {
        let clone = self.clone();
        thread::spawn(move || loop {
            if let Ok(mut stream) = std::net::TcpStream::connect(super::MASTER_ADDR) {
                let buf = SprinklerProto::buffer(&clone, String::from(COMMCHK));
                if let Err(e) = stream.write_all(&buf) {
                    debug!("Failed to send the master thread a message: {}", e);
                    thread::sleep(std::time::Duration::from_secs(super::RETRY_DELAY));
                }
            }
            else {
                debug!("Connection error, will retry after {} seconds.", super::RETRY_DELAY);
                thread::sleep(std::time::Duration::from_secs(super::RETRY_DELAY));
            }
            thread::sleep(std::time::Duration::from_secs(super::HEART_BEAT));
        });
    }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }
}