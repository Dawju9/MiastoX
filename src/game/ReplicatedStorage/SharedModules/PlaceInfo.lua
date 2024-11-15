
local PlaceInfo = {
	-- All of the following parameters are optional.
	Priority = 0, -- The default priority is 0. The higher the priority, the earlier the module will be loaded. Negative priorities are allowed and will always be loaded last.

	Initialize = true -- Determines if this modules :Init function will be called. If false, the module will not be initialized. Suitable for disabling modules.
} --print("Hello world!")

--= Initializers =--
function PlaceInfo:Init() -- This function will be called when the module is initialized. This is also optional.
	-- Do stuff here.

	-- shared/PlaceInfo.lua
	local PlaceInfo = {
		Id = game.PlaceId,
		Name = game.Name,
		Owner = game.CreatorId,
		NumberOfPlayers = #game.Players:GetPlayers()
	}
	
	
end
--= Return Module =--
return  PlaceInfo

