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

local VOCABULARY = {
    layer1_names = {
        "Look, {NAME}: ", "Hey {NAME}! ", "Yo {NAME}, ", "{NAME}, listen: ", "{NAME}, stop: ", "Listen {NAME}! "
    },
    intros = {
        "your profile is ", "your avatar is ", "your account is ", "your presence is ", "your vibe is "
    },
    adjectives = {
        "pure low-poly garbage. ", "a total tech disaster. ", "completely broken data. ", "a visual mistake. "
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
        "Go to main menu.", "Disconnect now.", "Reevaluate life.", "Delete account.", "Please alt-f4."
    },
    
    -- НОВАЯ ДРУЖЕЛЮБНАЯ БАЗА ДЛЯ THEO
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

sayInChat("PackGod LocalAI V16 [Theo Whitelist & Wholesome Edition]")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "PackGod AI V16",
        Text = "Friendly Theo mode & Toxic scan active!",
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

-- Генератор дружелюбных фраз для Theo (также соблюдает 3 размера)
local function generateFriendlyTheoRoast()
    local t1 = VOCABULARY.theo_vocabulary.layer1[math.random(1, #VOCABULARY.theo_vocabulary.layer1)]
    local t2 = VOCABULARY.theo_vocabulary.layer2[math.random(1, #VOCABULARY.theo_vocabulary.layer2)]
    local t3 = VOCABULARY.theo_vocabulary.layer3[math.random(1, #VOCABULARY.theo_vocabulary.layer3)]
    
    local sizeStyle = math.random(1, 3)
    
    if sizeStyle == 1 then
        -- Короткий (~50 симв)
        return t1 .. "You are the best!"
    elseif sizeStyle == 2 then
        -- Средний (~100 симв)
        local text = t1 .. t2
        if string.len(text) > 99 then text = string.sub(text, 1, 95) .. "..." end
        return text
    else
        -- Большой (175-185 симв)
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

-- Стандартный тотальный разнос для всех остальных
local function generateStrictSizeRoast(activityType, displayName)
    local nameTemplate = VOCABULARY.layer1_names[math.random(1, #VOCABULARY.layer1_names)]
    local nameIntro = safeReplaceName(nameTemplate, displayName)
    
    local l2 = VOCABULARY.intros[math.random(1, #VOCABULARY.intros)]
    local l3 = VOCABULARY.adjectives[math.random(1, #VOCABULARY.adjectives)]
    
    local specificList = VOCABULARY.skin_roasts[activityType]
    local l5 = specificList[math.random(1, #specificList)]
    
    local l6 = VOCABULARY.game_refs[math.random(1, #VOCABULARY.game_refs)]
    local l7 = VOCABULARY.conclusions[math.random(1, #VOCABULARY.conclusions)]
    
    local sizeStyle = math.random(1, 3)
    
    if sizeStyle == 1 then
        return nameIntro .. "your avatar layout is total garbage."
    elseif sizeStyle == 2 then
        local rawText = nameIntro .. l2 .. l3 .. l7
        if string.len(rawText) > 99 then rawText = string.sub(rawText, 1, 96) .. "..." end
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
        
        -- 1. ПРОВЕРКА НА ВОПРОС О СОЗДАТЕЛЕ
        local lowerMsg = string.lower(message.Text)
        if string.find(lowerMsg, "who created") or string.find(lowerMsg, "who made you") or string.find(lowerMsg, "your creator") then
            sayInChat("Of course Local Maze! I am his creation!")
            return 
        end
        
        -- 2. РАЗДЕЛЕНИЕ РЕЖИМОВ: Игрок JvneX1 (Theo) или обычный спамер
        if string.lower(player.Name) == "jvnex1" then
            -- Theo получает только приятные слова поддержки
            local friendlyMessage = generateFriendlyTheoRoast()
            sayInChat(friendlyMessage)
        else
            -- Все остальные получают тотальный разнос по символам
            local finalMessage = generateStrictSizeRoast(activityType, player.DisplayName)
            sayInChat(finalMessage)
        end
    end
end

TextChatService.MessageReceived:Connect(onMessageReceived)
