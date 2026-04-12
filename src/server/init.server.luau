-- MiastoX Server Initialization
-- Built on CityX Framework

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local CityX = require(ReplicatedStorage.CityX)
local DataStore = require(ReplicatedStorage.CityX.DataStore)

local config = {
	gameName = "MiastoX",
	maxPlayers = 30,
	enablePvP = false,
	enablePowerUps = true,
	enableWeather = true,
	difficulties = {
		{ name = "easy", unlocked = true },
		{ name = "medium", unlocked = true },
		{ name = "hard", unlocked = false, requiredRank = 25 },
		{ name = "extreme", unlocked = false, requiredRank = 50 }
	},
	platforms = {
		{ name = "blue", color = Color3.fromRGB(0, 0, 255), speed = 2 },
		{ name = "red", color = Color3.fromRGB(255, 0, 0), speed = 1.5 },
		{ name = "green", color = Color3.fromRGB(0, 255, 0), speed = 0 },
		{ name = "purple", color = Color3.fromRGB(128, 0, 128), speed = 1 },
		{ name = "yellow", color = Color3.fromRGB(255, 255, 0), speed = 2 }
	},
	stairs = {
		"basic", "platform", "moving", "rotating", "spiral", "checkpoint", "elevator", "special"
	},
	weather = {
		"sunny", "rainy", "foggy", "stormy", "snowy", "cloudy", "night", "eclipse", "apocalyptic"
	}
}

local dataStore = DataStore.new()
dataStore:init({
	maxPlayers = 30,
	saveInterval = 60,
})

local function onPlayerJoin(player)
	print(string.format("[MiastoX] Player joined: %s", player.Name))
	
	local playerData = dataStore:loadPlayerData(player.UserId)
	dataStore:setCoins(player.UserId, playerData.coins or 0)
	
	print(string.format("[MiastoX] %s loaded - Coins: %d, Level: %d", 
		player.Name, 
		playerData.coins or 0, 
		playerData.level or 1
	))
	
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Died:Connect(function()
				dataStore:incrementStat(player.UserId, "deaths")
				dataStore:setBestFloor(player.UserId, 1)
			end)
		end
	end)
end

local function onPlayerLeave(player)
	print(string.format("[MiastoX] Player left: %s", player.Name))
	
	dataStore:savePlayerData(player.UserId)
	dataStore:deletePlayerData(player.UserId)
end

game.Players.PlayerAdded:Connect(onPlayerJoin)
game.Players.PlayerRemoving:Connect(onPlayerLeave)

CityX.init(config)

print("[MiastoX] Initialized on CityX Framework v0.1.0")
print(string.format("[MiastoX] Game: %s | Players: %d/%d", 
	config.gameName, 
	game.Players.MaxPlayers, 
	config.maxPlayers
))