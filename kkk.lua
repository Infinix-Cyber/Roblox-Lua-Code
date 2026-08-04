local Players, TextChatService, Stats, Market = game:GetService("Players"), game:GetService("TextChatService"), game:GetService("Stats"), game:GetService("MarketplaceService")
local Player = Players.LocalPlayer
while not Player do task.wait(0.1) Player = Players.LocalPlayer end

-- НАСТРОЙКИ ДОСТУПА И СОФТА (Твой Ping Tool с новым акком)
local OwnerName = "TheLocalMaze"
local NewOwnerName = "TheLocalMazeV2"
local FriendName = "huy140513" 
local FriendId = 6184518776

local hasAccess = (Player.Name == OwnerName) or (Player.Name == NewOwnerName) or (Player.Name == FriendName) or (Player.UserId == FriendId)
local topbarGui, creditsLabel, isPanic, isBlocked = nil, nil, false, false
local places = {} 
local placeId, gName = game.PlaceId, "Unknown Game"
if places[placeId] then isBlocked = true end

pcall(function() local i = Market:GetProductInfo(placeId) if i and i.Name then gName = i.Name end end)

-- Кроссплатформенный метод отправки сообщений в чат
local function sendMsg(m) 
    if isPanic or not hasAccess then return end
    local replication = game:GetService("ReplicatedStorage")
    local chatEvents = replication:FindFirstChild("DefaultChatSystemChatEvents")
    local request = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
    
    if request then
        pcall(function() request:FireServer(m, "All") end)
    else
        pcall(function() 
            local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral") 
            if ch then ch:SendAsync(m) end 
        end)
    end 
end

-- АВТОМАТИЧЕСКАЯ ОТПРАВКА СООБЩЕНИЯ (REWORKED) ПРИ ЗАПУСКЕ
if hasAccess and not isBlocked then
    task.spawn(function()
        task.wait(0.5) -- Задержка, чтобы чат прогрузился
        sendMsg("Ping tool By Local Maze (Reworked by Crazy Maze)")
    end)
end

-- ВЫВОД В КОНСОЛЬ РАЗРАБОТЧИКА БЕЛЫМ ТЕКСТОМ (Обновлено: Co-Owner: Crazy Maze)
if hasAccess and not isBlocked then
    print([[ 
======================================================
  [Ping Tool v2] - REWORKED BY CRAZY MAZE
  Owner: Local Maze | Co-Owner: Crazy Maze
  Status: Successfully Loaded!
  
  Available Console Commands:
  -# ping       - Check your current latency
  -# fps        - Check your frames per second
  -# meshTool   - Clear current tool mesh
  -# meshBody   - Clear body meshes [head/legs/arms/torso/all]
  -# teto       - Deploy & Save Kasane Teto Plushies (01_server)
  -# miku       - Deploy & Save Hatsune Miku Plushies (01_server)
  -# OrbitTool  - Run Orbit Tool/Hat builder from rawscripts
======================================================
    ]])
end

local function randName()
    local c, s = "abcdefghijklmnopqrstuvwxyz0123456789", "_"
    for i = 1, Random.new():NextInteger(12, 16) do local r = Random.new():NextInteger(1, #c) s = s .. string.sub(c, r, r) end
    return s
end

local function panic()
    if isPanic then return end isPanic = true
    pcall(function() if topbarGui then topbarGui:Destroy() end end)
    task.defer(function() pcall(function() Player:Kick("Emergency dislocation activated.") end) end)
end

local function checkAdmin(p)
    if not p or p == Player or p.Name == FriendName or p.UserId == FriendId or p.Name == OwnerName or p.Name == NewOwnerName then return end
    pcall(function() if p:GetRankInGroup(game.CreatorId) >= 200 or p.IsCreator then panic() end end)
    pcall(function() for _, id in ipairs({1200769, 50, 16}) do if p:IsInGroup(id) then panic() break end end end)
end
local function drawWatermark()
    if isPanic or not hasAccess then return end
    if topbarGui and topbarGui.Parent and creditsLabel and creditsLabel.Parent then 
        pcall(function()
            local rx, ry = Random.new():NextNumber(-0.005, 0.005), Random.new():NextNumber(-0.005, 0.005)
            creditsLabel.Position = UDim2.new(1, -112, 0, 36) + UDim2.new(0, rx, 0, ry)
        end)
        return 
    end
    pcall(function()
        topbarGui = Instance.new("ScreenGui")
        topbarGui.Name, topbarGui.ResetOnSpawn, topbarGui.IgnoreGuiInset = randName(), false, true
        
        creditsLabel = Instance.new("TextLabel")
        creditsLabel.Name, creditsLabel.Size, creditsLabel.BackgroundTransparency = randName(), UDim2.new(0, 100, 0, 15), 1
        creditsLabel.Position = UDim2.new(1, -112, 0, 36)
        creditsLabel.Text, creditsLabel.TextSize, creditsLabel.Font = "by local maze", 10, Enum.Font.SourceSansBold
        creditsLabel.TextColor3, creditsLabel.TextTransparency = Color3.fromRGB(150, 150, 150), 0.4
        creditsLabel.TextXAlignment, creditsLabel.TextYAlignment = Enum.TextXAlignment.Right, Enum.TextYAlignment.Top
        creditsLabel.Parent = topbarGui
        
        local pGui = Player:WaitForChild("PlayerGui", 15) if pGui then topbarGui.Parent = pGui end
    end)
end

if hasAccess then
    task.spawn(function() for _, p in ipairs(Players:GetPlayers()) do checkAdmin(p) end Players.PlayerAdded:Connect(checkAdmin) end)
    task.spawn(function() while task.wait(0.5) do if isPanic then break end pcall(drawWatermark) end end)
end

local function getPing()
    local net = Stats:FindFirstChild("Network")
    local smp = net and net:FindFirstChild("ServerPingLastSample")
    local fbk = Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats:FindFirstChild("Ping")
    local v = 0
    if smp then v = math.round(smp:GetValue()) end
    if v == 0 and fbk then v = math.round(fbk:GetValue()) end
    return v
end

local function getFPS() local fps = 60 pcall(function() fps = math.round(1 / task.wait()) end) return fps end
local function isInsideTool(obj) return obj:FindFirstAncestorOfClass("Tool") ~= nil end
local function removeMeshFromBody(partType, targetPlayer)
    local char = targetPlayer.Character if not char then return end
    partType = string.lower(partType)
    local targets = {}
    if partType == "head" then targets = {"Head"}
    elseif partType == "legs" then targets = {"LeftLeg", "RightLeg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
    elseif partType == "arms" then targets = {"LeftArm", "RightArm", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand"}
    elseif partType == "torso" then targets = {"Torso", "UpperTorso", "LowerTorso"}
    elseif partType == "all" then
        for _, obj in ipairs(char:GetDescendants()) do
            if (obj:IsA("MeshPart") or obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh")) and not isInsideTool(obj) then pcall(function() obj:Destroy() end) end
        end
        return
    end
    for _, name in ipairs(targets) do
        local part = char:FindFirstChild(name)
        if part and not isInsideTool(part) then
            if part:IsA("MeshPart") then pcall(function() part.MeshId, part.Transparency = "", 1 end)
            else for _, child in ipairs(part:GetChildren()) do if child:IsA("SpecialMesh") or child:IsA("CharacterMesh") then pcall(function() child:Destroy() end) end end end
        end
    end
end

local function removeMeshFromCurrentTool(targetPlayer)
    local char = targetPlayer.Character if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool") if not tool then return false end
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") then pcall(function() obj:Destroy() end)
        elseif obj:IsA("MeshPart") then pcall(function() obj.MeshId, obj.Transparency = "", 1 end) end
    end
    return true
end

local cache = {}
local isCommandRunning = false

local function processCommand(text, sender)
    if cache[text] or isCommandRunning then return end
    
    if text == "-# ping" or text == "-# Ping" then
        isCommandRunning = true cache[text] = true
        sendMsg("Pong! (" .. tostring(getPing()) .. "ms)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
        
    elseif text == "-# fps" or text == "-# Fps" then
        isCommandRunning = true cache[text] = true
        sendMsg("Got it! (" .. tostring(getFPS()) .. " fps)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
        
    elseif string.sub(text, 1, 11) == "-# meshBody" or string.sub(text, 1, 11) == "-# meshbody" then
        isCommandRunning = true cache[text] = true
        local arg = string.sub(text, 1, 13) == "-# meshBody " and string.sub(text, 13) or string.sub(text, 13)
        if arg and arg ~= "" then 
            removeMeshFromBody(arg, sender) 
            sendMsg("Body mesh cleaner executed for: " .. tostring(arg))
        else 
            sendMsg("Usage: -# meshBody [head/legs/arms/torso/all]") 
        end
        task.delay(2, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
        
    elseif text == "-# meshTool" or text == "-# meshtool" then
        isCommandRunning = true cache[text] = true
        if removeMeshFromCurrentTool(sender) then 
            sendMsg("Tool mesh successfully cleared!")
        else
            sendMsg("Equip a tool first!")
        end
        task.delay(2, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false

    elseif text == "-# teto" or text == "-# Teto" then
        isCommandRunning = true cache[text] = true
        pcall(function()
            local serverEvent = game:GetService("ReplicatedStorage"):WaitForChild("01_server", 5)
            if serverEvent then
                serverEvent:FireServer("cmd", "-gh 99134410491628,99134410491628,99134410491628,99134410491628,99134410491628,99134410491628,99134410491628")
                task.delay(2, function() pcall(function() serverEvent:FireServer("cmd", "-sh") end) end)
            end
        end)
        sendMsg("Kasane Teto configuration deployed and saved.")
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false

    elseif text == "-# miku" or text == "-# Miku" then
        isCommandRunning = true cache[text] = true
        pcall(function()
            local serverEvent = game:GetService("ReplicatedStorage"):WaitForChild("01_server", 5)
            if serverEvent then
                serverEvent:FireServer("cmd", "-gh 14251147770,14251147770,14251147770,14251147770,14251147770,14251147770,14251147770")
                task.delay(2, function() pcall(function() serverEvent:FireServer("cmd", "-sh") end) end)
            end
        end)
        sendMsg("Hatsune Miku configuration deployed and saved.")
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false

    elseif text == "-# OrbitTool" or text == "-# orbittool" then
        isCommandRunning = true cache[text] = true
        task.spawn(function()
            pcall(function()
                loadstring(game:HttpGet("https://rawscripts.net"))()
            end)
        end)
        sendMsg("Orbit Tool script executed from rawscripts.")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
    end
end

if hasAccess then
    Player.Chatted:Connect(function(msg)
        processCommand(msg, Player)
    end)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.MessageReceived:Connect(function(textMessage)
            if textMessage.TextSource and textMessage.TextSource.UserId == Player.UserId then
                processCommand(textMessage.Text, Player)
            end
        end)
    end
end
