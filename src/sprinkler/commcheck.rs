use std::io::Write;
use std::thread;
use std::sync::{mpsc, Arc, Mutex};
use super::{Sprinkler, SprinklerProto};

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
        thread::spawn(move || loop {
            let addr = "127.0.0.1:3777";
            if let Ok(mut stream) = std::net::TcpStream::connect(&addr) {
                let buf = SprinklerProto::buffer(&clone, String::from("COMMCHK"));
                if let Err(e) = stream.write_all(&buf) {
                    error!("Failed to send the master thread a message: {}", e);
                    thread::sleep(std::time::Duration::from_secs(20));
                }
            }
            else {
                error!("Connection error.");
                thread::sleep(std::time::Duration::from_secs(20));
            }
            thread::sleep(std::time::Duration::from_secs(3));
        });
    }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }
}
