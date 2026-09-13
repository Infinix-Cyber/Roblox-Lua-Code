local player = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local lp = game:GetService("Players").LocalPlayer

local function gplr(String)
	local Found = {}
	local strl = String:lower()
	if strl == "all" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			table.insert(Found,v)
		end
	elseif strl == "others" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name ~= lp.Name then
				table.insert(Found,v)
			end
		end
	elseif strl == "me" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name == lp.Name then
				table.insert(Found,v)
			end
		end
	else
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name:lower():sub(1, #String) == String:lower() then
				table.insert(Found,v)
			end
		end
	end
	return Found
end

local function getNearestSpawn()
	local myChar = LocalPlayer.Character
	if not myChar or not myChar.PrimaryPart then return nil end
	local myPos = myChar.PrimaryPart.Position
	local nearest = nil
	local nearestDist = math.huge
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("SpawnLocation") then
			local dist = (obj.Position - myPos).Magnitude
			if dist < nearestDist then
				nearestDist = dist
				nearest = obj
			end
		end
	end
	return nearest
end

local function rescueMe()
	task.spawn(function()
		task.wait(0.5)
		local myChar = LocalPlayer.Character
		if not myChar or not myChar.PrimaryPart then return end
		local myPos = myChar.PrimaryPart.Position
		if myPos.Y < -100 or myPos.Magnitude > 100000 then
			local spawn = getNearestSpawn()
			if spawn then
				pcall(function()
					myChar:PivotTo(CFrame.new(spawn.Position + Vector3.new(0, 5, 0)))
				end)
			end
			local root = myChar:FindFirstChild("HumanoidRootPart")
			if root then
				root.Anchored = false
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
			end
			local hum = myChar:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health <= 0 then
				hum.Health = 100
			end
			local cam = workspace.CurrentCamera
			if cam then
				cam.CameraSubject = myChar:FindFirstChildOfClass("Humanoid") or myChar.PrimaryPart
			end
		end
	end)
end

local CGui = game:GetService("CoreGui")
if CGui:FindFirstChild("Kill") then CGui.Kill:Destroy() end
local DGui = game:GetService("CoreGui")
if DGui:FindFirstChild("Dupe") then DGui.Dupe:Destroy() end

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
ced.Text = "By blitz"
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
		if child:IsA("TextButton") then
			child:Destroy()
		end
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
	local Player = gplr(Username.Text)
	if Player[1] then
		Player = Player[1]
		LocalPlayer = game.Players.LocalPlayer
		game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("")

		if LocalPlayer.Character.PrimaryPart ~= nil and Player.Character and Player.Character.PrimaryPart ~= nil then
			local Character = LocalPlayer.Character
			local Victim = Player.Character
			local previous = Character.PrimaryPart.CFrame

			Character.Archivable = true
			local Clone = Character:Clone()
			LocalPlayer.Character = Clone
			wait(.1)
			LocalPlayer.Character = Character
			wait(.1)

			if LocalPlayer.Character and Victim and Victim.PrimaryPart ~= nil then
				local OldHumanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				if OldHumanoid then
					OldHumanoid.Name = "_Humanoid"
					local FakeHumanoid = OldHumanoid:Clone()
					FakeHumanoid.Parent = LocalPlayer.Character
					FakeHumanoid.Name = "Humanoid"
					wait(0.1)
					OldHumanoid:Destroy()
				end

				local animate = LocalPlayer.Character:FindFirstChild("Animate")
				if animate then animate.Disabled = true end

				workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
				local newHum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				if newHum then newHum.DisplayDistanceType = "None" end

				local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if not Tool and LocalPlayer.Backpack then
					Tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
				end

				if Tool ~= nil then
					Tool.Parent = LocalPlayer.Backpack
					Victim.HumanoidRootPart.Anchored = true

					local Arm = LocalPlayer.Character['Right Arm'] or LocalPlayer.Character['RightHand']
					if Arm then
						local ArmCF = Arm.CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
						Tool.Grip = ArmCF:ToObjectSpace(Victim.PrimaryPart.CFrame):Inverse()
					end

					Tool.Parent = LocalPlayer.Character
					Workspace.CurrentCamera.CameraSubject = Tool:FindFirstChild("Handle") or LocalPlayer.Character.PrimaryPart

					local taken = false
					local timeout = 0
					repeat
						wait()
						timeout = timeout + 0.03
						if Tool and Tool.Parent == Victim then
							taken = true
							break
						end
					until not Tool or taken or timeout > 3

					Victim.HumanoidRootPart.Anchored = false
					wait(0.1)

					if taken and Victim and Victim.PrimaryPart then
						local targetHum = Victim:FindFirstChildOfClass("Humanoid")
						if targetHum and targetHum.Health > 0 then
							for i = 1, 5 do
								if Victim and Victim.PrimaryPart then
									Victim.HumanoidRootPart.CFrame = CFrame.new(0, -1000000, 0)
								end
								wait(0.2)
							end
							pcall(function()
								targetHum.Health = 0
								targetHum:ChangeState(Enum.HumanoidStateType.Dead)
							end)
						end
					end

					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						LocalPlayer.Character.HumanoidRootPart.Anchored = false
					end

					if LocalPlayer.Character then
						local myHum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
						Workspace.CurrentCamera.CameraSubject = myHum or LocalPlayer.Character.PrimaryPart
					end

					local FinalHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
					if FinalHum then
						FinalHum.Health = 0
					end

					LocalPlayer.Character = nil
					wait(.35)

					rescueMe()
				end
			end
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
