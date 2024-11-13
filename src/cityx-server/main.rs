use std::collections::HashMap;

struct City {
    name: String,
    tasks: HashMap<String, bool>,
    server_tasks: HashMap<String, bool>,
    server_mechanics: HashMap<String, bool>,
    server_site_mechanics: HashMap<String, bool>,
    city_logic: HashMap<String, bool>,
}

impl City {
    fn new(name: String) -> City {
        City {
            name,
            tasks: HashMap::new(),
            server_tasks: HashMap::new(),
            server_mechanics: HashMap::new(),
            server_site_mechanics: HashMap::new(),
            city_logic: HashMap::new(),
        }
    }

    fn add_task(&mut self, task: String) {
        self.tasks.insert(task, false);
    }

    fn add_server_task(&mut self, task: String) {
        self.server_tasks.insert(task, false);
    }

    fn add_server_mechanic(&mut self, mechanic: String) {
        self.server_mechanics.insert(mechanic, false);
    }

    fn add_server_site_mechanic(&mut self, mechanic: String) {
        self.server_site_mechanics.insert(mechanic, false);
    }

    fn add_city_logic(&mut self, logic: String) {
        self.city_logic.insert(logic, false);
    }

    fn complete_task(&mut self, task: String) {
        if let Some(status) = self.tasks.get_mut(&task) {
            *status = true;
        }
    }

    fn complete_server_task(&mut self, task: String) {
        if let Some(status) = self.server_tasks.get_mut(&task) {
            *status = true;
        }
    }

    fn complete_server_mechanic(&mut self, mechanic: String) {
        if let Some(status) = self.server_mechanics.get_mut(&mechanic) {
            *status = true;
        }
    }

    fn complete_server_site_mechanic(&mut self, mechanic: String) {
        if let Some(status) = self.server_site_mechanics.get_mut(&mechanic) {
            *status = true;
        }
    }

    fn complete_city_logic(&mut self, logic: String) {
        if let Some(status) = self.city_logic.get_mut(&logic) {
            *status = true;
        }
    }

    fn view_tasks(&self) {
        println!("Tasks for {}:", self.name);
        for (task, status) in &self.tasks {
            println!("{}: {}", task, if *status { "Done" } else { "Not Done" });
        }
    }

    fn view_server_tasks(&self) {
        println!("Server Tasks for {}:", self.name);
        for (task, status) in &self.server_tasks {
            println!("{}: {}", task, if *status { "Done" } else { "Not Done" });
        }
    }

    fn view_server_mechanics(&self) {
        println!("Server Mechanics for {}:", self.name);
        for (mechanic, status) in &self.server_mechanics {
            println!("{}: {}", mechanic, if *status { "Done" } else { "Not Done" });
        }
    }

    fn view_server_site_mechanics(&self) {
        println!("Server Site Mechanics for {}:", self.name);
        for (mechanic, status) in &self.server_site_mechanics {
            println!("{}: {}", mechanic, if *status { "Done" } else { "Not Done" });
        }
    }

    fn view_city_logic(&self) {
        println!("City Logic for {}:", self.name);
        for (logic, status) in &self.city_logic {
            println!("{}: {}", logic, if *status { "Done" } else { "Not Done" });
        }
    }
}

fn main() {
    let mut city = City::new("New York".to_string());
    city.add_task("Build a new park".to_string());
    city.add_task("Fix the roads".to_string());
    city.add_server_task("Update server software".to_string());
    city.add_server_task("Increase server storage".to_string());
    city.add_server_mechanic("Check server temperature".to_string());
    city.add_server_mechanic("Replace server fans".to_string());
    city.add_server_site_mechanic("Check server site temperature".to_string());
    city.add_server_site_mechanic("Replace server site fans".to_string());
    city.add_city_logic("Implement new city rules".to_string());
    city.add_city_logic("Update city policies".to_string());
    city.view_tasks();
    city.view_server_tasks();
    city.view_server_mechanics();
    city.view_server_site_mechanics();
    city.view_city_logic();
    city.complete_task("Build a new park".to_string());
    city.complete_server_task("Update server software".to_string());
    city.complete_server_mechanic("Check server temperature".to_string());
    city.complete_server_site_mechanic("Check server site temperature".to_string());
    city.complete_city_logic("Implement new city rules".to_string());
    city.view_tasks();
    city.view_server_tasks();
    city.view_server_mechanics();
    city.view_server_site_mechanics();
    city.view_city_logic();
}