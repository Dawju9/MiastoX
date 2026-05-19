--!native
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LevelGenerator = require(ReplicatedStorage.Components.LevelGenerator)
local WeatherSystem = require(ReplicatedStorage.Components.WeatherSystem)

local LevelManager = {}
LevelManager.__index = LevelManager

export type LevelDifficulty = "easy" | "medium" | "hard" | "extreme"
export type LevelType = "city"

local BLOCKS_PER_LEVEL = 5

function LevelManager.new()
	local self = setmetatable({}, LevelManager)
	self.levelGenerator = LevelGenerator.new()
	self.weatherSystem = WeatherSystem.new()
	self.currentBlock = 1
	self.currentLevel = 1
	self.currentDifficulty = "easy" :: LevelDifficulty
	self.currentLevelType = "city" :: LevelType
	self.generatedBlocks = {}
	self.levelFolder = nil
	return self
end

function LevelManager:createLevelFolder()
	if not self.levelFolder then
		self.levelFolder = Instance.new("Folder")
		self.levelFolder.Name = "CityContainer"
		self.levelFolder.Parent = Workspace
	end
	return self.levelFolder
end

function LevelManager:getDifficultyForBlock(blockNumber: number): LevelDifficulty
	if blockNumber <= 5 then
		return "easy"
	elseif blockNumber <= 15 then
		return "medium"
	elseif blockNumber <= 30 then
		return "hard"
	else
		return "extreme"
	end
end

function LevelManager:generateNextBlock(): number
	local container = self:createLevelFolder()
	local difficulty = self:getDifficultyForBlock(self.currentBlock)
	self.currentDifficulty = difficulty

	local block = self.levelGenerator:generateCityBlock(self.currentBlock, difficulty)

	for _, obj in block do
		if typeof(obj) == "Instance" then
			obj.Parent = container
		elseif typeof(obj) == "table" then
			for _, subObj in obj do
				if typeof(subObj) == "Instance" and subObj.Parent == nil then
					subObj.Parent = container
				end
			end
		end
	end

	local weatherTypes = { "sunny", "rainy", "cloudy", "night", "foggy", "smog" }
	self.weatherSystem:apply(weatherTypes[math.random(#weatherTypes)] :: any)

	self.generatedBlocks[self.currentBlock] = block
	self.currentBlock += 1

	print(`[LevelManager] Generated city block {self.currentBlock - 1} (difficulty: {difficulty})`)
	return self.currentBlock - 1
end

function LevelManager:generateFullLevel(levelNumber: number): number
	self.currentLevel = levelNumber

	for _ = 1, BLOCKS_PER_LEVEL do
		self:generateNextBlock()
	end

	print(`[LevelManager] Generated city level {levelNumber} with {BLOCKS_PER_LEVEL} blocks`)
	return self.currentBlock - 1
end

function LevelManager:getCurrentBlock(): number
	return self.currentBlock - 1
end

function LevelManager:getCurrentLevel(): number
	return self.currentLevel
end

function LevelManager:getCurrentLevelType(): LevelType
	return self.currentLevelType
end

function LevelManager:cleanup()
	if self.levelGenerator then
		self.levelGenerator:cleanup()
	end
	if self.levelFolder then
		self.levelFolder:Destroy()
		self.levelFolder = nil
	end
	self.generatedBlocks = {}
	self.currentBlock = 1
	self.currentLevel = 1
	print("[LevelManager] Cleaned up city")
end

function LevelManager:reset()
	self:cleanup()
	self:generateNextBlock()
	print("[LevelManager] Reset - generating first city block")
end

return LevelManager
