local BigStarID = "134109413150675"   
local SmallStarID = "80132117907030"  

-- Уникальные ID сеток (Mesh) для точного распознавания звезд
local BigMeshAsset = "134109411943809" 
local SmallMeshAsset = "80132117180121" 

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
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

local bigHandle = nil
local smallHandle = nil

-- === БЕЗОПАСНЫЙ МЕТОД АВТО-ВЫДАЧИ ===
local serverRemote = ReplicatedStorage:WaitForChild("01_server", 5)

if serverRemote then
    local spawnArgs = {
        "cmd",
        "-gh " .. BigStarID .. "," .. SmallStarID
    }
    serverRemote:FireServer(unpack(spawnArgs))
end
-- =============================================

-- Функция подготовки звезды для орбиты
local function setupAccessory(accessory, isBig)
    local handle = accessory:WaitForChild("Handle", 5)
    if not handle then return end
    
    task.wait(0.1)
    
    -- Зачищаем велды, чтобы дать звездам летать
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
    else
        smallHandle = handle
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

    local currentBigPos = head.Position + Vector3.new(0, BigHeight, 0)
    
    -- 1. Движение Большой Звезды (Лежит на 90 градусов)
    if bigHandle and bigHandle:Parent() then
        local x = math.cos(angleBig) * BigRadius
        local z = math.sin(angleBig) * BigRadius
        currentBigPos = head.Position + Vector3.new(x, BigHeight + bigWave, z)
        
        -- math.rad(90) заваливает большую звезду набок
        bigHandle.CFrame = CFrame.new(currentBigPos) * CFrame.Angles(math.rad(90), angleBig, 0)
    else
        bigHandle = nil 
    end

    -- 2. Движение Маленькой Звезды (Стоит ровно на 180 градусов)
    if smallHandle and smallHandle:Parent() then
        local smallX = currentBigPos.X + (math.cos(angleSmall) * SmallRadius)
        local smallZ = currentBigPos.Z + (math.sin(angleSmall) * SmallRadius)
        local targetSmallPos = Vector3.new(smallX, currentBigPos.Y + smallWave, smallZ)
        
        -- math.rad(180) удерживает маленькую звезду в вертикальном положении при вращении
        smallHandle.CFrame = CFrame.new(targetSmallPos) * CFrame.Angles(math.rad(180), angleSmall, 0)
    else
        smallHandle = nil 
    end
end)

-- Сканирование и распознавание звезд
local function checkAccessoryInternal(child)
    if not child:IsA("Accessory") then return end
    
    if string.find(child.Name, BigStarID) then
        setupAccessory(child, true)
        return
    elseif string.find(child.Name, SmallStarID) then
        setupAccessory(child, false)
        return
    end
    
    local handle = child:FindFirstChild("Handle")
    if handle then
        local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle:FindFirstChildOfClass("MeshPart")
        if mesh then
            local meshId = tostring(mesh.MeshId)
            if string.find(meshId, BigMeshAsset) or string.find(meshId, BigStarID) then
                setupAccessory(child, true)
            elseif string.find(meshId, SmallMeshAsset) or string.find(meshId, SmallStarID) then
                setupAccessory(child, false)
            end
        end
    end
end

character.ChildAdded:Connect(checkAccessoryInternal)
