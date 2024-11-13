use std::env;
use std::process;
use std::fs;
use base64;

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
            "help" => {
                print_help();
            }
            "version" => {
                print_version();
            }
            "encode" => {
                encode_rs();
            }
            _ => {
                println!("Unknown command");
                print_help();
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
    println!("  help        Display this help message");
    println!("  version     Display the version number");
    println!("  encode      Encode rs script");
}

fn print_version() {
    println!("MiastoX version 0.1.0");
}

fn encode_rs() {
    let file_path = "path_to_your_file.rs"; // Update with the correct file path

    // Read the file contents
    let file_content = match fs::read_to_string(file_path) {
        Ok(content) => content,
        Err(e) => {
            println!("Failed to read file: {}", e);
            process::exit(1);
        }
    };

    // Encode the file content in base64
    let encoded_content = base64::encode(&file_content);

    // Print the encoded content
    println!("Encoded content:\n{}", encoded_content);
}



/*
**


use std::env;
use std::process;
use MiastoX::game;
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
            "help" => {
                print_help();
            }
            "version" => {
                print_version();
            }
            "encode" => {
                encode_rs();
            }
            _ => {
                println!("Unknown command");
                print_help();
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
    println!("  help        Display this help message");
    println!("  version     Display the version number");
    println!("  encode      Encode rs script");
}

fn print_version() {
    println!("MiastoX version 0.1.0");
}

fn encode_rs() {
    let file_path = "path_to_your_file.rs";
    let file_content = std::fs::read_to_string(file_path).unwrap();
    let encoded_content = base64::encode(&file_content);
    println!("Encoded content: {}", encoded_content);
}

**
*/
