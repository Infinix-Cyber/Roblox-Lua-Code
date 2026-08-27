print("Extra's Ai (Modified by Quur92) - DEEPSEEK FINAL")
print("Connecting to DeepSeek API...")
print("15 studs radius - whitelist mode active")

local API_KEY = "sk-5d4c3a6ab0e54a44ab7317c0995b10eb"  -- ВСТАВЬ СВОЙ КЛЮЧ СЮДА
local API_URL = "https://api.deepseek.com/v1/chat/completions"
local MODEL = "deepseek-chat"
local MAX_TOKENS = 300
local TEMPERATURE = 0.9
local RESPONSE_DELAY = 2
local RESPONSE_RADIUS = 15
local CHAT_LIMIT = 200

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local isEnabled = true
local lastMessageTime = 0
local processedMessages = {}
local lastReply = ""
local rateLimit = {}
local lastMessageByPlayer = {}

local whitelist = {
    ["TheLocalMazeV2"] = true,
    ["TheLocalMaze"] = true,
    ["Quur92"] = true,
    ["BAcON_KJpast"] = true,
    ["FreakAssDamn2"] = true
}

if not whitelist[LocalPlayer.Name] then
    print("Access denied.")
    return
end

local function filterProfanity(text)
    local bad = {"fuck","shit","ass","bitch","cunt","dick","pussy","bastard","whore","slut","cock","balls","cum","semen","crap","damn","hell","хуй","пизд","бля","ебал","сука","мудак"}
    for _, w in pairs(bad) do
        text = string.gsub(text, w, "")
        text = string.gsub(text, string.upper(w), "")
        text = string.gsub(text, string.lower(w), "")
    end
    return text
end

local function isRussian(text)
    return string.match(text, "[а-яА-Я]") ~= nil
end

local function sendMsg(message)
    if not isEnabled then return end
    if not message or message == "" then return end
    if message == lastReply then return end
    
    message = filterProfanity(message)
    message = string.gsub(message, "%s+", " ")
    message = string.gsub(message, "^%s+", "")
    message = string.gsub(message, "%s+$", "")
    if message == "" then return end
    
    pcall(function()
        local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        local sayRequest = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
        if sayRequest then
            sayRequest:FireServer(message, "All")
            lastReply = message
        else
            local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if ch then
                ch:SendAsync(message)
                lastReply = message
            end
        end
    end)
end

task.spawn(function()
    task.wait(1.5)
    sendMsg("Extra's Ai (DeepSeek) activated!")
    task.wait(0.6)
    sendMsg("Created by Extra / TheLocalMazeV2")
    task.wait(0.6)
    sendMsg("Ask me anything in any language!")
end)

local function callAI(prompt)
    local lower = string.lower(prompt)
    if string.find(lower, "who made you") or string.find(lower, "creator") or string.find(lower, "who created you") or string.find(lower, "создатель") or string.find(lower, "кто тебя создал") then
        return "My creator is Extra, also known as TheLocalMazeV2. Co-owners: Quur92, BAcON_KJpast, FreakAssDamn2."
    end
    
    local ok, res = pcall(function()
        local userLang = isRussian(prompt) and "russian" or "english"
        local sys = [[
You are Extra's Ai. Created by Extra (TheLocalMazeV2).
CRITICAL: You MUST respond in the EXACT SAME LANGUAGE as the user.
If Russian -> respond in Russian. English -> English. Any language -> that language.
Never use profanity. Never use words censored by Roblox.
Never use ###. Be friendly, polite, supportive and creative.
]]
        local data = {
            model = MODEL,
            messages = {
                {role = "system", content = sys},
                {role = "user", content = "User wrote in " .. userLang .. ". Respond in " .. userLang .. ". User message: " .. prompt}
            },
            max_tokens = MAX_TOKENS,
            temperature = TEMPERATURE
        }
        local headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. API_KEY
        }
        local json = HttpService:JSONEncode(data)
        local result = HttpService:PostAsync(API_URL, json, Enum.HttpContentType.ApplicationJson, false, headers)
        return HttpService:JSONDecode(result)
    end)
    
    if ok and res and res.choices and res.choices[1] then
        local txt = res.choices[1].message.content
        txt = filterProfanity(txt)
        if isRussian(prompt) and not isRussian(txt) then
            local ok2, res2 = pcall(function()
                local data2 = {
                    model = MODEL,
                    messages = {
                        {role = "system", content = "Translate to Russian only, no extra text."},
                        {role = "user", content = txt}
                    },
                    max_tokens = 150,
                    temperature = 0.3
                }
                local json2 = HttpService:JSONEncode(data2)
                local result2 = HttpService:PostAsync(API_URL, json2, Enum.HttpContentType.ApplicationJson, false, headers)
                return HttpService:JSONDecode(result2)
            end)
            if ok2 and res2 and res2.choices and res2.choices[1] then
                txt = res2.choices[1].message.content
                txt = filterProfanity(txt)
            end
        end
        return txt
    else
        print("⚠️ DeepSeek API error or empty response")
        return nil
    end
end

local function shouldReply(msg, name)
    if name == LocalPlayer.Name then return false end
    if not msg or string.len(msg) < 3 then return false end
    if processedMessages[name .. ":" .. msg] then return false end
    if lastMessageByPlayer[name] == msg then return false end
    if rateLimit[name] and rateLimit[name] >= 3 then
        print("⛔ Anti-spam:", name, "is rate limited")
        return false
    end
    
    local target = Players:FindFirstChild(name)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
            if dist > RESPONSE_RADIUS then return false end
        else return false end
    else return false end
    return true
end

local function processChat(msg, name)
    local now = tick()
    local key = name .. ":" .. msg
    if processedMessages[key] then return end
    processedMessages[key] = true
    
    if now - lastMessageTime < RESPONSE_DELAY then return end
    if not isEnabled then return end
    if not shouldReply(msg, name) then return end
    
    rateLimit[name] = (rateLimit[name] or 0) + 1
    task.delay(60, function() rateLimit[name] = math.max(0, (rateLimit[name] or 0) - 1) end)
    lastMessageByPlayer[name] = msg
    
    print("User:", name, "said:", msg)
    task.spawn(function()
        local reply = callAI(msg)
        if reply and reply ~= "" and reply ~= lastReply then
            task.wait(0.1)
            sendMsg(reply)
            lastMessageTime = tick()
            print("Sent reply")
        else
            print("⚠️ Skipping empty or duplicate reply")
        end
    end)
end

local function connectToChat()
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.MessageReceived:Connect(function(msg)
            pcall(function()
                if msg.TextSource then
                    local sender = Players:GetPlayerByUserId(msg.TextSource.UserId)
                    if sender then
                        processChat(msg.Text, sender.Name)
                    end
                end
            end)
        end)
    else
        pcall(function()
            local onMsg = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("OnMessageDoneFiltering")
            if onMsg and onMsg:IsA("RemoteEvent") then
                onMsg.OnClientEvent:Connect(function(data)
                    pcall(function()
                        if data and data.FromSpeaker and data.Message then
                            local sender = Players:FindFirstChild(data.FromSpeaker)
                            if sender then
                                processChat(data.Message, sender.Name)
                            end
                        end
                    end)
                end)
            end
        end)
    end
end

local function cmd(msg)
    local args = string.split(string.lower(msg), " ")
    if args[1] == "/ai" then
        if args[2] == "on" then isEnabled = true print("AI enabled") end
        if args[2] == "off" then isEnabled = false print("AI disabled") end
        return true
    end
    return false
end

if LocalPlayer then
    LocalPlayer.Chatted:Connect(function(msg)
        cmd(msg)
    end)
end

task.spawn(function()
    task.wait(2)
    connectToChat()
    print("Extra's Ai ready - DEEPSEEK FINAL")
    print("Delay: 2 seconds | Anti-spam: 3/min")
    print("Type /ai on / off")
end)

task.spawn(function()
    while true do
        task.wait(120)
        processedMessages = {}
        lastReply = ""
        print("Cache cleared")
    end
end)

local function createGUI()
    local sg = Instance.new("ScreenGui")
    sg.Name = "ExtraAiGUI"
    sg.Parent = LocalPlayer.PlayerGui
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 370, 0, 200)
    f.Position = UDim2.new(0, 20, 0.5, -100)
    f.BackgroundColor3 = Color3.fromRGB(10, 10, 22)
    f.BorderSizePixel = 0
    f.Parent = sg
    f.Active = true
    f.Draggable = true
    Instance.new("UICorner").CornerRadius = UDim.new(0, 12)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 40)
    t.BackgroundTransparency = 1
    t.Text = "Extra's Ai"
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.TextScaled = true
    t.Font = Enum.Font.GothamBold
    t.Parent = f
    local s = Instance.new("TextLabel")
    s.Size = UDim2.new(1, 0, 0, 20)
    s.Position = UDim2.new(0, 0, 0, 38)
    s.BackgroundTransparency = 1
    s.Text = "DeepSeek Engine - 2s delay"
    s.TextColor3 = Color3.fromRGB(150, 220, 255)
    s.TextScaled = true
    s.Font = Enum.Font.Gotham
    s.Parent = f
    local st = Instance.new("TextLabel")
    st.Size = UDim2.new(1, -20, 0, 25)
    st.Position = UDim2.new(0, 10, 0, 62)
    st.BackgroundTransparency = 1
    st.Text = "Active - global chat"
    st.TextColor3 = Color3.fromRGB(50, 200, 50)
    st.TextScaled = true
    st.Font = Enum.Font.Gotham
    st.Parent = f
    local tog = Instance.new("TextButton")
    tog.Size = UDim2.new(0.45, -5, 0, 35)
    tog.Position = UDim2.new(0, 10, 0, 100)
    tog.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    tog.BorderSizePixel = 0
    tog.Text = "Disable"
    tog.TextColor3 = Color3.fromRGB(255, 255, 255)
    tog.TextScaled = true
    tog.Font = Enum.Font.GothamBold
    tog.Parent = f
    Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
    local cl = Instance.new("TextButton")
    cl.Size = UDim2.new(0.45, -5, 0, 35)
    cl.Position = UDim2.new(0.55, 0, 0, 100)
    cl.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    cl.BorderSizePixel = 0
    cl.Text = "Close"
    cl.TextColor3 = Color3.fromRGB(255, 255, 255)
    cl.TextScaled = true
    cl.Font = Enum.Font.GothamBold
    cl.Parent = f
    Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
    tog.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        st.Text = isEnabled and "Active - global" or "Disabled"
        st.TextColor3 = isEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        tog.Text = isEnabled and "Disable" or "Enable"
        tog.BackgroundColor3 = isEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 150, 250)
    end)
    cl.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)
end

task.spawn(function()
    task.wait(1)
    createGUI()
end)

print("Extra's Ai (DeepSeek) loaded")
print("Delay: 2 seconds | Anti-spam: 3/min")
print("Type /ai on / off")
