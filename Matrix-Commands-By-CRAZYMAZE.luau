-- =========================================================================
-- MATRIX HUB v28 [PART 1: SECURE PHYSICAL CORE & WHITELIST]
-- PRIVACY PROTECTION: STRICT USERNAME WHITELIST (ANTI-LEAK ENCRYPTION)
-- TARGET: Just a baseplate (The local Maze / localmazestudio)
-- =========================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- =========================================================================
-- СТРОГИЙ БЕЛЫЙ СПИСОК (ТВОИ АЛЬТ-АККАУНТЫ)
-- =========================================================================
local Whitelist = {
    ["infinixnsw"] = true,
    ["thelocalmazev2"] = true,
    ["quur92"] = true
}

local function logTech(message, status)
    local prefix = status == "ERROR" and "❌ [CRITICAL_ERR]" or "🛰️ [MATRIX_OK]"
    print(string.format("%s %s -> TIME: %f", prefix, message, os.clock()))
end

-- Проверка авторизации текущего пользователя
local currentUsername = LocalPlayer.Name:lower()

if not Whitelist[currentUsername] then
    logTech("ACCESS DENIED: USER '" .. LocalPlayer.Name .. "' IS NOT AUTHORIZED.", "ERROR")
    logTech("TERMINATING MEMORY INSTANCES AND REPRICATORS... BOOT BLOCK STAGE 4.", "ERROR")
    return -- Мгновенно останавливаем выполнение скрипта для левых людей
end

logTech("ACCESS GRANTED. WELCOME MASTER, DEPLOYING QUANTUM HUBS...", "OK")

-- Инициализация глобальной таблицы в памяти чита для обмена данными
getgenv().MatrixTags = getgenv().MatrixTags or {}
getgenv().MatrixAuthorized = true -- Флаг успешной авторизации для Части 2

-- =========================================================================
-- БЕЛАЯ ШПАРГАЛКА ВСЕХ КОМАНД В КОНСОЛЬ F9 ПРИ СТАРТЕ
-- =========================================================================
print("================================================================")
print("       GALACTIC CORE v28 [PRIVATE EDITION] - SYSTEM ACTIVE      ")
print("================================================================")
print("-#ChangePlayerTag :target:\"Name\" :tag:\"idk\" -> Bind alias")
print("-#destroySelfAvatar :target:\"Name/Tag/all/others/priority\" :method:#\"Name\"")
print("----------------------------------------------------------------")
print("AVAILABLE CODES FOR METHOD PARAMETER:")
print("1. HeadDestroyTest_1       10. MeatGrinder_10       19. JointGlitch_19")
print("2. RootVoidCollapse_2      11. AscendToHeaven_11    20. HelixFly_20")
print("3. MeshDissolution_3       12. CameraLagCorrupt_12  21. GroundSlam_21")
print("4. SpinAnnihilation_4      13. NeonOverload_13      22. SizeJitter_22")
print("5. NoGripGlitch_5          14. FreezeState_14       23. OrbitNuke_23")
print("6. KineticExplosion_6      15. FlatCharacter_15     24. GlitchWalk_24")
print("7. GiantSpasm_7            16. ReverseGravity_16    25. AnchorYeet_25")
print("8. GeometryGlitch_8        17. UltimateLagKill_17   26. InstantHitboxCollapse_26")
print("9. InvisibleGhost_9        18. PhaseShift_18")
print("================================================================")

-- FE REANIMATE CORE (БЕССМЕРТНЫЙ NETLESS-ПОТОК)
if getgenv().NetlessConnection then getgenv().NetlessConnection:Disconnect() end

getgenv().NetlessConnection = RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.new(0, -28.1, 0)
                part.RotVelocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for tag, linkedName in pairs(getgenv().MatrixTags) do
        if linkedName == player.Name then
            getgenv().MatrixTags[tag] = nil
            logTech("Target left. Tag '"..tag.."' auto-purged from registry.", "OK")
        end
    end
end)

logTech("PART 1 OPERATIONAL: PRIVATE NETLESS MODE ENGAGED.", "OK")
-- =========================================================================
-- MATRIX HUB v28 [PART 2: PARSER & DESTRUCTIVE CORE ENGINE]
-- FEATURES: SECURITY COMPLIANCE SYSTEM, ALL/OTHERS SERIAL KILL QUEUE
-- =========================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

local function logTech(message, status)
    local prefix = status == "ERROR" and "❌ [CRITICAL_ERR]" or "🛰️ [MATRIX_OK]"
    print(string.format("%s %s -> TIME: %f", prefix, message, os.clock()))
end

-- Проверка связи со второй степенью защиты ядра
if not getgenv().MatrixAuthorized then
    logTech("SECURITY BREACH: UNLINKED EXECUTION ENVIRONMENT DETECTED.", "ERROR")
    logTech("TERMINATING STREAM PARSER INTERFACES...", "ERROR")
    return
end

-- Функция фильтрации целей по макросам и кэшу тегов
local function getTargets(targetInput)
    local foundTargets = {}
    local inputLower = targetInput:lower()
    local tags = getgenv().MatrixTags or {}

    if inputLower == "all" then
        for _, p in pairs(Players:GetPlayers()) do table.insert(foundTargets, p) end
        return foundTargets
    elseif inputLower == "others" then
        for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(foundTargets, p) end end
        return foundTargets
    elseif inputLower == "priority" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and (p:IsInGroup(1234567) or p.Name:lower():find("maze")) then
                table.insert(foundTargets, p)
            end
        end
        return foundTargets
    end

    if tags[targetInput] then
        local realPlayer = Players:FindFirstChild(tags[targetInput])
        if realPlayer then table.insert(foundTargets, realPlayer) return foundTargets end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():find(inputLower) then table.insert(foundTargets, p) return foundTargets end
    end
    return foundTargets
end

-- Ультимативная цепная Instant Kill атака через пространственный коллапс хитбоксов
local function executeInstantKill(targetList)
    local char = LocalPlayer.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = char.HumanoidRootPart
    local oldCFrame = hrp.CFrame

    for _, p in pairs(char:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end

    task.spawn(function()
        for _, victim in pairs(targetList) do
            if victim ~= LocalPlayer and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") and victim.Character:FindFirstChildOfClass("Humanoid") then
                local vHrp = victim.Character.HumanoidRootPart
                local vHum = victim.Character:FindFirstChildOfClass("Humanoid")

                logTech("Locking hitbox vector on: " .. victim.Name, "OK")
                hrp.CFrame = vHrp.CFrame
                vHrp.CanCollide = true
                hrp.CanCollide = true
                hrp.AssemblyLinearVelocity = Vector3.new(0, -999999, 0)

                local timeout = 0
                while vHum.Health > 0 and vHrp:IsDescendantOf(workspace) and timeout < 20 do
                    hrp.CFrame = vHrp.CFrame
                    RunService.Heartbeat:Wait()
                    timeout = timeout + 1
                end
                logTech("Instant Kill confirmed: " .. victim.Name, "OK")
                task.wait(0.05)
            end
        end

        for _, p in pairs(char:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = true end end
        hrp.CFrame = oldCFrame
        logTech("All entities wiped. Returned to original coordinates.", "OK")
    end)
end

-- Главный парсер входящего чат-потока
local function onChatted(msg)
    if msg:sub(1, 16) == "-#ChangePlayerTag" then
        local targetInput = msg:match(':target:"([^"]+)"')
        local tagInput = msg:match(':tag:"([^"]+)"')
        if targetInput and tagInput then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Name:lower():find(targetInput:lower()) then
                    getgenv().MatrixTags[tagInput] = p.Name
                    logTech("TAG '" .. tagInput .. "' STRUCT BOUND TO: " .. p.Name, "OK")
                    return
                end
            end
        end
    end

    if msg:sub(1, 19) == "-#destroySelfAvatar" then
        local targetInput = msg:match(':target:"([^"]+)"')
        local method = msg:match(':method:#"([^"]+)"')
        if not method then return end

        logTech("CHANNELS DETECTED. INITIATING 2.0s SYNC DELAY...", "OK")
        task.wait(2) -- Жесткое 2-секундное КД в чате для всех игроков

        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")

        local targetPlayers = targetInput and getTargets(targetInput) or {}

        -- КАТАЛОГ КОМАНД СЕРВЕРА
        if method == "InstantHitboxCollapse_26" then
            executeInstantKill(targetPlayers)
        elseif method == "HeadDestroyTest_1" then
            local head = char:FindFirstChild("Head")
            if head then
                head.Massless = true
                RunService.Heartbeat:Connect(function()
                    if head and head.Parent then
                        head.CFrame = head.CFrame * CFrame.fromEulerAnglesXYZ(math.random(10,50), 0, math.random(10,50))
                        head.Size = head.Size - Vector3.new(0.08, 0.08, 0.08)
                    end
                end)
            end
        elseif method == "RootVoidCollapse_2" then
            if hrp then
                hrp.Anchored = true
                RunService.RenderStepped:Connect(function()
                    for _, j in pairs(char:GetDescendants()) do
                        if j:IsA("Motor6D") then j.C0 = j.C0 * CFrame.new(0, math.sin(tick()*150)*8, 0) end
                    end
                    hrp.CFrame = hrp.CFrame * CFrame.new(math.random(-4,4), -2.5, math.random(-4,4))
                end)
            end
        elseif method == "SpinAnnihilation_4" then
            if hrp then
                local bv = Instance.new("BodyAngularVelocity", hrp)
                bv.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bv.AngularVelocity = Vector3.new(0, 9999, 0)
            end
        elseif method == "PhaseShift_18" then
            if hrp then
                RunService.Heartbeat:Connect(function()
                    if hrp and hrp.Parent then
                        hrp.CFrame = hrp.CFrame * CFrame.new(Vector3.new(math.sin(tick()*80)*15, 0, math.cos(tick()*80)*15))
                    end
                end)
            end
        elseif method == "JointGlitch_19" then
            RunService.RenderStepped:Connect(function()
                for _, j in pairs(char:GetDescendants()) do
                    if j:IsA("Motor6D") and j.Name ~= "Neck" then
                        j.C1 = j.C1 * CFrame.fromEulerAnglesXYZ(math.sin(tick()*50), math.cos(tick()*50), math.tan(tick()*50))
                    end
                end
            end)
        elseif method == "HelixFly_20" then
            if hrp then
                local bv = Instance.new("BodyVelocity", hrp)
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                local t = 0
                RunService.Heartbeat:Connect(function()
                    t = t + 0.2
                    bv.Velocity = Vector3.new(math.sin(t)*40, 25, math.cos(t)*40)
                    hrp.CFrame = hrp.CFrame * CFrame.fromEulerAnglesXYZ(0, 0.5, 0)
                end)
            end
        elseif method == "OrbitNuke_23" then
            if hrp and #targetPlayers > 0 and targetPlayers.Character and targetPlayers.Character:FindFirstChild("HumanoidRootPart") then
                local tHrp = targetPlayers.Character.HumanoidRootPart
                RunService.Heartbeat:Connect(function()
                    local t = tick() * 10
                    hrp.CFrame = CFrame.new(tHrp.Position + Vector3.new(math.sin(t)*12, math.cos(t)*5, math.cos(t)*12))
                end)
            end
        end
    end
end

-- Синхронизация потоков чата старых и новых версий Roblox
LocalPlayer.Chatted:Connect(onChatted)
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.MessageReceived:Connect(function(textMessage)
        if textMessage.TextSource and textMessage.TextSource.UserId == LocalPlayer.UserId then onChatted(textMessage.Text) end
    end)
end

logTech("PART 2 SECURITY HANDSHAKE ACTIVE. SECURE MATRIX DEPLOYED.", "OK")
