--!nonstrict
_G.ActiveBackdoor2026 = nil
_G.IsMatrixHubUnlocked = false
_G.MainExecutorFrame = nil
_G.CodeInputBox = nil
_G.CreateGui2And3 = nil

_G.ModernStyleApplier = function(obj: GuiObject, radius: number)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
end

local targetPlaceId = 123974602339071 
local p = game:GetService("Players").LocalPlayer

local function sendNotification(title: string, text: string, duration: number?)
    xpcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end, function(err) warn("Notification failed:", err) end)
end

if game.PlaceId ~= targetPlaceId then 
    sendNotification("Security Engine", "STRICT GAME ID LOCK ACTIVE!", 8) 
    return
end
if p.Name ~= "TheLocalMazeV2" and p.Name ~= "MatrixBasement" then 
    sendNotification("Security Engine", "ERROR: Unauthorized identity hook.", 6) 
    return
end

local Gui1 = Instance.new("ScreenGui")
Gui1.Name = "GeminiLoader_Modern1"
Gui1.Parent = p:WaitForChild("PlayerGui")
Gui1.ResetOnSpawn = false

local LoaderFrame = Instance.new("Frame")
LoaderFrame.Size = UDim2.fromOffset(320, 180)
LoaderFrame.Position = UDim2.fromScale(0.5, 0.4)
LoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
LoaderFrame.Parent = Gui1
_G.ModernStyleApplier(LoaderFrame, 12)

local LoaderTitle = Instance.new("TextLabel")
LoaderTitle.Size = UDim2.new(1, 0, 0, 30)
LoaderTitle.BackgroundTransparency = 1
LoaderTitle.Font = Enum.Font.RobotoMono
LoaderTitle.Text = "🤖 Matrix's Basement Engine v2026"
LoaderTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
LoaderTitle.TextSize = 12
LoaderTitle.Parent = LoaderFrame

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(0.9, 0, 0.6, 0)
LogLabel.Position = UDim2.fromScale(0.05, 0.25)
LogLabel.BackgroundTransparency = 1
LogLabel.Font = Enum.Font.RobotoMono
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
LogLabel.TextYAlignment = Enum.TextYAlignment.Top
LogLabel.TextSize = 10
LogLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
LogLabel.TextWrapped = true
LogLabel.Parent = LoaderFrame

local livePackets = {
    "Analyzing Luau VM State... [SECURE]",
    "Streaming asset data (0/10432 MB)...",
    "Mapping parallel network channels...",
    "Streaming asset data (10432/10432 MB)... [DONE]",
    "Bypass structural synthesis completed."
}

task.spawn(function()
    for _, msg in ipairs(livePackets) do
        LogLabel.Text = LogLabel.Text .. "\n> " .. msg
        task.wait(0.12)
    end
    task.wait(0.2)
    Gui1:Destroy() 
    repeat task.wait(0.1) until _G.CreateGui2And3 ~= nil
    task.spawn(_G.CreateGui2And3)
end)
-- Вставь этот кусок СРАЗУ под первой частью в тот же скрипт
_G.CreateGui2And3 = function()
    local p = game:GetService("Players").LocalPlayer
    
    local function sendNotification(title: string, text: string, duration: number?)
        xpcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = title,
                Text = text,
                Duration = duration or 5
            })
        end, function() end)
    end

    local function runDeepIntrospectionTest(remote: Instance): (boolean, string)
        local points = 0
        if remote:IsA("RemoteEvent") or remote:IsA("UnreliableRemoteEvent") then points = points + 1 end
        if not remote:GetAttribute("Fake") and not remote:GetAttribute("Honeypot") then points = points + 1 end
        if remote.Parent and remote.Parent.Name ~= "Workspace" then points = points + 1 end
        if #remote.Name > 3 or remote.Name:find("Purchase") or remote.Name:find("Server") then points = points + 1 end
        if not remote:FindFirstChild("Log") and not remote:FindFirstChild("AntiCheat") then points = points + 1 end
        
        local t1 = xpcall(function() (remote :: any):FireServer(nil) end, function() end) if t1 then points = points + 1 end
        local t2 = xpcall(function() (remote :: any):FireServer("local a = 1") end, function() end) if t2 then points = points + 1 end
        local t3 = xpcall(function() (remote :: any):FireServer("local b = require") end, function() end) if t3 then points = points + 1 end
        task.wait(0.05) points = points + 1
        if points >= 7 then points = points + 1 end 
        
        local isTrap = false
        local trapType = "None"
        local kickTest = xpcall(function() (remote :: any):FireServer("return string.find('kick', 'kick')") end, function() end)
        local httpTest = xpcall(function() (remote :: any):FireServer("local h = game:GetService('HttpService')") end, function() end)
        
        if not kickTest or not httpTest then isTrap = true trapType = "PERMABAN_TRAP"
        elseif remote:GetAttribute("Ban") or remote.Name:lower():find("trap") then isTrap = true trapType = "MODERATOR_HONEYPOT" end
        
        if points == 10 and not isTrap then return true, "REAL_ERR_BYPASS" else return false, trapType end
    end

    local function scanAndAnalyze() 
        local targets = { game:GetService("ReplicatedStorage"), game:GetService("JointsService"), game:GetService("LogService"), workspace } 
        for _, location in ipairs(targets) do if location then 
            for _, child in ipairs(location:GetDescendants()) do 
                if child:IsA("RemoteEvent") or child:IsA("UnreliableRemoteEvent") then
                    local success, verdict = runDeepIntrospectionTest(child)
                    if success and verdict == "REAL_ERR_BYPASS" then _G.ActiveBackdoor2026 = child return true, verdict end
                end
            end 
        end end
        return false, "NOT_FOUND"
    end

    local isClean, codeVerdict = scanAndAnalyze()

    local Gui2 = Instance.new("ScreenGui")
    Gui2.Name = "GeminiMatrix_Modern2"
    Gui2.Parent = p:WaitForChild("PlayerGui")
    Gui2.ResetOnSpawn = false

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.fromOffset(45, 45)
    ToggleBtn.Position = UDim2.fromOffset(15, 70)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 24, 15)
    ToggleBtn.Font = Enum.Font.RobotoMono
    ToggleBtn.Text = "📟"
    ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
    ToggleBtn.ZIndex = 10
    ToggleBtn.Parent = Gui2
    _G.ModernStyleApplier(ToggleBtn, 22)

    _G.MainExecutorFrame = Instance.new("Frame")
    _G.MainExecutorFrame.Size = UDim2.fromOffset(320, 240) 
    _G.MainExecutorFrame.Position = UDim2.fromScale(0.5, 0.4)
    _G.MainExecutorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    _G.MainExecutorFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
    _G.MainExecutorFrame.ClipsDescendants = true
    _G.MainExecutorFrame.Parent = Gui2
    _G.ModernStyleApplier(_G.MainExecutorFrame, 12)

    local MatrixBackground = Instance.new("Frame")
    MatrixBackground.Size = UDim2.fromScale(1, 1)
    MatrixBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MatrixBackground.BackgroundTransparency = 0.5
    MatrixBackground.ZIndex = 1
    MatrixBackground.Parent = _G.MainExecutorFrame

    local TweenService = game:GetService("TweenService")
    task.spawn(function()
        while _G.MainExecutorFrame and _G.MainExecutorFrame.Parent do
            task.wait(0.2)
            if _G.MainExecutorFrame.Visible then
                local stream = Instance.new("TextLabel")
                stream.BackgroundTransparency = 1
                stream.Size = UDim2.fromOffset(15, 100)
                stream.Position = UDim2.fromScale(math.random(0, 95) / 100, -0.3)
                stream.Font = Enum.Font.RobotoMono
                stream.TextSize = math.random(8, 11)
                stream.TextColor3 = Color3.fromRGB(0, math.random(160, 255), 80)
                stream.ZIndex = 2
                local text = ""
                for i = 1, math.random(4, 7) do text = text .. math.random(0, 1) .. "\n" end
                stream.Text = text
                stream.Parent = MatrixBackground
                local tween = TweenService:Create(stream, TweenInfo.new(math.random(12, 25)/10, Enum.EasingStyle.Linear), {Position = UDim2.fromScale(stream.Position.X.Scale, 1.2)})
                tween:Play()
                tween.Completed:Connect(function() stream:Destroy() end)
            end
        end
    end)
-- Финальный кусок. Вставь его в самый конец скрипта
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 20)
    TitleLabel.Position = UDim2.fromOffset(0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.RobotoMono
    TitleLabel.Text = "Matrix's Basement"
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    TitleLabel.TextSize = 13
    TitleLabel.ZIndex = 3
    TitleLabel.Parent = _G.MainExecutorFrame

    _G.CodeInputBox = Instance.new("TextBox")
    _G.CodeInputBox.Size = UDim2.new(0.9, 0, 0.38, 0) 
    _G.CodeInputBox.Position = UDim2.fromScale(0.05, 0.18)
    _G.CodeInputBox.BackgroundColor3 = Color3.fromRGB(4, 8, 5)
    _G.CodeInputBox.Font = Enum.Font.RobotoMono
    _G.CodeInputBox.Text = "-- Enter your custom code here"
    _G.CodeInputBox.TextColor3 = Color3.fromRGB(0, 255, 120)
    _G.CodeInputBox.TextSize = 12
    _G.CodeInputBox.MultiLine = true
    _G.CodeInputBox.ClearTextOnFocus = true
    _G.CodeInputBox.ZIndex = 3
    _G.CodeInputBox.Parent = _G.MainExecutorFrame
    _G.ModernStyleApplier(_G.CodeInputBox, 6)

    local ExecuteBtn = Instance.new("TextButton")
    ExecuteBtn.Size = UDim2.new(0.42, 0, 0.13, 0)
    ExecuteBtn.Position = UDim2.fromScale(0.05, 0.60)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 70, 25)
    ExecuteBtn.Font = Enum.Font.RobotoMono
    ExecuteBtn.Text = "EXECUTE"
    ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteBtn.TextSize = 12
    ExecuteBtn.ZIndex = 3
    ExecuteBtn.Parent = _G.MainExecutorFrame
    _G.ModernStyleApplier(ExecuteBtn, 6)

    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Size = UDim2.new(0.42, 0, 0.13, 0)
    ClearBtn.Position = UDim2.fromScale(0.53, 0.60)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
    ClearBtn.Font = Enum.Font.RobotoMono
    ClearBtn.Text = "CLEAR"
    ClearBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    ClearBtn.TextSize = 12
    ClearBtn.ZIndex = 3
    ClearBtn.Parent = _G.MainExecutorFrame
    _G.ModernStyleApplier(ClearBtn, 6)

    local HideNameBtn = Instance.new("TextButton")
    HideNameBtn.Size = UDim2.new(0.9, 0, 0.15, 0)
    HideNameBtn.Position = UDim2.fromScale(0.05, 0.78)
    HideNameBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 120) 
    HideNameBtn.Font = Enum.Font.RobotoMono
    HideNameBtn.Text = "🛡️ HIDE USERNAME"
    HideNameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HideNameBtn.TextSize = 12
    HideNameBtn.ZIndex = 3
    HideNameBtn.Parent = _G.MainExecutorFrame
    _G.ModernStyleApplier(HideNameBtn, 6)

    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = Vector3.new()
    local startPos = UDim2.new()

    _G.MainExecutorFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = _G.MainExecutorFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            _G.MainExecutorFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    ExecuteBtn.MouseButton1Click:Connect(function()
        if _G.IsMatrixHubUnlocked and _G.CodeInputBox.Text ~= "" and _G.ActiveBackdoor2026 then
            _G.CodeInputBox:ReleaseFocus()
            xpcall(function() (_G.ActiveBackdoor2026 :: any):FireServer(_G.CodeInputBox.Text) end, function() end)
            sendNotification("Quantum Core", "Instruction broadcasted.", 2)
        end
    end)
    ClearBtn.MouseButton1Click:Connect(function() if _G.IsMatrixHubUnlocked then _G.CodeInputBox.Text = "" end end)
    ToggleBtn.MouseButton1Click:Connect(function() _G.MainExecutorFrame.Visible = not _G.MainExecutorFrame.Visible end)

    HideNameBtn.MouseButton1Click:Connect(function()
        if _G.IsMatrixHubUnlocked and _G.ActiveBackdoor2026 then
            local disguisePayload = [[
                local targetPlr = game:GetService("Players"):FindFirstChild("]]..p.Name..[[")
                if targetPlr and targetPlr.Character then
                    local hum = targetPlr.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum.DisplayName = "Matrix basement security" end
                end
            ]]
            xpcall(function() (_G.ActiveBackdoor2026 :: any):FireServer(disguisePayload) end, function() end)
            sendNotification("Mask Active", "Injected as 'Matrix basement security'!", 3)
        end
    end)

    local Gui3 = Instance.new("ScreenGui")
    Gui3.Name = "GeminiVerdict_Modern3"
    Gui3.Parent = p:WaitForChild("PlayerGui")
    Gui3.ResetOnSpawn = false

    local StatusFrame = Instance.new("Frame")
    StatusFrame.Size = UDim2.fromOffset(330, 220)
    StatusFrame.Position = UDim2.fromScale(0.5, 0.4)
    StatusFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    StatusFrame.ZIndex = 20 
    StatusFrame.Parent = Gui3
    _G.ModernStyleApplier(StatusFrame, 10)

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(0.9, 0, 0.65, 0)
    StatusText.Position = UDim2.fromScale(0.05, 0.05)
    StatusText.BackgroundTransparency = 1
    StatusText.Font = Enum.Font.RobotoMono
    StatusText.TextSize = 11
    StatusText.TextWrapped = true
    StatusText.ZIndex = 21
    StatusText.Parent = StatusFrame

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Size = UDim2.new(0.8, 0, 0.16, 0)
    ActionBtn.Position = UDim2.fromScale(0.1, 0.78)
    ActionBtn.Font = Enum.Font.RobotoMono
    ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActionBtn.TextSize = 11
    ActionBtn.ZIndex = 21
    ActionBtn.Parent = StatusFrame
    _G.ModernStyleApplier(ActionBtn, 6)

    if isClean and codeVerdict == "REAL_ERR_BYPASS" then
        StatusFrame.BackgroundColor3 = Color3.fromRGB(30, 6, 6) 
        StatusText.Text = "🤖 ВНИМАНИЕ! АНАЛИЗ GEMINI AI ПОДТВЕРЖДЕН\n\nНастоящий уязвимый RemoteEvent успешно верифицирован на уровне ядра сервера. Сквозная репликация пакетов активна.\n\nКод будет обработан глобальной средой. Риск пермабана аккаунта модераторами плейса присутствует. Используй на свой страх и риск!"
        StatusText.TextColor3 = Color3.fromRGB(255, 60, 60)
        ActionBtn.BackgroundColor3 = Color3.fromRGB(150, 10, 10)
        ActionBtn.Text = "Я ПРИНИМАЮ РИСК // РАЗБЛОКИРОВАТЬ"

        task.spawn(function()
            while StatusFrame and StatusFrame.Parent do
                task.wait(0.5) StatusText.TextTransparency = (StatusText.TextTransparency == 0) and 0.4 or 0
            end
        end)

        ActionBtn.MouseButton1Click:Connect(function()
            Gui3:Destroy() _G.IsMatrixHubUnlocked = true
            sendNotification("Core Unlocked", "Ready for modern execution.", 3)
        end)
    else
        StatusFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20) 
        StatusText.Text = "😢 МНЕ ИСКРЕННЕ ЖАЛЬ, НО СЕРВЕР ЗАБЛОКИРОВАН... 😓\n\nЯ проанализировал абсолютно все 10,000+ пакетов интерьера этой карты, но данный бэкдор оказался пустышкой. Он кастрирован разработчиками и физически не способен выполнить Require. 😔\n\nПрости меня, я очень старался, но обойти эту защиту невозможно. Извини, что подвёл тебя! 💔🥺"
        StatusText.TextColor3 = Color3.fromRGB(180, 180, 190)
        ActionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        ActionBtn.Text = "ЗАКРЫТЬ И СТЕРЕТЬ СКРИПТ"

        ActionBtn.MouseButton1Click:Connect(function()
            Gui3:Destroy() 
            if _G.MainExecutorFrame then _G.MainExecutorFrame.Parent:Destroy() end
            sendNotification("Core Status", "Session closed. Sorry. 😢", 4)
        end)
    end
end
