--!native
--!optimize 2
--!strict

-- MiastoX Player Controller
-- Uses cityx UIManager + custom loading screen

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- First, use cityx framework for core UI
local CityXClient = ReplicatedStorage:FindFirstChild("CityXClient")
if CityXClient and CityXClient.UIManager then
	local UIManager = require(CityXClient.UIManager)
	UIManager.init(PlayerGui)
end

-- Then, handle MiastoX-specific loading screen
local Screen = script:FindFirstChild("Screen")
if Screen then
	Screen.Parent = PlayerGui
end

-- Remove default loading screen
ReplicatedFirst:RemoveDefaultLoadingScreen()

-- Custom loading screen logic
task.wait(2)
local OldScreen = PlayerGui:FindFirstChild("StaticLoadingScreen")
if OldScreen then
	OldScreen:Destroy()
end

task.wait(1)
print("[MiastoX] Player controller initialized")