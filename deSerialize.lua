local fs = require("@lune/fs")
local roblox = require("@lune/roblox")
 
local placeFile = fs.readFile("ayachapter.rbxl")
local game = roblox.deserializePlace(placeFile)
-- Reading a place file

-- Manipulating and reading instances - just like in Roblox!
local workspace = game:GetService("Workspace")
for _, child in workspace:GetChildren() do
	print("Found child " .. child.Name .. " of class " .. child.ClassName)
end
 
-- Writing a place filerokit add lune
local newPlaceFile = roblox.serializePlace(game)
fs.writeFile("ayachapter.rbxl", newPlaceFile)
print("builded child ")
