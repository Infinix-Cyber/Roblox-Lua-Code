-- Защита от повторов: намертво перемешиваем генератор чисел через время и сессию
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

-- Хранилище индексов для проверки на дубликаты
local lastIndexes = {
    l1 = 0, l2 = 0, l3 = 0, l5 = 0, l6 = 0, l7 = 0,
    t1 = 0, t2 = 0, t3 = 0
}

local VOCABULARY = {
    layer1_names = {
        "Look, {NAME}: ", "Hey {NAME}! ", "Yo {NAME}, ", "{NAME}, listen: ", "{NAME}, stop: ", "Listen {NAME}! ",
        "Check this, {NAME}: ", "Wake up, {NAME}! ", "Seriously, {NAME}: ", "Hold on, {NAME}! "
    },
    intros = {
        "your profile is ", "your avatar is ", "your account is ", "your presence is ", "your vibe is ",
        "your current state is ", "your character layout is ", "your visual style is "
    },
    adjectives = {
        "pure low-poly garbage. ", "a total tech disaster. ", "completely broken data. ", "a visual mistake. ",
        "an absolute software failure. ", "pure unrendered trash. ", "a complete system error. "
    },
    skin_roasts = {
        jump = {
            "Stop lagging your glitched jump physics object. ", "Your terrible air acceleration looks broken. ",
            "Jumping won't fix your corrupted geometry. ", "Your animation graph is totally falling apart. "
        },
        run = {
            "Your broken pathfinding code is a joke. ", "Running in circles won't save your profile. ",
            "Your movement style looks like a cheap clone. ", "Stop erratically glitched moving around. "
        },
        still = {
            "Standing there like a blank wooden dummy. ", "You look like a forgotten missing texture. ",
            "An absolute frozen low-resolution asset. ", "Stuck in the terrain like a 2013 bug. "
        }
    },
    game_refs = {
        "You look like a glitched Minecraft chunk! ", "A useless item from a level 1 chest! ",
        "A broken NPC stuck behind an invisible wall! ", "A default asset made by an intern! ",
        "A low-res texture from a forgotten build! "
    },
    conclusions = {
        "Go to main menu.", "Disconnect now.", "Reevaluate life.", "Delete account.", "Please alt-f4.",
        "Leave this server.", "Absolute failure.", "Stop rendering.", "Clear your cache.", "Database error."
    },
    
    theo_vocabulary = {
        layer1 = {
            "Greetings, Theo! ", "Yo Theo, absolute legend! ", "Look who it is, Theo! ", "Hey Theo! "
        },
        layer2 = {
            "You are literally the top player here. ", "Your playtime on this server is insane. ", 
            "Thanks for dedication to this game! ", "You hold the absolute best record! "
        },
        layer3 = {
            "Keep up the amazing grind! ", "You are carrying this entire lobby. ", 
            "Maximum respect to your dedication! ", "Stay awesome and keep winning! "
        }
    }
}

-- Умная функция выбора случайного элемента без повтора с прошлым разом
local function getRandomUnique(vocabularyTable, storageKey)
    local idx
    local count = #vocabularyTable
    if count <= 1 then return vocabularyTable[1] end
    
    repeat
        idx = math.random(1, count)
    until idx ~= lastIndexes[storageKey]
    
    lastIndexes[storageKey] = idx
    return vocabularyTable[idx]
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

sayInChat("PackGod LocalAI V18 [Anti-Repeat Seed Engine]")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "PackGod AI V18",
        Text = "Random Seed & Anti-Repeat Engine Active!",
        Duration = 5
    })
end)

local function checkDistanceAndGetActivity(targetPlayer)
    local myChar = LocalPlayer.Character
    local targetChar = targetPlayer.Character
    if not myChar or not targetChar then return nil end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
    
    if not myRoot or not targetRoot or not targetHumanoid then return nil end
    
    local distance = (myRoot.Position - targetRoot.Position).Magnitude
    if distance > TRIGGER_RADIUS then return nil end
    
    if targetHumanoid.FloorMaterial == Enum.Material.Air then
        return "jump"
    elseif targetRoot.AssemblyLinearVelocity.Magnitude > 2 then
        return "run"
    else
        return "still"
    end
end

local function safeReplaceName(template, displayName)
    local left, right = string.find(template, "{NAME}")
    if left and right then
        return string.sub(template, 1, left - 1) .. displayName .. string.sub(template, right + 1)
    end
    return template
end

local function generateStrictSizeRoast(activityType, displayName)
    -- Используем getRandomUnique вместо обычной выборки
    local nameTemplate = getRandomUnique(VOCABULARY.layer1_names, "l1")
    local nameIntro = safeReplaceName(nameTemplate, displayName)
    
    local l2 = getRandomUnique(VOCABULARY.intros, "l2")
    local l3 = getRandomUnique(VOCABULARY.adjectives, "l3")
    
    local specificList = VOCABULARY.skin_roasts[activityType]
    local l5 = getRandomUnique(specificList, "l5")
    
    local l6 = getRandomUnique(VOCABULARY.game_refs, "l6")
    local l7 = getRandomUnique(VOCABULARY.conclusions, "l7")
    
    local sizeStyle = math.random(1, 3)
    
    if sizeStyle == 1 then
        local rawText = nameIntro .. l5
        if string.len(rawText) > 55 then
            rawText = string.sub(rawText, 1, 52) .. "..."
        end
        return rawText
    elseif sizeStyle == 2 then
        local rawText = nameIntro .. l2 .. l3 .. l7
        if string.len(rawText) > 99 then
            rawText = string.sub(rawText, 1, 96) .. "..."
        end
        return rawText
    else
        local rawText = nameIntro .. l2 .. l3 .. l5 .. l6 .. l7
        local currentLength = string.len(rawText)
        
        if currentLength < 175 then
            local padding = " [SYSTEM_PURGE_REQUIRED_IMMEDIATELY]"
            rawText = rawText .. padding
            rawText = string.sub(rawText, 1, math.random(175, 185))
        elseif currentLength > 185 then
            rawText = string.sub(rawText, 1, 182) .. "..."
        end
        return rawText
    end
end

local function generateFriendlyTheoRoast()
    local t1 = getRandomUnique(VOCABULARY.theo_vocabulary.layer1, "t1")
    local t2 = getRandomUnique(VOCABULARY.theo_vocabulary.layer2, "t2")
    local t3 = getRandomUnique(VOCABULARY.theo_vocabulary.layer3, "t3")
    
    local sizeStyle = math.random(1, 3)
    
    if sizeStyle == 1 then
        return t1 .. "You are the best!"
    elseif sizeStyle == 2 then
        local text = t1 .. t2
        if string.len(text) > 99 then text = string.sub(text, 1, 95) .. "..." end
        return text
    else
        local text = t1 .. t2 .. t3 .. "Respect for holding the leaderboards active! [REWARD_ELIGIBLE]"
        if string.len(text) < 175 then
            text = text .. " [🏆 TOP 1 TIME HOLDER]"
            text = string.sub(text, 1, math.random(175, 185))
        elseif string.len(text) > 185 then
            text = string.sub(text, 1, 182) .. "..."
        end
        return text
    end
end

local function onMessageReceived(message)
    local sender = message.TextSource
    if not sender then return end
    
    local player = Players:GetPlayerByUserId(sender.UserId)
    if not player or player == LocalPlayer or isOwner(player) then return end
    
    local cleanText = string.gsub(message.Text, "%s+", "") 
    if string.len(cleanText) < 3 then 
        return 
    end
    
    local currentTime = os.time()
    local lastTime = lastRoastTime[player.UserId] or 0
    if currentTime - lastTime < COOLDOWN_TIME then 
        return 
    end
    
    local activityType = checkDistanceAndGetActivity(player)
    
    if activityType then
        lastRoastTime[player.UserId] = currentTime
        
        local lowerMsg = string.lower(message.Text)
        if string.find(lowerMsg, "who created") or string.find(lowerMsg, "who made you") or string.find(lowerMsg, "your creator") then
            sayInChat("Of course Local Maze! I am his creation!")
            return 
        end
        
        if string.lower(player.Name) == "jvnex1" then
            local friendlyMessage = generateFriendlyTheoRoast()
            sayInChat(friendlyMessage)
        else
            local finalMessage = generateStrictSizeRoast(activityType, player.DisplayName)
            sayInChat(finalMessage)
        end
    end
end

TextChatService.MessageReceived:Connect(onMessageReceived)
