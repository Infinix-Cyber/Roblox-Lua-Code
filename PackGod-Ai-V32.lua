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

local lastMatrixIndexes = { l1 = 0, l2 = 0, l3 = 0, l4 = 0, l5 = 0, s1 = 0 }

local TOXIC_FILTER = {
    toxic_keywords = {
        "noob", "nub", "loser", "trash", "bot", "ez", "hacker", "scam", 
        "clown", "garbage", "bad", "kid", "lmao", "cry", "l"
    }
}

-- ОТКАЛИБРОВАННАЯ БАЗА СЛОВ ПОД ТВОИ ТОЧНЫЕ ЛИМИТЫ СИМВОЛОВ
local MATRIX_BANKS = {
    layer1_intros = {
        "Hold on {NAME}, look! ", "Bro {NAME}, who invited you? ",
        "Yo {NAME}, let's talk. ", "Look at you, {NAME}! ", "Seriously {NAME}, look. ",
        "Ayo {NAME}, wait up! ", "Check this {NAME}: ", "Listen closely {NAME}: "
    },
    layer2_punches = {
        "typing like your keyboard is from Dollar Tree ",
        "built like a K-Mart microwave turntable ",
        "running like a lost coupon hunter at Costco ",
        "frozen like a broken door at 7-Eleven ",
        "flexing items from a Target clearance aisle ",
        "looking like a stretched mannequin from IKEA ",
        "looking like a soggy straw from Wendy's cup "
    },
    layer3_connectors = {
        "and your chat literally ",
        "while your presence just ",
        "plus your energy genuinely ",
        "and honestly your style out here "
    },
    layer4_boosters = {
        "made the server pause like a laggy Taco Bell, ",
        "looks like a cheap local grocery commercial, ",
        "resembles defective parts from Home Depot, ",
        "looks like a stale sandwich from Subway, ",
        "looks like a broken gas station machine, "
    },
    layer5_conclusions = {
        "this is a certified comedy show.",
        "you are the funniest entity here.",
        "that is an absolute goofy behavior.",
        "I have never seen someone look this cheap.",
        "go back to lobby, your style is a disaster."
    },
    short_conclusions = {
        "looking like a clearance aisle bot.", "looking like a budget discount bot.",
        "built like a broken plastic toy.", "your whole style is pure comedy.",
        "looking completely out of place.", "honestly looking like a total joke."
    },
    
    theo_vocabulary = {
        layer1 = { "Greetings, Theo! ", "Yo Theo, absolute legend! ", "Look who it is, Theo! " },
        layer2 = { "You are literally the top player here. ", "Your playtime on this server is insane. " },
        layer3 = { "Keep up the amazing grind! " }
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

sayInChat("PackGod LocalAI V32 [Strict One-Line Limits]")

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

local function checkIfMessageIsToxic(messageText)
    local lowerMsg = string.lower(messageText)
    for _, badWord in ipairs(TOXIC_FILTER.toxic_keywords) do
        if string.find(lowerMsg, badWord) then return true end
    end
    local lettersOnly = string.gsub(messageText, "[^%a]", "")
    if string.len(lettersOnly) > 3 and string.upper(lettersOnly) == lettersOnly then return true end
    if string.find(messageText, "!!!") then return true end
    return false
end

-- СВЕРХТОЧНЫЙ ОДНОСТРОЧНЫЙ ГЕНЕРАТОР (80-95 / 125 / 185 символов)
local function generateChaosMatrixRoast(displayName, forceLong)
    local introTemplate = getUniqueSegment(MATRIX_BANKS.layer1_intros, "l1")
    local nameIntro = safeReplaceName(introTemplate, displayName)
    
    local p2 = getUniqueSegment(MATRIX_BANKS.layer2_punches, "l2")
    local l3 = getUniqueSegment(MATRIX_BANKS.layer3_connectors, "l3")
    local l4 = getUniqueSegment(MATRIX_BANKS.layer4_boosters, "l4")
    local l5 = getUniqueSegment(MATRIX_BANKS.layer5_conclusions, "l5")
    local shortConclusion = getUniqueSegment(MATRIX_BANKS.short_conclusions, "s1")
    
    local sizeStyle = forceLong and 3 or math.random(1, 3)
    
    if sizeStyle == 1 then
        -- 1. МАЛЕНЬКИЙ СТИЛЬ: Строго 80-95 символов (в одно сообщение)
        local rawText = nameIntro .. p2 .. "goofy."
        local currentLen = string.len(rawText)
        if currentLen < 80 then
            rawText = rawText .. string.rep(" ", 80 - currentLen) -- Добиваем пробелами до 80, если ник короткий
        elseif currentLen > 95 then
            rawText = string.sub(rawText, 1, 95)
        end
        return rawText
    elseif sizeStyle == 2 then
        -- 2. СРЕДНИЙ СТИЛЬ: Строго около 125 символов (в одно сообщение)
        local rawText = nameIntro .. p2 .. l5
        local currentLen = string.len(rawText)
        if currentLen > 130 then
            rawText = string.sub(rawText, 1, 125)
        elseif currentLen < 120 then
            rawText = rawText .. " Pure comedy show right here."
            rawText = string.sub(rawText, 1, 125)
        end
        return rawText
    else
        -- 3. БОЛЬШОЙ СТИЛЬ: Строго до 185 символов (в одно сообщение, БЕЗ ОБРЫВОВ И ТОЧЕК)
        local rawText = nameIntro .. p2 .. l3 .. l4 .. l5
        local currentLen = string.len(rawText)
        
        if currentLen > 185 then
            -- Если ник игрока огромный и ломает лимит, аккуратно убираем один слой (l4), чтобы влезть в 185
            rawText = nameIntro .. p2 .. l3 .. l5
        end
        
        -- Финальная полировка длины
        if string.len(rawText) > 185 then
            rawText = string.sub(rawText, 1, 185)
        end
        return rawText
    end
end

local function generateFriendlyTheoRoast()
    local t1 = MATRIX_BANKS.theo_vocabulary.layer1[math.random(1, #MATRIX_BANKS.theo_vocabulary.layer1)]
    local t2 = MATRIX_BANKS.theo_vocabulary.layer2[math.random(1, #MATRIX_BANKS.theo_vocabulary.layer2)]
    local t3 = MATRIX_BANKS.theo_vocabulary.layer3[math.random(1, #MATRIX_BANKS.theo_vocabulary.layer3)]
    return t1 .. t2 .. t3
end

local function onMessageReceived(message)
    local sender = message.TextSource
    if not sender then return end
    local player = Players:GetPlayerByUserId(sender.UserId)
    if not player or player == LocalPlayer or isOwner(player) then return end
    
    local cleanText = string.gsub(message.Text, "%s+", "") 
    if string.len(cleanText) < 1 then return end 
    
    local isBadMessage = checkIfMessageIsToxic(message.Text)
    local currentTime = os.time()
    local lastTime = lastRoastTime[player.UserId] or 0
    
    if not isBadMessage and (currentTime - lastTime < COOLDOWN_TIME) then 
        return 
    end
    
    if checkDistance(player) then
        lastRoastTime[player.UserId] = currentTime
        
        local lowerMsg = string.lower(message.Text)
        if string.find(lowerMsg, "who created") or string.find(lowerMsg, "who made you") or string.find(lowerMsg, "your creator") then
            sayInChat("Of course Local Maze! I am his creation!")
            return 
        end
        
        if string.lower(player.Name) == "jvnex1" then
            sayInChat(generateFriendlyTheoRoast())
            return
        end
        
        -- ИИ всегда отправляет ровно ОДНО законченное сообщение заданной длины
        local finalMessage = generateChaosMatrixRoast(player.DisplayName, isBadMessage)
        sayInChat(finalMessage)
    end
end

TextChatService.MessageReceived:Connect(onMessageReceived)
