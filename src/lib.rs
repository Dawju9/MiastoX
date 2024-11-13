// src/lib.rs

pub fn greet(name: &str) {
    println!("Hello, {}! Welcome to MiastoX.", name);
}
pub class Game;
/// A module for game-related utilities.
pub mod game_utils {
    /// A struct for representing a game object.
    pub struct GameObject {
        /// A unique identifier for the game object.
        pub id: u32,
        /// The name of the game object.
        pub name: String,
    }

    impl GameObject {
        /// Creates a new instance of `GameObject`.
        pub fn new(id: u32, name: String) -> Self {
            GameObject { id, name }
        }

        /// Returns the ID of the game object.
        pub fn get_id(&self) -> u32 {
            self.id
        }

        /// Returns the name of the game object.
        pub fn get_name(&self) -> &str {
            &self.name
        }
    }
}

/// A module for game-related data structures.
pub mod game_data {
    use super::game_utils;

    /// A struct for representing a game level.
    pub struct GameLevel {
        /// The ID of the game level.
        pub id: u32,
        /// The name of the game level.
        pub name: String,
        /// A list of game objects in the level.
        pub objects: Vec<game_utils::GameObject>,
    }

    impl GameLevel {
        /// Creates a new instance of `GameLevel`.
        pub fn new(id: u32, name: String) -> Self {
            GameLevel {
                id,
                name,
                objects: Vec::new(),
            }
        }

        /// Adds a game object to the level.
        pub fn add_object(&mut self, object: game_utils::GameObject) {
            self.objects.push(object);
        }

        /// Returns the ID of the game level.
        pub fn get_id(&self) -> u32 {
            self.id
        }

        /// Returns the name of the game level.
        pub fn get_name(&self) -> &str {
            &self.name
        }

        /// Returns a list of game objects in the level.
        pub fn get_objects(&self) -> &Vec<game_utils::GameObject> {
            &self.objects
        }
    }
}

/// A module for game-related events.
pub mod game_events {
    use super::game_utils;

    /// A struct for representing a game event.
    pub struct GameEvent {
        /// The type of game event.
        pub event_type: String,
        /// The game object associated with the event.
        pub object: game_utils::GameObject,
    }

    impl GameEvent {
        /// Creates a new instance of `GameEvent`.
        pub fn new(event_type: String, object: game_utils::GameObject) -> Self {
            GameEvent { event_type, object }
        }

        /// Returns the type of game event.
        pub fn get_event_type(&self) -> &str {
            &self.event_type
        }

        /// Returns the game object associated with the event.
        pub fn get_object(&self) -> &game_utils::GameObject {
            &self.object
        }
    }
}

/// A module for game-related logic.
pub mod game_logic {
    use super::game_data;
    use super::game_events;

    /// A struct for representing a game logic.
    pub struct GameLogic {
        /// The game level associated with the logic.
        pub level: game_data::GameLevel,
        /// A list of game events in the logic.
        pub events: Vec<game_events::GameEvent>,
    }

    impl GameLogic {
        /// Creates a new instance of `GameLogic`.
        pub fn new(level: game_data::GameLevel) -> Self {
            GameLogic {
                level,
                events: Vec::new(),
            }
        }

        /// Adds a game event to the logic.
        pub fn add_event(&mut self, event: game_events::GameEvent) {
            self.events.push(event);
        }

        /// Returns the game level associated with the logic.
        pub fn get_level(&self) -> &game_data::GameLevel {
            &self.level
        }

        /// Returns a list of game events in the logic.
        pub fn get_events(&self) -> &Vec<game_events::GameEvent> {
            &self.events
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_game_object() {
        let game_object = game_utils::GameObject::new(1, "Test Object".to_string());
        assert_eq!(game_object.get_id(), 1);
        assert_eq!(game_object.get_name(), "Test Object");
    }

    #[test]
    fn test_game_level() {
        let mut game_level = game_data::GameLevel::new(1, "Test Level".to_string());
        let game_object = game_utils::GameObject::new(1, "Test Object".to_string());
        game_level.add_object(game_object);
        assert_eq!(game_level.get_id(), 1);
        assert_eq!(game_level.get_name(), "Test Level");
        assert_eq!(game_level.get_objects().len(), 1);
    }

    #[test]
    fn test_game_event() {
        let game_object = game_utils::GameObject::new(1, "Test Object".to_string());
        let game_event = game_events::GameEvent::new("Test Event".to_string(), game_object);
        assert_eq!(game_event.get_event_type(), "Test Event");
        assert_eq!(game_event.get_object().get_id(), 1);
    }

    #[test]
    fn test_game_logic() {
        let mut game_level = game_data::GameLevel::new(1, "Test Level".to_string());
        let game_object = game_utils::GameObject::new(1, "Test Object".to_string());
        game_level.add_object(game_object);
        let mut game_logic = game_logic::GameLogic::new(game_level);
        let game_event = game_events::GameEvent::new("Test Event".to_string(), game_object);
        game_logic.add_event(game_event);
        assert_eq!(game_logic.get_level().get_id(), 1);
        assert_eq!(game_logic.get_events().len(), 1);
    }
}