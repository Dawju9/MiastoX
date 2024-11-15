use std::io;

mod citix;

fn main() {
    println!("Welcome to Citix!");

    loop {
        println!("1. Start Citix");
        println!("2. Quit");

        let mut input = String::new();

        io::stdin().read_line(&mut input)
            .expect("Failed to read line");

        let input: u32 = match input.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match input {
            1 => citix::start(),
            2 => break,
            _ => println!("Invalid input"),
        }
    }
}