local function sendNotification(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

-- 1. Двойная проверка безопасности
local targetPlaceId = 123974602339071 -- ID игры Just a baseplate
local currentPlaceId = game.PlaceId
local p = game:GetService("Players").LocalPlayer

if currentPlaceId ~= targetPlaceId then
    sendNotification("Execution Error", "Wrong game detected. Restricted to Just a baseplate.", 7)
    return 
end

if p.Name ~= "TheLocalMazeV2" then
    sendNotification("Access Denied", "Error: Username mismatch. Execution halted.", 6)
    return 
end

-- 2. Сканирование наличия Backdoor (Server-Side)
local activeBackdoor = nil

local function scanForBackdoor()
    local targets = {
        game:GetService("ReplicatedStorage"),
        game:GetService("JointsService"),
        game:GetService("LogService"),
        game:GetService("RobloxReplicatedStorage")
    }
    
    for _, location in ipairs(targets) do
        if location then
            for _, child in ipairs(location:GetDescendants()) do
                if child:IsA("RemoteEvent") and (
                    child.Name:find("Backdoor") or 
                    child.Name:find("vibe") or 
                    child.Name:find("HDAdmin") or 
                    child.Name:find("Server") or
                    #child.Name == 32
                ) then
                    activeBackdoor = child
                    return true
                end
            end
        end
    end
    return false
end

-- 3. Выполнение логики в зависимости от результатов сканирования
sendNotification("System Confirmation", "Welcome back, TheLocalMazeV2. Checking Server-Side...", 4)

local backdoorFound = scanForBackdoor()

if backdoorFound and activeBackdoor then
    -- РЕЖИМ С БЭКДОРОМ: Серверный код (FE - увидят ВСЕ игроки)
    sendNotification("Backdoor Found!", "Executing FE replication via " .. activeBackdoor.Name, 6)
    
    local serverCode = [[
        -- Отправка системного сообщения в чат для всех
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "[SYSTEM]: Welcome back, TheLocalMazeV2. Loading Crazy Maze RGB module...", 
            "All"
        )
        
        local baseplate = workspace:FindFirstChild("Baseplate")
        if baseplate and baseplate:IsA("BasePart") then
            -- Серверное RGB переливание плиты
            spawn(function()
                while task.wait(0.05) do
                    local hue = (tick() % 5) / 5
                    baseplate.Color = Color3.fromHSV(hue, 1, 1)
                    baseplate.Material = Enum.Material.Neon
                end
            end)
            
            -- СЕРВЕРНОЕ СОЗДАНИЕ ЧЁРНОЙ ПОДСВЕТКИ (FE)
            local oldHighlight = baseplate:FindFirstChild("Crazy Maze")
            if oldHighlight then oldHighlight:Destroy() end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "Crazy Maze"
            highlight.FillColor = Color3.fromRGB(0, 0, 0)
            highlight.FillTransparency = 0.4
            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            highlight.OutlineTransparency = 0
            highlight.Adornee = baseplate
            highlight.Parent = baseplate
            
            -- СЕРВЕРНОЕ СОЗДАНИЕ НАДПИСИ (FE)
            local oldGui = baseplate:FindFirstChild("DFACE_Text")
            if oldGui then oldGui:Destroy() end
            
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "DFACE_Text"
            billboardGui.Size = UDim2.new(0, 200, 0, 50)
            billboardGui.AlwaysOnTop = true
            billboardGui.ExtentsOffset = Vector3.new(0, 5, 0)
            billboardGui.Adornee = baseplate
            billboardGui.Parent = baseplate
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = "DFACE Highlight Test"
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextSize = 14
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.Parent = billboardGui
        end
        
        -- Серверное перекрашивание других обводок в игре для ВСЕХ
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("Highlight") or obj:IsA("SelectionBox")) and obj.Name ~= "Crazy Maze" then
                obj.Color3 = Color3.fromRGB(0, 0, 0)
                obj.FillColor = Color3.fromRGB(0, 0, 0)
                obj.OutlineColor = Color3.fromRGB(0, 0, 0)
            end
        end
    ]]
    
    pcall(function()
        activeBackdoor:FireServer(serverCode)
    end)
else
    -- РЕЖИМ БЕЗ БЭКДОРА: Локальный клиентский визуал (видите ТОЛЬКО ВЫ)
    sendNotification(
        "No Backdoor ;(", 
        "Running in Client-Side mode. Visuals are restricted.", 
        6
    )
    
    local baseplate = workspace:FindFirstChild("Baseplate")
    if baseplate and baseplate:IsA("BasePart") then
        baseplate.Material = Enum.Material.Neon 
        baseplate.Color = Color3.fromRGB(255, 0, 0)
        
        local oldHighlight = baseplate:FindFirstChild("Crazy Maze")
        if oldHighlight then oldHighlight:Destroy() end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "Crazy Maze"
        highlight.FillColor = Color3.fromRGB(0, 0, 0)
        highlight.FillTransparency = 0.4
        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
        highlight.OutlineTransparency = 0
        highlight.Adornee = baseplate
        highlight.Parent = baseplate
        
        local oldGui = baseplate:FindFirstChild("DFACE_Text")
        if oldGui then oldGui:Destroy() end
        
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "DFACE_Text"
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.AlwaysOnTop = true
        billboardGui.ExtentsOffset = Vector3.new(0, 5, 0)
        billboardGui.Adornee = baseplate
        billboardGui.Parent = baseplate
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "DFACE Highlight Test"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextStrokeTransparency = 0
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Parent = billboardGui
    end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("Highlight") or obj:IsA("SelectionBox")) and obj.Name ~= "Crazy Maze" then
            obj.Color3 = Color3.fromRGB(0, 0, 0)
            obj.FillColor = Color3.fromRGB(0, 0, 0)
            obj.OutlineColor = Color3.fromRGB(0, 0, 0)
        end
    end
end
