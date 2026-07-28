local BigStarID = "134109413150675"   
local SmallStarID = "80132117907030"  

-- Настройки анимации парения
local BigSpeed = 2          
local BigRadius = 3.0       
local BigHeight = 2.0       
local BigWaveSpeed = 3      
local BigWaveHeight = 0.4   

local SmallSpeed = 4        
local SmallRadius = 1.5     
local SmallWaveSpeed = 5    
local SmallWaveHeight = 0.3 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

local bigHandle = nil
local smallHandle = nil

-- Функция для отправки предупреждений на экран телефона
local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- Функция подготовки звезды после команды -gh
local function setupAccessory(accessory, isBig)
    local handle = accessory:WaitForChild("Handle", 5)
    if not handle then return end
    
    task.wait(0.1)
    
    -- Очищаем велды игры
    for _, v in ipairs(character:GetDescendants()) do
        if (v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("ManualWeld")) and (v.Part0 == handle or v.Part1 == handle) then
            v:Destroy()
        end
    end
    for _, v in ipairs(handle:GetChildren()) do
        if v:IsA("Weld") or v:IsA("ManualWeld") or v:IsA("WeldConstraint") then
            v:Destroy()
        end
    end

    handle.Anchored = false
    handle.CanCollide = false
    
    if isBig then
        bigHandle = handle
        sendNotification("Успешно!", "Большая звезда перешла под контроль орбиты ✨", 4)
    else
        smallHandle = handle
        sendNotification("Успешно!", "Маленькая звезда добавлена на орбиту 🌟", 4)
    end
end

-- Цикл плавной процедурной анимации
local angleBig = 0
local angleSmall = 0
local timeElapsed = 0

local connection
connection = RunService.Heartbeat:Connect(function(dt)
    if not character or not character:Parent() or not head then
        connection:Disconnect()
        return
    end

    angleBig = angleBig + (BigSpeed * dt)
    angleSmall = angleSmall + (SmallSpeed * dt)
    timeElapsed = timeElapsed + dt

    local bigWave = math.sin(timeElapsed * BigWaveSpeed) * BigWaveHeight
    local smallWave = math.sin(timeElapsed * SmallWaveSpeed) * SmallWaveHeight

    -- 1. Движение Большой Звезды
    local currentBigPos = head.Position + Vector3.new(0, BigHeight, 0)
    
    if bigHandle and bigHandle:Parent() then
        local x = math.cos(angleBig) * BigRadius
        local z = math.sin(angleBig) * BigRadius
        currentBigPos = head.Position + Vector3.new(x, BigHeight + bigWave, z)
        bigHandle.CFrame = CFrame.new(currentBigPos) * CFrame.Angles(math.rad(90), angleBig, 0)
    else
        bigHandle = nil 
    end

    -- 2. Движение Маленькой Звезды
    if smallHandle and smallHandle:Parent() then
        local smallX = currentBigPos.X + (math.cos(angleSmall) * SmallRadius)
        local smallZ = currentBigPos.Z + (math.sin(angleSmall) * SmallRadius)
        local targetSmallPos = Vector3.new(smallX, currentBigPos.Y + smallWave, smallZ)
        smallHandle.CFrame = CFrame.new(targetSmallPos) * CFrame.Angles(math.rad(90), angleSmall, 0)
    else
        smallHandle = nil 
    end
end)

-- Отслеживание спавна новых звезд через -gh
local function checkNewChild(child)
    if child:IsA("Accessory") then
        task.wait(0.1)
        if string.find(child.Name, BigStarID) or (child:GetAttribute("AssetId") == tonumber(BigStarID)) then
            setupAccessory(child, true)
        elseif string.find(child.Name, SmallStarID) or (child:GetAttribute("AssetId") == tonumber(SmallStarID)) then
            setupAccessory(child, false)
        end
    end
end

character.ChildAdded:Connect(checkNewChild)

-- Первичная проверка при запуске скрипта
local hasBig = false
local hasSmall = false

for _, child in ipairs(character:GetChildren()) do
    if child:IsA("Accessory") then
        if string.find(child.Name, BigStarID) then hasBig = true end
        if string.find(child.Name, SmallStarID) then hasSmall = true end
        checkNewChild(child)
    end
end

-- Если одной из звёзд (или обеих) нет на персонаже при старте скрипта, выводим предупреждение
if not hasBig or not hasSmall then
    task.wait(0.5) -- Небольшая задержка, чтобы интерфейс игры успел прогрузиться
    sendNotification(
        "Внимание! ⚠️", 
        "Вы не загружили hats! Пропишите в чат -gh с ID обеих звёзд.", 
        8
    )
end
