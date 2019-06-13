#[macro_use]
extern crate clap;
use sprinkler_api::{SprinklerBuilder, SprinklerOptions, Sprinkler, Switch, CommCheck};

const MASTER_ADDR: &str = "desktop-cyberpower.localdomain:3777";

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
    let sprinklers: Vec<Box<dyn Sprinkler>> = vec![
        Box::new(builder.build::<CommCheck>(String::from("alex-jetson-tx2")))
    ];
    if args.is_present("AGENT") {
        sprinkler_api::agent(&sprinklers);
        sprinkler_api::loop_forever();
    }
    else {
        let switch = Switch::new();
        switch.connect_all(&sprinklers);
        let addr = "0.0.0.0:3777".parse().unwrap();
        sprinkler_api::server(&addr, &switch);
    }
}
