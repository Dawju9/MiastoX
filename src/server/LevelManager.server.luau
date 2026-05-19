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
	self.castleFolder = nil
	return self
end

function LevelManager:generateCastle()
	if not self.castleFolder then
		self.castleFolder = Instance.new("Folder")
		self.castleFolder.Name = "Castle"
		self.castleFolder.Parent = Workspace
	end

	local castleParts = self.levelGenerator:createCastle(Vector3.new(0, 0, 0))
	for _, part in castleParts do
		part.Parent = self.castleFolder
	end

	print("[LevelManager] Castle of Gods generated at center")
end

function LevelManager:generateRoyalSquare()
	local container = self:createLevelFolder()
	local square = self.levelGenerator:createRoyalSquare(Vector3.new(0, 0, 0))

	for _, obj in square do
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
	print("[LevelManager] Royal Square generated around castle")
end

function LevelManager:generateRadiantCity()
	local sectors = {
		{ name = "North", pos = Vector3.new(0, 0, -150), difficulty = "easy" },
		{ name = "East", pos = Vector3.new(150, 0, 0), difficulty = "medium" },
		{ name = "South", pos = Vector3.new(0, 0, 150), difficulty = "hard" },
		{ name = "West", pos = Vector3.new(-150, 0, 0), difficulty = "extreme" },
	}

	for _, sector in sectors do
		for i = 1, 3 do
			local offset = Vector3.new((math.random() - 0.5) * 80, 0, (math.random() - 0.5) * 80)
			local block = self.levelGenerator:generateCityBlock(i, sector.difficulty :: any, sector.pos + offset)

			local container = self:createLevelFolder()
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
		end
		print(`[LevelManager] Sector {sector.name} generated`)
	end
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
	if self.castleFolder then
		self.castleFolder:Destroy()
		self.castleFolder = nil
	end
	self.generatedBlocks = {}
	self.currentBlock = 1
	self.currentLevel = 1
	print("[LevelManager] Cleaned up city")
end

function LevelManager:reset()
	self:cleanup()
	self:generateCastle()
	self:generateRoyalSquare()
	self:generateRadiantCity()
	print("[LevelManager] Reset - City of Gods fully re-generated")
end

return LevelManager
