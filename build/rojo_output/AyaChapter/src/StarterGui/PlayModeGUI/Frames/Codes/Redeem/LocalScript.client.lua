script.Parent.MouseButton1Down:Connect(function()
	game:GetService("ReplicatedStorage").Remotes.RedeemCode:FireServer(script.Parent.Parent.CodesBox.Text)
	wait(1)
end)