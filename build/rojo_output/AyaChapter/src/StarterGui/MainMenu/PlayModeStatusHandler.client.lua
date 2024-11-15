-- PlayModeStatusHandler
-- This script is designed to manage the play mode status and ensure that team chasing functionality is enabled only when play mode is on.

local mainMenu = script.Parent -- Accessing the MainMenu ScreenGui as the parent of this script.

-- Adding a custom property to the mainMenu to track the play mode status.
mainMenu:SetAttribute("isPlaymodeON", false)

-- Function to enable play mode
local function enablePlayMode()
    mainMenu:SetAttribute("isPlaymodeON", true)
	print("Play mode is now ON.")
	
    -- Here you can add any additional logic to start or enable features that should only be active in play mode.
end

-- Function to disable play mode
local function disablePlayMode()
    mainMenu:SetAttribute("isPlaymodeON", false)
    print("Play mode is now OFF.")
    -- Here you can add any additional logic to stop or disable features that should only be active in play mode.
end

-- Connecting the PlayButton's click event to toggle play mode
local playButton = mainMenu:FindFirstChild("PlayButton")
if playButton then
    playButton.MouseButton1Click:Connect(function()
        if mainMenu:GetAttribute("isPlaymodeON") then
			disablePlayMode()
			-- enbable GUI - mainMenu not needed 
        else
			enablePlayMode()
			-- disable GUI - mainMenu
			mainMenu.Enabled = false
			-- enable GUI - playModeGUI
			local playModeGUI = script.Parent.Parent.PlayModeGUI
			playModeGUI.Enabled = true
        end
    end)
else
    warn("PlayButton not found under MainMenu. Please ensure it exists to toggle play mode.")
end

-- Example of how to check the play mode status elsewhere in your game:
-- if mainMenu:GetAttribute("isPlaymodeON") then
--     print("Play mode is currently ON.")
-- else
--     print("Play mode is currently OFF.")
-- end