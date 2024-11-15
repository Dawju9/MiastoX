local PlayerHandler = {
	Priority = 0,  -- Wyższy priorytet oznacza wcześniejsze załadowanie modułu
	Initialize = true -- Określa, czy moduł ma być zainicjalizowany
}

-- Roblox Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

--= Dependencies =--
local DisplayInfo = shared("Shared/DisplayInfo") 
--= API Functions =--
function PlayerHandler:onPlayerAdded(player)
	-- Logika gracza przy dołączaniu
	print(player.Name .. " dołączył do gry.")
	self:showInfoPlayer(player)
	self:setupMainMenu(player)
end

function PlayerHandler:showInfoPlayer(player)
	DisplayInfo:Init()
	-- Zakładam, że DisplayInfo ma odpowiednią funkcję wyświetlania informacji
	DisplayInfo:displayPlaceInfo({
		Id = game.PlaceId,
		Name = game.Name,
		Owner = game.CreatorId,
		NumberOfPlayers = #Players:GetPlayers()
	})
end

function PlayerHandler:setupMainMenu(player)
	-- Tworzenie menu głównego dla gracza
	local playerGui = player:WaitForChild("PlayerGui")

	-- Sprawdzenie i ustawienie MenuCam
	local menuCam = Workspace:FindFirstChild("MenuCam")
	if not menuCam then
		warn("MenuCam not found in Workspace. Ensure it exists.")
		return
	end

	-- Tworzenie głównego menu GUI
	local mainMenuGui = Instance.new("ScreenGui")
	mainMenuGui.Name = "MainMenu"
	mainMenuGui.Parent = playerGui

	local mainMenuLabel = Instance.new("TextLabel")
	mainMenuLabel.Parent = mainMenuGui
	mainMenuLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
	mainMenuLabel.Position = UDim2.new(0.35, 0, 0.45, 0)
	mainMenuLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	mainMenuLabel.TextColor3 = Color3.new(1, 1, 1)
	mainMenuLabel.Text = "Witaj w Menu Głównym!"
	mainMenuLabel.TextScaled = true

	-- Ustawienie kamery na MenuCam (dla widoku menu głównego)
	local camera = Workspace.CurrentCamera
	if camera then
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CFrame = menuCam.CFrame
	end
end

function PlayerHandler:onPlayerRemoving(player)
	-- Logika gracza przy opuszczaniu gry
	print(player.Name .. " opuścił grę.")
end

--= Initializers =--
function PlayerHandler:Init()
	Players.PlayerAdded:Connect(function(player)
		self:onPlayerAdded(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:onPlayerRemoving(player)
	end)
end

return PlayerHandler




