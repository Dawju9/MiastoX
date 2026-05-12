--!native
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LevelGenerator = require(ReplicatedStorage.Components.LevelGenerator)
local WeatherSystem = require(ReplicatedStorage.Components.WeatherSystem)

local LevelManager = {}
LevelManager.__index = LevelManager

export type LevelDifficulty = "easy" | "medium" | "hard" | "extreme"

local FLOORS_PER_LEVEL = 10
local DISASTER_FLOOR_THRESHOLD = 50

function LevelManager.new()
	local self = setmetatable({}, LevelManager)
	self.levelGenerator = LevelGenerator.new()
	self.weatherSystem = WeatherSystem.new()
	self.currentFloor = 1
	self.currentLevel = 1
	self.currentDifficulty = "easy" :: LevelDifficulty
	self.generatedFloors = {}
	self.levelFolder = nil
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
	else
		return "extreme"
	end
end

function LevelManager:shouldGenerateDisaster(floorNumber: number): string?
	if floorNumber >= DISASTER_FLOOR_THRESHOLD and floorNumber % 10 == 0 then
		local disasters = {"tornado", "earthquake", "meteor"}
		return disasters[math.random(#disasters)]
	end
	return nil
end

function LevelManager:generateNextFloor(): number
	local container = self:createLevelFolder()
	local difficulty = self:getDifficultyForFloor(self.currentFloor)
	local disasterType = self:shouldGenerateDisaster(self.currentFloor)

	local floor = self.levelGenerator:generateFloor(self.currentFloor, difficulty)

	for _, part in floor do
		part.Parent = container
	end

	if disasterType then
		print(`[LevelManager] DISASTER FLOOR! Floor {self.currentFloor} - {disasterType}`)
		self.weatherSystem:apply(disasterType :: any)
	else
		local weatherTypes = {"sunny", "rainy", "cloudy", "night"}
		self.weatherSystem:apply(weatherTypes[math.random(#weatherTypes)] :: any)
	end

	self.generatedFloors[self.currentFloor] = floor
	self.currentFloor += 1

	print(`[LevelManager] Generated floor {self.currentFloor - 1} (difficulty: {difficulty})`)
	return self.currentFloor - 1
end

function LevelManager:generateFullLevel(levelNumber: number): number
	local difficulty = self:getDifficultyForFloor(self.currentFloor)
	local container = self:createLevelFolder()

	for f = 1, FLOORS_PER_LEVEL do
		local floor = self.levelGenerator:generateFloor(self.currentFloor, difficulty)
		for _, part in floor do
			part.Parent = container
		end
		self.generatedFloors[self.currentFloor] = floor
		self.currentFloor += 1
	end

	self.currentLevel += 1
	print(`[LevelManager] Generated full level {levelNumber} with {FLOORS_PER_LEVEL} floors`)

	return self.currentFloor - 1
end

function LevelManager:generateDisasterLevel(levelNumber: number, disasterType: string): number
	local container = self:createLevelFolder()
	local floors = self.levelGenerator:generateDisasterLevel(levelNumber, disasterType)

	for floorNum, floor in floors do
		for _, part in floor do
			part.Parent = container
		end
		self.generatedFloors[self.currentFloor] = floor
		self.currentFloor += 1
	end

	self.weatherSystem:apply(disasterType :: any)
	print(`[LevelManager] Generated disaster level {levelNumber}: {disasterType}`)

	return self.currentFloor - 1
end

function LevelManager:getCurrentFloor(): number
	return self.currentFloor - 1
end

function LevelManager:getCurrentLevel(): number
	return self.currentLevel
end

function LevelManager:getCurrentDifficulty(): LevelDifficulty
	return self.currentDifficulty
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
	print("[LevelManager] Cleaned up all levels")
end

function LevelManager:reset()
	self:cleanup()
	self:generateNextFloor()
	print("[LevelManager] Reset and generated first floor")
end

return LevelManager