--[[


--[[




    Game loop CREATION AND ENHANCEMENT v-1.0.0

    :--------------[  Game ]:--------------:
    Author: < 'Whitekali' >
    Version: 0.0.1
    Date: 2024-07-06
    Codebase: https://github.com/Whitekali/Roblox-Scripts/blob/master/SplashScreenModule.luau
    License: MIT License
    Description:
Świat pogrążony w cybernetycznym chaosie. Sieci neuronowe wymknęły się spod kontroli, a rzeczywistość miesza się z wirtualem. W samym sercu tego cyfrowego labiryntu kryje się FinnalStair - ciągle zmieniający się labirynt, będący ostatnim bastionem wolności i miejscem, gdzie prawdziwi gracze testują swoje umiejętności.

Głównym bohaterem jest Aiden, genialny, choć ekscentryczny haker, który włada siecią jak nikt inny. To on odkrył FinnalStair i przekształcił go w arenę dla żądnych wrażeń graczy. Ty wcielasz się w rolę jego przyjaciela, który dołącza do gry, aby sprawdzić swoje siły i spędzić czas z Aidenem.

FinnalStair to nie tylko labirynt, to żyjący organizm. Ściany pulsują energią, ścieżki zmieniają się na twoich oczach, a pułapki zastawione przez Aidena wystawiają na próbę refleks i spryt. Każde wejście do labiryntu to zupełnie nowa przygoda, pełna niebezpieczeństw i nagród.

W trybie fabularnym wspinasz się po kolejnych poziomach FinnalStair, odkrywając tajemnice przeszłości Aidena i prawdę o cybernetycznym chaosie, który ogarnął świat. Każdy poziom to unikalne wyzwanie, wymagające opanowania nowych umiejętności i współpracy z Aidenem.

W trybie swobodnym FinnalStair staje się miejscem spotkań graczy z całego świata. Możesz zmierzyć się z nimi w emocjonujących wyścigach, współpracować, aby pokonać trudne wyzwania, lub po prostu spędzić czas na rozmowach i zabawie w ciągle zmieniającym się labiryncie.

Czy uda ci się zdobyć szczyt FinnalStair i odkryć wszystkie jego tajemnice? Czy sprostasz wyzwaniom, jakie stawia przed tobą Aiden? Zanurz się w cybernetyczny chaos i przekonaj się sam!

Dodatkowe pytania, które pomogą rozwinąć fabułę:

Jaka jest historia Aidena? Co skłoniło go do stworzenia FinnalStair?
Jakie są motywacje graczy, którzy dołączają do gry?
Jakie zagrożenia czyhają na graczy w FinnalStair?
Jakie nagrody czekają na tych, którzy zdobędą szczyt labiryntu?
Jaki wpływ na świat gry ma cybernetyczny chaos?
Czy w FinnalStair istnieją frakcje lub gildie graczy?
Jakie są relacje między Aidenem a graczami?
Im więcej szczegółów poznamy, tym bogatszy i bardziej wciągający będzie świat FinnalStair.
Wyobraź sobie świat pogrążony w cybernetycznym chaosie, 
gdzie rzeczywistość łączy się z wirtualną przestrzenią. 
W sercu tej cyfrowej burzy znajduje się 'FinnalStair' – 
zmieniający się labirynt, będący jedynym schronieniem przed chaosem sieci 
neuronowych. W tej dynamicznej grze, gracze muszą nieustannie mierzyć 
się z żywymi ścianami, pulsującymi energią, a podłoga pod ich stopami 
zmienia się w czasie rzeczywistym, reagując na każde ich działanie. 
Ścieżki pojawiają się i znikają, tworząc skomplikowaną sieć wyzwań i
 pułapek. Wciel się w rolę przyjaciela Aidena – genialnego hakera, 
 który kontroluje te cyber-przestrzenie. Twoje zadanie to nie tylko 
 przetrwać, ale i zdobyć szczyt FinnalStair, gdzie czekają tajemnice 
 o przyszłości świata i chaotycznej naturze cyfrowego labiryntu. 
 Wizualnie gra łączy w sobie elementy neonowego cyberpunku, żywe 
 kolory i intensywnie kontrastujące cienie, gdzie każdy element 
 otoczenia ma głębokie powiązania z siecią neuronową, którą Aiden
  stara się kontrolować.
Opis kodu:

Import bibliotek: Importujemy Pygame, random i math.
Ustawienia gry: Definiujemy rozmiar okna, tytuł, kolory.
Klasy:
Player: Klasa gracza, obsługująca ruch i kolizje.
Tile: Klasa płytki, z losowym kolorem i energią.
Funkcje:
generate_maze: Generuje prosty labirynt.
Inicjalizacja: Tworzymy gracza, labirynt, grupy sprite'ów.
Główna pętla gry: Obsługuje zdarzenia, logikę, rysowanie i aktualizację ekranu.
Dalsze kroki:

Ulepszenie labiryntu: Stwórz bardziej zaawansowany algorytm generowania labiryntu.
Animacje: Dodaj animacje do płytek i gracza.
Interakcje: Wykrywaj kolizje i zaimplementuj interakcje z płytkami.
Dodaj fabułę: Wprowadź elementy fabularne związane z Aidenem.
Grafika i dźwięk: Dodaj grafikę i efekty dźwiękowe.
To jedynie podstawowy szkielet gry. Rozwijaj go, dodając nowe funkcje i mechaniki, aby stworzyć wciągającą grę FinnalStair!
    Versions history:
        1.0.0 - Initial release
        1.0.1 - Added fade-in/fade-out animation
        1.0.2 - Added progress bar
        1.0.3 - Added image scaling
        1.0.4 - Added code base date and version check script
        1.0.5 - Added autoupdate script
        1.0.6 - Added secure for code base 
            and ensure it is up-to-date and same at all version provided in this script while running 
                / Add other information here /
    :-------------------------------------------------------------:



				The code in the file Untitled-4 is a markdown document that describes the functionality of a script called "PreloadGameSetup" for a game called "MiastoX". It outlines the various components that should be included in the script, such as asset preloading, initial game settings, event binding, and grid and route generation.


--[[The code in the file Untitled-3 performs the following functionalities:

Preloading game assets: It loads models, textures, and other necessary resources before the game starts.
Setting up initial game settings: It configures the initial state of the game, including global variables and constants.
Binding preload events: It activates necessary events before the game starts, such as handling player connections.
Generating the city grid and routes: It creates a grid in the workspace and defines routes based on a given world scheme.
Overall, this script ensures that all required assets are loaded, initial game settings are configured, necessary events are bound, and the game environment is properly generated.



Skrypt `preloadgamesetup` dla MiastoX odpowiedzialny jest za:

Wczytywanie zasobów:
Przed rozpoczęciem gry wczytuje modele, tekstury i inne niezbędne zasoby.

Ustawienia początkowe gry:
Konfiguruje początkowy stan gry, zmienne globalne i stałe.

Wiązanie zdarzeń:
Aktywuje niezbędne zdarzenia przed rozpoczęciem gry, np. obsługę połączeń gracza.

Generacja siatki i tras:
Tworzy siatkę w przestrzeni roboczej oraz definiuje trasy według schematu `city.gen`.

Skrypt ten zapewnia kompleksowe przygotowanie gry, aby wszystkie potrzebne zasoby były wczytane,
ustawienia początkowe skonfigurowane, niezbędne zdarzenia aktywowane, oraz środowisko gry odpowiednio wygenerowane.





local module = require(script.Parent.Settings)
local plrCash = Instance.new("Folder", game.ServerStorage)
local clones = Instance.new("Folder", game.ServerStorage)
local parts = Instance.new("Folder", workspace)
plrCash.Name = "PlayerCash"
parts.Name = "Parts"
clones.Name = "TycoonClones"

-- Create default team if AutoAssignTeams is false
if module.autoAssignTeams == false then
	local neutralTeam = Instance.new("Team", game:GetService("Teams"))
	neutralTeam.Name = module.neutralTeamName
	neutralTeam.AutoAssignable = true
end
-- Initiate all tycoons
for i,tycoon in ipairs(script.Parent.Tycoons:GetChildren()) do
	-- Clone tycoon for later, create team for tycoon
	tycoon:Clone().Parent = clones
	local team = Instance.new("Team", game:GetService("Teams"))
	team.TeamColor = tycoon.TycoonInfo.TeamColor.Value
	team.Name = tycoon.Name
	team.AutoAssignable = module.autoAssignTeams
	-- SpawnLocations and enable Main script
	if tycoon.Essentials:FindFirstChildWhichIsA("SpawnLocation") then
		tycoon.Essentials:FindFirstChildWhichIsA("SpawnLocation").TeamColor = tycoon.TycoonInfo.TeamColor.Value
		tycoon.Essentials:FindFirstChildWhichIsA("SpawnLocation").BrickColor = tycoon.TycoonInfo.TeamColor.Value
	end
	tycoon.Main.Enabled = true
end
-- Player joins the game
game.Players.PlayerAdded:Connect(function(plr)
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	local cash = Instance.new("IntValue", leaderstats)
	cash.Name = module.currencyName
	
	local numValue = Instance.new("NumberValue", plrCash)
	numValue.Name = plr.Name
	local objValue = Instance.new("ObjectValue", numValue)
	objValue.Name = "OwnsTycoon"
	
	if module.autoAssignTeams then
		plr.Team.AutoAssignable = false
		local tycoon = script.Parent.Tycoons:FindFirstChild(plr.Team.Name)
		if tycoon then
			for i, obj in ipairs(tycoon:GetDescendants()) do
				if obj.Name == "GateControl" and obj:IsA("Script") then
					obj.ClaimTycoon:Fire(plr)
				end
			end
		end
	end
	
	local function updateCash()
		cash.Value = numValue.Value
	end
	numValue:GetPropertyChangedSignal("Value"):Connect(updateCash)
	cash:GetPropertyChangedSignal("Value"):Connect(updateCash)
end)
-- Developer Products
game:GetService("MarketplaceService").ProcessReceipt = function(receiptInfo)
	-- Debug function for displaying any DevProduct errors that may occur
	local function devProductError(errorMsg)
		warn("DevProduct Error: "..errorMsg..". ProductId "..receiptInfo.ProductId)
	end
	-- Get player's tycoon and find the button they purchased
	local plr = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if plr then
		local tycoon = game.ServerStorage:WaitForChild("PlayerCash"):FindFirstChild(plr.Name).OwnsTycoon.Value
		if tycoon then
			for i, button in ipairs(tycoon.Buttons:GetChildren()) do
				if button:FindFirstChild("DevProductID") and button.DevProductID.Value == receiptInfo.ProductId then
					tycoon.Main.DevProductPurchased:Fire(receiptInfo.ProductId)
					break
				end
			end
		else devProductError("Tycoon not found")
		end
	else devProductError("Player not found")
	end
end




--[[
-- Wait for the child "__Disabled__" with a timeout
local model = script.Parent:WaitForChild("__Disabled__", 3)  -- Wait for up to 5 seconds

if model then
	-- Destroy the model after a certain delay (optional)
	wait(3)  -- Wait for 3 seconds before destroying the model
	model:Destroy()  -- Destroy the model
else
	warn("Timeout: '__Disabled__' not found within 5 seconds.")
end



					-- Define states
					local State = {
						Destroy = "Destroy",
						Clone = "Clone"
					}

					-- Set initial state
					local currentState = State.Destroy  -- Default state is Destroy

					-- Function to handle the main logic based on the current state
					local function mainLogic()
						if currentState == State.Destroy then
							-- Wait for the child "__Disabled__" with a timeout in a specific folder
							local mapFolder = game.Workspace:FindFirstChild("Map")
							if mapFolder then
								local model = mapFolder:FindFirstChild("__Disabled__")
								if model then
									model:Destroy()
								else
									warn("Model '__Disabled__' not found under 'Workspace.Map.__disabled__'.")
								end
							else
								warn("Folder '__disabled__' not found under 'Workspace.Map'.")
							end
						elseif currentState == State.Clone then
							-- Clone the model directly where the script is located
							local model = script.Parent.Parent:FindFirstChild("__Disabled__")
							if model then
								local clone = model:Clone()
								clone.Parent = game.Workspace.Map.Cloned  -- Adjust this to wherever you want to place the clone

--[[
			Optionally destroy the original model after a delay
			wait(3)  -- Wait for 3 seconds before destroying the original model
			model:Destroy()  -- Destroy the original model
		else

								warn("Model '__Disabled__' not found under parent.")
							end
						end
					end

					-- Call mainLogic initially
					mainLogic()

					-- Example: Change state to Clone after 5 seconds (you can change this logic based on your requirements)
					wait(5)
					currentState = State.Clone

					-- Re-run main logic with the new state
					mainLogic()














--[[



-- Wait for the child "__Disabled__" with a timeout
local model = script.Parent:WaitForChild("__Disabled__", 3)  -- Wait for up to 3 seconds

if model then
	-- Clone the model and position it in the game world
	local clone = model:Clone()
	clone.Parent = game.Workspace  -- Adjust this to wherever you want to place the clone

	-- Optionally destroy the original model after a delay
	wait(3)  -- Wait for 3 seconds before destroying the original model
	model:Destroy()  -- Destroy the original model
else
	warn("Timeout: '__Disabled__' not found within 3 seconds.")
end]





					-- Define states
					local State = {
						Destroy = "Destroy",
						Clone = "Clone"
					}

					-- Metadata table to store additional properties for cloned models
					local Metadata = {
						Creator = "YourScriptName",
						CreatedAt = os.date(),  -- Date and time when the model is cloned
						Version = "1.0",
						-- Add more metadata as needed
					}

					-- Set initial state
					local currentState = State.Clone  -- Default state is Clone

					-- Variable to track if the script has executed logic already
					local hasExecuted = false

					-- Counter for cloned models
					local cloneCount = 0

					-- Function to handle the main logic based on the current state
					local function mainLogic()
						-- Ensure mainLogic is only executed once
						if hasExecuted then
							return
						end
						hasExecuted = true

						if currentState == State.Destroy then
							-- Wait for the child "__Disabled__" with a timeout in a specific folder
							local mapFolder = game.Workspace:FindFirstChild("Map")
							if mapFolder then
								local model = mapFolder:FindFirstChild("__Disabled__")
								if model then
									model:Destroy()
								else
									warn("Model '__Disabled__' not found under 'Workspace.Map.__disabled__'.")
								end
							else
								warn("Folder 'Map' not found under 'Workspace'.")
							end
						elseif currentState == State.Clone then
							-- Clone the model directly where the script is located
							local parent = script.Parent.Parent  -- Assuming script is in a Component
							local model = parent:FindFirstChild("__NonEqual__")
							if model then
								local clone = model:Clone()

								-- Increment the clone count
								cloneCount = cloneCount + 1

								-- Name the clone with a prefix and number
								clone.Name = "Clone_" .. cloneCount

								-- Ensure the clone is parented correctly
								clone.Parent = game.Workspace.Map.Cloned  -- Adjust this to wherever you want to place the clone

								-- Add metadata to the cloned model
								local metadataFolder = Instance.new("Folder")
								metadataFolder.Name = "Metadata"
								metadataFolder.Parent = clone

								for key, value in pairs(Metadata) do
									local metadataValue = Instance.new("StringValue")
									metadataValue.Name = key
									metadataValue.Value = tostring(value)
									metadataValue.Parent = metadataFolder
								end

								-- Disable or remove script and other components from the clone
								local componentsToRemove = {"Script"}  -- Add other component names as needed

								for _, componentName in ipairs(componentsToRemove) do
									local component = clone:FindFirstChild(componentName)
									if component then
										component:Destroy()
									end
								end
							else
								warn("Model '__NonEqual__' not found under parent.")
							end
						end
					end

					-- Call mainLogic initially
					mainLogic()

					-- Example: Change state to Destroy after 5 seconds (you can change this logic based on your requirements)
					wait(5)
					currentState = State.Destroy

					-- Re-run main logic with the new state
					mainLogic()








--[[
-- Wait for the child "__Disabled__" with a timeout
local model = script.Parent:WaitForChild("__Disabled__", 3)  -- Wait for up to 5 seconds

if model then
	-- Destroy the model after a certain delay (optional)
	wait(3)  -- Wait for 3 seconds before destroying the model
	model:Destroy()  -- Destroy the model
else
	warn("Timeout: '__Disabled__' not found within 5 seconds.")
end



					-- Define states
					local State = {
						Destroy = "Destroy",
						Clone = "Clone"
					}

					-- Set initial state
					local currentState = State.Destroy  -- Default state is Destroy

					-- Function to handle the main logic based on the current state
					local function mainLogic()
						if currentState == State.Destroy then
							-- Wait for the child "__Disabled__" with a timeout in a specific folder
							local mapFolder = game.Workspace:FindFirstChild("Map")
							if mapFolder then
								local model = mapFolder:FindFirstChild("__Disabled__")
								if model then
									model:Destroy()
								else
									warn("Model '__Disabled__' not found under 'Workspace.Map.__disabled__'.")
								end
							else
								warn("Folder '__disabled__' not found under 'Workspace.Map'.")
							end
						elseif currentState == State.Clone then
							-- Clone the model directly where the script is located
							local model = script.Parent.Parent:FindFirstChild("__Disabled__")
							if model then
								local clone = model:Clone()
								clone.Parent = game.Workspace.Map.Cloned  -- Adjust this to wherever you want to place the clone

--[[
			Optionally destroy the original model after a delay
			wait(3)  -- Wait for 3 seconds before destroying the original model
			model:Destroy()  -- Destroy the original model
		else
								warn("Model '__Disabled__' not found under parent.")
							end
						end
					end

					-- Call mainLogic initially
					mainLogic()

					-- Example: Change state to Clone after 5 seconds (you can change this logic based on your requirements)
					wait(5)
					currentState = State.Clone

					-- Re-run main logic with the new state
					mainLogic()



























]]--
