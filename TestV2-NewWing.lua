local BigStarID = "134109413150675"   
local SmallStarID = "80132117907030"  
local WingsID = "14948065405"         

local BigMeshAsset = "134109411943809" 
local SmallMeshAsset = "80132117180121" 
local WingsMeshAsset = "14948065261"   

-- Настройки анимации звезд
local BigSpeed = 2          
local BigRadius = 3.0       
local BigHeight = 2.0       
local BigWaveSpeed = 3      
local BigWaveHeight = 0.4   

local SmallSpeed = 4        
local SmallRadius = 1.5     
local SmallWaveSpeed = 5    
local SmallWaveHeight = 0.3 

-- НАСТРОЙКИ РЕАЛИСТИЧНЫХ ВЗМАХОВ КРЫЛЬЕВ
local FlapSpeed = 1.8       -- Скорость взмаха (сделал чуть медленнее, для величественности)
local FlapAmplitude = 0.28  -- Глубина взмаха (крылья раскрываются широко)
local TwistAmplitude = 0.12 -- Реалистичный разворот перьев при взмахе
local WingsIdleSpeed = 1.2  -- Скорость "дыхания" всего тела вверх-вниз
local WingsIdleHeight = 0.15-- Высота покачивания крыльев

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")
local torso = character:WaitForChild("Torso") or character:WaitForChild("UpperTorso")

local bigHandle = nil
local smallHandle = nil
local wingsHandle = nil

-- === СКРЫТЫЙ МЕТОД АВТО-ВЫДАЧИ ===
local serverRemote = ReplicatedStorage:WaitForChild("01_server", 5)

if serverRemote then
    local spawnArgs = {
        "cmd",
        "-gh " .. BigStarID .. "," .. SmallStarID .. "," .. WingsID
    }
    serverRemote:FireServer(unpack(spawnArgs))
end
-- =============================================

local function setupAccessory(accessory, typeStr)
    local handle = accessory:WaitForChild("Handle", 5)
    if not handle then return end
    
    task.wait(0.1)
    
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
    
    if typeStr == "big" then bigHandle = handle
    elseif typeStr == "small" then smallHandle = handle
    elseif typeStr == "wings" then wingsHandle = handle end
end

local angleBig = 0
local angleSmall = 0
local timeElapsed = 0

local connection
connection = RunService.Heartbeat:Connect(function(dt)
    if not character or not character:Parent() or not head or not torso then
        connection:Disconnect()
        return
    end

    angleBig = angleBig + (BigSpeed * dt)
    angleSmall = angleSmall + (SmallSpeed * dt)
    timeElapsed = timeElapsed + dt

    -- Волны парения звезд
    local bigWave = math.sin(timeElapsed * BigWaveSpeed) * BigWaveHeight
    local smallWave = math.sin(timeElapsed * SmallWaveSpeed) * SmallWaveHeight
    
    -- Реалистичная физика крыльев (Двойная синусоида)
    local wingFlap = math.sin(timeElapsed * FlapSpeed) * FlapAmplitude
    local wingTwist = math.cos(timeElapsed * FlapSpeed) * TwistAmplitude -- Смещение фазы косинусом для наклона
    local wingBreath = math.sin(timeElapsed * WingsIdleSpeed) * WingsIdleHeight

    local currentBigPos = head.Position + Vector3.new(0, BigHeight, 0)
    
    -- 1. Большая звезда (Лежит 90°)
    if bigHandle and bigHandle:Parent() then
        local x = math.cos(angleBig) * BigRadius
        local z = math.sin(angleBig) * BigRadius
        currentBigPos = head.Position + Vector3.new(x, BigHeight + bigWave, z)
        bigHandle.CFrame = CFrame.new(currentBigPos) * CFrame.Angles(math.rad(90), angleBig, 0)
    else bigHandle = nil end

    -- 2. Маленькая звезда (Ровная 180°)
    if smallHandle and smallHandle:Parent() then
        local smallX = currentBigPos.X + (math.cos(angleSmall) * SmallRadius)
        local smallZ = currentBigPos.Z + (math.sin(angleSmall) * SmallRadius)
        local targetSmallPos = Vector3.new(smallX, currentBigPos.Y + smallWave, smallZ)
        smallHandle.CFrame = CFrame.new(targetSmallPos) * CFrame.Angles(math.rad(180), angleSmall, 0)
    else smallHandle = nil end

    -- 3. ЖИВЫЕ РЕАЛИСТИЧНЫЕ КРЫЛЬЯ (С поворотом осей при взмахе)
    if wingsHandle and wingsHandle:Parent() then
        -- Базовая позиция строго за спиной персонажа (смещено назад на 0.75 по оси Z)
        local baseWingsCFrame = torso.CFrame * CFrame.new(0, wingBreath - 0.2, 0.75)
        
        -- Применяем сложный анатомический поворот: взмах (ось Y) + крен крыла наружу/внутрь (ось Z)
        wingsHandle.CFrame = baseWingsCFrame * CFrame.Angles(wingTwist, wingFlap, wingTwist * 0.5)
    else wingsHandle = nil end
end)

local function checkAccessoryInternal(child)
    if not child:IsA("Accessory") then return end
    if string.find(child.Name, BigStarID) then setupAccessory(child, "big") return end
    if string.find(child.Name, SmallStarID) then setupAccessory(child, "small") return end
    if string.find(child.Name, WingsID) then setupAccessory(child, "wings") return end
    
    local handle = child:FindFirstChild("Handle")
    if handle then
        local mesh = handle:FindFirstChildOfClass("SpecialMesh") or handle:FindFirstChildOfClass("MeshPart")
        if mesh then
            local meshId = tostring(mesh.MeshId)
            if string.find(meshId, BigMeshAsset) then setupAccessory(child, "big")
            elseif string.find(meshId, SmallMeshAsset) then setupAccessory(child, "small")
            elseif string.find(meshId, WingsMeshAsset) or string.find(meshId, "14948065") then setupAccessory(child, "wings") end
        end
    end
end

character.ChildAdded:Connect(checkAccessoryInternal)
for _, child in ipairs(character:GetChildren()) do checkAccessoryInternal(child) end
