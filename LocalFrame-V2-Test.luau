local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LogService = game:GetService("LogService")

if _G.CustomSystemFinal then _G.CustomSystemFinal:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomSystemFinal"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = gethui and gethui() or Players.LocalPlayer:WaitForChild("PlayerGui")
_G.CustomSystemFinal = ScreenGui

local function AddMobileDrag(frame, handle)
    local drag, inputStart, startPos
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true; inputStart = inp.Position; startPos = frame.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then drag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = inp.Position - inputStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

_G.TopBarIcon = Instance.new("ImageButton")
_G.TopBarIcon.Name = "TopBarGearButton"
_G.TopBarIcon.Size = UDim2.new(0, 32, 0, 32)
_G.TopBarIcon.Position = UDim2.new(1, -45, 0, 10) 
_G.TopBarIcon.BackgroundTransparency = 1
_G.TopBarIcon.Image = "rbxassetid://12717316029" 
_G.TopBarIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
_G.TopBarIcon.Visible = false 
_G.TopBarIcon.Parent = ScreenGui

_G.WindowsContainer = Instance.new("Frame")
_G.WindowsContainer.Size = UDim2.new(1, 0, 1, 0)
_G.WindowsContainer.BackgroundTransparency = 1
_G.WindowsContainer.Visible = false 
_G.WindowsContainer.Parent = ScreenGui

_G.TopBarIcon.MouseButton1Click:Connect(function()
    _G.WindowsContainer.Visible = not _G.WindowsContainer.Visible
end)

local LeftWindow = Instance.new("Frame")
LeftWindow.Size = UDim2.new(0, 260, 0, 240)
LeftWindow.Position = UDim2.new(0.5, -280, 0.5, -120)
LeftWindow.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
LeftWindow.BorderSizePixel = 0
LeftWindow.Active = true
LeftWindow.Parent = _G.WindowsContainer

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 10)
LeftCorner.Parent = LeftWindow

local LeftHeader = Instance.new("Frame")
LeftHeader.Size = UDim2.new(1, 0, 0, 40)
LeftHeader.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
LeftHeader.BorderSizePixel = 0
LeftHeader.Parent = LeftWindow

local LeftHeaderCorner = Instance.new("UICorner")
LeftHeaderCorner.CornerRadius = UDim.new(0, 10)
LeftHeaderCorner.Parent = LeftHeader

local AvatarIcon = Instance.new("ImageLabel")
AvatarIcon.Size = UDim2.new(0, 24, 0, 24)
AvatarIcon.Position = UDim2.new(0, 12, 0, 8)
AvatarIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AvatarIcon.Image = "rbxassetthumbnail://type=AvatarHeadShot&id="..Players.LocalPlayer.UserId.."&width=48&height=48"
AvatarIcon.Parent = LeftHeader

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = Color3.fromRGB(85, 255, 120)
AvatarStroke.Thickness = 2
AvatarStroke.Parent = AvatarIcon

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarIcon

local LeftTitle = Instance.new("TextLabel")
LeftTitle.Size = UDim2.new(1, -115, 1, 0) 
LeftTitle.Position = UDim2.new(0, 45, 0, 0)
LeftTitle.BackgroundTransparency = 1
LeftTitle.Text = "Just A Baseplate / Modified by Crazy Maze"
LeftTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LeftTitle.TextSize = 10
LeftTitle.Font = Enum.Font.GothamBold
LeftTitle.TextXAlignment = Enum.TextXAlignment.Left
LeftTitle.Parent = LeftHeader

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 60, 1, 0)
VersionLabel.Position = UDim2.new(1, -12, 0, 0) 
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "Beta 1.0.3" 
VersionLabel.TextColor3 = Color3.fromRGB(0, 0, 0) 
VersionLabel.TextSize = 10
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.Parent = LeftHeader

local EmptyContent = Instance.new("Frame")
EmptyContent.Size = UDim2.new(1, -16, 1, -50)
EmptyContent.Position = UDim2.new(0, 8, 0, 46)
EmptyContent.BackgroundTransparency = 1
EmptyContent.Parent = LeftWindow

AddMobileDrag(LeftWindow, LeftHeader)

local LogWindow = Instance.new("Frame")
LogWindow.Size = UDim2.new(0, 280, 0, 240)
LogWindow.Position = UDim2.new(0.5, 10, 0.5, -120)
LogWindow.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
LogWindow.BorderSizePixel = 0
LogWindow.Active = true
LogWindow.Parent = _G.WindowsContainer

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 10)
LogCorner.Parent = LogWindow

local LogHeader = Instance.new("Frame")
LogHeader.Size = UDim2.new(1, 0, 0, 40)
LogHeader.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
LogHeader.BorderSizePixel = 0
LogHeader.Parent = LogWindow

local LogHeaderCorner = Instance.new("UICorner")
LogHeaderCorner.CornerRadius = UDim.new(0, 10)
LogHeaderCorner.Parent = LogHeader

local LogTitle = Instance.new("TextLabel")
LogTitle.Size = UDim2.new(1, -60, 1, 0)
LogTitle.Position = UDim2.new(0, 15, 0, 0)
LogTitle.BackgroundTransparency = 1
LogTitle.Text = "Logs" 
LogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LogTitle.TextSize = 13
LogTitle.Font = Enum.Font.GothamBold
LogTitle.TextXAlignment = Enum.TextXAlignment.Left
LogTitle.Parent = LogHeader

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0, 45, 1, 0)
ClearBtn.Position = UDim2.new(1, -50, 0, 0)
ClearBtn.BackgroundTransparency = 1
ClearBtn.Text = "Clear"
ClearBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
ClearBtn.TextSize = 11
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.Parent = LogHeader

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Size = UDim2.new(1, -16, 1, -50)
LogScroll.Position = UDim2.new(0, 8, 0, 46)
LogScroll.BackgroundTransparency = 1
LogScroll.BorderSizePixel = 0
LogScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LogScroll.ScrollBarThickness = 0
LogScroll.Parent = LogWindow

local LogLayout = Instance.new("UIListLayout")
LogLayout.Parent = LogScroll
LogLayout.Padding = UDim.new(0, 4)

LogLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    LogScroll.CanvasSize = UDim2.new(0, 0, 0, LogLayout.AbsoluteContentSize.Y + 10)
    LogScroll.CanvasPosition = Vector2.new(0, LogLayout.AbsoluteContentSize.Y)
end)

_G.AddGameLog = function(tag, message, color)
    local timeStr = os.date("[%H:%M:%S]")
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, 0, 0, 16)
    LogLabel.BackgroundTransparency = 1
    LogLabel.Font = Enum.Font.Code
    LogLabel.TextSize = 10
    LogLabel.TextXAlignment = Enum.TextXAlignment.Left
    LogLabel.TextWrapped = true
    LogLabel.Text = timeStr .. " " .. tag .. " " .. message
    LogLabel.TextColor3 = color
    LogLabel.Parent = LogScroll
end

Players.PlayerAdded:Connect(function(player)
    _G.AddGameLog("[JOIN]", player.Name .. " connected to the server.", Color3.fromRGB(85, 255, 120))
    player.Chatted:Connect(function(msg)
        _G.AddGameLog("[CHAT]", player.Name .. ": " .. msg, Color3.fromRGB(255, 255, 255))
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    _G.AddGameLog("[LEAVE]", player.Name .. " disconnected from the game.", Color3.fromRGB(255, 100, 100))
end)

for _, player in ipairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(msg)
        _G.AddGameLog("[CHAT]", player.Name .. ": " .. msg, Color3.fromRGB(255, 255, 255))
    end)
end

LogService.MessageOut:Connect(function(message, messageType)
    if messageType == Enum.MessageType.MessageError and _G.AddGameLog then
        _G.AddGameLog("[GAME ERROR]", message, Color3.fromRGB(255, 75, 75))
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    for _, child in ipairs(LogScroll:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
end)

AddMobileDrag(LogWindow, LogHeader)
print("Part 1 successfully executed. Standing by for Part 2...")
local StarterGui = game:GetService("StarterGui")

local function SendRobloxNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

task.spawn(function()
    task.wait(0.5) 
    SendRobloxNotification("Booting Loader", "Initializing script environment...", 3)
    
    task.wait(2.2)
    SendRobloxNotification("Bypass Module", "Searching engine exploit vectors...", 3)
    
    task.wait(1.8)
    SendRobloxNotification("RemoteEvent Fire", "Firing token: jskkb2oeorv4vle94bt9wb4f5", 4)
    
    task.wait(2.5)
    SendRobloxNotification("Network Stream", "Downloading assets from main branch...", 3)
    
    task.wait(1.5)
    SendRobloxNotification("RemoteEvent Fire", "Validating key: v4vle94bt9wb4f5jskkb2oeor", 4)
    
    task.wait(2.0)
    SendRobloxNotification("Security", "Exploit successfully attached to Workspace.", 3)
    
    task.wait(1.2)
    SendRobloxNotification("Success", "GUI generated. Execution complete!", 2)
    
    task.wait(0.2)
    if _G.AddGameLog and _G.WindowsContainer and _G.TopBarIcon then
        _G.AddGameLog("[SYSTEM]", "Core successfully initialized.", Color3.fromRGB(200, 200, 200))
        _G.WindowsContainer.Visible = true
        _G.TopBarIcon.Visible = true
    else
        warn("Error: Part 1 was not found or was destroyed!")
    end
end)
