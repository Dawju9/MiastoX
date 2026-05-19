--!native
--!optimize 2
--!strict

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer
local PlayerGUI: PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Screen = require(ReplicatedFirst.Screen)
Screen.Parent = PlayerGUI
ReplicatedFirst:RemoveDefaultLoadingScreen()

local LightingRiver = ReplicatedFirst:FindFirstChild("LightingRiver")
local Generator = ReplicatedFirst:FindFirstChild("Generator")

--// LightingRiver Element Manager \\--
local function manageLightingRiverElement(element: Instance)
	if element:IsA("BasePart") then
		element.Anchored = true
		element.CanCollide = false
	end
end

--// LightingRiver Manager \\--
local function manageLightingRiver()
	if not LightingRiver then
		return
	end
	for _, object in LightingRiver:GetDescendants() do
		manageLightingRiverElement(object)
	end
end

--// Apply static lighting elements \\--
local function applyLightingRiver()
	if not LightingRiver then
		return
	end

	manageLightingRiver()

	for _, object in LightingRiver:GetDescendants() do
		object.Parent = Lighting
	end

	LightingRiver:Destroy()
	print("[MiastoX] LightingRiver applied to Lighting")
end

--// Generator \\--
local function generate()
	if not Generator then
		return
	end
	local template = Generator:FindFirstChild("Template")
	if not template then
		return
	end
	local instance = template:Clone()
	instance.Parent = Generator
	CollectionService:AddTag(instance, "Generated")
	task.wait(1)
	instance:Destroy()
end

--// LightingRiver Element Generator \\--
local function generateLightingRiverElement()
	local riverTemplate = LightingRiver and LightingRiver:FindFirstChild("Template")
	if not riverTemplate then
		return
	end
	local instance = riverTemplate:Clone()
	manageLightingRiverElement(instance)
	instance.Parent = Lighting
end

--// Apply static lighting \\--
applyLightingRiver()

--// City ambience \\--
Lighting.Ambient = Color3.fromRGB(80, 80, 85)
Lighting.Brightness = 1.2
Lighting.GlobalShadows = true
Lighting.Outlines = false

--// Generator Loop \\--
task.spawn(function()
	while true do
		generate()
		task.wait(5)
	end
end)

--// LightingRiver Element Loop \\--
task.spawn(function()
	while true do
		generateLightingRiverElement()
		task.wait(10)
	end
end)

print("[MiastoX] Generator initialized — lighting + generator systems running")
