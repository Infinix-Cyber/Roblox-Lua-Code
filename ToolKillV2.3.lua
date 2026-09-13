local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local function gplr(str)
	local found = {}
	local s = str:lower()
	if s == "all" then
		for _, v in ipairs(Players:GetPlayers()) do table.insert(found, v) end
	elseif s == "others" then
		for _, v in ipairs(Players:GetPlayers()) do
			if v ~= LocalPlayer then table.insert(found, v) end
		end
	elseif s == "me" then
		for _, v in ipairs(Players:GetPlayers()) do
			if v == LocalPlayer then table.insert(found, v) end
		end
	else
		for _, v in ipairs(Players:GetPlayers()) do
			if v.Name:lower():sub(1, #str) == s then table.insert(found, v) end
		end
	end
	return found
end

local function findTool()
	for _, t in ipairs(LocalPlayer.Backpack:GetChildren()) do
		if t:IsA("Tool") then return t end
	end
	if LocalPlayer.Character then
		for _, t in ipairs(LocalPlayer.Character:GetChildren()) do
			if t:IsA("Tool") then return t end
		end
	end
	return nil
end

local function replicateKill(target)
	if not target or not target.Character then return false end
	local char = LocalPlayer.Character
	if not char or not char.PrimaryPart then return false end
	if not target.Character.PrimaryPart then return false end

	local tool = findTool()
	if not tool then
		tool = Instance.new("Tool")
		tool.Name = "ClickTarget"
		tool.RequiresHandle = false
		tool.Parent = LocalPlayer.Backpack
		task.wait(0.03)
		tool.Parent = char
	end

	local prev = char.PrimaryPart.CFrame
	char.Archivable = true
	local clone = char:Clone()
	local oldChar = char

	LocalPlayer.Character = clone
	task.wait(0.03)
	LocalPlayer.Character = oldChar

	local oldHum = oldChar:FindFirstChildOfClass("Humanoid")
	if oldHum then oldHum:Destroy() end
	local newHum = Instance.new("Humanoid")
	newHum.Parent = oldChar

	local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
	local targetHum = target.Character:FindFirstChildOfClass("Humanoid")
	if not targetRoot or not targetHum then return false end

	targetRoot.Anchored = true

	local arm = oldChar:FindFirstChild("Right Arm") or oldChar:FindFirstChild("RightHand")
	if arm then
		local gripCF = arm.CFrame * CFrame.new(0, -1, 0)
		tool.Grip = gripCF:ToObjectSpace(targetRoot.CFrame):Inverse()
	else
		tool.Grip = CFrame.new(0,0,0):ToObjectSpace(targetRoot.CFrame):Inverse()
	end

	tool.Parent = oldChar
	Workspace.CurrentCamera.CameraSubject = tool:FindFirstChild("Handle") or oldChar.PrimaryPart

	task.wait(0.12)
	targetRoot.Anchored = false
	task.wait(0.04)

	newHum.Health = 0
	newHum:TakeDamage(999999)
	newHum:ChangeState(Enum.HumanoidStateType.Dead)

	task.wait(0.1)
	targetRoot.CFrame = CFrame.new(0, -5000, 0)

	task.wait(0.15)
	LocalPlayer.Character = nil
	task.wait(0.15)
	LocalPlayer.Character = oldChar
	oldChar.PrimaryPart.CFrame = prev

	return true
end

local CGui = game:GetService("CoreGui")
if CGui:FindFirstChild("Dupe") then CGui.Dupe:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CGui)
ScreenGui.Name = "Dupe"

local ui = Instance.new("Frame")
local title = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local Username = Instance.new("TextBox")
local Kill = Instance.new("TextButton")
local ced = Instance.new("TextLabel")

ScreenGui.Parent = CGui
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
ced.Text = "Modded By Local Maze"
ced.TextColor3 = Color3.new(1, 1, 1)
ced.TextScaled = true
ced.TextSize = 14
ced.TextWrapped = true

task.wait(1)

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
	for i = 1, 6 do
		pcall(function() replicateKill(targets[1]) end)
		task.wait(0.2)
	end
end)

local script1 = Instance.new("LocalScript", Kill)
task.spawn(function()
	while task.wait() do
		script1.Parent.BackgroundColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do task.wait() script1.Parent.BackgroundColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do task.wait() script1.Parent.BackgroundColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do task.wait() script1.Parent.BackgroundColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do task.wait() script1.Parent.BackgroundColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do task.wait() script1.Parent.BackgroundColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do task.wait() script1.Parent.BackgroundColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)

local script2 = Instance.new("LocalScript", title)
task.spawn(function()
	while task.wait() do
		script2.Parent.TextColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do task.wait() script2.Parent.TextColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do task.wait() script2.Parent.TextColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do task.wait() script2.Parent.TextColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do task.wait() script2.Parent.TextColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do task.wait() script2.Parent.TextColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do task.wait() script2.Parent.TextColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)

local script3 = Instance.new("LocalScript", Frame)
task.spawn(function()
	while task.wait() do
		script3.Parent.BackgroundColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do task.wait() script3.Parent.BackgroundColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do task.wait() script3.Parent.BackgroundColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do task.wait() script3.Parent.BackgroundColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do task.wait() script3.Parent.BackgroundColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do task.wait() script3.Parent.BackgroundColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do task.wait() script3.Parent.BackgroundColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)

local script4 = Instance.new("LocalScript", ced)
task.spawn(function()
	while task.wait() do
		script4.Parent.TextColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do task.wait() script4.Parent.TextColor3 = Color3.new(255/255,i/255,0/255) end
		for i = 255,0,-10 do task.wait() script4.Parent.TextColor3 = Color3.new(i/255,255/255,0/255) end
		for i = 0,255,10 do task.wait() script4.Parent.TextColor3 = Color3.new(0/255,255/255,i/255) end
		for i = 255,0,-10 do task.wait() script4.Parent.TextColor3 = Color3.new(0/255,i/255,255/255) end
		for i = 0,255,10 do task.wait() script4.Parent.TextColor3 = Color3.new(i/255,0/255,255/255) end
		for i = 255,0,-10 do task.wait() script4.Parent.TextColor3 = Color3.new(255/255,0/255,i/255) end
	end
end)
