use std::io::Write;
use std::thread;
use std::sync::{mpsc, Arc, Mutex};
use super::{Sprinkler, SprinklerProto};

#[derive(Clone)]
pub struct CommCheck {
    _id: usize,
    _hostname: String,
    _deactivate: Arc<Mutex<bool>>
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
        // new thread
        // ssh & run docker events
        // detect oom
        // lookup pod
    }

    fn activate_agent(&self) {
        unimplemented!();
    }

    fn deactivate(&self) {
        *self._deactivate.lock().unwrap() = true;
    }

    // fn trigger(&self) {
    //     // kill pod, kill continer, rm --force
    // }
}