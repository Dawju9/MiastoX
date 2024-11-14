package decode

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

// Example of a structure for the model
type ModelData struct {
	Name       string   `json:"name"`
	Position   [3]float32 `json:"position"`
	Properties []string `json:"properties"`
}

// Deserialize function to read a .rbxl file (assuming it's JSON encoded)
func Deserialpackage decode

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

// Example of a structure for the model
type ModelData struct {
	Name       string   `json:"name"`
	Position   [3]float32 `json:"position"`
	Properties []string `json:"properties"`
}

// Deserialize function to read a .rbxl file (assuming it's JSON encoded)
func DeserializeRbxlToModel(filePath string) (*ModelData, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return nil, fmt.Errorf("error opening file: %w", err)
	}
	defer file.Close()

	var model ModelData
	err = json.NewDecoder(file).Decode(&model)
	if err != nil {
		return nil, fmt.Errorf("error decoding JSON: %w", err)
	}

	return &model, nil
}

// Serialize function to convert model data back into a .rbxl (JSON format here)
func SerializeModelToRbxl(model *ModelData) (string, error) {
	encoded, err := json.MarshalIndent(model, "", "\t")
	if err != nil {
		return "", fmt.Errorf("error encoding JSON: %w", err)
	}

	return string(encoded), nil
}izeRbxlToModel(filePath string) (ModelData, error) {
	file, err := os.Open(filePath)
	if err != nil {
		log.Printf("Error opening file: %v", err)
		return ModelData{}, err
	}
	defer file.Close()

	var model ModelData
	err = json.NewDecoder(file).Decode(&model)
	if err != nil {
		log.Printf("Error decoding JSON: %v", err)
		return ModelData{}, err
	}

	return model, nil
}

// Serialize function to convert model data back into a .rbxl (JSON format here)
func SerializeModelToRbxl(model ModelData) (string, error) {
	encoded, err := json.MarshalIndent(model, "", "\t")
	if err != nil {
		log.Printf("Error encoding JSON: %v", err)
		return "", err
	}

	return string(encoded), nil
}