--!native
--!optimize 2
--!strict

-- MiastoX Server Controller
-- Uses cityx PlayerHandler + custom game logic

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- First, use cityx framework for core server handling
local CityX = ReplicatedStorage:FindFirstChild("CityX")
if CityX and CityX.PlayerHandler then
	local PlayerHandler = require(CityX.PlayerHandler)
	PlayerHandler.init()
end

-- MiastoX-specific player tracking
Players.PlayerAdded:Connect(function(Player)
	print(string.format("[MiastoX] Player joined: %s (ID: %d)", Player.Name, Player.UserId))

	-- Set player attributes
	Player:SetAttribute("JoinedTime", os.time())
	Player:SetAttribute("PlayTime", 0)
end)

Players.PlayerRemoving:Connect(function(Player)
	local playTime = Player:GetAttribute("PlayTime") or 0
	print(string.format("[MiastoX] Player left: %s (PlayTime: %ds)", Player.Name, playTime))
end)

-- Game-specific data storage
local function createPlayerData(player)
	return {
		Coins = 0,
		XP = 0,
		Level = 1,
		Rank = 0,
		Deaths = 0,
		Kills = 0,
		CurrentFloor = 1,
		BestFloor = 1,
	}
end

print("[MiastoX] Server controller initialized with CityX Framework")
