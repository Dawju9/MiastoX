--!native
--!strict

local LevelGenerator = {}
LevelGenerator.__index = LevelGenerator

export type LevelDifficulty = "easy" | "medium" | "hard" | "extreme"
export type PlatformType = "basic" | "platform" | "moving" | "rotating" | "spiral" | "checkpoint" | "elevator" | "special"

local PlatformColors = {
	blue = Color3.fromRGB(0, 120, 255),
	red = Color3.fromRGB(255, 60, 60),
	green = Color3.fromRGB(60, 200, 60),
	purple = Color3.fromRGB(160, 60, 200),
	yellow = Color3.fromRGB(255, 200, 0),
	orange = Color3.fromRGB(255, 140, 0),
	cyan = Color3.fromRGB(0, 200, 200),
	pink = Color3.fromRGB(255, 100, 150),
}

local DifficultySettings = {
	easy = {
		gapMultiplier = 1.0,
		speedMultiplier = 0.8,
		obstacleChance = 0.1,
		platformWidth = 6,
	},
	medium = {
		gapMultiplier = 1.3,
		speedMultiplier = 1.0,
		obstacleChance = 0.25,
		platformWidth = 5,
	},
	hard = {
		gapMultiplier = 1.6,
		speedMultiplier = 1.3,
		obstacleChance = 0.4,
		platformWidth = 4,
	},
	extreme = {
		gapMultiplier = 2.0,
		speedMultiplier = 1.6,
		obstacleChance = 0.6,
		platformWidth = 3,
	},
}

function LevelGenerator.new()
	local self = setmetatable({}, LevelGenerator)
	self.currentLevel = 1
	self.currentDifficulty = "easy" :: LevelDifficulty
	self.platforms = {}
	return self
end

function LevelGenerator:generateFloor(floorNumber: number, difficulty: LevelDifficulty): { [number]: Instance }
	local settings = DifficultySettings[difficulty]
	local floor = {}
	local baseHeight = floorNumber * 20

	local platforms = {
		"basic", "platform", "moving", "rotating", "spiral", "checkpoint"
	}

	for i = 1, 5 do
		local platformType = platforms[math.random(#platforms)]
		local colorKey = table.keys(PlatformColors)[math.random(#table.keys(PlatformColors))]

		local part = Instance.new("Part")
		part.Name = `Floor_{floorNumber}_Platform_{i}`
		part.Size = Vector3.new(settings.platformWidth, 1, settings.platformWidth)
		part.Position = Vector3.new(
			(math.random() - 0.5) * 10,
			baseHeight + (i - 1) * 8,
			(math.random() - 0.5) * 10
		)
		part.Anchored = platformType == "basic" or platformType == "checkpoint"
		part.CanCollide = true

		local mesh = Instance.new("Highlight")
		mesh.Adornee = part
		mesh.FillColor = PlatformColors[colorKey]
		mesh.OutlineColor = PlatformColors[colorKey]
		mesh.Parent = part

		if platformType == "moving" then
			local script = Instance.new("Script")
			script.Source = [[
				local part = script.Parent
				local start = part.Position
				local dir = Vector3.new(5, 0, 0)
				while true do
					part.Position = start + dir * math.sin(os.clock() * 2)
					task.wait(0.016)
				end
			]]
			script.Parent = part
		end

		if platformType == "rotating" then
			local rotator = Instance.new("BodyAngularVelocity")
			rotator.AngularVelocity = Vector3.new(0, 2, 0)
			rotator.Parent = part
		end

		floor[i] = part
	end

	self.platforms = floor
	return floor
end

function LevelGenerator:generateLevel(levelNumber: number, difficulty: LevelDifficulty): { [number]: { [number]: Instance } }
	self.currentLevel = levelNumber
	self.currentDifficulty = difficulty

	local floors = {}
	local floorsInLevel = 10

	for f = 1, floorsInLevel do
		floors[f] = self:generateFloor(f, difficulty)
	end

	print(`[LevelGenerator] Generated level {levelNumber} with {floorsInLevel} floors (difficulty: {difficulty})`)
	return floors
end

function LevelGenerator:generateDisasterLevel(levelNumber: number, disasterType: string): { [number]: { [number]: Instance } }
	local difficulty: LevelDifficulty = "hard"
	local floors = {}
	local floorsInLevel = 15

	for f = 1, floorsInLevel do
		local floor = self:generateFloor(f, difficulty)

		for _, part in floor do
			if disasterType == "tornado" then
				local debris = Instance.new("Part")
				debris.Size = Vector3.new(1, 1, 1)
				debris.Position = part.Position + Vector3.new(math.random() * 5, 5, math.random() * 5)
				debris.Anchored = false
				debris.Parent = part.Parent
			elseif disasterType == "meteor" then
				local crater = Instance.new("Part")
				crater.Size = Vector3.new(2, 0.5, 2)
				crater.Position = part.Position - Vector3.new(0, 0.5, 0)
				crater.Anchored = true
				crater.Color = Color3.fromRGB(50, 20, 10)
				crater.Parent = part.Parent
			elseif disasterType == "earthquake" then
				part.Position = part.Position + Vector3.new(math.random() - 0.5, math.random() * 0.5, math.random() - 0.5)
			end
		end

		floors[f] = floor
	end

	print(`[LevelGenerator] Generated disaster level {levelNumber} ({disasterType})`)
	return floors
end

function LevelGenerator:cleanup()
	for _, floor in self.platforms do
		if typeof(floor) == "table" then
			for _, part in floor do
				if part and part.Parent then
					part:Destroy()
				end
			end
		end
	end
	self.platforms = {}
end

return LevelGenerator