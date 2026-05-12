--!native
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LevelGenerator = require(ReplicatedStorage.Components.LevelGenerator)
local WeatherSystem = require(ReplicatedStorage.Components.WeatherSystem)

local LevelManager = {}
LevelManager.__index = LevelManager

export type LevelDifficulty = "easy" | "medium" | "hard" | "extreme"
export type LevelType = "normal" | "infinite" | "paradox" | "time_loop" | "mirror" | "void"

local FLOORS_PER_LEVEL = 10
local SPECIAL_LEVEL_INTERVAL = 25

local LevelTypeConfig = {
	normal = {
		floors = 10,
		description = "Standard climb",
		difficulty = "normal",
	},
	infinite = {
		floors = -1,
		description = "Infinite spiral - never ending",
		difficulty = "scaling",
	},
	paradox = {
		floors = 5,
		description = "Impossible geometry",
		difficulty = "hard",
	},
	time_loop = {
		floors = 7,
		description = "Time loop - same but different",
		difficulty = "medium",
	},
	mirror = {
		floors = 8,
		description = "Mirror dimension",
		difficulty = "hard",
	},
	void = {
		floors = 3,
		description = "The void - fall and restart",
		difficulty = "extreme",
	},
}

function LevelManager.new()
	local self = setmetatable({}, LevelManager)
	self.levelGenerator = LevelGenerator.new()
	self.weatherSystem = WeatherSystem.new()
	self.currentFloor = 1
	self.currentLevel = 1
	self.currentDifficulty = "easy" :: LevelDifficulty
	self.currentLevelType = "normal" :: LevelType
	self.generatedFloors = {}
	self.levelFolder = nil
	self.isInfiniteMode = false
	self.infiniteFloorsGenerated = 0
	return self
end

function LevelManager:createLevelFolder()
	if not self.levelFolder then
		self.levelFolder = Instance.new("Folder")
		self.levelFolder.Name = "LevelContainer"
		self.levelFolder.Parent = Workspace
	end
	return self.levelFolder
end

function LevelManager:getDifficultyForFloor(floorNumber: number): LevelDifficulty
	if floorNumber <= 10 then
		return "easy"
	elseif floorNumber <= 25 then
		return "medium"
	elseif floorNumber <= 50 then
		return "hard"
	elseif floorNumber <= 100 then
		return "extreme"
	else
		return "extreme"
	end
end

function LevelManager:getNextLevelType(): LevelType
	local floor = self.currentFloor

	if floor == 1 then
		return "normal"
	elseif floor % 100 == 0 then
		return "void"
	elseif floor % 75 == 0 then
		return "paradox"
	elseif floor % 50 == 0 then
		return "time_loop"
	elseif floor % 33 == 0 then
		return "mirror"
	elseif floor >= 15 and self.isInfiniteMode then
		return "infinite"
	else
		return "normal"
	end
end

function LevelManager:generateInfiniteSpiral(): number
	local container = self:createLevelFolder()
	local baseHeight = (self.currentFloor - 1) * 15
	local spiralRadius = 15
	local floors = 50

	print(`[LevelManager] Generating INFINITE SPIRAL level...`)

	for f = 1, floors do
		local angle = (f / 10) * math.pi * 2
		local height = baseHeight + (f * 12)

		for i = 1, 8 do
			local part = Instance.new("Part")
			part.Name = `Infinite_Floor_{f}_Platform_{i}`
			part.Size = Vector3.new(4, 1, 4)
			part.Position = Vector3.new(
				math.cos(angle + (i * math.pi / 4)) * spiralRadius,
				height,
				math.sin(angle + (i * math.pi / 4)) * spiralRadius
			)
			part.Anchored = true
			part.CanCollide = true

			local highlight = Instance.new("Highlight")
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(255, 215, 0)
			highlight.OutlineColor = Color3.fromRGB(255, 140, 0)
			highlight.Parent = part

			part.Parent = container
		end

		self.generatedFloors[self.currentFloor] = true
		self.currentFloor += 1
		self.infiniteFloorsGenerated += 1
	end

	self.isInfiniteMode = true
	self.weatherSystem:apply("eclipse")

	print(`[LevelManager] Generated infinite spiral with {floors} floors`)
	return floors
end

function LevelManager:generateParadoxLevel(): number
	local container = self:createLevelFolder()
	local baseHeight = (self.currentFloor - 1) * 20

	print(`[LevelManager] Generating PARADOX level - impossible geometry...`)

	for f = 1, 5 do
		local height = baseHeight + (f * 25)

		for i = 1, 6 do
			local part = Instance.new("Part")
			part.Name = `Paradox_Floor_{f}_Platform_{i}`
			part.Size = Vector3.new(5, 1, 5)

			local offsetX = (math.random() - 0.5) * 20
			local offsetZ = (math.random() - 0.5) * 20
			local offsetY = math.random() * 10

			part.Position = Vector3.new(offsetX, height + offsetY, offsetZ)
			part.Anchored = true
			part.CanCollide = true
			part.Transparency = 0.3

			local highlight = Instance.new("Highlight")
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(138, 43, 226)
			highlight.OutlineColor = Color3.fromRGB(75, 0, 130)
			highlight.FillTransparency = 0.5
			highlight.Parent = part

			local decal = Instance.new("Decal")
			decal.Texture = "rbxassetid://0"
			decal.Face = Enum.NormalId.Top
			decal.Parent = part

			part.Parent = container

			local portal = Instance.new("Part")
			portal.Name = `Portal_{f}_{i}`
			portal.Size = Vector3.new(3, 5, 0.5)
			portal.Position = part.Position + Vector3.new(0, 3, 0)
			portal.Anchored = true
			portal.CanCollide = false
			portal.Transparency = 0.5
			portal.Color = Color3.fromRGB(138, 43, 226)

			local surface = Instance.new("SurfaceGui")
			surface.Parent = portal

			local label = Instance.new("TextLabel")
			label.Text = "∞"
			label.Size = UDim2.new(1, 0, 1, 0)
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.Parent = surface

			portal.Parent = container
		end

		self.generatedFloors[self.currentFloor] = true
		self.currentFloor += 1
	end

	self.weatherSystem:apply("apocalyptic")

	print(`[LevelManager] Generated paradox level`)
	return 5
end

function LevelManager:generateTimeLoopLevel(): number
	local container = self:createLevelFolder()
	local baseHeight = (self.currentFloor - 1) * 18

	print(`[LevelManager] Generating TIME LOOP level...`)

	for f = 1, 7 do
		local height = baseHeight + (f * 20)

		for i = 1, 4 do
			local part = Instance.new("Part")
			part.Name = `TimeLoop_Floor_{f}_Platform_{i}`
			part.Size = Vector3.new(4, 1, 4)
			part.Position = Vector3.new(
				(math.random() - 0.5) * 8,
				height,
				(math.random() - 0.5) * 8
			)
			part.Anchored = true
			part.CanCollide = true

			local highlight = Instance.new("Highlight")
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(0, 255, 255)
			highlight.OutlineColor = Color3.fromRGB(0, 139, 139)
			highlight.Parent = part

			local clock = Instance.new("Part")
			clock.Name = `Clock_{f}_{i}`
			clock.Size = Vector3.new(2, 2, 0.2)
			clock.Position = part.Position + Vector3.new(0, 2, 0)
			clock.Anchored = true
			clock.CanCollide = false
			clock.Color = Color3.fromRGB(0, 255, 255)

			clock.Parent = container
			part.Parent = container
		end

		self.generatedFloors[self.currentFloor] = true
		self.currentFloor += 1
	end

	self.weatherSystem:apply("night")
	self.weatherSystem:apply("eclipse")

	print(`[LevelManager] Generated time loop level`)
	return 7
end

function LevelManager:generateMirrorLevel(): number
	local container = self:createLevelFolder()
	local baseHeight = (self.currentFloor - 1) * 16

	print(`[LevelManager] Generating MIRROR DIMENSION level...`)

	for f = 1, 8 do
		local height = baseHeight + (f * 18)

		for i = 1, 6 do
			local part = Instance.new("Part")
			part.Name = `Mirror_Floor_{f}_Platform_{i}`
			part.Size = Vector3.new(4, 1, 4)
			part.Position = Vector3.new(
				(i - 3) * 6,
				height,
				(math.random() - 0.5) * 6
			)
			part.Anchored = true
			part.CanCollide = true

			local highlight = Instance.new("Highlight")
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(192, 192, 192)
			highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			highlight.Parent = part

			part.Parent = container

			local mirror = Instance.new("Part")
			mirror.Name = `Mirror_{f}_{i}`
			mirror.Size = Vector3.new(0.2, 4, 3)
			mirror.Position = part.Position + Vector3.new(3, 1, 0)
			mirror.Anchored = true
			mirror.CanCollide = false
			mirror.Transparency = 0.3
			mirror.Reflectance = 0.9
			mirror.Color = Color3.new(0.9, 0.9, 1)

			mirror.Parent = container
		end

		self.generatedFloors[self.currentFloor] = true
		self.currentFloor += 1
	end

	self.weatherSystem:apply("foggy")

	print(`[LevelManager] Generated mirror dimension level`)
	return 8
end

function LevelManager:generateVoidLevel(): number
	local container = self:createLevelFolder()
	local baseHeight = (self.currentFloor - 1) * 30

	print(`[LevelManager] Generating THE VOID - impossible level...`)

	for f = 1, 3 do
		local height = baseHeight + (f * 35)

		for i = 1, 3 do
			local part = Instance.new("Part")
			part.Name = `Void_Floor_{f}_Platform_{i}`
			part.Size = Vector3.new(2, 0.5, 2)
			part.Position = Vector3.new(
				(math.random() - 0.5) * 15,
				height,
				(math.random() - 0.5) * 15
			)
			part.Anchored = true
			part.CanCollide = true

			local highlight = Instance.new("Highlight")
			highlight.Adornee = part
			highlight.FillColor = Color3.fromRGB(0, 0, 0)
			highlight.OutlineColor = Color3.fromRGB(139, 0, 0)
			highlight.Parent = part

			part.Parent = container
		end

		self.generatedFloors[self.currentFloor] = true
		self.currentFloor += 1
	end

	self.weatherSystem:apply("apocalyptic")

	print(`[LevelManager] Generated void level - 3 floors of despair`)
	return 3
end

function LevelManager:generateNextFloor(): number
	local levelType = self:getNextLevelType()
	self.currentLevelType = levelType

	if levelType == "infinite" then
		return self:generateInfiniteSpiral()
	elseif levelType == "paradox" then
		return self:generateParadoxLevel()
	elseif levelType == "time_loop" then
		return self:generateTimeLoopLevel()
	elseif levelType == "mirror" then
		return self:generateMirrorLevel()
	elseif levelType == "void" then
		return self:generateVoidLevel()
	else
		local container = self:createLevelFolder()
		local difficulty = self:getDifficultyForFloor(self.currentFloor)
		local floor = self.levelGenerator:generateFloor(self.currentFloor, difficulty)

		for _, part in floor do
			part.Parent = container
		end

		local weatherTypes = {"sunny", "rainy", "cloudy", "night", "foggy"}
		self.weatherSystem:apply(weatherTypes[math.random(#weatherTypes)] :: any)

		self.generatedFloors[self.currentFloor] = floor
		self.currentFloor += 1

		print(`[LevelManager] Generated floor {self.currentFloor - 1} (difficulty: {difficulty})`)
		return self.currentFloor - 1
	end
end

function LevelManager:generateFullLevel(levelNumber: number): number
	self.currentLevel = levelNumber

	for f = 1, FLOORS_PER_LEVEL do
		self:generateNextFloor()
	end

	print(`[LevelManager] Generated level {levelNumber}`)
	return self.currentFloor - 1
end

function LevelManager:getCurrentFloor(): number
	return self.currentFloor - 1
end

function LevelManager:getCurrentLevel(): number
	return self.currentLevel
end

function LevelManager:getCurrentLevelType(): LevelType
	return self.currentLevelType
end

function LevelManager:getNextLevelTypePreview(): LevelType
	return self:getNextLevelType()
end

function LevelManager:cleanup()
	if self.levelGenerator then
		self.levelGenerator:cleanup()
	end
	if self.levelFolder then
		self.levelFolder:Destroy()
		self.levelFolder = nil
	end
	self.generatedFloors = {}
	self.currentFloor = 1
	self.currentLevel = 1
	self.isInfiniteMode = false
	self.infiniteFloorsGenerated = 0
	print("[LevelManager] Cleaned up all levels")
end

function LevelManager:reset()
	self:cleanup()
	self:generateNextFloor()
	print("[LevelManager] Reset - generating first floor")
end

return LevelManager