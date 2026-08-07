local function sendNotification(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

-- 1. Двойная проверка безопасности: по PlaceId игры и по вашему никнейму
local targetPlaceId = 123974602339071 -- Официальный ID игры Just a baseplate
local currentPlaceId = game.PlaceId
local p = game:GetService("Players").LocalPlayer

if currentPlaceId ~= targetPlaceId then
    sendNotification(
        "Execution Error",
        "Wrong game detected. This script is restricted to Just a baseplate.",
        7
    )
    return -- Блокировка, если игра чужая
end

if p.Name == "TheLocalMazeV2" then
    sendNotification(
        "System Confirmation", 
        "Welcome back, TheLocalMazeV2. Loading Crazy Maze RGB module... Standby for replication.", 
        8
    )
else
    sendNotification(
        "Access Denied",
        "Error: Username mismatch. Execution halted.",
        6
    )
    return -- Блокировка, если ник чужой
end

-- Очистка старых эффектов перед перезапуском
local c = p.Character or p.CharacterAdded:Wait()
if c:FindFirstChild("CrazyMazeHighlight") then c.CrazyMazeHighlight:Destroy() end
if c:FindFirstChild("Head") and c.Head:FindFirstChild("CrazyMazeText") then c.Head.CrazyMazeText:Destroy() end

_G.ServerSideSuccess = false

-- 2. Главный серверный скрипт
local serverScript = [[
    local player = game:GetService("Players"):FindFirstChild("]]..p.Name..[[")
    if not player or not player.Character then return end
    local char = player.Character
    local head = char:WaitForChild("Head")

    local highlight = Instance.new("Highlight")
    highlight.Name = "CrazyMazeHighlight"
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.Adornee = char
    highlight.Parent = char

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CrazyMazeText"
    billboard.Size = UDim2.new(0, 250, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = head
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Crazy Maze"
    label.TextSize = 32
    label.Font = Enum.Font.LuckiestGuy
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.Parent = billboard

    _G.ServerSideSuccess = true

    local RunService = game:GetService("RunService")
    local speed = 0.4
    
    coroutine.wrap(function()
        while char and char:IsDescendantOf(workspace) do
            local hue = (tick() * speed) % 1
            local rgbColor = Color3.fromHSV(hue, 1, 1)
            
            highlight.OutlineColor = rgbColor
            label.TextColor3 = rgbColor
            
            RunService.Heartbeat:Wait()
        end
    end)()
]]

local success, err = pcall(function()
    local env = getfenv and getfenv() or _G
    if env then
        local t = loadstring(serverScript)
        if t then t() end
    end
end)

-- 3. Финальная проверка статуса Server-Side
task.wait(2.0)
local hasHighlight = c:FindFirstChild("CrazyMazeHighlight")

if hasHighlight and game:GetService("RunService"):IsClient() and not _G.ServerSideSuccess then
    local errorCode = string.format("[DebugLog] Code: 403 | Executor: Delta Mobile | Status: Client-Only | Game: JustABaseplate | Err: %s", tostring(err or "None"))
    warn(errorCode)
    
    sendNotification(
        "Script Warning", 
        "Script loaded on Client-Side. Server connection failed. Copy the console error log and send it to the developer to fix it.", 
        10
    )
else
    print("[DebugLog] Code: 200 | Status: Active | Replication: Success")
    
    sendNotification(
        "Execution Successful", 
        "Working good! enjoy script! The server-side module is active and visible to everyone.", 
        7
    )
end
