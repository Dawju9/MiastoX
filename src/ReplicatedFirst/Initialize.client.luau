--!native
--!optimize 2
--!strict

-- MiastoX ReplicatedFirst Initialization
-- Uses cityx framework for core init

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- Wait for PlayerGui
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Use cityx framework for initialization
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CityXClient = ReplicatedStorage:FindFirstChild("CityXClient")

if CityXClient then
	local CityXInit = require(CityXClient)
	if CityXInit.onClientInit then
		CityXInit.onClientInit(PlayerGui)
	end
end

-- Remove default loading screen
ReplicatedFirst:RemoveDefaultLoadingScreen()

print("[MiastoX] Client initialized via CityX Framework")