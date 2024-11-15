local DisplayInfo = {
	Priority = 0,  -- Domyślny priorytet ładowania modułu
	Initialize = true -- Czy moduł ma być inicjalizowany
}

-- Roblox Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--= Variables =--
local TimeInitialized = 0

--= Internal Functions =--
local function GetCurrentTime()
	return os.time()
end

--= API Functions =--
function DisplayInfo:displayPlaceInfo(placeInfo, player)
	-- Sprawdzenie, czy skrypt działa w trybie gry
	if not RunService:IsRunning() then
		warn("displayPlaceInfo może być używane tylko w trybie gry.")
		return
	end

	-- Oczekiwanie na poprawne przekazanie obiektu gracza, jeśli jest to konieczne
	local maxWaitTime = 5  -- Maksymalny czas oczekiwania na poprawny obiekt gracza (w sekundach)
	local startTime = tick()

	while (not player or not player:IsA("Player")) and tick() - startTime < maxWaitTime do
		player = Players.LocalPlayer  -- Przykładowe przypisanie dla kontekstu gry (możesz dostosować do własnych potrzeb)
		task.wait(0.1)
	end

	-- Jeśli nadal nie ma poprawnego obiektu gracza, wyświetlamy ostrzeżenie
	if not player or not player:IsA("Player") then
		warn("Nieprawidłowy obiekt gracza przekazany do displayPlaceInfo po maksymalnym czasie oczekiwania.")
		return
	end

	-- Upewnij się, że operacja jest wykonywana tylko na kliencie (np. z LocalScript)
	local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui", maxWaitTime)
	if not playerGui then
		warn("Nie znaleziono PlayerGui dla gracza: " .. player.Name)
		return
	end

	local screenGui = Instance.new("ScreenGui")
	local infoLabel = Instance.new("TextLabel")
	screenGui.Parent = playerGui
	infoLabel.Parent = screenGui
	infoLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
	infoLabel.Position = UDim2.new(0.25, 0, 0.25, 0)
	infoLabel.BackgroundColor3 = Color3.new(0, 0, 0)
	infoLabel.TextColor3 = Color3.new(1, 1, 1)
	infoLabel.TextScaled = true
	infoLabel.Text = string.format(
		"Place ID: %s\nPlace Name: %s\nOwner ID: %s\nPlayers: %d",
		placeInfo.Id, placeInfo.Name, placeInfo.Owner, placeInfo.NumberOfPlayers
	)

	-- Usuwanie UI po 10 sekundach
	task.wait(10)
	screenGui:Destroy()
end

--= Initializers =--
function DisplayInfo:Init()
	TimeInitialized = GetCurrentTime()
end

return DisplayInfo