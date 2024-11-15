local module = {}

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local plr = Players.LocalPlayer

local Buildings = RS:WaitForChild("Buildings")
local BlocksRS = RS:WaitForChild("Blocks")

local RsBlock = RS:WaitForChild("Block")

local Blocks = workspace:WaitForChild("Blocks")

local BuildingsAmount = #Buildings:GetChildren()

local bSizeX = RsBlock:WaitForChild("Ground").Size.X 
local bSizeZ = RsBlock:WaitForChild("Ground").Size.Z

local WaitAfterDeleting = true -- if the game should wait after deleting a block, massively improves performance but it makes the buildings load in slower. Recommended to have on if you wont be moving to quickly
local WaitAfterAdding = true -- same as above but when adding a new block


local DefaultLoaded = 24 -- render distance


local sizeX = (math.sqrt(DefaultLoaded)*bSizeX)*1.5 -- removal distance, if a block is further away from the player than this value it gets removed, not recommended to change as it changes automatically. But you might still need to change if it spam deletes and re generates the same block over and over.
local sizeZ = (math.sqrt(DefaultLoaded)*bSizeZ)*1.5 -- same as above but Z

math.randomseed(1) -- the seed, does not really matter that much as the city will still be different for each player cause this does not use perlin noise to randomly generate the city.

local function roundTo(num, mult)
	return math.floor(num / mult + 0.5) * mult
end

local function CreateBlock(Pos)
	coroutine.wrap(function()
		local Block = BlocksRS["Block"..math.random(1,BuildingsAmount)]:Clone()
		Block:SetPrimaryPartCFrame(CFrame.new(Pos))
		Block.Name = tostring(Pos)

		Block.Parent = Blocks
	end)()
end

function module.Generate()
	local char = plr.Character
	if char == nil then
		warn"No char"
		return
	end
	local Root = char:FindFirstChild("HumanoidRootPart")
	if Root == nil then
		warn"No Root"
		return
	end

	local Pos = Root.Position
	local Corner1 = Vector3.new(Pos.X+(sizeX/2), 0, Pos.Z+(sizeX/2))
	local Corner2 = Vector3.new(Pos.X-(sizeX/2), 0, Pos.Z-(sizeX/2))
	coroutine.wrap(function()
		for i,v in pairs(Blocks:GetChildren()) do
			if v.PrimaryPart then
				local p = v.PrimaryPart.Position
				local d = (p-Vector3.new(Pos.X, p.Y, Pos.Z)).Magnitude
				if p.X > Corner1.X or p.X < Corner2.X or p.Z > Corner1.Z or p.Z < Corner2.Z then
					v:Destroy()
					if WaitAfterDeleting then
						wait()
					end	
				end

			else
				warn"Building has no primaryPart"
			end	
		end
	end)()	

	--

	-- loading
	coroutine.wrap(function()
		for z = 1, sizeZ,bSizeZ do
			for x  = 1,sizeX,bSizeX do
				local CurrentPos = Vector3.new(
					roundTo((Pos.X-sizeX/2)+x, bSizeX),
					0,
					roundTo((Pos.Z-sizeZ/2)+z, bSizeZ)

				)
				if Blocks:FindFirstChild(tostring(CurrentPos)) == nil then
					CreateBlock(CurrentPos)
					if WaitAfterAdding then
						wait()
					end	
				end
			end
		end
	end)()	
end

for i,Building in pairs(Buildings:GetChildren()) do -- generating the city blocks
	local bl = RsBlock:Clone()
	for _,v in pairs(bl:WaitForChild("Platforms"):GetChildren()) do
		local b = Building:Clone()
		local s = b.PrimaryPart.Size
		local p = v.Position
		local pos = Vector3.new(
			p.X,
			p.Y+s.Y/2,
			p.Z
		)
		b:SetPrimaryPartCFrame(CFrame.new(pos))
		b.Parent = bl.Buildings
		v:Destroy()
	end	
	bl.Platforms:Destroy()
	bl.Name = "Block"..i
	bl.Parent = BlocksRS
end

return module
