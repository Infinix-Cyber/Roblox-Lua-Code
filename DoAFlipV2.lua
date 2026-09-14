local player = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local lp = game:GetService("Players").LocalPlayer

local function gplr(String)
	local Found = {}
	local strl = String:lower()
	if strl == "all" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do table.insert(Found,v) end
	elseif strl == "others" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name ~= lp.Name then table.insert(Found,v) end
		end
	elseif strl == "me" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name == lp.Name then table.insert(Found,v) end
		end
	else
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name:lower():sub(1, #String) == String:lower() then table.insert(Found,v) end
		end
	end
	return Found
end

local CGui = game:GetService("CoreGui")
if CGui:FindFirstChild("Kill") then CGui.Kill:Destroy() end
if CGui:FindFirstChild("Dupe") then CGui.Dupe:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CGui)
ScreenGui.Name = "Dupe"

local ui = Instance.new("Frame")
local title = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local Username = Instance.new("TextBox")
local Kill = Instance.new("TextButton")
local ced = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ui.Name = "ui"
ui.Parent = ScreenGui
ui.Active = true
ui.BackgroundColor3 = Color3.new(0, 0, 0)
ui.BackgroundTransparency = 0
ui.BorderSizePixel = 3
ui.Position = UDim2.new(0.254972845, 0, 0.419703096, 0)
ui.Size = UDim2.new(0, 200, 0, 200)

title.Name = "title"
title.Parent = ui
title.BackgroundColor3 = Color3.new(68, 68, 68)
title.BackgroundTransparency = 1
title.BorderSizePixel = 2
title.Position = UDim2.new(0, 0, 0.0199999996, 0)
title.Size = UDim2.new(1, 0, 0, 50)
title.Font = Enum.Font.Sarpanch
title.Text = "Tool Dupe"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.TextSize = 14
title.TextWrapped = true

Frame.Parent = title
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.07, 0, 0.860000014, 0)
Frame.Size = UDim2.new(0.85, 0, 0, 6)

Username.Name = "F20 FR"
Username.Parent = ui
Username.BackgroundColor3 = Color3.new(1, 1, 1)
Username.BorderSizePixel = 0
Username.Position = UDim2.new(0.100000001, 0, 0.300000012, 0)
Username.Size = UDim2.new(0.800000012, 0, 0, 50)
Username.Font = Enum.Font.Sarpanch
Username.PlaceholderText = "Username"
Username.Text = "Username"
Username.TextColor3 = Color3.new(0, 0, 0)
Username.TextScaled = true
Username.TextSize = 14
Username.TextWrapped = true

Kill.Name = "Stick"
Kill.Parent = ui
Kill.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
Kill.BackgroundTransparency = 0
Kill.BorderSizePixel = 2
Kill.Position = UDim2.new(0.25, 0, 0.629999971, 0)
Kill.Size = UDim2.new(0.5, 0, 0, 45)
Kill.Font = Enum.Font.Sarpanch
Kill.Text = "Kill"
Kill.TextColor3 = Color3.new(0, 0, 0)
Kill.TextScaled = true
Kill.TextSize = 10
Kill.TextWrapped = true
ui.Draggable = true

ced.Name = "made"
ced.Parent = ui
ced.BackgroundColor3 = Color3.new(68, 68, 68)
ced.BackgroundTransparency = 1
ced.BorderSizePixel = 2
ced.Position = UDim2.new(0, 0, 0.769999981, 0)
ced.Size = UDim2.new(1, 0, 0, 50)
ced.Font = Enum.Font.Sarpanch
ced.Text = "✧"
ced.TextColor3 = Color3.new(1, 1, 1)
ced.TextScaled = true
ced.TextSize = 14
ced.TextWrapped = true

wait(1)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1.19, -70)
ScrollingFrame.Position = UDim2.new(0, 200, 0, 35)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.Parent = ui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function updatePlayerList()
	for _, child in pairs(ScrollingFrame:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local PlayerButton = Instance.new("TextButton")
			PlayerButton.Size = UDim2.new(1, 0, 0, 25)
			PlayerButton.Text = player.Name
			PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			PlayerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			PlayerButton.Font = Enum.Font.Sarpanch
			PlayerButton.TextSize = 12
			PlayerButton.Parent = ScrollingFrame
			PlayerButton.MouseButton1Click:Connect(function()
				Username.Text = player.Name
			end)
		end
	end
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

Kill.MouseButton1Click:Connect(function()
	local targets = gplr(Username.Text)
	if not targets[1] then return end
	local Target = targets[1]

	if not LocalPlayer.Character then return end
	if not LocalPlayer.Character.PrimaryPart then return end
	if not Target.Character then return end
	if not Target.Character.PrimaryPart then return end

	local Character = LocalPlayer.Character
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not Root then return end

	local Tool = Character:FindFirstChildOfClass("Tool")
	if not Tool then
		local bp = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:WaitForChild("Backpack", 5)
		if bp then Tool = bp:FindFirstChildOfClass("Tool") end
	end
	if not Tool then return end

	local savedCF = Root.CFrame
	local alive = true

	pcall(function()
		workspace.FallenPartsDestroyHeight = -9000000000
	end)

	Humanoid:Clone().Parent = Character
	Humanoid:Destroy()

	local Handle = Tool:FindFirstChild("Handle")
	if Handle then
		Handle.Massless = true
		Tool.Grip = CFrame.new(0, -5000, 0)
		Tool.Parent = Character
	end

	RunService.Stepped:Connect(function()
		if not alive then return end
		if Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and Handle and Handle.Parent then
			firetouchinterest(Handle, Target.Character.HumanoidRootPart, 0)
			firetouchinterest(Handle, Target.Character.HumanoidRootPart, 1)
		end
	end)

	Character.ChildRemoved:Connect(function(child)
		if child:IsA("Tool") and alive then
			alive = false
			if Root and Root.Parent then
				Root:ApplyImpulse(Vector3.new(0, -9000000000, 0))
			end
			child.Grip = CFrame.new(0, -10000, 0)
		end
	end)

	LocalPlayer.CharacterAdded:Wait()

	if LocalPlayer.Character then
		local newRoot = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 5)
		if newRoot then
			newRoot.CFrame = savedCF
		end
	end
end)

local script = Instance.new('LocalScript', Kill)
task.spawn(function()
	while wait() do
		script.Parent.BackgroundColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do wait() script.Parent.BackgroundColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do wait() script.Parent.BackgroundColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do wait() script.Parent.BackgroundColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do wait() script.Parent.BackgroundColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do wait() script.Parent.BackgroundColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do wait() script.Parent.BackgroundColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)

local script2 = Instance.new('LocalScript', title)
task.spawn(function()
	while wait() do
		script2.Parent.TextColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do wait() script2.Parent.TextColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do wait() script2.Parent.TextColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do wait() script2.Parent.TextColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do wait() script2.Parent.TextColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do wait() script2.Parent.TextColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do wait() script2.Parent.TextColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)

local script3 = Instance.new('LocalScript', Frame)
task.spawn(function()
	while wait() do
		script3.Parent.BackgroundColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do wait() script3.Parent.BackgroundColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do wait() script3.Parent.BackgroundColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do wait() script3.Parent.BackgroundColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do wait() script3.Parent.BackgroundColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do wait() script3.Parent.BackgroundColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do wait() script3.Parent.BackgroundColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)

local script4 = Instance.new('LocalScript', ced)
task.spawn(function()
	while wait() do
		script4.Parent.TextColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do wait() script4.Parent.TextColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do wait() script4.Parent.TextColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do wait() script4.Parent.TextColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do wait() script4.Parent.TextColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do wait() script4.Parent.TextColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do wait() script4.Parent.TextColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)
