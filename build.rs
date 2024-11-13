use std::env;
use std::process::Command;

fn main() {
    // Automatyczne wykonanie polecenia "go build" za pomocą `gobuild`
    if let Err(e) = gobuild::Build::new().run() {
        eprintln!("Failed to run gobuild: {}", e);
        std::process::exit(1);
    }
    
    // Kompilacja pliku Go (jeśli jest)
    gobuild::Build::new()
        .file("hello.go")
        .compile("hello");

    // Zapisz informacje o czasie kompilacji
    if let Err(e) = built::write_built_file() {
        eprintln!("Failed to acquire build-time information: {}", e);
        std::process::exit(1);
    }

    // Uruchomienie Lune do kompilacji pliku .rbxl
    let lune_status = Command::new("lune")
        .arg("ayachapter.rbxl")
        .status();

    if let Err(e) = lune_status {
        eprintln!("Failed to run lune: {}", e);
        std::process::exit(1);
    }

    // Uruchomienie Rojo do przetwarzania zasobów Roblox
    let rojo_status = Command::new("rojo")
        .arg("--output")
        .arg("build/rojo_output")
        .status();

    if let Err(e) = rojo_status {
        eprintln!("Failed to run rojo: {}", e);
        std::process::exit(1);
    }

    // Opcjonalnie, można uruchomić inne narzędzia jak stylua
    // Command::new("stylua").arg("src/**/*.lua").status();
    
    // Informacje dla kompilatora o ścieżkach do plików
    println!("cargo:rerun-if-changed=src/lib.rs");
    println!("cargo:rerun-if-changed=src/main.rs");
}
