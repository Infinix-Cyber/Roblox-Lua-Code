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
    -- РЕЖИМ С БЭКДОРОМ: Всё работает в штатном режиме (Server-Side RGB)
    sendNotification("Backdoor Found!", "Executing replication via " .. activeBackdoor.Name, 6)
    
    local serverCode = [[
        -- Отправка сообщения в глобальный чат
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "[SYSTEM]: Welcome back, TheLocalMazeV2. Loading Crazy Maze RGB module...", 
            "All"
        )
        
        -- Полноценная RGB подсветка для всего сервера
        local baseplate = workspace:FindFirstChild("Baseplate")
        if baseplate and baseplate:IsA("BasePart") then
            spawn(function()
                while task.wait(0.05) do
                    local hue = (tick() % 5) / 5
                    baseplate.Color = Color3.fromHSV(hue, 1, 1)
                    baseplate.Material = Enum.Material.Neon
                end
            end)
        end
    ]]
    
    pcall(function()
        activeBackdoor:FireServer(serverCode)
    end)

else
    -- РЕЖИМ БЕЗ БЭКДОРА: Текст меняется на "No Backdoor ;(", цвет становится статичным красным
    -- Вывод уведомления об ошибке Server-Side
    sendNotification(
        "No Backdoor ;(", 
        "Running in Client-Side mode. Visuals are restricted.", 
        6
    )
    
    -- Окрашивание Baseplate в красный цвет (только на вашем клиенте)
    local baseplate = workspace:FindFirstChild("Baseplate")
    if baseplate and baseplate:IsA("BasePart") then
        baseplate.Material = Enum.Material.Neon -- Неоновое свечение для яркости
        baseplate.Color = Color3.fromRGB(255, 0, 0) -- Чистый красный цвет (без RGB переливов)
    end
    
    -- Если у вас в игре есть UI-обводка (SelectionBox/Highlight), её тоже можно принудительно сделать красной
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") or obj:IsA("SelectionBox") then
            obj.Color3 = Color3.fromRGB(255, 0, 0)
            obj.FillColor = Color3.fromRGB(255, 0, 0)
            obj.OutlineColor = Color3.fromRGB(255, 0, 0)
        end
    end
end
