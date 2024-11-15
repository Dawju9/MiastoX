--[[ Made by coolcapidog
Channel ->> https://www.youtube.com/c/coolcapidog
You can change the settings but you shouldn't change anything except settings.
]]
------------------------------------ Settings
local SettingsEnabled = true
local CreditsEnabled = true
local DayClockTime = 14
local NightClockTime = 18
------------------------------------ Settings

local Player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local Char = Player.Character
local Camera = game.Workspace.CurrentCamera
local MenuCam = game.Workspace:WaitForChild("MenuCam")
local Process = false

wait(game:IsLoaded())
MenuCam.Transparency = 1
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = MenuCam.CFrame
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Parent = game.Lighting

local Black = tweenService:Create(script.Parent:WaitForChild("Black") ,TweenInfo.new(2, 
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out),
	{Transparency = 0})
local UnBlack = tweenService:Create(script.Parent:WaitForChild("Black") ,TweenInfo.new(2, 
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out),
	{Transparency = 1})
local Blur = tweenService:Create(BlurEffect ,TweenInfo.new(2, 
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out),
	{Size = 20})
local UnBlur = tweenService:Create(BlurEffect ,TweenInfo.new(1, 
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out),
	{Size = 0})

if SettingsEnabled == false then
	script.Parent.SettingsButton.Visible = false
end
if CreditsEnabled == false then
	script.Parent.CreditsButton.Visible = false
else
	if script.Parent:WaitForChild("CreditsFrame"):WaitForChild("Frame"):FindFirstChild("TextLabel") then
		if script.Parent:WaitForChild("CreditsFrame"):WaitForChild("Frame"):WaitForChild("TextLabel").Text == "Scripter -" then
			script.Parent.CreditsFrame.Frame.TextLabel.Text = "Scripter - "..Player.Name
		end
	end
end
script.Parent:WaitForChild("GameMusic").Playing = true

script.Parent.SettingsButton.MouseButton1Click:Connect(function()
	if Process == true then return end
	Process = true
	if script.Parent.SettingsFrame.Position == UDim2.new(0.5, 0,-0.4, 0) then
		script.Parent.SettingsFrame:TweenPosition(UDim2.new(0.5, 0,0.5, 0), "Out", "Quad", 1)
		script.Parent.PlayButton:TweenPosition(UDim2.new(-0.3, 0,0.353, 0), "Out", "Quad", 0.5)
		script.Parent.SettingsButton:TweenPosition(UDim2.new(-0.3, 0,0.508, 0), "Out", "Quad", 0.5)
		script.Parent.CreditsButton:TweenPosition(UDim2.new(-0.3, 0,0.636, 0), "Out", "Quad", 0.5)
		Blur:Play()
	else
		script.Parent.SettingsFrame:TweenPosition(UDim2.new(0.5, 0,-0.4, 0), "Out", "Quad", 1)
		script.Parent.PlayButton:TweenPosition(UDim2.new(0.005, 0,0.353, 0), "Out", "Quad", 0.5)
		script.Parent.SettingsButton:TweenPosition(UDim2.new(0.005, 0,0.508, 0), "Out", "Quad", 0.5)
		script.Parent.CreditsButton:TweenPosition(UDim2.new(0.005, 0,0.636, 0), "Out", "Quad", 0.5)
		UnBlur:Play()
	end
	wait(2)
	Process = false
end)

script.Parent.CreditsButton.MouseButton1Click:Connect(function()
	if Process == true then return end
	Process = true
	if script.Parent.CreditsFrame.Position == UDim2.new(0.5, 0,-0.4, 0) then
		script.Parent.CreditsFrame:TweenPosition(UDim2.new(0.5, 0,0.5, 0), "Out", "Quad", 1)
		script.Parent.PlayButton:TweenPosition(UDim2.new(-0.3, 0,0.353, 0), "Out", "Quad", 0.5)
		script.Parent.SettingsButton:TweenPosition(UDim2.new(-0.3, 0,0.508, 0), "Out", "Quad", 0.5)
		script.Parent.CreditsButton:TweenPosition(UDim2.new(-0.3, 0,0.636, 0), "Out", "Quad", 0.5)
		Blur:Play()
	else
		script.Parent.CreditsFrame:TweenPosition(UDim2.new(0.5, 0,-0.4, 0), "Out", "Quad", 1)
		script.Parent.PlayButton:TweenPosition(UDim2.new(0.005, 0,0.353, 0), "Out", "Quad", 0.5)
		script.Parent.SettingsButton:TweenPosition(UDim2.new(0.005, 0,0.508, 0), "Out", "Quad", 0.5)
		script.Parent.CreditsButton:TweenPosition(UDim2.new(0.005, 0,0.636, 0), "Out", "Quad", 0.5)
		UnBlur:Play()
	end
	wait(2)
	Process = false
end)

script.Parent.CreditsFrame.ExitButton.MouseButton1Click:Connect(function()
	if Process == true then return end
	Process = true
	script.Parent.CreditsFrame:TweenPosition(UDim2.new(0.5, 0,-0.4, 0), "Out", "Quad", 1)
	script.Parent.PlayButton:TweenPosition(UDim2.new(0.005, 0,0.353, 0), "Out", "Quad", 0.5)
	script.Parent.SettingsButton:TweenPosition(UDim2.new(0.005, 0,0.508, 0), "Out", "Quad", 0.5)
	script.Parent.CreditsButton:TweenPosition(UDim2.new(0.005, 0,0.636, 0), "Out", "Quad", 0.5)
	UnBlur:Play()
	wait(2)
	Process = false
end)

script.Parent.SettingsFrame.ExitButton.MouseButton1Click:Connect(function()
	if Process == true then return end
	Process = true
	script.Parent.SettingsFrame:TweenPosition(UDim2.new(0.5, 0,-0.4, 0), "Out", "Quad", 1)
	script.Parent.PlayButton:TweenPosition(UDim2.new(0.005, 0,0.353, 0), "Out", "Quad", 0.5)
	script.Parent.SettingsButton:TweenPosition(UDim2.new(0.005, 0,0.508, 0), "Out", "Quad", 0.5)
	script.Parent.CreditsButton:TweenPosition(UDim2.new(0.005, 0,0.636, 0), "Out", "Quad", 0.5)
	UnBlur:Play()
	wait(2)
	Process = false
end)

if script.Parent.SettingsFrame.Frame:FindFirstChild("Shadows") then
	script.Parent.SettingsFrame.Frame.Shadows.MouseButton1Click:Connect(function()
		if script.Parent.SettingsFrame.Frame.Shadows.Text == "X" then
			script.Parent.SettingsFrame.Frame.Shadows.Text = ""
			game.Lighting.GlobalShadows = false
		else
			script.Parent.SettingsFrame.Frame.Shadows.Text = "X"
			game.Lighting.GlobalShadows = true
		end
	end)
end
if script.Parent.SettingsFrame.Frame:FindFirstChild("Time") then
	script.Parent.SettingsFrame.Frame.Time.MouseButton1Click:Connect(function()
		if script.Parent.SettingsFrame.Frame.Time.Text == "DAY" then
			script.Parent.SettingsFrame.Frame.Time.Text = "NIGHT"
			game.Lighting.ClockTime = NightClockTime
		else
			script.Parent.SettingsFrame.Frame.Time.Text = "DAY"
			game.Lighting.ClockTime = DayClockTime
		end
	end)
end
if script.Parent.SettingsFrame.Frame:FindFirstChild("Music") then
	script.Parent.SettingsFrame.Frame.Music.MouseButton1Click:Connect(function()
		if script.Parent.SettingsFrame.Frame.Music.Text == "X" then
			script.Parent.SettingsFrame.Frame.Music.Text = ""
			script.Parent.GameMusic.Playing = false
		else
			script.Parent.SettingsFrame.Frame.Music.Text = "X"
			script.Parent.GameMusic.Playing = true
		end
	end)
end
script.Parent.PlayButton.MouseButton1Click:Connect(function()
	if Process == true then return end
	Process = true
	Black:Play()
	wait(3)
	Camera.CameraType = Enum.CameraType.Custom
	script.Parent.PlayButton:Destroy()
	script.Parent.SettingsButton:Destroy()
	script.Parent.CreditsButton:Destroy()
	UnBlack:Play()
end)