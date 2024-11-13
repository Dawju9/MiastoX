use std::env;
use std::process;

mod citix;
mod game;
mod lib;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() > 1 {
        match args[1].as_str() {
            "run" => {
                game::run();
            }
            "build" => {
                citix::build();
            }
            "test" => {
                game::test();
            }
            "clean" => {
                citix::clean();
            }
            _ => {
                println!("Unknown command");
                process::exit(1);
            }
        }
    } else {
        println!("Hello, world!");
    }
}

fn print_help() {
    println!("Usage:");
    println!("  run         Run the game");
    println!("  build       Build the game");
    println!("  test        Run tests");
    println!("  clean       Clean the build directory");
}

fn print_version() {
    println!("MiastoX version 0.1.0");
}