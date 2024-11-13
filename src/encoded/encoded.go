package decode

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

// ModelData represents the structure of the model
type ModelData struct {
	Name       string   `json:"name"`
	Position   [3]float32 `json:"position"`
	Properties []string `json:"properties"`
}

// Deserialize function to read a .rbxl file (assuming it's JSON encoded)
func DeserializeRbxlToModel(filePath string) (ModelData, error) {
	file, err := ioutil.ReadFile(filePath)
	if err != nil {
		log.Printf("Error reading file: %v", err)
		return ModelData{}, err
	}

	var model ModelData
	err = json.Unmarshal(file, &model)
	if err != nil {
		log.Printf("Error unmarshaling JSON: %v", err)
		return ModelData{}, err
	}

	return model, nil
}

// Serialize function to convert model data back into a .rbxl (JSON format here)
func SerializeModelToRbxl(model ModelData, outputPath string) error {
	encoded, err := json.MarshalIndent(model, "", "\t")
	if err != nil {
		log.Printf("Error marshaling JSON: %v", err)
		return err
	}

	// Write the encoded content to the output file
	err = ioutil.WriteFile(outputPath, encoded, os.ModePerm)
	if err != nil {
		log.Printf("Error writing file: %v", err)
		return err
	}

	fmt.Printf("Successfully written to %s\n", outputPath)
	return nil
}

func main() {
	// Example usage of the functions
	filePath := "path_to_your_input_file.rbxl"
	outputPath := "path_to_your_output_file.rbxl"

	// Deserialize from file
	model, err := DeserializeRbxlToModel(filePath)
	if err != nil {
		log.Fatalf("Failed to deserialize: %v", err)
	}

	// Serialize and write back to file
	err = SerializeModelToRbxl(model, outputPath)
	if err != nil {
		log.Fatalf("Failed to serialize: %v", err)
	}
}

/*
**


package decode

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
)

// Example of a structure for the model
type ModelData struct {
	Name       string   `json:"name"`
	Position   [3]float32 `json:"position"`
	Properties []string `json:"properties"`
}

// Deserialize function to read a .rbxl file (assuming it's JSON encoded)
func DeserializeRbxlToModel(filePath string) (ModelData, error) {
	file, err := ioutil.ReadFile(filePath)
	if err != nil {
		log.Printf("Error reading file: %v", err)
		return ModelData{}, err
	}

	var model ModelData
	err = json.Unmarshal(file, &model)
	if err != nil {
		log.Printf("Error unmarshaling JSON: %v", err)
		return ModelData{}, err
	}

	return model, nil
}

// Serialize function to convert model data back into a .rbxl (JSON format here)
func SerializeModelToRbxl(model ModelData) (string, error) {
	encoded, err := json.MarshalIndent(model, "", "\t")
	if err != nil {
		log.Printf("Error marshaling JSON: %v", err)
		return "", err
	}

	return string(encoded), nil
}

**
*/