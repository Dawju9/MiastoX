local ReplicatedStorage = game:GetService("ReplicatedStorage")
local require = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Eden"))

require:InitModules {
    -- (Optional) Module Paths
    DisplayInfo = shared("Shared/DisplayInfo"),
    FistCheck = shared("Client/Scripts/FistCheck")
}

-- FistCheck Script
local FistCheck = require("FistCheck")

local function onFistCheck()
    -- Code to check for fist
end

FistCheck:Init(onFistCheck)