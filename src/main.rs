#[macro_use]
extern crate clap;
#[macro_use]
extern crate log;

use std::thread;
use futures::future::{self, Either};
use tokio::prelude::*;
use sprinkler_api::*;

const MASTER_ADDR: &str = "192.168.0.3:3777";

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

/// This only an example.
fn main() {
    let args = clap_app!(sprinkler =>
            (version: crate_version!())
            (author: crate_authors!())
            (about: crate_description!())
            (@arg AGENT: --("agent") "Agent mode")
            (@arg VERBOSE: --verbose -v ... "Logging verbosity")
        ).get_matches();
    
    setup_logger(args.occurrences_of("VERBOSE")).expect("Logger Error.");

    let mut builder = SprinklerBuilder::new(SprinklerOptions{ master_addr: String::from(MASTER_ADDR), ..Default::default() });

    let triggers: Vec<Box<dyn Sprinkler>> = vec![
        Box::new(builder.build::<CommCheck>(String::from("alex-jetson-tx2")))
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
        let addr = "0.0.0.0:3777".parse().unwrap();
        let listener = tokio::net::TcpListener::bind(&addr).expect("unable to bind TCP listener");
        let server = listener.incoming()
            .map_err(|e| eprintln!("accept failed = {:?}", e))
            .for_each({ let switch = switch.clone(); move |s| {
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
                tokio::spawn(handle_conn)
            }});
        { // Wire'em up!
            let mut swith_init = switch.inner.lock().unwrap();
            for i in triggers {
                swith_init.insert(i.id(), i.activate_master());
            }
        }
        tokio::run(server);
    }
}
