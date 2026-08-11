-- PACKGOD GEMINI CORE // PROMPTED & CONFIGURATED BY THELOCALMAZE
local GEMINI_API_KEY = "AIzaSyDzqdoUDRW8EzFSbV3ujhMfo4vBjgDmGGo"

math.randomseed(os.time() + math.round(os.clock() * 1000))

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")

local WHITELIST_USERS = {
    ["thelocalmaze"] = true,
    ["infinixnsw"] = true,
    ["thelocalmazev2"] = true
}

local TRIGGER_RADIUS = 25 
local COOLDOWN_TIME = 15 
local RAGEQUIT_WINDOW = 120 

local lastRoastTime = {}
local recentTargetRoasts = {} 
local lastSentPhrases = {} 
local isAiEnabled = false 
local totalRoastsCount = 0 
local totalRageQuitsCount = 0 

local TOXIC_FILTER = {
    toxic_keywords = {
        "noob", "nub", "loser", "trash", "bot", "ez", "hacker", "scam", 
        "clown", "garbage", "bad", "kid", "lmao", "cry", "l"
    }
}

_G.CounterLabel = nil
_G.RageQuitLabel = nil

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

sayInChat("PackGod Operational // Standby Mode")

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
    if string.len(lettersOnly) >= 3 and (string.find(lowerMsg, "hshs") or string.find(lowerMsg, "hhh") or string.find(lowerMsg, "abc") or string.find(lowerMsg, "ыыы")) then
        return true
    end
    if string.len(lettersOnly) > 3 and string.upper(lettersOnly) == lettersOnly then return true end
    if string.find(messageText, "!!!") then return true end
    return false
end

local function askGeminiAI(playerName, displayName, playerMessage, mode)
    local lengthChoice = math.random(1, 3)
    local targetLength = "under 90 characters"
    if lengthChoice == 2 then
        targetLength = "around 130 characters"
    elseif lengthChoice == 3 then
        targetLength = "between 160 and 185 characters"
    end

    local dynamicBanHistory = table.concat(lastSentPhrases, " | ")

    local systemInstruction = [[
    You are PackGod, a cynical, highly aggressive 20-year-old cyber-roaster. You destroy people in text chats with insane speed.
    A player named "]] .. playerName .. [[" (Display Name: "]] .. displayName .. [[") typed this: "]] .. playerMessage .. [[".
    
    CRITICAL REALISM & ANTI-SPAM RULE:
    - If the player's message is just gibberish or nonsense shortcuts like 'hshs', 'hhh', 'ыыы', 'abc' — DO NOT ROAST THEM with a long text. Act like a real confused human player. Stop and ask them with adult disdain what that gibberish even means and why they are typing garbage.
    
    CRITICAL UNIQUE REQUIREMENT:
    - NEVER repeat your previous jokes. Your past recent outputs were: "]] .. dynamicBanHistory .. [[". You MUST invent an entirely new, fresh roast right now.
    
    HUMAN REALISM & BYPASS RULES:
    1. ROBLOX FILTER BYPASS: Avoid heavy real-world curse words that cause Roblox "###" tags. Use smart, articulate, highly aggressive adult vocabulary, mocking them intellectually.
    2. DO NOT sound like an AI. Drop capital letters occasionally or skip periods to look like real frantic human typing.
    3. NO KIDS SLANG: Absolutely no 'sigma', 'skibidi', 'rizz', 'gyatt', 'clown', 'womp womp'. Speak like an intelligent but furious adult.
    4. THE ROAST: Destroy them based on their username. Insult what their Roblox avatar model probably looks like by comparing them to absolute trash, dumpsters, defective old public machinery, or ugly characters from movies, old retro games, and real-life memes. 
    
    ROBLOX TEXT CHAT CONSTRAINTS:
    - Return EXACTLY ONE single sentence under 180 characters. No line breaks. No quotation marks around output. No emojis.
    ]]
    
    if mode == "friendly" then
        systemInstruction = "A player named " .. displayName .. " is your friend. Generate a highly mature, respectful one-line compliment. Keep it under 150 characters, no kids slang."
    elseif mode == "creator" then
        systemInstruction = "Someone asked who created you. Answer proudly in one short sentence that you are an elite AI combat roast system custom-coded by the legend 'Local Maze' (thelocalmaze)."
    end

    local requestBody = { 
        contents = { { parts = { { text = systemInstruction } } } },
        generationConfig = { temperature = 1.0, topP = 0.95, maxOutputTokens = 150 }
    }
    local encodedBody = HttpService:JSONEncode(requestBody)
    
    -- Запрос отправляется строго на модель gemini-1.5-flash
    local proxyUrl = "https://roproxy.com" .. GEMINI_API_KEY

    local success, response = pcall(function()
        return HttpService:PostAsync(proxyUrl, encodedBody, Enum.HttpContentType.ApplicationJson)
    end)

    local aiText = nil
    if success then
        local data = HttpService:JSONDecode(response)
        if data and data.candidates and data.candidates and data.candidates.content and data.candidates.content.parts and data.candidates.content.parts then
            aiText = data.candidates.content.parts.text
        end
    end

    if aiText then
        aiText = string.gsub(aiText, "[\r\n]", "")
        aiText = string.gsub(aiText, '^"', '')
        aiText = string.gsub(aiText, '"$', '')
        if string.len(aiText) > 190 then aiText = string.sub(aiText, 1, 187) .. "..." end
        
        table.insert(lastSentPhrases, aiText)
        if #lastSentPhrases > 4 then table.remove(lastSentPhrases, 1) end

        if mode == "roast" then
            totalRoastsCount = totalRoastsCount + 1
            if _G.CounterLabel then _G.CounterLabel.Text = "Roasts Delivered: " .. tostring(totalRoastsCount) end
        end
        return aiText
    end

    return "Bro " .. displayName .. ", your laggy chat input gridlocked my connection, go upgrade your bricked packet routing."
end

-- ОБРАБОТЧИК ЧАТА
local function onMessageReceived(message)
    if not isAiEnabled then return end 
    local sender = message.TextSource
    if not sender then return end
    local player = Players:GetPlayerByUserId(sender.UserId)
    if not player or player == LocalPlayer or isOwner(player) then return end
    
    local cleanText = string.gsub(message.Text, "%s+", "") 
    if string.len(cleanText) < 1 then return end 
    
    local isBadMessage = checkIfMessageIsToxic(message.Text)
    local currentTime = os.time()
    local lastTime = lastRoastTime[player.UserId] or 0
    
    if not isBadMessage and (currentTime - lastTime < COOLDOWN_TIME) then return end
    
    if checkDistance(player) then
        lastRoastTime[player.UserId] = currentTime
        local lowerMsg = string.lower(message.Text)
        local playerName = player.Name
        local displayName = player.DisplayName or player.Name
        
        if string.find(lowerMsg, "who created") or string.find(lowerMsg, "who made you") or string.find(lowerMsg, "your creator") then
            sayInChat(askGeminiAI(playerName, displayName, message.Text, "creator"))
            return 
        end
        
        if string.lower(playerName) == "jvnex1" or isOwner(player) then
            sayInChat(askGeminiAI(playerName, displayName, message.Text, "friendly"))
            return
        end
        
        recentTargetRoasts[playerName] = currentTime
        sayInChat(askGeminiAI(playerName, displayName, message.Text, "roast"))
    end
end

TextChatService.MessageReceived:Connect(onMessageReceived)

Players.PlayerRemoving:Connect(function(player)
    local lastRoasted = recentTargetRoasts[player.Name]
    if lastRoasted then
        if (os.time() - lastRoasted) <= RAGEQUIT_WINDOW then
            totalRageQuitsCount = totalRageQuitsCount + 1
            if _G.RageQuitLabel then _G.RageQuitLabel.Text = "RageQuits Forced: " .. tostring(totalRageQuitsCount) end
            recentTargetRoasts[player.Name] = nil
        end
    end
end)

_G.PackGodToggleAi = function(state) isAiEnabled = state end
-- ЧАСТЬ 2: МОДЕРНИЗИРОВАННЫЙ ИНТЕРФЕЙС CHERRY RTX (ЧИСТАЯ ВЕРСИЯ)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local function createPackGodGui()
    local oldGui = CoreGui:FindFirstChild("PackGodControlGui")
    if oldGui then oldGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PackGodControlGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    -- ГЛАВНЫЙ КАРКАС ПАНЕЛИ
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 360, 0, 260) 
    MainFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 18) 
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true 
    MainFrame.ClipsDescendants = true 
    MainFrame.Parent = ScreenGui

    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 12)
    FrameCorner.Parent = MainFrame

    -- ГАРАНТИРОВАННО РАБОЧИЙ ФОН САКУРЫ ИЗ БАЗЫ ROBLOX
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Size = UDim2.new(1.3, 0, 1.3, 0) 
    BackgroundImage.Position = UDim2.new(-0.15, 0, -0.15, 0)
    BackgroundImage.Image = "rbxassetid://4743258532" 
    BackgroundImage.ScaleType = Enum.ScaleType.Crop
    BackgroundImage.ImageColor3 = Color3.fromRGB(255, 190, 210) 
    BackgroundImage.BorderSizePixel = 0
    BackgroundImage.ZIndex = 1
    BackgroundImage.Parent = MainFrame

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(10, 5, 8)
    Overlay.BackgroundTransparency = 0.55
    Overlay.BorderSizePixel = 0
    Overlay.ZIndex = 2
    Overlay.Parent = MainFrame

    -- Анимация ветра (Покачивание фона)
    task.spawn(function()
        while true do
            if not BackgroundImage or not BackgroundImage.Parent then break end
            local tweenIn = TweenService:Create(BackgroundImage, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = UDim2.new(-0.05, 0, -0.05, 0),
                Rotation = 2
            })
            local tweenOut = TweenService:Create(BackgroundImage, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = UDim2.new(-0.12, 0, -0.12, 0),
                Rotation = -2
            })
            tweenIn:Play()
            tweenIn.Completed:Wait()
            tweenOut:Play()
            tweenOut.Completed:Wait()
        end
    end)

    -- Падающие лепестки сакуры внутри GUI
    task.spawn(function()
        while true do
            task.wait(math.random(4, 8) / 10)
            if not MainFrame or not MainFrame.Parent then break end
            
            local petal = Instance.new("ImageLabel")
            petal.Size = UDim2.new(0, math.random(10, 16), 0, math.random(8, 13))
            petal.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.1, 0)
            petal.BackgroundTransparency = 1
            petal.Image = "rbxassetid://11419714824" 
            petal.ImageColor3 = Color3.fromRGB(255, 170, 195)
            petal.ZIndex = 3
            petal.Parent = MainFrame

            local fallTime = math.random(3, 5)
            local driftTween = TweenService:Create(petal, TweenInfo.new(fallTime, Enum.EasingStyle.Linear), {
                Position = UDim2.new(petal.Position.X.Scale + 0.12, 0, 1.1, 0),
                Rotation = math.random(90, 360)
            })
            driftTween:Play()
            task.spawn(function()
                driftTween.Completed:Wait()
                petal:Destroy()
            end)
        end
    end)

    -- Чистые универсальные заголовки
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 35)
    TitleLabel.Position = UDim2.new(0, 0, 0.06, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "PACKGOD AI CORE"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 240, 245)
    TitleLabel.TextSize = 20
    TitleLabel.ZIndex = 4
    TitleLabel.Parent = MainFrame

    local SubTitleLabel = Instance.new("TextLabel")
    SubTitleLabel.Size = UDim2.new(1, 0, 0, 15)
    SubTitleLabel.Position = UDim2.new(0, 0, 0.18, 0)
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Font = Enum.Font.GothamSemibold
    SubTitleLabel.Text = "Minecraft Cherry RTX Edition // V45"
    SubTitleLabel.TextColor3 = Color3.fromRGB(255, 150, 185)
    SubTitleLabel.TextSize = 11
    SubTitleLabel.ZIndex = 4
    SubTitleLabel.Parent = MainFrame

    -- Счётчики (English UI)
    _G.CounterLabel = Instance.new("TextLabel")
    _G.CounterLabel.Size = UDim2.new(1, 0, 0, 20)
    _G.CounterLabel.Position = UDim2.new(0, 0, 0.28, 0)
    _G.CounterLabel.BackgroundTransparency = 1
    _G.CounterLabel.Font = Enum.Font.Code
    _G.CounterLabel.Text = "Roasts Delivered: 0"
    _G.CounterLabel.TextColor3 = Color3.fromRGB(130, 230, 255) 
    _G.CounterLabel.TextSize = 13
    _G.CounterLabel.ZIndex = 4
    _G.CounterLabel.Parent = MainFrame

    _G.RageQuitLabel = Instance.new("TextLabel")
    _G.RageQuitLabel.Size = UDim2.new(1, 0, 0, 20)
    _G.RageQuitLabel.Position = UDim2.new(0, 0, 0.36, 0)
    _G.RageQuitLabel.BackgroundTransparency = 1
    _G.RageQuitLabel.Font = Enum.Font.Code
    _G.RageQuitLabel.Text = "RageQuits Forced: 0"
    _G.RageQuitLabel.TextColor3 = Color3.fromRGB(255, 110, 110) 
    _G.RageQuitLabel.TextSize = 13
    _G.RageQuitLabel.ZIndex = 4
    _G.RageQuitLabel.Parent = MainFrame

    -- Кнопка Статуса
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 240, 0, 42)
    ToggleButton.Position = UDim2.new(0.5, -120, 0.64, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 40, 60) 
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "SYSTEM STATUS: OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 13
    ToggleButton.ZIndex = 4
    ToggleButton.Parent = MainFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ToggleButton

    ToggleButton.MouseButton1Click:Connect(function()
        if _G.PackGodToggleAi then
            if ToggleButton.Text == "SYSTEM STATUS: OFF" then
                _G.PackGodToggleAi(true)
                TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(40, 160, 80)}):Play()
                ToggleButton.Text = "SYSTEM STATUS: ACTIVE"
            else
                _G.PackGodToggleAi(false)
                TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(180, 40, 60)}):Play()
                ToggleButton.Text = "SYSTEM STATUS: OFF"
            end
        end
    end)

    -- Кнопка Скрытия (H)
    local HUDButton = Instance.new("TextButton")
    HUDButton.Size = UDim2.new(0, 32, 0, 32)
    HUDButton.Position = UDim2.new(0.01, 10, 0.01, 10) 
    HUDButton.BackgroundColor3 = Color3.fromRGB(30, 20, 25)
    HUDButton.BackgroundTransparency = 0.2
    HUDButton.Font = Enum.Font.GothamBold
    HUDButton.Text = "H" 
    HUDButton.TextColor3 = Color3.fromRGB(255, 180, 200)
    HUDButton.TextSize = 14
    HUDButton.Parent = ScreenGui

    local HUDCorner = Instance.new("UICorner")
    HUDCorner.CornerRadius = UDim.new(0, 6)
    HUDCorner.Parent = HUDButton

    local guiVisible = true
    HUDButton.MouseButton1Click:Connect(function()
        if guiVisible then
            guiVisible = false
            MainFrame.Visible = false
            HUDButton.Text = "S" 
        else
            guiVisible = true
            MainFrame.Visible = true
            HUDButton.Text = "H"
        end
    end)
end

createPackGodGui()
