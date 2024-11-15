--[[
    Main loop Miasto X 0.0.1v
    :--------------[  Game ]:--------------:
    Author: < 'Whitekali' >
    Version: 0.0.1
    Date: 2024-10-07
    Codebase: https://github.com/Whitekali/Roblox-Scripts/blob/master/SplashScreenModule.luau
    License: MIT License
    Description:
    	/ Add other information here /
    Versions history:
        0.0.1 - Initial release
	Wyjaśnienie:
		Pętla gry (gameLoop) jest odpowiedzialna za ciągłe 
	aktualizowanie stanu gry.
    :-------------------------------------------------------------:
]]--

-- Moduł ładowania modułów
local ModuleLoader = require("ModuleLoader")


-- Serwis Gry
local Players = game:GetService("Players")

--[[
    FINNALSTAIR - Zmienne i funkcje
]]--	

-- Folder przechowujący dane o labiryncie
local MazeDataFolder = game:GetService("ReplicatedStorage"):WaitForChild("MazeData")


-- Globalne zmienne stanu gry
local gameRunning = false
local currentLevel = 1
local players = {}

-- Funkcja ładująca dane labiryntu dla danego poziomu
local function loadMazeData(level)
	local levelData = MazeDataFolder:FindFirstChild("Level" .. level)
	if levelData then
		return levelData:GetChildren() -- Zwraca tablicę instancji reprezentujących dane labiryntu
	else
		warn("Brak danych dla poziomu " .. level)
		return nil
	end
end



-- Funkcja generująca labirynt na podstawie danych
local function generateMaze(mazeData)
    --[[
        Tutaj umieść logikę generowania labiryntu na podstawie danych z mazeData.
        Możesz użyć instancji z mazeData do stworzenia części labiryntu w Workspace.
    ]]--
end
-- Funkcja pobierająca aktywnych graczy w FinnalStair (przykład)
local function getActivePlayersInFinnalStair()
	local activePlayers = {}
	for _, player in ipairs(players) do
		if player.InFinnalStair then
			table.insert(activePlayers, player)
		end
	end
	return activePlayers
end

-- Funkcja obsługująca pętlę gry FinnalStair
local function handleFinnalStairGameLoop()
	if currentLevel > 0 then 
		-- Pobierz aktywnych graczy w FinnalStair
		local activePlayers = getActivePlayersInFinnalStair()

		for _, player in ipairs(activePlayers) do
			--UpdatePlayerState(player)      -- Aktualizacja stanu graczy
			--HandlePlayerInput(player)      -- Obsługa wejścia od graczy
			--CheckCollisions(player)         -- Sprawdzenie kolizji 
		end

		--UpdateGameWorld()        -- Aktualizacja stanu świata gry (FinnalStair)
		--UpdateAI()               -- Aktualizacja sztucznej inteligencji (FinnalStair)
		--ManageEvents()           -- Zarządzanie zdarzeniami w grze (FinnalStair)
	end
end

-- Funkcja obsługująca pętlę Hangoutu
local function handleHangoutLoop()
    --[[
        -- Tutaj umieść logikę specyficzną dla Hangoutu, np.:
        -- Obsługa czatu
        -- Interakcje z NPC
        -- Mini-gry
    ]]--
end

-- Inicjalizacja gry
local function initGame()
	-- Ładowanie modułów
	ModuleLoader.loadModules()


	-- Inicjalizacja graczy (FinnalStair i Hangout)
	--   - Tworzenie postaci graczy
	--   - Ustawianie początkowych statystyk i ekwipunku
	--   - Pozycjonowanie graczy w świecie gry (Hangout)

	Players.PlayerAdded:Connect(function(player)
		-- Dodaj gracza do tablicy 'players'
		table.insert(players, player)

		-- Ustaw początkowe wartości dla gracza
		player.InFinnalStair = false

		-- Połącz zdarzenia gracza
		player.CharacterAdded:Connect(function(character)
			-- Ustaw pozycję startową postaci w Hangout
			character:MoveTo(Vector3.new(0, 10, 0)) -- Przykładowa pozycja
		end)
	end)

	-- Inicjalizacja środowiska (FinnalStair i Hangout)
	--   - Ładowanie mapy i zasobów graficznych
	--   - Tworzenie obiektów w świecie gry
	--   - Ustawianie początkowego stanu środowiska
	--   - Ustawianie początkowych statystyk i ekwipunku


	--World.citix.InitElevator()

	-- Inicjalizacja SI Miastox/Cityx (Ogólna)
	--   - Inicjalizacja AI dla postaci niezależnych (NPC)
	--   - Ustawianie parametrów symulacji miasta


end









--[[
    HANGOUT - Zmienne i funkcje
]]--

--[[
#### **Główna Logika Gry (Main Game Logic Loop)**
	**Funkcje w pętli głównej gry:**
			-- Akcje
		-- Obsługa graczy
		-- Obsługa środowiska
		-- Obsługa czasu
		-- Wywoływanie anomalii i zdarzeń
		-- Zapytania dla graczy
		-- Poruszanie się po świecie gry
		-- Logika SI Miastox/Cityx
			-- Inicjatory
		Funkcja initGame jest wywoływana jednorazowo na początku 
		gry i służy do inicjalizacji niezbędnych elementów.
		-- Inicjalizacja graczy
		-- Inicjalizacja środowiska
		-- Inicjalizacja SI Miastox/Cityx
]]--
local function gameLoop()
	gameRunning = true

	while gameRunning do
		-- FINNALSTAIR - Obsługa gry
		handleFinnalStairGameLoop()

		-- HANGOUT - Obsługa 
		handleHangoutLoop()

		wait(1/30) -- Aktualizacja 30 razy na sekundę
	end

	-- Sprzątanie po zakończeniu gry (jeśli potrzebne)
end
