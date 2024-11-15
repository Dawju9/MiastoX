local fs = require("@lune/fs")
local roblox = require("@lune/roblox")
local net = require("@lune/net")
local placeFile = fs.readFile("ayachapter.rbxl")
local game = roblox.deserializePlace(placeFile)
-- Reading a place file
print("builded deserialized")