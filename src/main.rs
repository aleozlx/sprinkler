#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;

use std::thread;
use futures::future::{self, Either};
use tokio::prelude::*;
mod sprinkler;
use sprinkler::*;

const FNAME_CONFIG: &str = "/etc/sprinkler.conf";

fn setup_logger(verbose: u64) -> Result<(), fern::InitError> {
    fern::Dispatch::new()
        .format(|out, message, record| {
            out.finish(format_args!(
                "{} {} {}",
                chrono::Local::now().format("[%Y-%m-%d %H:%M:%S]"),
                record.level(),
                message
            ))
        })
        .level(match verbose {
            0 => log::LevelFilter::Info,
            1 => log::LevelFilter::Info,
            2 => log::LevelFilter::Debug,
            3 => log::LevelFilter::Trace,
            _ => log::LevelFilter::Trace
        })
        .chain(std::io::stderr())
        .apply()?;
    Ok(())
}

fn main() {
    let args = clap_app!(sprinkler =>
            (version: crate_version!())
            (author: crate_authors!())
            (about: crate_description!())
            (@arg AGENT: --("agent") "Agent mode")
            (@arg VERBOSE: --verbose -v ... "Logging verbosity")
        ).get_matches();
    
    setup_logger(args.occurrences_of("VERBOSE")).expect("Logger Error.");

    // parse FNAME_CONFIG and add triggers
    let triggers = vec![
        // DockerOOM { hostname: String::from("k-prod-cpu-1.dsa.lan") }
        CommCheck::new(0, String::from("latitude-5289")),
        CommCheck::new(1, String::from("localhost"))
    ];

    if args.is_present("AGENT") {
        if let Ok(hostname) = sys_info::hostname() {
            for i in triggers.iter().filter(|&i| i.hostname() == hostname) {
                i.activate_agent();
                info!("sprinkler[{}] activated.", i.id());
            }
            loop { thread::sleep(std::time::Duration::from_secs(300)); }
        }
        else {
            error!("Cannot obtain hostname.");
            std::process::exit(-1);
        }
    }
    else {
        let switch = Switch::new();
        let switch_clone = switch.clone();

        let addr = "0.0.0.0:3777".parse().unwrap();
        let listener = tokio::net::TcpListener::bind(&addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each(move |s| {
                // Rust is absolute savage!
                let switch_clone2 = switch_clone.clone();
                let proto = SprinklerProto::new(s);
                let handle_conn = proto
                    .into_future()
                    .map_err(|(e, _)| e)
                    .and_then(move |(header, proto)| {
                        if let Some(header) = header {
                            Either::A(SprinklerRelay{ proto, header, switch: switch_clone2 })
                        }
                        else {
                            Either::B(future::ok(())) // Connection dropped?
                        }
                    })
                    // Task futures have an error of type `()`, this ensures we handle the
                    // error. We do this by printing the error to STDOUT.
                    .map_err(|e| {
                        error!("connection error = {:?}", e);
                    });
                tokio::spawn(handle_conn)
            });
        {
            let mut swith_init = switch.inner.lock().unwrap();
            for i in triggers {
                swith_init.insert(i.id(), i.activate_master());
            }
        }
        tokio::run(server);
    }
}
