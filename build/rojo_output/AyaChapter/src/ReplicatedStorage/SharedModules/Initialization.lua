
local PreInitialization = {
	-- All of the following parameters are optional.
	Priority = 0, -- The default priority is 0. The higher the priority, the earlier the module will be loaded. Negative priorities are allowed and will always be loaded last.

	Initialize = true -- Determines if this modules :Init function will be called. If false, the module will not be initialized. Suitable for disabling modules.
} --print("Hello world!")

--= Initializers =--
function PreInitialization:Init() -- This function will be called when the module is initialized. This is also optional.
	-- Do stuff here.
	--[[
	
	local PlaceInfo = require(shared.PlaceInfo)
	local DisplayInfo = require(ClientLoader.DisplayInfo)
	local PlayerHandler = require(ServerLoader.PlayerHandler)

	-- Wywołanie funkcji na kliencie
	if game.Players.LocalPlayer then
		DisplayInfo.displayPlaceInfo(PlaceInfo)
	else
		print("Script should be run by a local player.")
	end

	-- Obsługa serwera (przykład dla `onPlayerAdded`)
	game.Players.PlayerAdded:Connect(PlayerHandler.onPlayerAdded)

	]]--
	
end
--= Return Module =--
return  PreInitialization

