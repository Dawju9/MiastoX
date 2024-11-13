use std::collections::HashMap;

struct City {
    name: String,
    tasks: HashMap<String, bool>,
    clients: HashMap<String, HashMap<String, bool>>,
}

impl City {
    fn new(name: String) -> City {
        City {
            name,
            tasks: HashMap::new(),
            clients: HashMap::new(),
        }
    }

    fn add_task(&mut self, task: String) {
        self.tasks.insert(task, false);
    }

    fn complete_task(&mut self, task: String) {
        if let Some(status) = self.tasks.get_mut(&task) {
            *status = true;
        }
    }

    fn view_tasks(&self) {
        println!("Tasks for {}:", self.name);
        for (task, status) in &self.tasks {
            println!("{}: {}", task, if *status { "Done" } else { "Not Done" });
        }
    }

    fn add_client(&mut self, client_name: String) {
        self.clients.insert(client_name, HashMap::new());
    }

    fn add_client_task(&mut self, client_name: String, task: String) {
        if let Some(client_tasks) = self.clients.get_mut(&client_name) {
            client_tasks.insert(task, false);
        }
    }

    fn complete_client_task(&mut self, client_name: String, task: String) {
        if let Some(client_tasks) = self.clients.get_mut(&client_name) {
            if let Some(status) = client_tasks.get_mut(&task) {
                *status = true;
            }
        }
    }

    fn view_client_tasks(&self, client_name: String) {
        if let Some(client_tasks) = self.clients.get(&client_name) {
            println!("Tasks for {} in {}:", client_name, self.name);
            for (task, status) in client_tasks {
                println!("{}: {}", task, if *status { "Done" } else { "Not Done" });
            }
        }
    }

    fn view_all_client_tasks(&self) {
        for (client_name, client_tasks) in &self.clients {
            println!("Tasks for {} in {}:", client_name, self.name);
            for (task, status) in client_tasks {
                println!("{}: {}", task, if *status { "Done" } else { "Not Done" });
            }
        }
    }
}

fn main() {
    let mut city = City::new("New York".to_string());
    city.add_task("Build a new park".to_string());
    city.add_task("Fix the roads".to_string());
    city.view_tasks();

    city.add_client("John".to_string());
    city.add_client_task("John".to_string(), "Buy groceries".to_string());
    city.add_client_task("John".to_string(), "Walk the dog".to_string());
    city.view_client_tasks("John".to_string());

    city.add_client("Alice".to_string());
    city.add_client_task("Alice".to_string(), "Buy milk".to_string());
    city.add_client_task("Alice".to_string(), "Walk the cat".to_string());
    city.view_client_tasks("Alice".to_string());

    city.view_all_client_tasks();

    city.complete_client_task("John".to_string(), "Buy groceries".to_string());
    city.view_client_tasks("John".to_string());
}