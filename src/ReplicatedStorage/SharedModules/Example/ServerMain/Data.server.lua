local module = require(script.Parent.Parent.Settings)
local plrCash = game.ServerStorage:WaitForChild("PlayerCash", 10000)
local dataStoreService = game:GetService("DataStoreService")
local store = dataStoreService:GetDataStore(module.dataStoreName)
local removedObjects = {}

function saveData(plr)
	-- Retrieve player's current tycoon
	local oldTycoon = plrCash[plr.Name].OwnsTycoon.Value
	if module.currencySaves then
		-- Save currency
		local succ, err = pcall(function()
			store:SetAsync(plr.UserId.."-cash", plrCash:WaitForChild(plr.Name).Value)
		end)
	end
	if module.tycoonSaves and oldTycoon then
		-- Save tycoon by adding object names to a table that
		-- can later be unpacked by the loading function
		local objects = plrCash[plr.Name].OwnsTycoon.Value.PurchasedObjects
		local data = {}
		for i,obj in ipairs(objects:GetChildren()) do
			table.insert(data, obj.Name)
		end
		for i,obj in ipairs(removedObjects[plr.Name]) do
			table.insert(data, obj)
		end
		local succ, err = pcall(function()
			-- Save object table to data store
			store:SetAsync(plr.UserId.."-tycoon", data)
		end)
	end
	-- Replace tycoon with a new one for another player
	if oldTycoon then
		local newTycoon = game.ServerStorage:WaitForChild("TycoonClones"):FindFirstChild(oldTycoon.Name):Clone()
		newTycoon.Parent = oldTycoon.Parent
		oldTycoon:Destroy()
		newTycoon.Main.Enabled = true
	end
	if plrCash:FindFirstChild(plr.Name) then
		plrCash[plr.Name]:Destroy()
	end
end

local function hideButton(button)
	button.Head.CanCollide = false
	button.Head.Transparency = 1
	if button:FindFirstChild("Button") then
		-- Button has extra components that need to be removed
		for i, part in ipairs(button.Button:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
				part.Transparency = 1
			end
		end
	end
	delay(0, function()
		if button.Head:FindFirstChild("ButtonOverhead") then
			-- If button has custom overhead text, remove it
			button.Head.ButtonOverhead.Enabled = false
		end
	end)
end
-- Load player data when a tycoon is claimed
script.Parent.TycoonClaimed.Event:Connect(function(tycoon)
	if module.tycoonSaves then
		-- Retrieve owner's tycoon data from DataStore
		local owner = tycoon.TycoonInfo.Owner.Value
		local tycoonData
		local success, err = pcall(function()
			tycoonData = store:GetAsync(owner.UserId.."-tycoon")
		end)
		if err then warn(err) end
		if tycoonData and success then
			-- Clone original tycoon and remove old one
			local clone = game.ServerStorage:WaitForChild("TycoonClones"):WaitForChild(tycoon.Name):Clone()
			clone.Parent = tycoon.Parent
			clone.TycoonInfo.Owner.Value = tycoon.TycoonInfo.Owner.Value
			plrCash:WaitForChild(clone.TycoonInfo.Owner.Value.Name).OwnsTycoon.Value = clone
			tycoon:Destroy()
			tycoon = clone
			
			local purchases = clone:FindFirstChild("Purchases")
			local purchased = clone:FindFirstChild("PurchasedObjects")
			local buttons = clone:FindFirstChild("Buttons")
			-- Hide all saved buttons
			for i,button in ipairs(buttons:GetChildren()) do
				if button:FindFirstChild("Object") then
					local obj = purchases:FindFirstChild(button.Object.Value)
					if obj and table.find(tycoonData, obj.Name) then
						obj.Parent = purchased
						hideButton(button)
					end
				elseif button:FindFirstChild("RemoveObject") then
					local obj = purchases:FindFirstChild(button.RemoveObject.Value)
					if obj and table.find(tycoonData, obj.Name) then
						table.insert(removedObjects[owner.Name], obj.Name)
						hideButton(button)
						obj:Destroy()
					end
				end
			end
			-- Enable tycoon's Main script and set up gate
			clone.Main.Enabled = true
			for i,v in ipairs(clone.Essentials.Entrance:GetChildren()) do
				v.Name = clone.TycoonInfo.Owner.Value.Name.."'s Tycoon"
				v.Head.Transparency = 0.7
			end
		end
	end
	-- Set player's SpawnLocation to the tycoon spawn pad if one exists
	local spawnPad = tycoon.Essentials:FindFirstChildWhichIsA("SpawnLocation")
	if spawnPad then
		tycoon.TycoonInfo.Owner.Value.RespawnLocation = spawnPad
	end
end)
script.ObjectRemoved.Event:Connect(function(plr, objName)
	-- Store removed objects in a table, as they can't be
	-- found later because they are destroyed
	table.insert(removedObjects[plr.Name], objName)
end)
game.Players.PlayerAdded:Connect(function(plr)
	removedObjects[plr.Name] = {}
	if module.currencySaves then
		-- Retrieve and set player cash on join
		local cashData
		local succ, err = pcall(function()
			cashData = store:GetAsync(plr.UserId.."-cash")
		end)
		if err then warn(err) end
		if cashData then
			plrCash:WaitForChild(plr.Name).Value = cashData
		end
	end
end)
game.Players.PlayerRemoving:Connect(function(plr)
	-- Save player data when a player leaves the game
	saveData(plr)
end)
game:BindToClose(function()
	-- Sometimes data is lost if the server closes before the saving
	-- can take place, this function will save data for all players
	-- before closing the server to ensure no data is lost.
	for i,plr in ipairs(game.Players:GetPlayers()) do
		saveData(plr)
	end
end)