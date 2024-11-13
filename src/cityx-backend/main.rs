use std::collections::HashMap;

struct City {
    name: String,
    tasks: HashMap<String, bool>,
    population: u32,
    budget: f64,
    infrastructure: HashMap<String, bool>,
}

impl City {
    fn new(name: String) -> City {
        City {
            name,
            tasks: HashMap::new(),
            population: 0,
            budget: 0.0,
            infrastructure: HashMap::new(),
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

    fn add_infrastructure(&mut self, infrastructure: String) {
        self.infrastructure.insert(infrastructure, false);
    }

    fn complete_infrastructure(&mut self, infrastructure: String) {
        if let Some(status) = self.infrastructure.get_mut(&infrastructure) {
            *status = true;
        }
    }

    fn view_infrastructure(&self) {
        println!("Infrastructure for {}:", self.name);
        for (infrastructure, status) in &self.infrastructure {
            println!("{}: {}", infrastructure, if *status { "Built" } else { "Not Built" });
        }
    }

    fn increase_population(&mut self, amount: u32) {
        self.population += amount;
    }

    fn decrease_population(&mut self, amount: u32) {
        if self.population >= amount {
            self.population -= amount;
        } else {
            self.population = 0;
        }
    }

    fn view_population(&self) {
        println!("Population of {}: {}", self.name, self.population);
    }

    fn increase_budget(&mut self, amount: f64) {
        self.budget += amount;
    }

    fn decrease_budget(&mut self, amount: f64) {
        if self.budget >= amount {
            self.budget -= amount;
        } else {
            self.budget = 0.0;
        }
    }

    fn view_budget(&self) {
        println!("Budget of {}: {}", self.name, self.budget);
    }
}

fn main() {
    let mut city = City::new("New York".to_string());
    city.add_task("Build a new park".to_string());
    city.add_task("Fix the roads".to_string());
    city.view_tasks();
    city.complete_task("Build a new park".to_string());
    city.view_tasks();

    city.add_infrastructure("Build a new hospital".to_string());
    city.add_infrastructure("Build a new school".to_string());
    city.view_infrastructure();
    city.complete_infrastructure("Build a new hospital".to_string());
    city.view_infrastructure();

    city.increase_population(1000);
    city.view_population();
    city.decrease_population(500);
    city.view_population();

    city.increase_budget(1000000.0);
    city.view_budget();
    city.decrease_budget(500000.0);
    city.view_budget();
}