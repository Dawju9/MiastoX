--!native
--!strict

local LevelGenerator = {}
LevelGenerator.__index = LevelGenerator

export type LevelDifficulty = "easy" | "medium" | "hard" | "extreme"
export type CityObjectType =
	"building"
	| "rooftop"
	| "scaffolding"
	| "fire_escape"
	| "crane"
	| "bridge_plank"
	| "ladder"
	| "billboard"
	| "balcony"
	| "stairs"
	| "moving_scaffold"
	| "rotating_sign"
	| "collapsing_ledge"
	| "crumbling_stairs"
	| "boost_vent"
	| "bounce_tarp"
	| "rebar"
	| "elevator_shaft"
	| "wet_roof"
	| "construction_laser"

export type BuildingConfig = {
	width: number,
	depth: number,
	height: number,
	hasBalcony: boolean,
	hasRoofAccess: boolean,
	storyCount: number,
}

local CityColors = {
	brick = Color3.fromRGB(180, 90, 70),
	concrete = Color3.fromRGB(160, 160, 155),
	darkConcrete = Color3.fromRGB(120, 120, 115),
	glass = Color3.fromRGB(140, 190, 220),
	steel = Color3.fromRGB(80, 80, 85),
	scaffoldYellow = Color3.fromRGB(230, 190, 50),
	roofGray = Color3.fromRGB(100, 100, 100),
	signRed = Color3.fromRGB(220, 50, 50),
	ventOrange = Color3.fromRGB(255, 140, 0),
	tarpBlue = Color3.fromRGB(60, 120, 200),
	rebarRust = Color3.fromRGB(160, 80, 50),
	laserRed = Color3.fromRGB(255, 0, 0),
	elevatorGold = Color3.fromRGB(200, 170, 60),
	wetDark = Color3.fromRGB(90, 95, 105),
	balconyIron = Color3.fromRGB(60, 60, 60),
	windowGlow = Color3.fromRGB(200, 210, 230),
	atmBlue = Color3.fromRGB(0, 120, 215),
	leaderboardGold = Color3.fromRGB(255, 215, 0),
	shopGreen = Color3.fromRGB(50, 180, 50),
}

local DifficultySettings = {
	easy = {
		gapMultiplier = 1.0,
		speedMultiplier = 0.8,
		obstacleChance = 0.1,
		platformWidth = 6,
		buildingMaxStories = 3,
	},
	medium = {
		gapMultiplier = 1.3,
		speedMultiplier = 1.0,
		obstacleChance = 0.25,
		platformWidth = 5,
		buildingMaxStories = 4,
	},
	hard = {
		gapMultiplier = 1.6,
		speedMultiplier = 1.3,
		obstacleChance = 0.4,
		platformWidth = 4,
		buildingMaxStories = 5,
	},
	extreme = {
		gapMultiplier = 2.0,
		speedMultiplier = 1.6,
		obstacleChance = 0.6,
		platformWidth = 3,
		buildingMaxStories = 6,
	},
}

local STORY_HEIGHT = 5

function LevelGenerator.new()
	local self = setmetatable({}, LevelGenerator)
	self.currentLevel = 1
	self.currentDifficulty = "easy" :: LevelDifficulty
	self.platforms = {}
	self.cityBlocks = {}
	return self
end

function LevelGenerator:createPart(name: string, size: Vector3, color: Color3, anchored: boolean): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Anchored = anchored
	part.CanCollide = true
	part.Color = color
	part.Material = Enum.Material.SmoothPlastic
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	return part
end

function LevelGenerator:addHighlight(part: Instance, fillColor: Color3, outlineColor: Color3)
	local highlight = Instance.new("Highlight")
	highlight.Adornee = part
	highlight.FillColor = fillColor
	highlight.OutlineColor = outlineColor
	highlight.FillTransparency = 0.3
	highlight.Parent = part
end

function LevelGenerator:addWindows(building: Instance, width: number, depth: number, height: number)
	for y = 2, height - 1, STORY_HEIGHT do
		local windowY = y + 1.5
		for x = -1, 1, 2 do
			local winFront = Instance.new("Part")
			winFront.Name = "Window"
			winFront.Size = Vector3.new(2, 2, 0.2)
			winFront.Position = Vector3.new(x * 1.5, windowY, depth / 2 + 0.1)
			winFront.Anchored = true
			winFront.CanCollide = false
			winFront.Color = CityColors.glass
			winFront.Transparency = 0.3
			winFront.Material = Enum.Material.Glass
			winFront.Parent = building

			local winBack = Instance.new("Part")
			winBack.Name = "Window"
			winBack.Size = Vector3.new(2, 2, 0.2)
			winBack.Position = Vector3.new(x * 1.5, windowY, -depth / 2 - 0.1)
			winBack.Anchored = true
			winBack.CanCollide = false
			winBack.Color = CityColors.glass
			winBack.Transparency = 0.3
			winBack.Material = Enum.Material.Glass
			winBack.Parent = building

			local winLeft = Instance.new("Part")
			winLeft.Name = "Window"
			winLeft.Size = Vector3.new(0.2, 2, 2)
			winLeft.Position = Vector3.new(-width / 2 - 0.1, windowY, x * 1.5)
			winLeft.Anchored = true
			winLeft.CanCollide = false
			winLeft.Color = CityColors.glass
			winLeft.Transparency = 0.3
			winLeft.Material = Enum.Material.Glass
			winLeft.Parent = building

			local winRight = Instance.new("Part")
			winRight.Name = "Window"
			winRight.Size = Vector3.new(0.2, 2, 2)
			winRight.Position = Vector3.new(width / 2 + 0.1, windowY, x * 1.5)
			winRight.Anchored = true
			winRight.CanCollide = false
			winRight.Color = CityColors.glass
			winRight.Transparency = 0.3
			winRight.Material = Enum.Material.Glass
			winRight.Parent = building
		end
	end
end

function LevelGenerator:createBuilding(buildingConfig: BuildingConfig, position: Vector3): Instance
	local w = buildingConfig.width
	local d = buildingConfig.depth
	local h = buildingConfig.height

	local building = Instance.new("Folder")
	building.Name = "Building"

	local core = self:createPart("BuildingCore", Vector3.new(w, h, d), CityColors.concrete, true)
	core.Position = position
	core.Parent = building

	if buildingConfig.storyCount >= 2 then
		self:addWindows(building, w, d, h)
	end

	local roof = self:createPart("Roof", Vector3.new(w - 0.4, 0.5, d - 0.4), CityColors.roofGray, true)
	roof.Position = position + Vector3.new(0, h / 2 + 0.25, 0)
	roof.Parent = building

	if buildingConfig.hasRoofAccess then
		local hatch = self:createPart("RoofHatch", Vector3.new(1.5, 1, 1.5), CityColors.steel, true)
		hatch.Position = position + Vector3.new(0, h / 2 + 0.75, 0)
		hatch.Parent = building
		self:addHighlight(hatch, Color3.fromRGB(100, 200, 100), Color3.fromRGB(0, 150, 0))
	end

	if buildingConfig.hasBalcony then
		local direction = 1
		local balcony = self:createPart("Balcony", Vector3.new(3, 0.3, 2), CityColors.balconyIron, true)
		balcony.Position = position + Vector3.new(0, h / 2 - 1.5, (d / 2 + 1) * direction)
		balcony.Parent = building

		local rail = self:createPart("BalconyRail", Vector3.new(3.2, 1, 0.2), CityColors.balconyIron, true)
		rail.Position = balcony.Position + Vector3.new(0, 0.65, 1.1 * direction)
		rail.Parent = building
	end

	return building
end

function LevelGenerator:createScaffolding(position: Vector3, height: number): { Instance }
	local parts: { Instance } = {}
	local pipeColor = CityColors.scaffoldYellow
	local plankColor = Color3.fromRGB(190, 150, 80)

	local function pipe(name, size, pos)
		local p = self:createPart(name, size, pipeColor, true)
		p.Position = pos
		p.Material = Enum.Material.Metal
		table.insert(parts, p)
		return p
	end

	local function plank(name, size, pos)
		local p = self:createPart(name, size, plankColor, true)
		p.Position = pos
		p.Material = Enum.Material.Wood
		table.insert(parts, p)
		return p
	end

	local levels = math.floor(height / 4)
	for level = 0, levels do
		local y = position.Y + level * 4
		local spread = 3

		pipe(`ScaffoldVert_{level}_L`, Vector3.new(0.2, 4, 0.2), Vector3.new(position.X - spread, y + 2, position.Z - spread))
		pipe(`ScaffoldVert_{level}_R`, Vector3.new(0.2, 4, 0.2), Vector3.new(position.X + spread, y + 2, position.Z - spread))
		pipe(`ScaffoldVert_{level}_BL`, Vector3.new(0.2, 4, 0.2), Vector3.new(position.X - spread, y + 2, position.Z + spread))
		pipe(`ScaffoldVert_{level}_BR`, Vector3.new(0.2, 4, 0.2), Vector3.new(position.X + spread, y + 2, position.Z + spread))

		pipe(
			`ScaffoldHoriz_{level}_F`,
			Vector3.new(spread * 2 + 0.4, 0.2, 0.2),
			Vector3.new(position.X, y + 4, position.Z - spread)
		)
		pipe(
			`ScaffoldHoriz_{level}_B`,
			Vector3.new(spread * 2 + 0.4, 0.2, 0.2),
			Vector3.new(position.X, y + 4, position.Z + spread)
		)
		pipe(
			`ScaffoldHoriz_{level}_L`,
			Vector3.new(0.2, 0.2, spread * 2 + 0.4),
			Vector3.new(position.X - spread, y + 4, position.Z)
		)
		pipe(
			`ScaffoldHoriz_{level}_R`,
			Vector3.new(0.2, 0.2, spread * 2 + 0.4),
			Vector3.new(position.X + spread, y + 4, position.Z)
		)

		-- Cross braces
		if level < levels then
			local diagLen = math.sqrt(4 * 4 + (spread * 2) * (spread * 2))
			pipe(
				`ScaffoldDiag_{level}_1`,
				Vector3.new(0.15, diagLen, 0.15),
				Vector3.new(position.X, y + 2 + 2, position.Z - spread)
			)
			pipe(
				`ScaffoldDiag_{level}_2`,
				Vector3.new(0.15, diagLen, 0.15),
				Vector3.new(position.X, y + 2 + 2, position.Z + spread)
			)
		end

		plank(`ScaffoldPlank_{level}`, Vector3.new(spread * 2 + 0.2, 0.15, 1), Vector3.new(position.X, y + 4.1, position.Z - 1))
		plank(
			`ScaffoldPlank_{level}_B`,
			Vector3.new(spread * 2 + 0.2, 0.15, 1),
			Vector3.new(position.X, y + 4.1, position.Z + 1)
		)
	end

	return parts
end

function LevelGenerator:createFireEscape(adjacentTo: Instance, side: number): { Instance }
	local parts: { Instance } = {}
	local buildingPos = adjacentTo.Position
	local buildingSize = adjacentTo.Size
	local platformColor = Color3.fromRGB(70, 70, 70)

	local startY = -buildingSize.Y / 2 + 2
	local endY = buildingSize.Y / 2 - 1
	local numPlatforms = math.floor((endY - startY) / 4)

	for i = 0, numPlatforms do
		local y = startY + i * 4
		local offset = (i % 2 == 0) and 3 or -3

		local platform = self:createPart(`FireEscape_{i}`, Vector3.new(2.5, 0.15, 1.5), platformColor, true)
		platform.Position = buildingPos + Vector3.new(buildingSize.X / 2 * side + offset, y, buildingSize.Z / 2 * side + 0.5)
		platform.Material = Enum.Material.Metal
		table.insert(parts, platform)

		if i > 0 then
			local prevOffset = (i % 2 == 0) and -3 or 3
			local prevPos = buildingPos
				+ Vector3.new(buildingSize.X / 2 * side + prevOffset, y - 4, buildingSize.Z / 2 * side + 0.5)
			local ladder = self:createPart(`FireLadder_{i}`, Vector3.new(0.2, 4, 0.5), platformColor, true)
			ladder.Position = Vector3.new((platform.Position.X + prevPos.X) / 2, y - 2, platform.Position.Z)
			ladder.Material = Enum.Material.Metal
			table.insert(parts, ladder)
		end
	end

	return parts
end

function LevelGenerator:createCrane(position: Vector3, height: number): { Instance }
	local parts: { Instance } = {}
	local baseColor = CityColors.steel

	local tower = self:createPart("CraneTower", Vector3.new(1, height, 1), baseColor, true)
	tower.Position = position + Vector3.new(0, height / 2, 0)
	tower.Material = Enum.Material.Metal
	table.insert(parts, tower)

	local arm = self:createPart("CraneArm", Vector3.new(10, 0.5, 0.5), baseColor, true)
	arm.Position = position + Vector3.new(5, height, 0)
	arm.Material = Enum.Material.Metal
	table.insert(parts, arm)

	local counterWeight = self:createPart("CraneCounter", Vector3.new(3, 1, 1), baseColor, true)
	counterWeight.Position = position + Vector3.new(-2, height, 0)
	counterWeight.Material = Enum.Material.Metal
	table.insert(parts, counterWeight)

	local hook = self:createPart("CraneHook", Vector3.new(0.5, 1, 0.5), CityColors.scaffoldYellow, false)
	hook.Position = position + Vector3.new(9, height - 1, 0)
	hook.Material = Enum.Material.Metal
	table.insert(parts, hook)
	self:addMovingBehavior(hook)

	local cable = self:createPart("CraneCable", Vector3.new(0.15, height * 0.6, 0.15), Color3.fromRGB(60, 60, 60), true)
	cable.Position = position + Vector3.new(9, height * 0.7, 0)
	cable.Material = Enum.Material.Metal
	table.insert(parts, cable)

	return parts
end

function LevelGenerator:createBridge(posA: Vector3, posB: Vector3): { Instance }
	local parts: { Instance } = {}
	local mid = (posA + posB) / 2
	local dx = posB.X - posA.X
	local dz = posB.Z - posA.Z
	local length = math.sqrt(dx * dx + dz * dz)

	local plank = self:createPart("BridgePlank", Vector3.new(length, 0.3, 2), Color3.fromRGB(139, 90, 43), true)
	plank.Position = Vector3.new(mid.X, posA.Y + 0.15, mid.Z)
	plank.Material = Enum.Material.Wood
	plank.CFrame = plank.CFrame * CFrame.Angles(0, math.atan2(dx, dz), 0)
	table.insert(parts, plank)

	local railL = self:createPart("BridgeRail_L", Vector3.new(length, 0.15, 0.2), Color3.fromRGB(100, 100, 100), true)
	railL.Position = Vector3.new(mid.X, posA.Y + 1, mid.Z - 1.1)
	railL.CFrame = railL.CFrame * CFrame.Angles(0, math.atan2(dx, dz), 0)
	railL.Material = Enum.Material.Metal
	table.insert(parts, railL)

	local railR = self:createPart("BridgeRail_R", Vector3.new(length, 0.15, 0.2), Color3.fromRGB(100, 100, 100), true)
	railR.Position = Vector3.new(mid.X, posA.Y + 1, mid.Z + 1.1)
	railR.CFrame = railR.CFrame * CFrame.Angles(0, math.atan2(dx, dz), 0)
	railR.Material = Enum.Material.Metal
	table.insert(parts, railR)

	return parts
end

function LevelGenerator:createLadder(position: Vector3, height: number): { Instance }
	local parts: { Instance } = {}
	local ladderColor = Color3.fromRGB(100, 100, 100)

	local railL = self:createPart("LadderRail_L", Vector3.new(0.15, height, 0.15), ladderColor, true)
	railL.Position = position + Vector3.new(-0.4, height / 2, 0)
	railL.Material = Enum.Material.Metal
	table.insert(parts, railL)

	local railR = self:createPart("LadderRail_R", Vector3.new(0.15, height, 0.15), ladderColor, true)
	railR.Position = position + Vector3.new(0.4, height / 2, 0)
	railR.Material = Enum.Material.Metal
	table.insert(parts, railR)

	local rungs = math.floor(height / 1.5)
	for i = 1, rungs do
		local rung = self:createPart(`LadderRung_{i}`, Vector3.new(1, 0.1, 0.1), ladderColor, true)
		rung.Position = position + Vector3.new(0, i * 1.5, 0)
		rung.Material = Enum.Material.Metal
		table.insert(parts, rung)
	end

	return parts
end

function LevelGenerator:createBillboard(position: Vector3): { Instance }
	local parts: { Instance } = {}
	local frameColor = CityColors.steel

	local pillar = self:createPart("BillboardPillar", Vector3.new(0.3, 6, 0.3), frameColor, true)
	pillar.Position = position + Vector3.new(0, 3, 0)
	pillar.Material = Enum.Material.Metal
	table.insert(parts, pillar)

	local board = self:createPart("BillboardBoard", Vector3.new(4, 2.5, 0.3), Color3.fromRGB(255, 255, 255), true)
	board.Position = position + Vector3.new(0, 6, 0)
	board.Material = Enum.Material.SmoothPlastic
	table.insert(parts, board)

	return parts
end

function LevelGenerator:createBalcony(position: Vector3): { Instance }
	local parts: { Instance } = {}

	local floor = self:createPart("BalconyFloor", Vector3.new(2.5, 0.2, 1.5), CityColors.balconyIron, true)
	floor.Position = position
	floor.Material = Enum.Material.Metal
	table.insert(parts, floor)

	local rail = self:createPart("BalconyRail", Vector3.new(2.5, 0.8, 0.1), CityColors.balconyIron, true)
	rail.Position = position + Vector3.new(0, 0.5, 0.85)
	rail.Material = Enum.Material.Metal
	table.insert(parts, rail)

	return parts
end

function LevelGenerator:createStairs(startPos: Vector3, height: number): { Instance }
	local parts: { Instance } = {}
	local stepColor = Color3.fromRGB(140, 130, 120)
	local numSteps = math.floor(height / 1)
	local width = 2

	for i = 1, numSteps do
		local step = self:createPart(`Stair_{i}`, Vector3.new(width, 0.15, 0.8), stepColor, true)
		step.Position = startPos + Vector3.new(0, i * 1 - 0.5, i * 0.8 - 0.4)
		step.Material = Enum.Material.Concrete
		table.insert(parts, step)
	end

	return parts
end

--- Behavioral city objects (same mechanics as original, city-themed)

function LevelGenerator:createMovingScaffold(position: Vector3): Instance
	local part = self:createPart("MovingScaffold", Vector3.new(3, 0.5, 2), CityColors.scaffoldYellow, false)
	part.Position = position
	part.Material = Enum.Material.Metal
	self:addHighlight(part, Color3.fromRGB(230, 190, 50), Color3.fromRGB(200, 150, 30))
	self:addMovingBehavior(part)
	return part
end

function LevelGenerator:createRotatingSign(position: Vector3): Instance
	local part = self:createPart("RotatingSign", Vector3.new(3, 1.5, 0.3), CityColors.signRed, false)
	part.Position = position
	self:addHighlight(part, Color3.fromRGB(220, 50, 50), Color3.fromRGB(180, 30, 30))
	self:addRotatingBehavior(part)
	return part
end

function LevelGenerator:createCollapsingLedge(position: Vector3): Instance
	local part = self:createPart("CollapsingLedge", Vector3.new(2.5, 0.3, 1.5), Color3.fromRGB(180, 160, 140), true)
	part.Position = position
	part.Transparency = 0.3
	part.Material = Enum.Material.Concrete
	self:addHighlight(part, Color3.fromRGB(180, 160, 140), Color3.fromRGB(140, 120, 100))
	self:addDisappearingBehavior(part)
	return part
end

function LevelGenerator:createCrumblingStairs(position: Vector3): Instance
	local part = self:createPart("CrumblingStairs", Vector3.new(2, 0.3, 2), Color3.fromRGB(160, 130, 100), true)
	part.Position = position
	part.Material = Enum.Material.Slate
	self:addHighlight(part, Color3.fromRGB(160, 130, 100), Color3.fromRGB(120, 90, 70))
	self:addCrumblingBehavior(part)
	return part
end

function LevelGenerator:createBoostVent(position: Vector3): Instance
	local part = self:createPart("BoostVent", Vector3.new(1.5, 0.3, 1.5), CityColors.ventOrange, true)
	part.Position = position
	self:addHighlight(part, Color3.fromRGB(255, 140, 0), Color3.fromRGB(200, 100, 0))
	self:addBoostBehavior(part)
	return part
end

function LevelGenerator:createBounceTarp(position: Vector3): Instance
	local part = self:createPart("BounceTarp", Vector3.new(2.5, 0.15, 2.5), CityColors.tarpBlue, true)
	part.Position = position
	self:addHighlight(part, Color3.fromRGB(60, 120, 200), Color3.fromRGB(40, 90, 170))
	self:addBounceBehavior(part)
	return part
end

function LevelGenerator:createRebar(position: Vector3): Instance
	local part = self:createPart("Rebar", Vector3.new(1, 1.5, 1), CityColors.rebarRust, true)
	part.Position = position
	part.Material = Enum.Material.Metal
	self:addHighlight(part, Color3.fromRGB(160, 80, 50), Color3.fromRGB(120, 50, 30))
	self:addSpikeBehavior(part)
	return part
end

function LevelGenerator:createElevatorShaft(position: Vector3, targetFloor: number): Instance
	local part = self:createPart("ElevatorShaft", Vector3.new(2, 0.5, 2), CityColors.elevatorGold, true)
	part.Position = position
	part.CanCollide = false
	self:addHighlight(part, Color3.fromRGB(200, 170, 60), Color3.fromRGB(160, 130, 40))
	self:addTeleporterBehavior(part, targetFloor)
	return part
end

function LevelGenerator:createWetRoof(position: Vector3): Instance
	local part = self:createPart("WetRoof", Vector3.new(3, 0.3, 3), CityColors.wetDark, true)
	part.Position = position
	part.Transparency = 0.2
	part.Reflectance = 0.6
	self:addHighlight(part, Color3.fromRGB(90, 95, 105), Color3.fromRGB(60, 65, 75))
	self:addIceBehavior(part)
	return part
end

function LevelGenerator:createConstructionLaser(position: Vector3): Instance
	local part = self:createPart("ConstructionLaser", Vector3.new(4, 0.5, 0.3), CityColors.laserRed, true)
	part.Position = position
	part.CanCollide = false
	self:addLaserBehavior(part)
	return part
end

function LevelGenerator:createCastle(position: Vector3): { Instance }
	local parts: { Instance } = {}
	local stone = Color3.fromRGB(200, 185, 155)
	local darkStone = Color3.fromRGB(160, 145, 120)
	local roof = Color3.fromRGB(140, 75, 55)
	local gold = Color3.fromRGB(255, 215, 0)

	local H = 20
	local T = 3
	local R = 32

	-- Base platform
	local base = self:createPart("CastleBase", Vector3.new(R * 2 + 8, 2, R * 2 + 8), darkStone, true)
	base.Position = position - Vector3.new(0, 1, 0)
	base.Material = Enum.Material.Slate
	table.insert(parts, base)

	-- Floor / courtyard
	local floor = self:createPart("CastleFloor", Vector3.new(R * 2 - 2, 0.5, R * 2 - 2), stone, true)
	floor.Position = position + Vector3.new(0, 0.25, 0)
	floor.Material = Enum.Material.Slate
	table.insert(parts, floor)

	-- Outer walls
	local function makeWall(name, size, pos)
		local w = self:createPart(name, size, stone, true)
		w.Position = pos
		w.Material = Enum.Material.Concrete
		table.insert(parts, w)
		return w
	end

	makeWall("Wall_N", Vector3.new(R * 2, H, T), position + Vector3.new(0, H / 2, -R))
	makeWall("Wall_S", Vector3.new(R * 2, H, T), position + Vector3.new(0, H / 2, R))
	makeWall("Wall_E", Vector3.new(T, H, R * 2), position + Vector3.new(R, H / 2, 0))
	makeWall("Wall_W", Vector3.new(T, H, R * 2), position + Vector3.new(-R, H / 2, 0))

	-- Wall crenellations
	for side = -1, 1, 2 do
		for x = -R + 3, R - 3, 4 do
			local c = makeWall(`Crenel_N_{x}`, Vector3.new(2, 2, 1), position + Vector3.new(x, H + 1, -R * side))
			c.Color = darkStone
		end
	end
	for side = -1, 1, 2 do
		for z = -R + 3, R - 3, 4 do
			local c = makeWall(`Crenel_E_{z}`, Vector3.new(1, 2, 2), position + Vector3.new(R * side, H + 1, z))
			c.Color = darkStone
		end
	end

	-- Main gate (south side, arch)
	makeWall("Gate_L", Vector3.new(2, 10, T), position + Vector3.new(-5, 5, R))
	makeWall("Gate_R", Vector3.new(2, 10, T), position + Vector3.new(5, 5, R))
	makeWall("Gate_Arch", Vector3.new(14, 2, T), position + Vector3.new(0, 11, R))

	-- Gate decorative columns
	makeWall("GateColumn_L", Vector3.new(1.5, H, 1.5), position + Vector3.new(-7, H / 2, R + 1))
	makeWall("GateColumn_R", Vector3.new(1.5, H, 1.5), position + Vector3.new(7, H / 2, R + 1))

	-- Corner towers
	local towerPositions = {
		{ -R + 5, -R + 5 },
		{ R - 5, -R + 5 },
		{ -R + 5, R - 5 },
		{ R - 5, R - 5 },
	}
	for i, tp in towerPositions do
		local tx, tz = tp[1], tp[2]
		local tBase = makeWall(`TowerBase_{i}`, Vector3.new(10, 30, 10), position + Vector3.new(tx, 15, tz))
		tBase.Material = Enum.Material.Concrete

		local tRoof = makeWall(`TowerRoof_{i}`, Vector3.new(12, 4, 12), position + Vector3.new(tx, 32, tz))
		tRoof.Color = roof
		tRoof.Material = Enum.Material.Slate

		local tSpire = makeWall(`TowerSpire_{i}`, Vector3.new(1.5, 6, 1.5), position + Vector3.new(tx, 37, tz))
		tSpire.Color = gold

		-- Tower windows
		for s = -2, 2, 2 do
			local win = self:createPart(`TowerWin_{i}_{s}`, Vector3.new(1.5, 2, 0.2), CityColors.glass, true)
			win.Position = position + Vector3.new(tx + s, 10, tz - 5.1)
			win.Transparency = 0.2
			win.Material = Enum.Material.Glass
			table.insert(parts, win)
		end
	end

	-- Central keep
	local keep = makeWall("CentralKeep", Vector3.new(16, 45, 16), position + Vector3.new(0, 22.5, 0))
	keep.Material = Enum.Material.Concrete

	-- Keep upper tier
	local upper = makeWall("UpperKeep", Vector3.new(12, 15, 12), position + Vector3.new(0, 52.5, 0))
	upper.Color = Color3.fromRGB(220, 200, 170)
	upper.Material = Enum.Material.Concrete

	-- Keep roof
	local keepRoof = makeWall("KeepRoof", Vector3.new(14, 3, 14), position + Vector3.new(0, 61.5, 0))
	keepRoof.Color = roof
	keepRoof.Material = Enum.Material.Slate

	-- Central spire (tall, golden)
	local spire = makeWall("CentralSpire", Vector3.new(2, 20, 2), position + Vector3.new(0, 73, 0))
	spire.Color = gold

	-- Golden glow
	local light = Instance.new("PointLight")
	light.Color = gold
	light.Range = 80
	light.Brightness = 5
	light.Shadows = true
	light.Parent = spire
	light.Name = "CastleGlow"
	table.insert(parts, light)

	-- Particle emitter
	local emitter = Instance.new("ParticleEmitter")
	emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	emitter.Rate = 15
	emitter.Lifetime = NumberRange.new(2, 5)
	emitter.Speed = NumberRange.new(1, 4)
	emitter.VelocityInheritance = 0
	emitter.Color = ColorSequence.new(gold)
	emitter.Size = NumberSequence.new(0.3, 0.8)
	emitter.Transparency = NumberSequence.new(0.6, 0.9)
	emitter.LightEmission = 1
	emitter.Parent = spire
	emitter.Name = "CastleParticles"

	-- Keep windows (glowing)
	for s = -5, 5, 3 do
		for y = 8, 38, 10 do
			local kW = self:createPart(`KeepWin_{s}_{y}`, Vector3.new(2, 3, 0.2), Color3.fromRGB(255, 230, 150), true)
			kW.Position = position + Vector3.new(s, y, 8.1)
			kW.Transparency = 0.1
			kW.Material = Enum.Material.Glass
			table.insert(parts, kW)
		end
	end

	-- Interior staircase (visual, inside keep)
	for s = 0, 15 do
		local stair = self:createPart(`CastleStair_{s}`, Vector3.new(4, 0.3, 2), stone, true)
		stair.Position = position + Vector3.new(0, 2 + s * 3, -2)
		stair.Transparency = math.min(0.7, 0.3 + s * 0.03)
		stair.Material = Enum.Material.Slate
		table.insert(parts, stair)

		-- Alternating stair segments
		local stair2 = self:createPart(`CastleStair_{s}_b`, Vector3.new(2, 0.3, 4), stone, true)
		stair2.Position = position + Vector3.new(2, 3.5 + s * 3, 0)
		stair2.Transparency = math.min(0.7, 0.3 + s * 0.03)
		stair2.Material = Enum.Material.Slate
		table.insert(parts, stair2)
	end

	print(`[LevelGenerator] Created Castle of Gods at {position}`)
	return parts
end

function LevelGenerator:createATM(position: Vector3): { Instance }
	local parts: { Instance } = {}
	local body = self:createPart("ATM_Body", Vector3.new(3, 6, 1.5), Color3.fromRGB(50, 50, 50), true)
	body.Position = position + Vector3.new(0, 3, 0)
	body.Material = Enum.Material.Metal
	table.insert(parts, body)

	local screen = self:createPart("ATM_Screen", Vector3.new(2.2, 1.8, 0.2), CityColors.atmBlue, true)
	screen.Position = position + Vector3.new(0, 4.5, 0.7)
	screen.Material = Enum.Material.Neon
	table.insert(parts, screen)

	local keypad = self:createPart("ATM_Keypad", Vector3.new(2, 0.2, 1), Color3.fromRGB(150, 150, 150), true)
	keypad.Position = position + Vector3.new(0, 3.2, 1)
	keypad.Material = Enum.Material.Metal
	table.insert(parts, keypad)

	print(`[LevelGenerator] Created ATM at {position}`)
	return parts
end

function LevelGenerator:createLeaderboard(position: Vector3): { Instance }
	local parts: { Instance } = {}
	local base = self:createPart("Leaderboard_Base", Vector3.new(10, 1, 4), Color3.fromRGB(80, 80, 80), true)
	base.Position = position + Vector3.new(0, 0.5, 0)
	base.Material = Enum.Material.Concrete
	table.insert(parts, base)

	local frame = self:createPart("Leaderboard_Frame", Vector3.new(12, 16, 1), Color3.fromRGB(40, 40, 40), true)
	frame.Position = position + Vector3.new(0, 9, 0)
	frame.Material = Enum.Material.Metal
	table.insert(parts, frame)

	local display = self:createPart("Leaderboard_Display", Vector3.new(11, 14, 0.2), Color3.fromRGB(20, 20, 20), true)
	display.Position = position + Vector3.new(0, 9, 0.5)
	display.Material = Enum.Material.Glass
	table.insert(parts, display)

	local crown = self:createPart("Leaderboard_Crown", Vector3.new(4, 2, 0.5), CityColors.leaderboardGold, true)
	crown.Position = position + Vector3.new(0, 18, 0)
	crown.Material = Enum.Material.Neon
	table.insert(parts, crown)

	print(`[LevelGenerator] Created Leaderboard at {position}`)
	return parts
end

function LevelGenerator:createShop(position: Vector3): { Instance }
	local parts: { Instance } = {}
	local booth = self:createPart("Shop_Booth", Vector3.new(8, 8, 8), Color3.fromRGB(120, 90, 60), true)
	booth.Position = position + Vector3.new(0, 4, 0)
	booth.Material = Enum.Material.Wood
	table.insert(parts, booth)

	local counter = self:createPart("Shop_Counter", Vector3.new(8.5, 1, 2), Color3.fromRGB(100, 80, 50), true)
	counter.Position = position + Vector3.new(0, 3.5, 3.5)
	counter.Material = Enum.Material.Wood
	table.insert(parts, counter)

	local roof = self:createPart("Shop_Roof", Vector3.new(10, 1, 10), CityColors.shopGreen, true)
	roof.Position = position + Vector3.new(0, 8.5, 0)
	roof.Material = Enum.Material.Fabric
	table.insert(parts, roof)

	local sign = self:createPart("Shop_Sign", Vector3.new(4, 2, 0.2), CityColors.shopGreen, true)
	sign.Position = position + Vector3.new(0, 7, 4.1)
	sign.Material = Enum.Material.SmoothPlastic
	table.insert(parts, sign)

	print(`[LevelGenerator] Created Shop at {position}`)
	return parts
end

function LevelGenerator:createRoyalSquare(position: Vector3): { [string]: any }
	local objects: { [string]: any } = {}
	local R = 64 -- Radius of the square

	-- Floor
	local floor = self:createPart("RoyalSquare_Floor", Vector3.new(R * 2, 1, R * 2), Color3.fromRGB(120, 120, 120), true)
	floor.Position = position
	floor.Material = Enum.Material.Pavement
	objects["Floor"] = floor

	-- Leaderboard in center
	local lbParts = self:createLeaderboard(position + Vector3.new(0, 0.5, 0))
	for i, p in lbParts do
		objects[`Leaderboard_{i}`] = p
	end

	-- ATMs at 4 corners
	local atmOffset = R - 10
	local atmPositions = {
		Vector3.new(atmOffset, 0.5, atmOffset),
		Vector3.new(-atmOffset, 0.5, atmOffset),
		Vector3.new(atmOffset, 0.5, -atmOffset),
		Vector3.new(-atmOffset, 0.5, -atmOffset),
	}
	for i, pos in atmPositions do
		local atmParts = self:createATM(position + pos)
		for j, p in atmParts do
			objects[`ATM_{i}_{j}`] = p
		end
	end

	-- Shop near the edge
	local shopParts = self:createShop(position + Vector3.new(0, 0.5, -R + 15))
	for i, p in shopParts do
		objects[`Shop_{i}`] = p
	end

	-- Spawns on edges
	objects["SpawnPoints"] = {
		position + Vector3.new(R - 5, 2, 0),
		position + Vector3.new(-R + 5, 2, 0),
		position + Vector3.new(0, 2, R - 5),
		position + Vector3.new(0, 2, -R + 5),
	}

	print(`[LevelGenerator] Created Royal Square at {position}`)
	return objects
end

function LevelGenerator:generateCityBlock(blockNumber: number, difficulty: LevelDifficulty, centerPos: Vector3?): { [string]: any }
	local settings = DifficultySettings[difficulty]
	local blockObjects: { [string]: any } = {}
	local baseHeight = centerPos and centerPos.Y or blockNumber * 20
	local blockCenterX = centerPos and centerPos.X or (math.random() - 0.5) * 20
	local blockCenterZ = centerPos and centerPos.Z or (math.random() - 0.5) * 20

	local numBuildings = math.random(2, 4)
	local buildingConfigs: { BuildingConfig } = {}

	for _ = 1, numBuildings do
		local stories = math.random(2, settings.buildingMaxStories)
		local config: BuildingConfig = {
			width = math.random(4, 8),
			depth = math.random(4, 8),
			height = stories * STORY_HEIGHT,
			hasBalcony = math.random() > 0.5,
			hasRoofAccess = true,
			storyCount = stories,
		}
		table.insert(buildingConfigs, config)
	end

	local buildingPositions: { Vector3 } = {}
	for i, config in buildingConfigs do
		local xOffset = (i - (numBuildings - 1) / 2) * 12 + (math.random() - 0.5) * 3
		local pos =
			Vector3.new(blockCenterX + xOffset, baseHeight + config.height / 2, blockCenterZ + (math.random() - 0.5) * 4)
		buildingPositions[i] = pos

		local building = self:createBuilding(config, pos)
		blockObjects[`Building_{i}`] = building
	end

	for i = 2, numBuildings do
		local prevPos = buildingPositions[i - 1]
		local currPos = buildingPositions[i]
		local prevHeight = buildingConfigs[i - 1].height
		local currHeight = buildingConfigs[i].height
		local bridgeY = math.min(prevPos.Y + prevHeight / 2, currPos.Y + currHeight / 2)

		local bridge = self:createBridge(Vector3.new(prevPos.X, bridgeY, prevPos.Z), Vector3.new(currPos.X, bridgeY, currPos.Z))
		for _, part in bridge do
			blockObjects[`Bridge_{i}_{tostring(part)}`] = part
		end
	end

	local firstPos = buildingPositions[1]
	local firstConfig = buildingConfigs[1]
	blockObjects["SpawnPoint"] = Vector3.new(firstPos.X, firstPos.Y - firstConfig.height / 2 + 2, firstPos.Z)

	local obstacleRoll = math.random()
	if obstacleRoll < settings.obstacleChance then
		local obsTypes = { "rebar", "wet_roof", "construction_laser" }
		local obsType = obsTypes[math.random(#obsTypes)]
		local obsPos = buildingPositions[math.random(#buildingPositions)]
		if obsType == "rebar" then
			blockObjects["Obstacle"] = self:createRebar(Vector3.new(obsPos.X + 3, obsPos.Y + obsPos.Y * 0.3, obsPos.Z))
		elseif obsType == "wet_roof" then
			local roofPos = buildingPositions[math.random(#buildingPositions)]
			local roofConfig = buildingConfigs[math.min(math.random(#buildingConfigs), #buildingConfigs)]
			blockObjects["Obstacle"] =
				self:createWetRoof(Vector3.new(roofPos.X, roofPos.Y + roofConfig.height / 2 + 0.5, roofPos.Z))
		elseif obsType == "construction_laser" then
			local mid = (buildingPositions[1] + buildingPositions[#buildingPositions]) / 2
			blockObjects["Obstacle"] = self:createConstructionLaser(Vector3.new(mid.X, baseHeight + 15, mid.Z))
		end
	end

	local boostRoll = math.random()
	if boostRoll < 0.3 then
		local boostPos = buildingPositions[math.random(#buildingPositions)]
		blockObjects["Boost"] = self:createBoostVent(Vector3.new(boostPos.X, baseHeight + 8, boostPos.Z + 4))
	end

	if math.random() < 0.2 then
		local billPos = buildingPositions[math.random(#buildingPositions)]
		local bill = self:createBillboard(Vector3.new(billPos.X + 5, baseHeight + 3, billPos.Z))
		for _, part in bill do
			blockObjects[`Billboard_{tostring(part)}`] = part
		end
	end

	if math.random() < 0.25 then
		local craneHeight = math.random(10, 20)
		local cranePos = Vector3.new(blockCenterX + numBuildings * 6 + 5, baseHeight, blockCenterZ)
		local crane = self:createCrane(cranePos, craneHeight)
		for _, part in crane do
			blockObjects[`Crane_{tostring(part)}`] = part
		end
	end

	blockObjects["_BuildingPositions"] = buildingPositions
	blockObjects["_BuildingConfigs"] = buildingConfigs

	print(`[LevelGenerator] Generated city block {blockNumber} with {numBuildings} buildings`)
	return blockObjects
end

--- Original behavior methods preserved

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

--- Generation methods

function LevelGenerator:generateFloor(_floorNumber: number, _difficulty: LevelDifficulty): { [number]: Instance }
	return {}
end

function LevelGenerator:generateLevel(levelNumber: number, difficulty: LevelDifficulty): { [number]: any }
	self.currentLevel = levelNumber
	self.currentDifficulty = difficulty

	local blocks: { [number]: any } = {}
	local blocksInLevel = 5

	for b = 1, blocksInLevel do
		blocks[b] = self:generateCityBlock(b, difficulty)
	end

	self.cityBlocks = blocks
	print(`[LevelGenerator] Generated city level {levelNumber} with {blocksInLevel} blocks (difficulty: {difficulty})`)
	return blocks
end

function LevelGenerator:generateDisasterLevel(levelNumber: number, _disasterType: string): any
	return self:generateLevel(levelNumber, "hard")
end

function LevelGenerator:cleanup()
	for _, block in self.cityBlocks do
		if typeof(block) == "table" then
			for _, obj in block do
				if typeof(obj) == "Instance" then
					obj:Destroy()
				end
			end
		end
	end
	self.cityBlocks = {}
end

return LevelGenerator
