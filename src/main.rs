use std::net::{IpAddr, Ipv4Addr};

const FNAME_CONFIG: &str = "/etc/sprinkler.conf";

trait Trigger {
    fn activate(&self);
    fn deactivate(&self);
    fn signal(&self);
}

struct DockerOOM {
    host: String
}

impl Trigger for DockerOOM {
    fn activate(&self) {
        // new thread
        // ssh & run docker events
        // detect oom
        // lookup pod
    }

    fn deactivate(&self) {
        // stop thread
    }

    fn signal(&self) {
        // kill pod, kill continer, rm --force
    }
}

fn main() {
    // parse FNAME_CONFIG and add triggers
    let triggers = vec![
        DockerOOM { host: String::from("k-prod-cpu-1.dsa.lan") }
    ];

    for i in triggers {
        i.activate();
    }
}
