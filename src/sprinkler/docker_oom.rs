use std::io::Write;
use std::thread;
use std::sync::{mpsc, Arc, Mutex};
use super::{Sprinkler, SprinklerProto};

#[derive(Clone)]
pub struct DockerOOM {
    _id: usize,
    _hostname: String,
    _deactivate: Arc<Mutex<bool>>
}

impl DockerOOM {
    pub fn new(id: usize, hostname: String) -> Self {
        DockerOOM {
            _id: id,
            _hostname: hostname,
            _deactivate: Arc::new(Mutex::new(false))
        }
    }
}

impl Sprinkler for DockerOOM {
    fn id(&self) -> usize {
        self._id
    }

    fn hostname(&self) -> &str {
        &self._hostname
    }

    fn activate_master(&self) -> mpsc::Sender<String> {
        unimplemented!();
        // 


        let clone = self.clone();
        let (tx, rx) = mpsc::channel();
        thread::spawn(move || {
            let mut state = false;
            loop {
                // detect oom
                let state_recv = false; //rx.try_recv().is_ok();
                
                if state != state_recv {
                    state = state_recv;
                    // lookup pod
                    // kill pod, kill continer, rm --force
                    // info!(
                    //     "sprinkler[{}] (CommCheck) {} => {}",
                    //     clone.id(), clone.hostname(), if state {"online"} else {"offline"}
                    // );
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
            //run docker events
        }
    }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }
}