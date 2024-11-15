use std::env;
use std::process;
use MiastoX::game;
use decode::decoded::{deserialize_rbxl_to_model, serialize_model_to_rbxl};
mod citix;
mod game;
mod lib;
mod bin;
use reqwest_middleware::ClientBuilder;
use reqwest_middleware::Middleware;
use tracing::info;
use tracing_subscriber::fmt::Subscriber;
use tracing_subscriber::prelude::*;
use reqwest::Client;
use reqwest_middleware::TracingMiddleware;

fn main() {
    // Konfiguracja tracing
    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::INFO)
        .init();

    let args: Vec<String> = env::args().collect();
    let model = deserialize_rbxl_to_model("AyaChapter.rbxl").unwrap();
    println!("{:?}", model);
    if args.len() > 1 {
        match args[1].as_str() {
            "run" => {
                // Tworzenie klienta z middleware
                let client: Client = ClientBuilder::new(Client::new())
                    .with(TracingMiddleware::default()) // Dodanie middleware Tracing
                    .build();
            
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
        // Sprawdzenie odpowiedzi
        match response {
            Ok(res) => info!("Response: {:?}", res),
            Err(e) => info!("Error: {:?}", e),
        }
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
// Use of a mod or pub mod is not actually necessary.
pub mod built_info {
    // Wykonanie zapytania
    let response = client.get("https://api.example.com")
        .send();
    
    // The file has been placed there by the build script.
    include!(concat!(env!("OUT_DIR"), "/built.rs"));
 }