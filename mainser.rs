local lune = require("lune")
local fs = require("fs")
local roblox = require("@lune/roblox")

local function deserializeRbxlToDecoded(inputPath, outputPath)
    local fileContent = fs.readFile(inputPath)
    local gameData = roblox.deserializePlace(fileContent)

    -- Rozbijanie i zapisywanie w postaci plików i folderów
    fs.writeDir(outputPath)
    for _, instance in ipairs(gameData:GetService("Workspace"):GetChildren()) do
        local modelData = roblox.serializeModel({ instance })
        fs.writeFile(string.format("%s/%s.lua", outputPath, instance.Name), modelData)
    end
end

local function serializeDecodedToRbxl(inputPath, outputPath)
    local instances = {}
    for _, fileName in ipairs(fs.listFiles(inputPath)) do
        local modelData = fs.readFile(string.format("%s/%s", inputPath, fileName))
        local instance = roblox.deserializeModel(modelData)
        table.insert(instances, instance)
    end

    local gameData = roblox.createDataModel()
    for _, instance in ipairs(instances) do
        instance.Parent = gameData:GetService("Workspace")
    end

    local serializedContent = roblox.serializePlace(gameData)
    fs.writeFile(outputPath, serializedContent)
end

return {
    deserializeRbxlToDecoded = deserializeRbxlToDecoded,
    serializeDecodedToRbxl = serializeDecodedToRbxl
}