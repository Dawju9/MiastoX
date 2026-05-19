-- MiastoX Server Initialization
-- Built on CityX Framework

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CityX = require(ReplicatedStorage.CityX)
local DataStore = require(ReplicatedStorage.CityX.DataStore)
local LevelManager = require(script.LevelManager)

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
		{ name = "extreme", unlocked = false, requiredRank = 50 },
	},
	city_objects = {
		"building",
		"scaffolding",
		"fire_escape",
		"crane",
		"bridge_plank",
		"ladder",
		"billboard",
		"balcony",
		"moving_scaffold",
		"rotating_sign",
		"collapsing_ledge",
		"crumbling_stairs",
		"boost_vent",
		"bounce_tarp",
		"rebar",
		"elevator_shaft",
		"wet_roof",
		"construction_laser",
	},
	weather = {
		"sunny",
		"rainy",
		"foggy",
		"snowy",
		"cloudy",
		"night",
		"smog",
		"drizzle",
		"overcast",
	},
}

local dataStore = DataStore.new()
dataStore:init {
	maxPlayers = 30,
	saveInterval = 60,
}

local function onPlayerJoin(player)
	print(string.format("[MiastoX] Player joined: %s", player.Name))

	local playerData = dataStore:loadPlayerData(player.UserId)
	dataStore:setCoins(player.UserId, playerData.coins or 0)

	print(
		string.format("[MiastoX] %s loaded - Coins: %d, Level: %d", player.Name, playerData.coins or 0, playerData.level or 1)
	)

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

local levelManager = LevelManager.new()
levelManager:reset()

print("[MiastoX] Level system initialized")
print("[MiastoX] Initialized on CityX Framework v0.1.0")
print(string.format("[MiastoX] Game: %s | Players: %d/%d", config.gameName, game.Players.MaxPlayers, config.maxPlayers))
