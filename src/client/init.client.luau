-- MiastoX Client Initialization
-- Built on CityX Framework

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local CityXClient = require(ReplicatedStorage.CityXClient)
local PauseMenu = require(ReplicatedStorage.CityX.PauseMenu)
local HUD = require(ReplicatedStorage.CityX.HUD)
local Shop = require(ReplicatedStorage.CityX.Shop)

local config = {
	showHealth = true,
	showCoins = true,
	showLevel = true,
	showXP = true,
}

local pauseMenu = PauseMenu.new()
local hud = HUD.new(config)
local shop = Shop.new()

local function onCharacterAdded(character)
	local player = Players.LocalPlayer
	print(string.format("[MiastoX] %s spawned", player.Name))
end

local function onGuiAdded(gui)
	print(string.format("[MiastoX] GUI added: %s", gui.Name))
end

local function setupInput()
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end
		
		if input.KeyCode == Enum.KeyCode.P then
			if shop:isOpen() then
				shop:close()
			else
				shop:open()
			end
		elseif input.KeyCode == Enum.KeyCode.Escape then
			if pauseMenu:isPaused() then
				pauseMenu:resume()
			end
		end
	end)
end

game.Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

CityXClient.init()
pauseMenu:init()
hud:init()
shop:init()
setupInput()

hud:setCoins(0)
hud:setLevel(1)

print("[MiastoX] Client initialized on CityX Framework")
print("[MiastoX] Controls: ESC = Pause, P = Shop")