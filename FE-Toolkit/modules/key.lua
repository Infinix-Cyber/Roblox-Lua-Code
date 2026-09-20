-- FE Toolkit - key screen
-- by Infinix-Cyber / local maze

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

local BASE = "https://raw.githubusercontent.com/Infinix-Cyber/Roblox-Lua-Code/main/FE-Toolkit/"
local CACHE = "maze_cache/"
local MODULES = CACHE .. "modules/"

if not isfolder(CACHE) then makefolder(CACHE) end
if not isfolder(MODULES) then makefolder(MODULES) end

local function getHWID()
    if gethwid then
        local ok, h = pcall(gethwid)
        if ok and h and #tostring(h) > 0 then return tostring(h) end
    end
    if syn and syn.get_hwid then
        local ok, h = pcall(syn.get_hwid)
        if ok and h and #tostring(h) > 0 then return tostring(h) end
    end
    local ok, h = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if ok and h and #tostring(h) > 0 then return tostring(h) end
    return "user_" .. tostring(LP.UserId)
end

local HWID = getHWID()

local function sha256(str)
    if crypt and crypt.hash then
        local ok, h = pcall(function() return crypt.hash(str, "sha256") end)
        if ok and h then return h end
    end
    if syn and syn.crypt and syn.crypt.hash then
        local ok, h = pcall(function() return syn.crypt.hash(str) end)
        if ok and h then return h end
    end
    local hash = 5381
    for i = 1, #str do
        hash = ((hash * 33) + string.byte(str, i)) % 4294967296
    end
    return string.format("%08x", hash)
end

local function fetchKeys()
    local ok, res = pcall(function()
        return game:HttpGet(BASE .. "data/keys.txt?t=" .. tostring(tick()), true)
    end)
    if not ok or not res then return {} end
    local keys = {}
    for line in res:gmatch("[^\r\n]+") do
        line = line:gsub("%s+", "")
        if #line > 0 and not line:match("^#") then
            keys[line] = true
        end
    end
    return keys
end

local function verify(inputKey)
    if not inputKey or #inputKey == 0 then
        return false, "empty key"
    end
    inputKey = inputKey:gsub("%s+", "")
    local hash = sha256(inputKey .. HWID)
    local keys = fetchKeys()
    if keys[hash] then
        return true, "ok"
    end
    return false, "invalid (" .. hash:sub(1, 8) .. "...)"
end

local function loadMain()
    local mainPath = MODULES .. "main.lua"
    if not isfile(mainPath) then
        return false, "main.lua missing"
    end
    local src = readfile(mainPath)
    local fn = loadstring(src)
    if not fn then return false, "main compile error" end
    local ok, err = pcall(fn)
    if not ok then return false, "main runtime: " .. tostring(err) end
    return true
end

local function buildKeyUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FE_Key_" .. tostring(math.random(1e4, 1e6))
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 200
    gui.Parent = (gethui and gethui()) or CoreGui

    local MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled
    local W = MOBILE and 340 or 320
    local H = MOBILE and 300 or 280

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, W, 0, H)
    main.Position = UDim2.new(0.5, -W/2, 0.5, -H/2)
    main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    main.BorderSizePixel = 0
    main.Active = true

    local mc = Instance.new("UICorner", main)
    mc.CornerRadius = UDim.new(0, 10)

    local ms = Instance.new("UIStroke", main)
    ms.Color = Color3.fromRGB(55, 55, 55)
    ms.Thickness = 1

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 44)
    title.Position = UDim2.new(0, 0, 0, 16)
    title.BackgroundTransparency = 1
    title.Text = "FE Toolkit"
    title.TextColor3 = Color3.fromRGB(240, 240, 240)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22

    local sub = Instance.new("TextLabel", main)
    sub.Size = UDim2.new(1, 0, 0, 18)
    sub.Position = UDim2.new(0, 0, 0, 46)
    sub.BackgroundTransparency = 1
    sub.Text = "by Infinix-Cyber  ·  local maze"
    sub.TextColor3 = Color3.fromRGB(120, 120, 120)
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 11

    local prompt = Instance.new("TextLabel", main)
    prompt.Size = UDim2.new(1, -40, 0, 16)
    prompt.Position = UDim2.new(0, 20, 0, 84)
    prompt.BackgroundTransparency = 1
    prompt.Text = "enter key:"
    prompt.TextColor3 = Color3.fromRGB(150, 150, 150)
    prompt.Font = Enum.Font.Gotham
    prompt.TextSize = 11
    prompt.TextXAlignment = Enum.TextXAlignment.Left

    local input = Instance.new("TextBox", main)
    input.Size = UDim2.new(1, -40, 0, 38)
    input.Position = UDim2.new(0, 20, 0, 104)
    input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = "MAZE-XXXX-XXXX"
    input.PlaceholderColor3 = Color3.fromRGB(70, 70, 70)
    input.TextColor3 = Color3.fromRGB(240, 240, 240)
    input.Font = Enum.Font.Code
    input.TextSize = 13
    input.ClearTextOnFocus = false
    local ic = Instance.new("UICorner", input)
    ic.CornerRadius = UDim.new(0, 6)

    local hwidBtn = Instance.new("TextButton", main)
    hwidBtn.Size = UDim2.new(1, -40, 0, 22)
    hwidBtn.Position = UDim2.new(0, 20, 0, 148)
    hwidBtn.BackgroundTransparency = 1
    hwidBtn.Text = "hwid: " .. HWID:sub(1, 18) .. "...  [ tap to copy ]"
    hwidBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
    hwidBtn.Font = Enum.Font.Code
    hwidBtn.TextSize = 10
    hwidBtn.TextXAlignment = Enum.TextXAlignment.Left

    hwidBtn.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(HWID) end
        hwidBtn.Text = "copied to clipboard"
        task.wait(2)
        hwidBtn.Text = "hwid: " .. HWID:sub(1, 18) .. "...  [ tap to copy ]"
    end)

    local verifyBtn = Instance.new("TextButton", main)
    verifyBtn.Size = UDim2.new(1, -40, 0, 44)
    verifyBtn.Position = UDim2.new(0, 20, 0, 178)
    verifyBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    verifyBtn.Text = "VERIFY"
    verifyBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
    verifyBtn.Font = Enum.Font.GothamBold
    verifyBtn.TextSize = 14
    verifyBtn.BorderSizePixel = 0
    local vc = Instance.new("UICorner", verifyBtn)
    vc.CornerRadius = UDim.new(0, 8)

    local statusLabel = Instance.new("TextLabel", main)
    statusLabel.Size = UDim2.new(1, -40, 0, 22)
    statusLabel.Position = UDim2.new(0, 20, 1, -30)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "waiting..."
    statusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left

    local drag, dStart, sPos
    main.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; dStart = inp.Position; sPos = main.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dStart
            main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)

    local busy = false
    verifyBtn.MouseButton1Click:Connect(function()
        if busy then return end
        busy = true
        statusLabel.Text = "checking..."
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

        task.spawn(function()
            local ok, reason = verify(input.Text)
            if ok then
                statusLabel.Text = "valid, loading..."
                statusLabel.TextColor3 = Color3.fromRGB(100, 220, 120)
                verifyBtn.BackgroundColor3 = Color3.fromRGB(100, 220, 120)
                task.wait(0.4)
                local loaded, err = loadMain()
                if loaded then
                    gui:Destroy()
                else
                    statusLabel.Text = tostring(err)
                    statusLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
                    verifyBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                    task.wait(1.5)
                    statusLabel.Text = "waiting..."
                    statusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
                end
            else
                statusLabel.Text = reason
                statusLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
                verifyBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                task.wait(1.5)
                statusLabel.Text = "waiting..."
                statusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
            end
            busy = false
        end)
    end)
end

buildKeyUI()
