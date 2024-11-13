use std::process::Command;

fn main() {
    // Write build-time information using the `built` crate
    if let Err(e) = built::write_built_file() {
        eprintln!("Failed to acquire build-time information: {}", e);
        std::process::exit(1);
    }

    // Run lune to compile the .rbxl file
    let lune_status = Command::new("lune")
        .arg("ayachapter.rbxl")
        .status();

    if let Err(e) = lune_status {
        eprintln!("Failed to run lune: {}", e);
        std::process::exit(1);
    }

    // Run rojo to process the Roblox game assets
    let rojo_status = Command::new("rojo")
        .arg("--output")
        .arg("build/rojo_output")
        .status();

    if let Err(e) = rojo_status {
        eprintln!("Failed to run rojo: {}", e);
        std::process::exit(1);
    }

    // Optional: You can also trigger other tasks like stylua or others here if needed
}
