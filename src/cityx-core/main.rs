use std::collections::HashMap;

struct CityCore {
    name: String,
    mechanics: HashMap<String, bool>,
    logic: HashMap<String, bool>,
}

impl CityCore {
    fn new(name: String) -> CityCore {
        CityCore {
            name,
            mechanics: HashMap::new(),
            logic: HashMap::new(),
        }
    }

    fn add_mechanic(&mut self, mechanic: String) {
        self.mechanics.insert(mechanic, false);
    }

    fn add_logic(&mut self, logic: String) {
        self.logic.insert(logic, false);
    }

    fn complete_mechanic(&mut self, mechanic: String) {
        if let Some(status) = self.mechanics.get_mut(&mechanic) {
            *status = true;
        }
    }

    fn complete_logic(&mut self, logic: String) {
        if let Some(status) = self.logic.get_mut(&logic) {
            *status = true;
        }
    }

    fn view_mechanics(&self) {
        println!("Mechanics for {}:", self.name);
        for (mechanic, status) in &self.mechanics {
            println!("{}: {}", mechanic, if *status { "Done" } else { "Not Done" });
        }
    }

    fn view_logic(&self) {
        println!("Logic for {}:", self.name);
        for (logic, status) in &self.logic {
            println!("{}: {}", logic, if *status { "Done" } else { "Not Done" });
        }
    }
}

struct City {
    name: String,
    tasks: HashMap<String, bool>,
    core: CityCore,
}

impl City {
    fn new(name: String) -> City {
        City {
            name,
            tasks: HashMap::new(),
            core: CityCore::new(name.clone()),
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

    fn add_mechanic(&mut self, mechanic: String) {
        self.core.add_mechanic(mechanic);
    }

    fn add_logic(&mut self, logic: String) {
        self.core.add_logic(logic);
    }

    fn complete_mechanic(&mut self, mechanic: String) {
        self.core.complete_mechanic(mechanic);
    }

    fn complete_logic(&mut self, logic: String) {
        self.core.complete_logic(logic);
    }

    fn view_mechanics(&self) {
        self.core.view_mechanics();
    }

    fn view_logic(&self) {
        self.core.view_logic();
    }
}

fn main() {
    let mut city = City::new("New York".to_string());
    city.add_task("Build a new park".to_string());
    city.add_task("Fix the roads".to_string());
    city.view_tasks();
    city.complete_task("Build a new park".to_string());
    city.view_tasks();

    city.add_mechanic("Implement traffic lights".to_string());
    city.add_logic("Create a public transportation system".to_string());
    city.view_mechanics();
    city.view_logic();
    city.complete_mechanic("Implement traffic lights".to_string());
    city.complete_logic("Create a public transportation system".to_string());
    city.view_mechanics();
    city.view_logic();
}