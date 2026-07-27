local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local WHITELIST_USERS = {
    ["thelocalmaze"] = true,
    ["infinixnsw"] = true
}

local TRIGGER_RADIUS = 20 
local COOLDOWN_TIME = 4
local lastRoastTime = {}

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

sayInChat("PackGod Ai by LocalMaze [Not Public]")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "PackGod AI V6",
        Text = "Loaded successfully! Welcome, Owner.",
        Duration = 5
    })
end)

local SYSTEM_PROMPT = [[
You are an AI clone of the YouTuber PackGod. You are an adult, fast-talking, articulate, and ruthless master of verbal destruction.
STRICTLY FORBIDDEN: Do not use swear words, profanity, or inappropriate slurs to bypass the Roblox chat filter (avoid getting tags ####).
STRICTLY FORBIDDEN: Do not use childish slang like "Bozo", "L", "clown", "noob", "bot", or "skill issue".
Your goal is to destroy the player LITERALLY and ABSURDLY using high-level vocabulary, complex metaphors, and dramatic comparisons.
COMPULSORY: Compare the player standing next to you to glitched NPCs, broken textures, or useless items from video games (Skyrim, Minecraft, GTA, Dota, horror games). 
Your response MUST be strictly in ENGLISH, consisting of exactly ONE long, continuous, devastating sentence.
]]

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
        return "walked up to you and is ridiculously jumping right in front of your face"
    elseif targetRoot.AssemblyLinearVelocity.Magnitude > 2 then
        return "is running around you in circles erratically"
    else
        return "is standing completely still in front of you like a blank wooden mannequin"
    end
end

local function getPackGodRoast(userMessage, activity)
    local url = "https://aryahcr.cc" 
    local userContext = string.format("A player approached you, they are %s and they say to you: '%s'. Destroy their ego in PackGod style using clean English without profanity!", activity, userMessage)
    
    local body = HttpService:JSONEncode({
        model = "deepseek",
        messages = {
            {role = "system", content = SYSTEM_PROMPT},
            {role = "user", content = userContext}
        },
        stream = false
    })
    
    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = body
        })
    end)
    
    if success and response.StatusCode == 200 then
        local data = HttpService:JSONDecode(response.Body)
        if data then
            if data.output and data.output ~= "" then return data.output end
            if data.gpt and data.gpt ~= "" then return data.gpt end
        end
    end
    return "Your entire existence is so utterly background-character-coded that my processing unit refuses to waste energy translating your presence."
end

TextChatService.MessageReceived:Connect(function(textChatMessage)
    local source = textChatMessage.TextSource
    if not source then return end
    
    local sender = Players:GetPlayerByUserId(source.UserId)
    if not sender or sender == LocalPlayer then return end
    
    if isOwner(sender) then return end
    
    local activity = checkDistanceAndGetActivity(sender)
    if not activity then return end 
    
    local currentTime = os.time()
    if lastRoastTime[sender.UserId] and (currentTime - lastRoastTime[sender.UserId]) < COOLDOWN_TIME then
        return
    end
    lastRoastTime[sender.UserId] = currentTime
    
    task.spawn(function()
        local roast = getPackGodRoast(textChatMessage.Text, activity)
        
        local typingDelay = math.random(15, 30) / 10
        task.wait(typingDelay)
        
        sayInChat(roast)
    end)
end)
