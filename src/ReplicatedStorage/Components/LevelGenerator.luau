--!native
--!strict

local LevelGenerator = {}
LevelGenerator.__index = LevelGenerator

export type LevelDifficulty = "easy" | "medium" | "hard" | "extreme"
export type PlatformType = 
	"basic" | "platform" | "moving" | "rotating" | "spiral" | "checkpoint" | 
	"elevator" | "special" | "disappearing" | "crumbling" | "boost" | "bounce" | 
	"spike" | "teleporter" | "ice" | "laser"

local PlatformColors = {
	blue = Color3.fromRGB(0, 120, 255),
	red = Color3.fromRGB(255, 60, 60),
	green = Color3.fromRGB(60, 200, 60),
	purple = Color3.fromRGB(160, 60, 200),
	yellow = Color3.fromRGB(255, 200, 0),
	orange = Color3.fromRGB(255, 140, 0),
	cyan = Color3.fromRGB(0, 200, 200),
	pink = Color3.fromRGB(255, 100, 150),
	gray = Color3.fromRGB(100, 100, 100),
	white = Color3.fromRGB(200, 220, 255),
}

local PlatformTypeConfig = {
	basic = { color = "blue", anchored = true },
	platform = { color = "blue", anchored = true },
	moving = { color = "red", anchored = false },
	rotating = { color = "yellow", anchored = false },
	spiral = { color = "green", anchored = false },
	checkpoint = { color = "purple", anchored = true },
	elevator = { color = "cyan", anchored = false },
	special = { color = "orange", anchored = true },
	disappearing = { color = "gray", anchored = true, transparent = true },
	crumbling = { color = "brown", anchored = true },
	boost = { color = "orange", anchored = true },
	bounce = { color = "pink", anchored = true },
	spike = { color = "red", anchored = true, isHazard = true },
	teleporter = { color = "purple", anchored = true, isPortal = true },
	ice = { color = "white", anchored = true },
	laser = { color = "red", anchored = true },
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

function LevelGenerator:createBasePlatform(floorNumber: number, platformType: PlatformType, width: number): (Instance, string)
	local colorKey = PlatformTypeConfig[platformType].color
	local color = PlatformColors[colorKey] or PlatformColors.blue

	local part = Instance.new("Part")
	part.Name = `Floor_{floorNumber}_{platformType}`
	part.Size = Vector3.new(width, 1, width)
	part.Anchored = PlatformTypeConfig[platformType].anchored
	part.CanCollide = true
	part.Color = color

	if PlatformTypeConfig[platformType].transparent then
		part.Transparency = 0.5
	end

	if PlatformTypeConfig[platformType].isHazard then
		part.Name = `SPIKE_{floorNumber}`
	end

	if PlatformTypeConfig[platformType].isPortal then
		part.Name = `PORTAL_{floorNumber}`
		part.CanCollide = false
	end

	local highlight = Instance.new("Highlight")
	highlight.Adornee = part
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.Parent = part

	return part, platformType
end

function LevelGenerator:addMovingBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "MovingPlatform"
	script.Source = [[
		local part = script.Parent
		local start = part.Position
		local direction = Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
		local speed = 2 + math.random() * 2
		
		while true do
			part.Position = start + direction * math.sin(os.clock() * speed) * 3
			task.wait(0.016)
		end
	]]
	script.Parent = part
end

function LevelGenerator:addRotatingBehavior(part: Instance)
	local rotator = Instance.new("BodyAngularVelocity")
	rotator.AngularVelocity = Vector3.new(0, math.random(1, 4), 0)
	rotator.MaxTorque = Vector3.new(1, 1, 1)
	rotator.Parent = part
end

function LevelGenerator:addDisappearingBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "DisappearingPlatform"
	script.Source = [[
		local part = script.Parent
		local fadeTime = 3
		local waitTime = 2
		local appears = true
		
		local function fade()
			for i = 1, 30 do
				if part.Transparency then
					part.Transparency = i / 30
				end
				task.wait(0.1)
			end
			part.CanCollide = false
			task.wait(waitTime)
			part.Transparency = 0
			part.CanCollide = true
			task.wait(waitTime)
			fade()
		end
		
		spawn(fade)
	]]
	script.Parent = part
end

function LevelGenerator:addCrumblingBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "CrumblingPlatform"
	script.Source = [[
		local part = script.Parent
		local crumbleTime = 2
		local touched = false
		
		part.Touched:Connect(function(hit)
			if hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not touched then
				touched = true
				task.wait(crumbleTime)
				for i = 1, 20 do
					part.Size = part.Size * 0.95
					part.Transparency = i / 20
					task.wait(0.05)
				end
				part:Destroy()
			end
		end)
	]]
	script.Parent = part
end

function LevelGenerator:addBoostBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "BoostPad"
	script.Source = [[
		local part = script.Parent
		local boostForce = Vector3.new(0, 50, 0)
		
		part.Touched:Connect(function(hit)
			if hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				local humanoid = hit.Parent:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.Jump = true
					humanoid.Parent:FindFirstChild("HumanoidRootPart").Velocity = boostForce + humanoid.Parent:FindFirstChild("HumanoidRootPart").Velocity
				end
			end
		end)
	]]
	script.Parent = part
	
	local decal = Instance.new("Decal")
	decal.Face = Enum.NormalId.Top
	decal.Texture = "rbxassetid://0"
	decal.Name = "BoostTexture"
	decal.Parent = part
end

function LevelGenerator:addBounceBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "BouncePad"
	script.Source = [[
		local part = script.Parent
		local bounceForce = Vector3.new(0, 80, 0)
		
		part.Touched:Connect(function(hit)
			if hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				local hrp = hit.Parent:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.Velocity = bounceForce
				end
			end
		end)
	]]
	script.Parent = part
	
	part.Size = Vector3.new(part.Size.X, 0.5, part.Size.Z)
	local highlight = part:FindFirstChild("Highlight")
	if highlight then
		highlight.FillColor = Color3.fromRGB(255, 100, 150)
		highlight.OutlineColor = Color3.fromRGB(255, 100, 150)
	end
end

function LevelGenerator:addSpikeBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "SpikeTrap"
	script.Source = [[
		local part = script.Parent
		local damage = 25
		
		part.Touched:Connect(function(hit)
			if hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				local humanoid = hit.Parent:FindFirstChild("Humanoid")
				local player = game.Players:GetPlayerFromCharacter(hit.Parent)
				if humanoid and player then
					humanoid.Health = humanoid.Health - damage
				end
			end
		end)
	]]
	script.Parent = part
end

function LevelGenerator:addTeleporterBehavior(part: Instance, targetFloor: number)
	local script = Instance.new("Script")
	script.Name = "Teleporter"
	script.Source = `local targetFloor = {targetFloor}`
	script.Source = [[
		local part = script.Parent
		local targetFloor = ]] .. tostring(targetFloor) .. [[
		
		part.Touched:Connect(function(hit)
			if hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				local hrp = hit.Parent:FindFirstChild("HumanoidRootPart")
				local player = game.Players:GetPlayerFromCharacter(hit.Parent)
				if hrp and player then
					local teleportEvent = game:GetService("ReplicatedStorage"):FindFirstChild("TeleportPlayer")
					if teleportEvent then
						teleportEvent:FireServer(player, targetFloor)
					end
				end
			end
		end)
		
		local light = Instance.new("PointLight")
		light.Color = Color3.fromRGB(138, 43, 226)
		light.Range = 10
		light.Parent = part
	]]
	script.Parent = part
end

function LevelGenerator:addIceBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "IcePlatform"
	script.Source = [[
		local part = script.Parent
		part.Material = Enum.Material.Ice
		
		local physics = Instance.new("BodyVelocity")
		physics.Name = "IcePhysics"
		physics.P = 0
		physics.MaxForce = Vector3.new(0, 0, 0)
		physics.Parent = part
		
		part.Touched:Connect(function(hit)
			if hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				local hrp = hit.Parent:FindFirstChild("HumanoidRootPart")
				if hrp then
					local currentVelocity = hrp.Velocity
					hrp.Velocity = Vector3.new(currentVelocity.X * 1.5, currentVelocity.Y, currentVelocity.Z * 1.5)
				end
			end
		end)
	]]
	script.Parent = part
	
	part.Transparency = 0.3
	part.Reflectance = 0.5
end

function LevelGenerator:addLaserBehavior(part: Instance)
	local script = Instance.new("Script")
	script.Name = "LaserBarrier"
	script.Source = [[
		local part = script.Parent
		part.CanCollide = false
		part.Transparency = 0.3
		
		local light = Instance.new("PointLight")
		light.Color = Color3.fromRGB(255, 0, 0)
		light.Range = 5
		light.Parent = part
		
		local active = true
		part.Touched:Connect(function(hit)
			if active and hit and hit:IsA("Part") and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
				local humanoid = hit.Parent:FindFirstChild("Humanoid")
				local player = game.Players:GetPlayerFromCharacter(hit.Parent)
				if humanoid and player then
					humanoid.Health = humanoid.Health - 15
				end
			end
		end)
		
		while true do
			active = not active
			part.CanCollide = active
			part.Transparency = active and 0.3 or 0.8
			light.Enabled = active
			task.wait(3)
		end
	]]
	script.Parent = part
end

function LevelGenerator:generateFloor(floorNumber: number, difficulty: LevelDifficulty): { [number]: Instance }
	local settings = DifficultySettings[difficulty]
	local floor = {}
	local baseHeight = floorNumber * 20

	local platforms = {
		"basic", "moving", "rotating", "checkpoint", "disappearing", 
		"crumbling", "boost", "bounce", "spike", "teleporter", "ice"
	}

	local platformCount = math.random(4, 6)

	for i = 1, platformCount do
		local platformType = platforms[math.random(#platforms)] :: PlatformType
		local width = settings.platformWidth + math.random() * 2

		local part, pType = self:createBasePlatform(floorNumber, platformType, width)
		
		part.Position = Vector3.new(
			(math.random() - 0.5) * 12,
			baseHeight + (i - 1) * 9,
			(math.random() - 0.5) * 12
		)

		if pType == "moving" then
			self:addMovingBehavior(part)
		elseif pType == "rotating" then
			self:addRotatingBehavior(part)
		elseif pType == "disappearing" then
			self:addDisappearingBehavior(part)
		elseif pType == "crumbling" then
			self:addCrumblingBehavior(part)
		elseif pType == "boost" then
			self:addBoostBehavior(part)
		elseif pType == "bounce" then
			self:addBounceBehavior(part)
		elseif pType == "spike" then
			self:addSpikeBehavior(part)
			part.Size = Vector3.new(width, 1.5, width)
		elseif pType == "teleporter" then
			local targetFloor = math.max(1, floorNumber + math.random(5, 15))
			self:addTeleporterBehavior(part, targetFloor)
		elseif pType == "ice" then
			self:addIceBehavior(part)
		elseif pType == "laser" then
			self:addLaserBehavior(part)
			part.Size = Vector3.new(width, 0.5, 0.5)
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

	print(`[LevelGenerator] Generated disaster level {levelNumber}: {disasterType}`)
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