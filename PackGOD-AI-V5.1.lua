local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local WHITELIST_USERS = {
    ["thelocalmaze"] = true,
    ["infinixnsw"] = true
}

local TRIGGER_RADIUS = 20 
local COOLDOWN_TIME = 4
local lastRoastTime = {}

-- ОГРОМНАЯ БАЗА СЛОВ (Ни одной запятой, только . ! ?)
local VOCABULARY = {
    introductions = {
        "Your entire virtual presence is so utterly background character coded! ",
        "Looking at your avatar genuinely destabilizes my processing core. ",
        "Why do you exist in this server with that specific layout? ",
        "I have never witnessed a more mathematically tragic display of existence! ",
        "Your account needs to be systematically purged from the database immediately. ",
        "Who allowed this unrendered default entity into my line of sight?"
    },
    activities = {
        jump = "You are ridiculously jumping right in front of my face like a glitched physics object from a pre alpha horror indie game. ",
        run = "You are running around me in circles erratically like a broken pathfinding script from an unfinished GTA clone! ",
        still = "You are standing completely still like a blank wooden mannequin with missing textures from a forgotten Skyrim build. "
    },
    connectors = {
        "This performance carries the absolute energy of a total disaster. ",
        "You are effectively transforming this area into a digital wasteland. ",
        "This perfectly matches the visual disappointment of your whole profile! ",
        "Your internal code consists entirely of corrupted placeholder files. ",
        "Every single frame you animate decreases the overall performance of this server."
    },
    game_references = {
        "You look like a glitched chunk in a heavily modded Minecraft server that refuses to load! ",
        "You are just a useless copper ingot sitting in a level 1 chest that nobody wants to loot. ",
        "You behave like a broken NPC in Dota that got stuck in the terrain back in 2013? ",
        "Your avatar resembles a low resolution background asset meant to be hidden behind an invisible wall. ",
        "You have the exact defensive capabilities of a level 1 Fortnite structure built out of rotten wood. ",
        "Your entire movement style looks like a corrupted animation graph from Cyberpunk!"
    },
    conclusions = {
        "This is an absolute failure of tactical positioning and aesthetic value!",
        "Please disconnect before your unrendered geometry crashes the local server.",
        "You are the most sub optimal entity to ever cross my render distance!",
        "Your whole vibe is like a default asset left by an underpaid intern?",
        "Go back to the main menu and reevaluate your life choices."
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

sayInChat("PackGod LocalAI V9 [Anti-Repeat Edition]")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "PackGod AI V9",
        Text = "Anti-Repeat system is fully active!",
        Duration = 5
    })
end)

local function checkDistanceAndGetActivityType(targetPlayer)
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

-- Генератор полностью уникальных строк
local function generateLocalRoast(activityType)
    local intro = VOCABULARY.introductions[math.random(1, #VOCABULARY.introductions)]
    local activity = VOCABULARY.activities[activityType]
    local connector = VOCABULARY.connectors[math.random(1, #VOCABULARY.connectors)]
    local gameRef = VOCABULARY.game_references[math.random(1, #VOCABULARY.game_references)]
    local conclusion = VOCABULARY.conclusions[math.random(1, #VOCABULARY.conclusions)]
    
    local finalSentence = intro .. activity .. connector .. gameRef .. conclusion
    
    -- Шанс 30%, что вся фраза превратится в кричащий КАПС для жесткости
    if math.random(1, 10) <= 3 then
        finalSentence = string.upper(finalSentence)
    end
    
    return finalSentence
end

TextChatService.MessageReceived:Connect(function(textChatMessage)
    local source = textChatMessage.TextSource
    if not source then return end
    
    local sender = Players:GetPlayerByUserId(source.UserId)
    if not sender or sender == LocalPlayer then return end
    
    if isOwner(sender) then return end
    
    local activityType = checkDistanceAndGetActivityType(sender)
    if not activityType then return end 
    
    local currentTime = os.time()
    if lastRoastTime[sender.UserId] and (currentTime - lastRoastTime[sender.UserId]) < COOLDOWN_TIME then
        return
    end
    lastRoastTime[sender.UserId] = currentTime
    
    task.spawn(function()
        local roast = generateLocalRoast(activityType)
        sayInChat(roast)
    end)
end)
