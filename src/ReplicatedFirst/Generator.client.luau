--// Services \\--
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

--// Local Variables \\--
local LocalPlayer = Players.LocalPlayer
local Screen = require(ReplicatedFirst.Screen)
local LightingRiver = ReplicatedFirst.LightingRiver
local Generator = ReplicatedFirst.Generator

--// Code \\--
-- Remove the default loading screen and then replace it
local PlayerGUI: PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
Screen.Parent = PlayerGUI
ReplicatedFirst:RemoveDefaultLoadingScreen()

-- Add the default lighting effects
for _, Object in pairs(LightingRiver:GetDescendants()) do
   Object.Parent = Lighting
end
LightingRiver:Destroy()

--// Generator \\--
local function generate()
    local template = Generator.Template
    local instance = template:Clone()
    instance.Parent = Generator
    CollectionService:AddTag(instance, "Generated")
    wait(1)
    instance:Destroy()
end

--// LightingRiver Manager \\--
local function manageLightingRiver()
    for _, object in pairs(LightingRiver:GetDescendants()) do
        if object:IsA("BasePart") then
            object.Anchored = true
            object.CanCollide = false
        end
    end
end

--// LightingRiver Element Manager \\--
local function manageLightingRiverElement(element)
    if element:IsA("BasePart") then
        element.Anchored = true
        element.CanCollide = false
    end
end

--// Generator Loop \\--
while true do
    generate()
    wait(5)
end

--// LightingRiver Element Generator \\--
local function generateLightingRiverElement()
    local template = LightingRiver.Template
    local instance = template:Clone()
    instance.Parent = LightingRiver
    manageLightingRiverElement(instance)
end

--// LightingRiver Element Loop \\--
while true do
    generateLightingRiverElement()
    wait(10)
end