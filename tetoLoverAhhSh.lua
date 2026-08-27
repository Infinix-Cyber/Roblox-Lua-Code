print("Extra's Ai (Modified by Quur92) - 2026 READY")
print("Connecting to Gemini API v1beta...")
print("15 studs radius - whitelist mode active")

local API_KEY = "AIzaSyA7q8xKllusMGdOgvnqqfNdgT4F4PcGCVg" 
local API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=" .. API_KEY
local MODEL = "gemini-2.0-flash-exp"
local MAX_TOKENS = 300
local TEMPERATURE = 0.9
local RESPONSE_DELAY = 0.1
local RESPONSE_RADIUS = 15
local CHAT_LIMIT = 200

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local isEnabled = true
local lastMessageTime = 0
local processedMessages = {}

local whitelist = {
    ["TheLocalMazeV2"] = true,
    ["TheLocalMaze"] = true,
    ["Quur92"] = true,
    ["BAcON_KJpast"] = true,
    ["FreakAssDamn2"] = true
}

if not whitelist[LocalPlayer.Name] then
    print("Access denied. You are not authorized.")
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

local function sendMessage(text)
    if not text or text == "" then return end
    text = filterProfanity(text)
    text = string.gsub(text, "%s+", " ")
    text = string.gsub(text, "^%s+", "")
    text = string.gsub(text, "%s+$", "")
    if text == "" then 
        text = "Hello! How can I help you?"
    end
    
    local function sendPart(t)
        pcall(function()
            if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                local e = ReplicatedStorage.DefaultChatSystemChatEvents
                if e:FindFirstChild("SayMessageRequest") then
                    e.SayMessageRequest:FireServer(t, "All")
                    return
                end
            end
            game:GetService("Chat"):Chat(LocalPlayer.Character.Head, t, Enum.ChatColor.White)
        end)
    end
    
    if string.len(text) <= CHAT_LIMIT then
        sendPart(text)
    else
        local parts = {}
        for i = 1, string.len(text), CHAT_LIMIT do
            local part = string.sub(text, i, i + CHAT_LIMIT - 1)
            table.insert(parts, part)
        end
        for i, part in ipairs(parts) do
            local prefix = (#parts > 1) and string.format("[%d/%d] ", i, #parts) or ""
            sendPart(prefix .. part)
            wait(0.5)
        end
    end
end

spawn(function()
    wait(1.5)
    sendMessage("Extra's Ai activated! I speak all languages.")
    wait(0.6)
    sendMessage("Created by Extra / TheLocalMazeV2")
    wait(0.6)
    sendMessage("Ask me anything in any language!")
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
            contents = {{
                parts = {{ text = sys .. "\n\nUser wrote in " .. userLang .. ". Respond in " .. userLang .. ". User message: " .. prompt }}
            }},
            generationConfig = {
                temperature = TEMPERATURE,
                maxOutputTokens = MAX_TOKENS
            }
        }
        local headers = {["Content-Type"] = "application/json"}
        local json = HttpService:JSONEncode(data)
        local result = HttpService:PostAsync(API_URL, json, Enum.HttpContentType.ApplicationJson, false, headers)
        return HttpService:JSONDecode(result)
    end)
    
    if ok and res and res.candidates and res.candidates[1] then
        local txt = res.candidates[1].content.parts[1].text
        txt = filterProfanity(txt)
        if isRussian(prompt) and not isRussian(txt) then
            local ok2, res2 = pcall(function()
                local data2 = {
                    contents = {{
                        parts = {{ text = "Translate this to Russian only, no extra text: " .. txt }}
                    }},
                    generationConfig = {
                        temperature = 0.3,
                        maxOutputTokens = 150
                    }
                }
                local json2 = HttpService:JSONEncode(data2)
                local result2 = HttpService:PostAsync(API_URL, json2, Enum.HttpContentType.ApplicationJson, false, {["Content-Type"] = "application/json"})
                return HttpService:JSONDecode(result2)
            end)
            if ok2 and res2 and res2.candidates and res2.candidates[1] then
                txt = res2.candidates[1].content.parts[1].text
                txt = filterProfanity(txt)
            end
        end
        return txt
    else
        return "I am here! What would you like to talk about?"
    end
end

local function shouldReply(msg, name)
    if name == LocalPlayer.Name then return false end
    if not msg or string.len(msg) < 1 then return false end
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
    print("User:", name, "said:", msg)
    spawn(function()
        local reply = callAI(msg)
        if reply then
            wait(0.1)
            sendMessage(reply)
            lastMessageTime = tick()
            print("Sent reply")
        end
    end)
end

local function connect()
    pcall(function()
        if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
            local e = ReplicatedStorage.DefaultChatSystemChatEvents
            if e:FindFirstChild("OnMessageDoneFiltering") then
                e.OnMessageDoneFiltering.OnClientEvent:Connect(function(data)
                    if data and data.Message and data.FromSpeaker then
                        processChat(data.Message, data.FromSpeaker)
                    end
                end)
            end
        end
    end)
    pcall(function()
        for _, p in pairs(Players:GetPlayers()) do
            p.Chatted:Connect(function(msg)
                processChat(msg, p.Name)
            end)
        end
    end)
    pcall(function()
        Players.PlayerAdded:Connect(function(p)
            p.Chatted:Connect(function(msg)
                processChat(msg, p.Name)
            end)
        end)
    end)
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

spawn(function()
    wait(2)
    connect()
    print("Extra's Ai (Modified by Quur92) ready - 2026")
    print("Whitelist mode active")
    print("Model: gemini-2.0-flash-exp")
    print("Type /ai on / off")
end)

spawn(function()
    while true do
        wait(300)
        processedMessages = {}
    end
end)

local function gui()
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
    s.Text = "2026 - Gemini 2.0 Flash - 15 studs"
    s.TextColor3 = Color3.fromRGB(150, 220, 255)
    s.TextScaled = true
    s.Font = Enum.Font.Gotham
    s.Parent = f
    local st = Instance.new("TextLabel")
    st.Size = UDim2.new(1, -20, 0, 25)
    st.Position = UDim2.new(0, 10, 0, 62)
    st.BackgroundTransparency = 1
    st.Text = "Active"
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
        st.Text = isEnabled and "Active" or "Disabled"
        st.TextColor3 = isEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        tog.Text = isEnabled and "Disable" or "Enable"
        tog.BackgroundColor3 = isEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 150, 250)
    end)
    cl.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)
end

spawn(function()
    wait(1)
    gui()
end)

print("Extra's Ai (Modified by Quur92) loaded - 2026 ready")
print("Model: gemini-2.0-flash-exp")
print("Whitelist mode active")
print("Type /ai on / off")
