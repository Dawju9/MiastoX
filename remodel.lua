-- Read the place file
local game = remodel.readPlaceFile("../build/rojo_output/cityx.rbxlx")

-- Create a directory for the models if it doesn't exist
remodel.createDirAll("models")

-- Get the models from ReplicatedStorage
local Models = game.ReplicatedStorage.Models

-- Loop through the models and write them out as separate files
for _, model in ipairs(Models:GetChildren()) do
    -- Save each model as an rbxmx file
    remodel.writeModelFile("models/" .. model.Name .. ".rbxmx", model)
end
