-- =========================================================================
-- MATRIX HUB v28 [PART 1: SECURE PHYSICAL CORE & WHITELIST] - KDL ANTIDOTE
-- PRIVACY PROTECTION: STRICT USERNAME WHITELIST (ANTI-LEAK ENCRYPTION)
-- TARGET: Just a baseplate (The local Maze / localmazestudio)
-- =========================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- СТРОГИЙ БЕЛЫЙ СПИСОК (ТВОИ АЛЬТ-АККАУНТЫ)
local Whitelist = {
    ["infinixnsw"] = true,
    ["thelocalmazev2"] = true,
    ["quur92"] = true
}

local function logTech(message, status)
    local prefix = status == "ERROR" and "❌ [KDL_ERR]" or "🧪 [KDL_ANTIDOTE_OK]"
    print(string.format("%s %s -> TIME: %f", prefix, message, os.clock()))
end

-- Проверка авторизации текущего пользователя
local currentUsername = LocalPlayer.Name:lower()

if not Whitelist[currentUsername] then
    logTech("ACCESS DENIED: USER '" .. LocalPlayer.Name .. "' IS NOT AUTHORIZED.", "ERROR")
    return -- Мгновенно останавливаем выполнение скрипта
end

logTech("ACCESS GRANTED. WELCOME MASTER, DEPLOYING MOLECULAR HUBS...", "OK")

-- Инициализация глобальной таблицы в памяти чита для обмена данными
getgenv().MatrixTags = getgenv().MatrixTags or {}
getgenv().MatrixAuthorized = true -- Флаг успешной авторизации для следующих частей
getgenv().NetlessActive = false -- По умолчанию Reanimate отключен до команды в чате

-- FE REANIMATE CORE (БЕССМЕРТНЫЙ NETLESS-ПОТОК)
if getgenv().NetlessConnection then getgenv().NetlessConnection:Disconnect() end

getgenv().NetlessConnection = RunService.Heartbeat:Connect(function()
    if getgenv().NetlessActive then -- Поток сработает только после ввода команды в чат
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Velocity = Vector3.new(0, -28.1, 0)
                    part.RotVelocity = Vector3.new(0, 0, 0)
                end
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

logTech("PART 1 OPERATIONAL: LAUNCH CONTROL MODE ENGAGED.", "OK")
-- =========================================================================
-- MATRIX HUB v28 [PART 2: TERMINAL INTRO SYSTEM] - KDL ANTIDOTE
-- FEATURES: ULTRA-FAST HEX DECRYPTION SIMULATOR (FULL VISUAL INFRASTRUCTURE)
-- =========================================================================

local CoreGui = game:GetService("CoreGui")
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "KdlLoadingMatrixScreen"
IntroGui.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
IntroGui.IgnoreGuiInset = true

-- Главный задний фон (Затемнение экрана)
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 5, 18) -- Глубокий фиолетовый
Background.BackgroundTransparency = 0.15
Background.Parent = IntroGui

-- Контейнер для бегущих пакетов (Слева)
local PacketFrame = Instance.new("Frame")
PacketFrame.Size = UDim2.new(0.4, 0, 0.8, 0)
PacketFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
PacketFrame.BackgroundTransparency = 1
PacketFrame.Parent = Background

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIList.Parent = PacketFrame

-- Окно прогресс-бара по центру
local CentralFrame = Instance.new("Frame")
CentralFrame.Size = UDim2.new(0, 450, 0, 120)
CentralFrame.Position = UDim2.new(0.5, -225, 0.5, -60)
CentralFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
CentralFrame.BorderSizePixel = 2
CentralFrame.BorderColor3 = Color3.fromRGB(170, 0, 255) -- Неоново-фиолетовая рамка
CentralFrame.Parent = Background

-- Заголовок загрузки
local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Text = "🧪 INJECTING KDL-ANTIDOTE MEMORY REPLICATOR..."
LoadTitle.TextColor3 = Color3.fromRGB(0, 255, 140) -- Токсичный зеленый
LoadTitle.BackgroundColor3 = Color3.fromRGB(28, 16, 42)
LoadTitle.Font = Enum.Font.Code
LoadTitle.TextSize = 14
LoadTitle.Parent = CentralFrame

-- Процент загрузки
local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, 0, 0, 30)
PercentLabel.Position = UDim2.new(0, 0, 0, 40)
PercentLabel.Text = "DECRYPTING PACKETS: 0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Font = Enum.Font.Code
PercentLabel.TextSize = 14
PercentLabel.Parent = CentralFrame

-- Задник ползунка (Пустой бар)
local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Size = UDim2.new(0, 390, 0, 15)
ProgressBarBackground.Position = UDim2.new(0.5, -195, 0, 80)
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
ProgressBarBackground.BorderSizePixel = 1
ProgressBarBackground.BorderColor3 = Color3.fromRGB(100, 50, 150)
ProgressBarBackground.Parent = CentralFrame

-- Сам ползунок (Заполняемый бар)
local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0) -- Начинаем с нуля
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 140) -- Наполняется неоново-зеленым
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBackground

-- Функция генерации случайного хакерского хэша пакетов
local function generateFakePacket()
    local chars = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEF"
    local packetType = {"NET_REPL_", "MEM_HEX_", "SYS_BYPASS_", "CORE_V28_", "DATA_STREAM_"}
    local str = "[" .. packetType[math.random(1, #packetType)]
    for i = 1, 12 do
        local rand = math.random(1, #chars)
        str = str .. chars:sub(rand, rand)
    end
    return str .. " -> OK]"
end

-- Асинхронный поток бешеного бега пакетов на экране (Слева)
task.spawn(function()
    while IntroGui and IntroGui.Parent do
        local PacketLog = Instance.new("TextLabel")
        PacketLog.Size = UDim2.new(1, 0, 0, 18)
        PacketLog.Text = generateFakePacket()
        PacketLog.TextColor3 = Color3.fromRGB(math.random(100,150), math.random(0,50), math.random(200,255)) -- Фиолетово-розовые коды
        if math.random(1, 5) == 1 then PacketLog.TextColor3 = Color3.fromRGB(0, 255, 140) end -- Редкие зеленые удачные пакеты
        PacketLog.BackgroundTransparency = 1
        PacketLog.Font = Enum.Font.Code
        PacketLog.TextSize = 12
        PacketLog.TextXAlignment = Enum.TextXAlignment.Left
        PacketLog.Parent = PacketFrame
        
        -- Удаляем старые строчки, чтобы экран не засорялся
        if #PacketFrame:GetChildren() > 25 then
            PacketFrame:GetChildren():Destroy()
        end
        task.wait(0.04) -- Скорость прокрутки пакетов в миллисекундах!
    end
end)

-- Плавное заполнение ползунка ровно за 10 секунд
for i = 0, 100 do
    ProgressBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
    PercentLabel.Text = "DECRYPTING PACKETS: " .. i .. "%"
    task.wait(0.1) -- 100 шагов по 0.1 секунды = 10 секунд
end

-- Финальный аккорд перед запуском (Пауза 2 секунды, пишется статус READY)
PercentLabel.Text = "🧬 MOLECULAR CORE STABILIZED. READY!"
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(200, 0, 255) -- Меняет цвет на фиолетовый при успехе
task.wait(2)

-- Сносим экран интро, загрузка официально завершена!
IntroGui:Destroy()
getgenv().KdlIntroComplete = true -- Сигнал для Части 3, что интро завершено успешно
-- =========================================================================
-- MATRIX HUB v28 [PART 3: MAIN SYSTEM BASE & PARSER CHANNELS]
-- FEATURES: TEXT STREAM RECEPTION, USER VERIFICATION, CONSOLE F9 HELP SHEET
-- =========================================================================

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

local function logTech(message, status)
    local prefix = status == "ERROR" and "❌ [KDL_ERR]" or "🧪 [KDL_OK]"
    print(string.format("%s %s -> TIME: %f", prefix, message, os.clock()))
end

-- Ожидаем завершения анимации загрузки из Части 2
while not getgenv().KdlIntroComplete do task.wait(0.5) end

if not getgenv().MatrixAuthorized then
    logTech("SECURITY BREACH: EXECUTE PART 1 INITIALIZER FIRST!", "ERROR")
    return
end

-- ВЫВОД ИДЕАЛЬНОЙ ШПАРГАЛКИ В КОНСОЛЬ F9 ДЛЯ ТЕБЯ
print("\n")
print("================================================================")
print("     📝 ШПАРГАЛКА ДЛЯ ТЕБЯ: КАК СРАЗУ ПРАВИЛЬНО ПИСАТЬ КОМАНДЫ    ")
print("================================================================")
print("Шаг 1. Сначала ВСЕГДА пиши в чат игры слово в слово: -# Reanimate")
print("----------------------------------------------------------------")
print("Шаг 2. Чтобы выключить чит и чисто возродиться, пиши в чат: -rs")
print("----------------------------------------------------------------")
print("Шаг 3. ГОТОВЫЕ ШАБЛОНЫ ДЛЯ КОПИРОВАНИЯ (Заменяй Ник на имя игрока):")
print("\n")
print("💥 1. КРАШ СУСТАВОВ И ВЗРЫВ ИГРОКА (;explode):")
print('-#destroySelfAvatar :target:"Ник" :method:#"AnnihilationExplode_10"')
print("\n")
print("💬 2. ХАКЕРСКИЙ ВИРУС ЧАТА С УПРАВЛЯЕМЫМ GUI (Приклеиться к нему):")
print('-#destroySelfAvatar :target:"Ник" :method:#"ChatVirus_66"')
print("\n")
print("🥫 3. СЕКРЕТНЫЙ БАГ ЧЕРЕЗ BLOXY COLA (Взять банку в руку!):")
print('-#destroySelfAvatar :target:"Ник" :method:#"NoGripGlitch_5"')
print("\n")
print("🥶 4. ЗАМОРОЗКА ФИЗИКИ ИГРОКА (Эффект вылета интернета):")
print('-#destroySelfAvatar :target:"Ник" :method:#"PhysicsAnchor_77"')
print("\n")
print("🌀 5. КРУТИЛКА ТВОЕГО АВАТАРА (Выключится сама через 4 сек):")
print('-#destroySelfAvatar :target:"all" :method:#"SpinAnnihilation_4"')
print("\n")
print("💀 6. СЛОМАТЬ И СЖАТЬ СВОЮ ГОЛОВУ (Выключится сама через 5 сек):")
print('-#destroySelfAvatar :target:"all" :method:#"HeadDestroyTest_1"')
print("================================================================\n")

logTech("KDL-ANTIDOTE INITIALIZATION COMPLETE. PARSER CHANNELS ACTIVE!", "OK")

-- Глобальная функция поиска целей (используется Частями 4 и 5)
getgenv().KdlGetTargets = function(targetInput)
    local foundTargets = {}
    if not targetInput then return foundTargets end
    local inputLower = targetInput:lower()
    local tags = getgenv().MatrixTags or {}

    if inputLower == "all" then
        for _, p in pairs(Players:GetPlayers()) do table.insert(foundTargets, p) end
        return foundTargets
    elseif inputLower == "others" then
        for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(foundTargets, p) end end
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

-- Регистратор методов выполнения
getgenv().KdlActiveMethods = getgenv().KdlActiveMethods or {}

-- ПАРСЕР КОМАНД ИЗ ЧАТА
local function onChatted(msg)
    msg = msg:match("^%s*(.-)%s*$") 

    if msg == "-# Reanimate" or msg == "-#reanimate" then
        getgenv().NetlessActive = true
        logTech("KDL INTERFACE ACTIVE: SERUM REPLICATION ENGAGED.", "OK")
        return
    end

    if msg == "-rs" then
        getgenv().NetlessActive = false 
        logTech("GAME RESPONDED TO -rs: KDL LAB CLEANUP COMPLETE.", "OK")
        return 
    end

    if msg:find("-#destroySelfAvatar") then
        if not getgenv().NetlessActive then
            logTech("EXECUTION DENIED: INJECT '-# Reanimate' SERUM FIRST!", "ERROR")
            return
        end

        local targetInput = msg:match(':target:"([^"]+)"')
        local method = msg:match(':method:#"([^"]+)"')
        if not method then return end

        -- Перенаправляем выполнение в глобальную таблицу методов (Части 4 и 5)
        if getgenv().KdlActiveMethods[method] then
            local targets = getgenv().KdlGetTargets(targetInput)
            getgenv().KdlActiveMethods[method](targets, method)
        else
            logTech("METHOD UNRESOLVED OR CURRENTLY UNLOADED: " .. method, "ERROR")
        end
    end
end

-- Привязка к чату игры
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.MessageReceived:Connect(function(textChatMessage)
        if textChatMessage.TextSource and textChatMessage.TextSource.UserId == LocalPlayer.UserId then
            onChatted(textChatMessage.Text)
        end
    end)
else
    LocalPlayer.Chatted:Connect(onChatted)
end
-- =========================================================================
-- MATRIX HUB v28 [PART 4: AGGRESSIVE PATIENT METHODS]
-- FEATURES: AnnihilationExplode_10 (;explode), NoGripGlitch_5 (Bloxy Cola)
-- =========================================================================

local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local function logTech(message, status)
    local prefix = status == "ERROR" and "❌ [KDL_ERR]" or "🧪 [KDL_OK]"
    print(string.format("%s %s -> TIME: %f", prefix, message, os.clock()))
end

-- Подключаемся к глобальной таблице Части 3
getgenv().KdlActiveMethods = getgenv().KdlActiveMethods or {}

-- =========================================================================
-- 💥 МЕТОД: AnnihilationExplode_10 (УБИЙСТВО СУСТАВОВ И ВЗРЫВ)
-- =========================================================================
getgenv().KdlActiveMethods["AnnihilationExplode_10"] = function(targetPlayers)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local oldCFrame = hrp.CFrame
    
    local victim = targetPlayers[1] -- Берем первую цель
    if victim and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
        logTech("KDL DETONATION LOCK-ON: " .. victim.Name, "OK")
        local vHrp = victim.Character.HumanoidRootPart
        
        -- Локальный красивый взрыв
        local exp = Instance.new("Explosion")
        exp.Position = vHrp.Position
        exp.BlastRadius = 12
        exp.BlastPressure = 999999
        exp.Parent = workspace
        
        for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
        
        -- Сверхскоростной пробивающий удар физикой
        hrp.CFrame = vHrp.CFrame
        hrp.AssemblyLinearVelocity = Vector3.new(math.random(-999999, 999999), 999999, math.random(-999999, 999999))
        hrp.AssemblyAngularVelocity = Vector3.new(999999, 999999, 999999)
        
        RunService.Heartbeat:Wait() -- СТОППЕР: Держим ровно 1 кадр!
        
        -- Возврат в безопасное прежнее состояние
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        hrp.CFrame = oldCFrame
        for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = true end end
        logTech("MOLECULAR PURGE COMPLETED SUCCESSFULLY.", "OK")
    end
end

-- =========================================================================
-- 🥫 МЕТОД: NoGripGlitch_5 (СЕКРЕТНЫЙ БАГ ЧЕРЕЗ BLOXY COLA)
-- =========================================================================
getgenv().KdlActiveMethods["NoGripGlitch_5"] = function(targetPlayers)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local oldCFrame = hrp.CFrame
    
    local victim = targetPlayers[1]
    if victim and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
        local tool = char:FindFirstChildOfClass("Tool")
        local rArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
        local gripWeld = rArm and rArm:FindFirstChild("RightGrip")
        
        if not tool or not gripWeld then
            logTech("EXECUTION FAILED: EQUIP BLOXY COLA IN YOUR HAND FIRST!", "ERROR")
            return
        end
        
        logTech("COLA GRIP DETECTED. LINKING MOLECULAR VECTOR TO: " .. victim.Name, "OK")
        local vHrp = victim.Character.HumanoidRootPart
        
        if tool:FindFirstChild("Handle") then tool.Handle.Transparency = 1 end
        for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
        
        local gripConnection
        gripConnection = RunService.Heartbeat:Connect(function()
            if getgenv().NetlessActive and vHrp and vHrp.Parent and gripWeld and gripWeld.Parent then
                gripWeld.C0 = rArm.CFrame:Inverse() * vHrp.CFrame
                hrp.AssemblyAngularVelocity = Vector3.new(0, 999999, 0)
                hrp.CFrame = vHrp.CFrame
            else
                if gripConnection then gripConnection:Disconnect() end
            end
        end)
        
        -- АВТО-СТОППЕР ТАЙМЕРА (На 4 секунды)
        task.delay(4, function()
            if gripConnection then gripConnection:Disconnect() end
            if tool and tool:FindFirstChild("Handle") then tool.Handle.Transparency = 0 end
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            hrp.CFrame = oldCFrame
            for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = true end end
            logTech("COLA PURGE OVER. RETURNED TO BASE POSITION.", "OK")
        end)
    end
end

logTech("PART 4 COMBAT METHODS FULLY REGISTERED.", "OK")
-- =========================================================================
-- MATRIX HUB v28 [PART 5: INTERACTIVE CONTROL METHODS & GLITCHES]
-- FEATURES: ChatVirus_66 (Interactive Purple GUI), PhysicsAnchor_77, Visuals
-- =========================================================================

local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local function logTech(message, status)
    local prefix = status == "ERROR" and "❌ [KDL_ERR]" or "🧪 [KDL_OK]"
    print(string.format("%s %s -> TIME: %f", prefix, message, os.clock()))
end

getgenv().KdlActiveMethods = getgenv().KdlActiveMethods or {}

local function sendChatMessage(text)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if channel then channel:SendAsync(text) end
    else
        local event = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        local request = event and event:FindFirstChild("SayMessageRequest")
        if request then request:FireServer(text, "All") end
    end
end

-- =========================================================================
-- 💬 МЕТОД: ChatVirus_66 (ВИРУС ЧАТА С ТОКСИЧНО-ФИОЛЕТОВЫМ GUI)
-- =========================================================================
getgenv().KdlActiveMethods["ChatVirus_66"] = function(targetPlayers)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local oldCFrame = hrp.CFrame
    
    local victim = targetPlayers[1]
    if victim and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
        logTech("INJECTING KDL-ANTIDOTE OVERRIDE GUI FOR: " .. victim.Name, "OK")
        local vHrp = victim.Character.HumanoidRootPart
        
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.Transparency = 1 
            elseif part:IsA("Decal") then part:Destroy() end
        end
        for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end

        local syncConnection
        syncConnection = RunService.RenderStepped:Connect(function()
            if getgenv().NetlessActive and vHrp and vHrp.Parent and hrp and hrp.Parent then
                hrp.CFrame = vHrp.CFrame
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            else
                if syncConnection then syncConnection:Disconnect() end
            end
        end)

        -- СОЗДАНИЕ ИНТЕРФЕЙСА УПРАВЛЕНИЯ КДЛ-АНТИДОТ
        local MatrixGui = Instance.new("ScreenGui")
        local MainFrame = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local VictimLabel = Instance.new("TextLabel")
        local CustomTextBox = Instance.new("TextBox")
        local StopButton = Instance.new("TextButton")

        MatrixGui.Name = "KdlAntidoteControl"
        MatrixGui.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui

        MainFrame.Size = UDim2.new(0, 310, 0, 185)
        MainFrame.Position = UDim2.new(0.5, -155, 0.4, -92)
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
        MainFrame.BorderSizePixel = 2
        MainFrame.BorderColor3 = Color3.fromRGB(170, 0, 255)
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = MatrixGui

        Title.Size = UDim2.new(1, 0, 0, 32)
        Title.Text = "🧪 KDL-ANTIDOTE: SYSTEM OVERRIDE"
        Title.TextColor3 = Color3.fromRGB(0, 255, 140)
        Title.BackgroundColor3 = Color3.fromRGB(35, 15, 50)
        Title.Font = Enum.Font.Code
        Title.TextSize = 14
        Title.Parent = MainFrame

        VictimLabel.Size = UDim2.new(1, 0, 0, 25)
        VictimLabel.Position = UDim2.new(0, 0, 0, 38)
        VictimLabel.Text = "🚨 INFECTED SUBJECT: " .. victim.Name:upper()
        VictimLabel.TextColor3 = Color3.fromRGB(200, 100, 255)
        VictimLabel.BackgroundTransparency = 1
        VictimLabel.Font = Enum.Font.Code
        VictimLabel.TextSize = 12
        VictimLabel.Parent = MainFrame

        CustomTextBox.Size = UDim2.new(0, 270, 0, 42)
        CustomTextBox.Position = UDim2.new(0.5, -135, 0, 72)
        CustomTextBox.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
        CustomTextBox.TextColor3 = Color3.fromRGB(0, 255, 140)
        CustomTextBox.PlaceholderText = "Type mind-control text & press Enter..."
        CustomTextBox.PlaceholderColor3 = Color3.fromRGB(130, 70, 180)
        CustomTextBox.Font = Enum.Font.SourceSansBold
        CustomTextBox.TextSize = 16
        CustomTextBox.Text = ""
        CustomTextBox.Parent = MainFrame

        StopButton.Size = UDim2.new(0, 270, 0, 35)
        StopButton.Position = UDim2.new(0.5, -135, 0, 130)
        StopButton.BackgroundColor3 = Color3.fromRGB(190, 0, 70)
        StopButton.Text = "DISCONNECT SERUM (RESET AVATAR)"
        StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        StopButton.Font = Enum.Font.Code
        StopButton.TextSize = 13
        StopButton.Parent = MainFrame

        CustomTextBox.FocusLost:Connect(function(enterPressed)
            if enterPressed and CustomTextBox.Text ~= "" then
                sendChatMessage(CustomTextBox.Text)
                CustomTextBox.Text = ""
                CustomTextBox:CaptureFocus()
            end
        end)

        StopButton.MouseButton1Click:Connect(function()
            if syncConnection then syncConnection:Disconnect() end
            MatrixGui:Destroy()
            hrp.CFrame = oldCFrame
            for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = true end end
            logTech("SERUM DISCONNECTED MANUALLY. SUBJECT RELEASED.", "OK")
        end)
    end
end

-- =========================================================================
-- 🥶 МЕТОД: PhysicsAnchor_77 (ЗАМОРОЗКА ИГРОКА)
-- =========================================================================
getgenv().KdlActiveMethods["PhysicsAnchor_77"] = function(targetPlayers)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local oldCFrame = hrp.CFrame
    
    local victim = targetPlayers[1]
    if victim and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
        logTech("LOCKING MOLECULAR VELOCITY ON: " .. victim.Name, "OK")
        local vHrp = victim.Character.HumanoidRootPart
        for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
        
        local anchorAttachment = Instance.new("Attachment", hrp)
        local victimAttachment = Instance.new("Attachment", vHrp)
        local alignPos = Instance.new("AlignPosition")
        alignPos.Attachment0 = anchorAttachment
        alignPos.Attachment1 = victimAttachment
        alignPos.MaxForce = math.huge
        alignPos.Responsiveness = 200
        alignPos.Parent = hrp
        
        hrp.Anchored = true
        
        task.delay(6, function()
            hrp.Anchored = false
            alignPos:Destroy()
            anchorAttachment:Destroy()
            victimAttachment:Destroy()
            hrp.CFrame = oldCFrame
            for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = true end end
            logTech("PHYSICS ANCHOR RELEASED AUTOMATICALLY.", "OK")
        end)
    end
end

-- =========================================================================
-- 💀 МЕТОДЫ 1 и 4: БАЗОВЫЕ ГЛИТЧИ НА СЕБЯ
-- =========================================================================
getgenv().KdlActiveMethods["HeadDestroyTest_1"] = function()
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if head then
        head.Massless = true
        local glitchLoop
        glitchLoop = RunService.Heartbeat:Connect(function()
            if head and head.Parent then
                head.CFrame = head.CFrame * CFrame.fromEulerAnglesXYZ(math.random(10,50), 0, math.random(10,50))
                head.Size = head.Size - Vector3.new(0.02, 0.02, 0.02)
            else
                if glitchLoop then glitchLoop:Disconnect() end
            end
        end)
        task.delay(5, function()
            if glitchLoop then glitchLoop:Disconnect() end
            if head then head.Size = Vector3.new(2, 1, 1) end 
            logTech("MOLECULAR DE-RECONSTRUCTION TIMEOUT.", "OK")
        end)
    end
end

getgenv().KdlActiveMethods["SpinAnnihilation_4"] = function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyAngularVelocity", hrp)
        bv.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bv.AngularVelocity = Vector3.new(0, 9999, 0)
        task.delay(4, function()
            bv:Destroy()
            hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
            logTech("CENTRIFUGE PURGE STOPPED.", "OK")
        end)
    end
end

logTech("PART 5 CORE SYSTEMS FULLY SYNCED AND READY.", "OK")
