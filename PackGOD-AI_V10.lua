local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local WHITELIST_USERS = {
    ["thelocalmaze"] = true,
    ["infinixnsw"] = true
}

local TRIGGER_RADIUS = 20 
local COOLDOWN_TIME = 6 -- Немного увеличили кулдаун, так как бот теперь выдает более детальный разнос
local lastRoastTime = {}

-- ОБНОВЛЕННАЯ БАЗА СЛОВ под активности и скины
local VOCABULARY = {
    introductions = {
        "Your entire virtual presence is so utterly background character coded! ",
        "Looking at your avatar genuinely destabilizes my processing core. ",
        "Why do you exist in this server with that specific layout? ",
        "I have never witnessed a more mathematically tragic display of existence! ",
        "Who allowed this unrendered default entity into my line of sight?"
    },
    -- Фразы под манеру движений
    activities = {
        jump = "You are ridiculously jumping right in front of my face like a glitched physics object. ",
        run = "You are running around me in circles erratically like a broken pathfinding script. ",
        still = "You are standing completely still like a blank wooden mannequin with missing textures. "
    },
    -- Фразы под АНАЛИЗ СКИНА
    looks = {
        robloxian20 = "Your blocky basic 2.0 package configuration is pure historical garbage. ",
        boy_girl = "That default free starter outfit makes you look like a total fresh account placeholder. ",
        rich = "Buying all those expensive items won't buy you an actual personality or good taste. ",
        rthro = "That creepy realistic Rthro scaling looks like an absolute sleep paralysis demon. ",
        default = "Your entire visual aesthetic carries the absolute energy of a total disaster. "
    },
    game_references = {
        "You look like a glitched chunk in a modded Minecraft server that refuses to load! ",
        "You are just a useless copper ingot sitting in a level 1 chest that nobody wants. ",
        "You behave like a broken NPC in Dota that got stuck in the terrain back in 2013? ",
        "Your avatar resembles a low resolution asset meant to be hidden behind a wall. "
    },
    conclusions = {
        "Please disconnect before your unrendered geometry crashes the server.",
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

sayInChat("PackGod LocalAI V9.5 [Skin-Scanner Edition]")

-- ФУНКЦИЯ АНАЛИЗА СКИНА
local function analyzeSkin(targetPlayer)
    local char = targetPlayer.Character
    if not char then return "default" end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    -- 1. Проверяем наличие дорогих вещей / доната (Лимитки, дорогие анимации)
    -- Простой способ: проверка анимации прыжка/ходьбы Toy, Mage, Vampire и т.д.
    local animate = char:FindFirstChild("Animate")
    if animate then
        local runAnim = animate:FindFirstChild("run")
        if runAnim and runAnim:FindFirstChildOfClass("Animation") then
            local animId = runAnim:FindFirstChildOfClass("Animation").AnimationId
            -- Если айди анимации кастомный (не стандартный), скорее всего игрок донатер
            if animId ~= "http://roblox.com" and animId ~= "" then
                return "rich"
            end
        end
    end

    -- 2. Проверяем тип тела (Rthro персонажи очень высокие или странной формы)
    if humanoid and humanoid.RigType == Enum.HumanoidRigType.R15 then
        local width = char:FindFirstChild("BodyWidthScale")
        local height = char:FindFirstChild("BodyHeightScale")
        if height and height.Value > 1.2 then
            return "rthro" -- Слишком высокий / Rthro
        end
    end

    -- 3. Проверяем классические паки тела
    if char:FindFirstChild("Robloxian2.0_LeftArm") or char:FindFirstChild("LeftArm_2.0") then
        return "robloxian20"
    end
    
    if char:FindFirstChild("BoyLeftArm") or char:FindFirstChild("GirlLeftArm") then
        return "boy_girl"
    end
    
    return "default"
end

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

-- Генератор, собирающий фразы по активности и скину
local function generateLocalRoast(activityType, skinType)
    local intro = VOCABULARY.introductions[math.random(1, #VOCABULARY.introductions)]
    local activity = VOCABULARY.activities[activityType] or ""
    local look = VOCABULARY.looks[skinType] or VOCABULARY.looks.default
    local gameRef = VOCABULARY.game_references[math.random(1, #VOCABULARY.game_references)]
    local conclusion = VOCABULARY.conclusions[math.random(1, #VOCABULARY.conclusions)]
    
    -- Безопасное разделение текста на 2 части по ~140 символов
    local part1 = intro .. activity
    local part2 = look .. gameRef .. conclusion
    
    return part1, part2
end

-- Главный рабочий цикл
task.spawn(function()
    while task.wait(0.5) do
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not isOwner(player) then
                local activityType = checkDistanceAndGetActivityType(player)
                
                if activityType then
                    local currentTime = os.time()
                    local lastTime = lastRoastTime[player.UserId] or 0
                    
                    if currentTime - lastTime >= COOLDOWN_TIME then
                        lastRoastTime[player.UserId] = currentTime
                        
                        -- Сканируем скин перед сборкой текста
                        local skinType = analyzeSkin(player)
                        
                        local p1, p2 = generateLocalRoast(activityType, skinType)
                        
                        -- Отправка
                        sayInChat("@" .. player.Name .. " " .. p1)
                        task.wait(0.4) 
                        sayInChat(p2)
                    end
                end
            end
        end
    end
end)
