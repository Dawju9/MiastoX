--!native
--!optimize 2
--!strict

-- MiastoX Character Controller
-- Uses cityx PlayerController + custom HumanoidStates

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HumanoidStates = require(ReplicatedStorage.Settings.HumanoidStates)

local Character = script.Parent
local Humanoid = Character:WaitForChild("Humanoid")

-- Apply MiastoX-specific humanoid states
for State, Value in pairs(HumanoidStates) do
	Humanoid:SetStateEnabled(State, Value)
end

-- Use cityx framework for movement
local CityXClient = ReplicatedStorage:FindFirstChild("CityXClient")
if CityXClient and CityXClient.PlayerController then
	local PlayerController = require(CityXClient.PlayerController)
	PlayerController.init(Character)
end

print("[MiastoX] Character controller initialized")