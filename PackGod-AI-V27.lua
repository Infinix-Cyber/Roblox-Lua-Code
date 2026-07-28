math.randomseed(os.time() + math.round(os.clock() * 1000))

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local WHITELIST_USERS = {
    ["thelocalmaze"] = true,
    ["infinixnsw"] = true
}

local TRIGGER_RADIUS = 25 
local COOLDOWN_TIME = 15 
local lastRoastTime = {}

local lastMatrixIndexes = { l1 = 0, l2 = 0, l3 = 0, l4 = 0, l5 = 0 }

-- БАЗА МАРКЕРОВ ДЛЯ СЧИТЫВАНИЯ СЛОВ
local TOXIC_FILTER = {
    -- Список плохих / обзывательских слов для мгновенного триггера
    toxic_keywords = {
        "noob", "nub", "loser", "trash", "bot", "ez", "hacker", "scam", 
        "clown", "garbage", "bad", "kid", "lmao", "cry", "l"
    }
}

local MATRIX_BANKS = {
    layer1_intros = {
        "Hold on {NAME}, look at your screen! ", "Bro {NAME}, who actually invited you? ",
        "Yo {NAME}, let's talk for a second. ", "Look at you, {NAME}! ", "Seriously {NAME}, look at this. ",
        "Ayo {NAME}, wait a minute! ", "Check this out {NAME}: ", "Listen closely {NAME}: "
    },
    layer2_punches = {
        "typing in all caps like your keyboard is missing half its keys ",
        "walking around here built like a generic microwave turntable from 2005 ",
        "running around in circles like a lost chicken in a Walmart parking lot ",
        "standing completely frozen like your entire internet connection just gave up on life ",
        "flexing all those random items with absolutely zero coordination or style ",
        "looking like a weirdly stretched action figure left out in the sun too long ",
        "looking like a wet McDonald's sprite straw left on the floor "
    },
    layer3_connectors = {
        "and your goofy message in this chat literally ",
        "while your entire presence right here just ",
        "plus that low-effort energy you carry genuinely ",
        "and honestly that visual display out here "
    },
    layer4_boosters = {
        "made the whole server pause in absolute confusion, ",
        "looks like a background character from a budget cartoon show nobody asked for, ",
        "resembles a low-quality item sitting at the bottom of a thrift store clearance bin, ",
        "looks like a laggy free model from an old abandoned 2008 starter pack, ",
        "made me realize you look like an unboxed discount toaster in the center of the map, "
    },
    layer5_conclusions = {
        "this whole display is a certified comedy show.",
        "you are genuinely the funniest entity on my screen right now.",
        "that is an absolute legendary performance of goofy behavior.",
        "I have never seen someone try this hard and look this weird.",
        "go back to the lobby and start a fresh profile because this is tragic."
    },
    
    theo_vocabulary = {
        layer1 = { "Greetings, Theo! ", "Yo Theo, absolute legend! ", "Look who it is, Theo! " },
        layer2 = { "You are literally the top player here. ", "Your playtime on this server is insane. " },
        layer3 = { "Keep up the amazing grind! ", "Maximum respect to your dedication! " }
    }
}

local function getUniqueSegment(bank, storageKey)
    local idx
    local count = #bank
    repeat idx = math.random(1, count) until idx ~= lastMatrixIndexes[storageKey]
    lastMatrixIndexes[storageKey] = idx
    return bank[idx]
end

local function sayInChat(text)
    task.spawn(function()
        local textChannels = TextChatService:WaitForChild("TextChannels", 5)
        if textChannels then
            local generalChannel = textChannels:WaitForChild("RBXGeneral", 5)
            if generalChannel then
                generalChannel:SendAsync(text)
            end
        end
    end)
end

local function isOwner(player)
    if not player then return false end
    return WHITELIST_USERS[string.lower(player.Name)] or false
end

if not isOwner(LocalPlayer) then
    sayInChat("Ay bro! this is not ur script! Get off!")
    return
end

sayInChat("PackGod LocalAI V27 [Word-Type Analyzer Enabled]")

local function safeReplaceName(template, displayName)
    local left, right = string.find(template, "{NAME}")
    if left and right then
        return string.sub(template, 1, left - 1) .. displayName .. string.sub(template, right + 1)
    end
    return template
end

local function checkDistance(targetPlayer)
    local myChar = LocalPlayer.Character
    local targetChar = targetPlayer.Character
    if not myChar or not targetChar then return false end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not targetRoot then return false end
    return (myRoot.Position - targetRoot.Position).Magnitude <= TRIGGER_RADIUS
end

-- Считывание типа слова и манеры речи
local function checkIfMessageIsToxic(messageText)
    local lowerMsg = string.lower(messageText)
    
    -- 1. Проверяем наличие обзывательских слов в тексте
    for _, badWord in ipairs(TOXIC_FILTER.toxic_keywords) do
        if string.find(lowerMsg, badWord) then
            return true -- Найдено плохое слово!
        end
    end
    
    -- 2. Анализ агрессивной манеры речи (КАПС или спам знаками восклицания)
    local lettersOnly = string.gsub(messageText, "[^%a]", "")
    if string.len(lettersOnly) > 3 and string.upper(lettersOnly) == lettersOnly then
        return true -- Агрессивный капс приравнивается к плохому сообщению
    end
    if string.find(messageText, "!!!") then
        return true -- Спам восклицаниями приравнивается к агрессии
    end
    
    return false -- Сообщение нормальное
end

local function generateChaosMatrixRoast(displayName, forceLong)
    local introTemplate = getUniqueSegment(MATRIX_BANKS.layer1_intros, "l1")
    local nameIntro = safeReplaceName(introTemplate, displayName)
    
    local p2 = getUniqueSegment(MATRIX_BANKS.layer2_punches, "l2")
    local l3 = getUniqueSegment(MATRIX_BANKS.layer3_connectors, "l3")
    local l4 = getUniqueSegment(MATRIX_BANKS.layer4_boosters, "l4")
    local l5 = getUniqueSegment(MATRIX_BANKS.layer5_conclusions, "l5")
    
    -- Если forceLong равен true (сообщение было плохим), всегда выдаем максимальный размер
    local sizeStyle = forceLong and 3 or math.random(1, 3)
    
    if sizeStyle == 1 then
        return nameIntro .. "you look absolutely goofy right here."
    elseif sizeStyle == 2 then
        local rawText = nameIntro .. p2 .. "Honestly this is pure comedy."
        if string.len(rawText) > 99 then rawText = string.sub(rawText, 1, 96) .. "..." end
        return rawText
    else
        local rawText = nameIntro .. p2 .. l3 .. l4 .. l5
        local currentLength = string.len(rawText)
        
        if currentLength < 175 then
            local padding = " This is a total certified disaster."
            rawText = rawText .. padding
            rawText = string.sub(rawText, 1, math.random(175, 185))
        elseif currentLength > 185 then
            rawText = string.sub(rawText, 1, 182) .. "..."
        end
        return rawText
    end
end

local function generateFriendlyTheoRoast()
    local t1 = MATRIX_BANKS.theo_vocabulary.layer1[math.random(1, #MATRIX_BANKS.theo_vocabulary.layer1)]
    local t2 = MATRIX_BANKS.theo_vocabulary.layer2[math.random(1, #MATRIX_BANKS.theo_vocabulary.layer2)]
    local t3 = MATRIX_BANKS.theo_vocabulary.layer3[math.random(1, #MATRIX_BANKS.theo_vocabulary.layer3)]
    local sizeStyle = math.random(1, 3)
    if sizeStyle == 1 then return t1 .. "You are the best!"
    elseif sizeStyle == 2 then return t1 .. t2
    else return t1 .. t2 .. t3 .. "Respect for holding the leaderboards! [🏆 TOP 1 TIME]" end
end

local function onMessageReceived(message)
    local sender = message.TextSource
    if not sender then return end
    local player = Players:GetPlayerByUserId(sender.UserId)
    if not player or player == LocalPlayer or isOwner(player) then return end
    
    local cleanText = string.gsub(message.Text, "%s+", "") 
    if string.len(cleanText) < 1 then return end 
    
    -- ИИ анализирует: плохое слово написал игрок или нормальное
    local isBadMessage = checkIfMessageIsToxic(message.Text)
    
    local currentTime = os.time()
    local lastTime = lastRoastTime[player.UserId] or 0
    
    -- Если слово нормальное — ИИ держит жесткий кулдаун в 15 секунд. Если плохое — отвечает СРАЗУ без задержек!
    if not isBadMessage and (currentTime - lastTime < COOLDOWN_TIME) then 
        return 
    end
    
    if checkDistance(player) then
        lastRoastTime[player.UserId] = currentTime
        
        -- Пасхалка создателя
        local lowerMsg = string.lower(message.Text)
        if string.find(lowerMsg, "who created") or string.find(lowerMsg, "who made you") or string.find(lowerMsg, "your creator") then
            sayInChat("Of course Local Maze! I am his creation!")
            return 
        end
        
        -- Проверка на Theo
        if string.lower(player.Name) == "jvnex1" then
            sayInChat(generateFriendlyTheoRoast())
            return
        end
        
        -- ИИ разносит в любом случае: но если слово было плохим (isBadMessage == true), разнос будет гарантированно большим
        local finalMessage = generateChaosMatrixRoast(player.DisplayName, isBadMessage)
        sayInChat(finalMessage)
    end
end

TextChatService.MessageReceived:Connect(onMessageReceived)
