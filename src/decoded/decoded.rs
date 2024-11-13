use std::env;
use std::process;
use MiastoX::game;
mod citix;
mod game;
mod lib;

use std::fs::File;
use std::io::{self, Read};
use serde::{Serialize, Deserialize};
use serde_json;

#[derive(Serialize, Deserialize, Debug)]
struct ModelData {
    name: String,
    position: [f32; 3],
    properties: Vec<String>,
}

pub fn deserialize_rbxl_to_model(file_path: &str) -> Result<ModelData, io::Error> {
    let mut file = File::open(file_path)?;
    let mut content = String::new();
    file.read_to_string(&mut content)?;

    let model: ModelData = match serde_json::from_str(&content) {
        Ok(model) => model,
        Err(err) => {
            eprintln!("Error deserializing model: {}", err);
            process::exit(1);
        }
    };

    Ok(model)
}

pub fn serialize_model_to_rbxl(model: &ModelData) -> Result<String, io::Error> {
    let json = match serde_json::to_string(model) {
        Ok(json) => json,
        Err(err) => {
            eprintln!("Error serializing model: {}", err);
            process::exit(1);
        }
    };

    Ok(json)
}