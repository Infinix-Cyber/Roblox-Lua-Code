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

local MATRIX_BANKS = {
    layer1_intros = {
        "Hold on {NAME}, look at your screen! ", "Bro {NAME}, who actually invited you? ",
        "Yo {NAME}, let's talk for a second. ", "Look at you, {NAME}! ", "Seriously {NAME}, look at this. ",
        "Ayo {NAME}, wait a minute! ", "Check this out {NAME}: ", "Listen closely {NAME}: "
    },
    layer2_punches = {
        "typing in all caps like your keyboard was bought from a Dollar Tree box ",
        "walking around here built like a generic microwave turntable from a 2005 K-Mart display ",
        "running around in circles like a lost coupon hunter during a black friday rush at Costco ",
        "standing completely frozen like a broken automatic door sensor at a local 7-Eleven ",
        "flexing all those random items like you just sprinted through a clearance aisle at Target ",
        "looking like a weirdly stretched unboxed mannequin from a liquidated IKEA warehouse ",
        "looking like a soggy, flat paper straw left inside a lukewarm Wendy's soda cup "
    },
    layer3_connectors = {
        "and your goofy message in this chat literally ",
        "while your entire presence right here just ",
        "plus that low-effort energy you carry genuinely ",
        "and honestly that visual display out here "
    },
    layer4_boosters = {
        "made the whole server pause like a glitching cash register at a busy Taco Bell, ",
        "looks like a background asset from a budget local grocery store commercial, ",
        "resembles a custom tool made from defective plastic parts found at Home Depot, ",
        "looks like a stale, forgotten footlong sandwich sitting behind a Subway counter, ",
        "made me realize you got the exact energy of a broken vending machine outside a gas station, "
    },
    layer5_conclusions = {
        "this display is a certified comedy show.",
        "you are genuinely the funniest entity on my screen.",
        "that is an absolute performance of pure goofy behavior.",
        "I have never seen someone try this hard and look this cheap.",
        "go back to the lobby because your style is a budget disaster."
    },
    short_conclusions = {
        "looking like a total clearance aisle artifact.", "looking like a budget discount bot.",
        "built like a broken Dollar Tree plastic toy.", "your whole style is a thrift store comedy.",
        "looking completely out of place like a broken prop.", "honestly looking like a total checkout line joke."
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

sayInChat("PackGod LocalAI V30 [No-Cuts Flow Engine]")

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

-- УМНЫЙ БЕЗРАЗРЫВНЫЙ ГЕНЕРАТОР: Больше никаких троеточий и обрубленных слов
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
        -- Режим SHORT: Предложение всегда короткое и законченное
        return nameIntro .. shortConclusion
    elseif sizeStyle == 2 then
        -- Режим MEDIUM: Предложение пишется целиком и закрывается точкой
        return nameIntro .. p2 .. "Honestly this is pure comedy."
    else
        -- Режим LONG: Умная проверка длины БЕЗ использования string.sub на ходу
        local fullText = nameIntro .. p2 .. l3 .. l4 .. l5
        
        -- Если текст идеален по длине (меньше 195 символов), отправляем целиком как есть
        if string.len(fullText) <= 195 then
            return fullText
        else
            -- Умный бэкап: если имя игрока слишком длинное и ломает лимит, 
            -- мы убираем один слой (l4), чтобы не резать слова, и получаем красивое слитное предложение
            return nameIntro .. p2 .. l3 .. l5
        end
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
        
        local finalMessage = generateChaosMatrixRoast(player.DisplayName, isBadMessage)
        sayInChat(finalMessage)
    end
end

TextChatService.MessageReceived:Connect(onMessageReceived)
