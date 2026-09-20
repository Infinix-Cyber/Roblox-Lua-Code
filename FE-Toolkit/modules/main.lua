-- FE Toolkit - main
-- by Infinix-Cyber / local maze

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

local BASE = "https://raw.githubusercontent.com/Infinix-Cyber/Roblox-Lua-Code/main/FE-Toolkit/"
local CACHE = "maze_cache/"
local MODULES = CACHE .. "modules/"

local function loadModule(name)
    local path = MODULES .. name
    if not isfile(path) then
        warn("[FE] missing module: " .. name)
        return nil
    end
    local src = readfile(path)
    local fn = loadstring(src)
    if not fn then
        warn("[FE] compile error: " .. name)
        return nil
    end
    local ok, res = pcall(fn)
    if not ok then
        warn("[FE] runtime error in " .. name .. ": " .. tostring(res))
        return nil
    end
    return res
end

local UI = loadModule("ui.lua")
local Status = loadModule("status.lua")
local Logger = loadModule("logger.lua")
local Tuner = loadModule("tuner.lua")

if not UI or not Status then
    warn("[FE] critical modules missing")
    return
end

local T = UI.Theme
local MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled
local W = MOBILE and 360 or 340
local H = MOBILE and 500 or 480

local parent = (gethui and gethui()) or CoreGui
local root = Instance.new("ScreenGui")
root.Name = "FE_Toolkit_" .. tostring(math.random(1e4, 1e6))
root.ResetOnSpawn = false
root.IgnoreGuiInset = true
root.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
root.DisplayOrder = 100
root.Parent = parent

local main = Instance.new("Frame", root)
main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0.5, -W/2, 0.5, -H/2)
main.BackgroundColor3 = T.BG
main.BorderSizePixel = 0
main.Active = true
UI.corner(main, 10)
UI.stroke(main, T.Stroke, 1)

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = T.Panel
titleBar.BorderSizePixel = 0
titleBar.Active = true
UI.corner(titleBar, 10)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FE Toolkit  ·  local maze"
title.TextColor3 = T.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -64, 0.5, -14)
minBtn.BackgroundColor3 = T.Panel2
minBtn.Text = "−"
minBtn.TextColor3 = T.Text
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.BorderSizePixel = 0
minBtn.ZIndex = 2
UI.corner(minBtn, 6)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0.5, -14)
closeBtn.BackgroundColor3 = T.Red
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 2
UI.corner(closeBtn, 6)

UI.dragify(main, titleBar)

local tabsBar = Instance.new("Frame", main)
tabsBar.Size = UDim2.new(1, -16, 0, 34)
tabsBar.Position = UDim2.new(0, 8, 0, 46)
tabsBar.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabsBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -16, 1, -136)
content.Position = UDim2.new(0, 8, 0, 86)
content.BackgroundTransparency = 1
content.ClipsDescendants = true

local pages = {}
local tabButtons = {}
local activeTab

local function switchTab(name)
    if activeTab == name then return end
    activeTab = name
    for n, p in pairs(pages) do p.Visible = (n == name) end
    for n, b in pairs(tabButtons) do
        b.BackgroundColor3 = (n == name) and T.Accent or T.Panel2
        b.TextColor3 = (n == name) and T.BG or T.TextDim
    end
end

local function makeTab(name, label)
    local btn = Instance.new("TextButton", tabsBar)
    btn.Size = UDim2.new(0, 0, 1, 0)
    btn.AutomaticSize = Enum.AutomaticSize.X
    btn.BackgroundColor3 = T.Panel2
    btn.BorderSizePixel = 0
    btn.Text = "  " .. label .. "  "
    btn.TextColor3 = T.TextDim
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    UI.corner(btn, 6)

    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false

    pages[name] = page
    tabButtons[name] = btn
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
    return page
end

local statusBar = Instance.new("TextLabel", main)
statusBar.Size = UDim2.new(1, -16, 0, 24)
statusBar.Position = UDim2.new(0, 8, 1, -30)
statusBar.BackgroundColor3 = T.Panel2
statusBar.BorderSizePixel = 0
statusBar.Text = "  ready"
statusBar.TextColor3 = T.TextDim
statusBar.Font = Enum.Font.Code
statusBar.TextSize = 11
statusBar.TextXAlignment = Enum.TextXAlignment.Left
UI.corner(statusBar, 6)

local function setStatus(txt, col)
    statusBar.Text = "  " .. txt
    statusBar.TextColor3 = col or T.TextDim
end

local ball = Instance.new("TextButton", root)
ball.Size = UDim2.new(0, 60, 0, 60)
ball.Position = UDim2.new(0, 20, 0.5, -30)
ball.BackgroundColor3 = T.Accent
ball.Text = "FE"
ball.TextColor3 = T.BG
ball.Font = Enum.Font.GothamBold
ball.TextSize = 20
ball.BorderSizePixel = 0
ball.AutoButtonColor = false
UI.corner(ball, 30)
UI.stroke(ball, T.Accent2, 2)

local ballDrag, ballStart, ballStartPos, ballMoved = false, nil, nil, false
ball.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        ballDrag = true
        ballMoved = false
        ballStart = inp.Position
        ballStartPos = ball.Position
    end
end)
UIS.InputChanged:Connect(function(inp)
    if ballDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - ballStart
        if math.abs(d.X) + math.abs(d.Y) > 8 then ballMoved = true end
        ball.Position = UDim2.new(ballStartPos.X.Scale, ballStartPos.X.Offset + d.X, ballStartPos.Y.Scale, ballStartPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        if ballDrag and not ballMoved then main.Visible = not main.Visible end
        ballDrag = false
    end
end)

minBtn.MouseButton1Click:Connect(function() main.Visible = false end)
closeBtn.MouseButton1Click:Connect(function() root:Destroy() end)

local loggerPage = makeTab("logger", "Logger")

local filterRow = Instance.new("Frame", loggerPage)
filterRow.Size = UDim2.new(1, 0, 0, 62)
filterRow.BackgroundTransparency = 1

local function makeFilterToggle(x, y, w, label, default, onChange)
    local b = Instance.new("TextButton", filterRow)
    b.Size = UDim2.new(0, w, 0, 26)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = default and T.Accent or T.Panel2
    b.BorderSizePixel = 0
    b.Text = label
    b.TextColor3 = default and T.BG or T.TextDim
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    UI.corner(b, 5)
    local state = default
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and T.Accent or T.Panel2
        b.TextColor3 = state and T.BG or T.TextDim
        if onChange then onChange(state) end
    end)
    return b
end

makeFilterToggle(0, 0, 90, "Logger ON", true, function(s) Logger.Config.Enabled = s end)
makeFilterToggle(94, 0, 90, "Character", true, function(s) Logger.Config.Character = s end)
makeFilterToggle(188, 0, 80, "Joints", true, function(s) Logger.Config.Joints = s end)
makeFilterToggle(0, 30, 90, "Workspace", false, function(s) Logger.Config.Workspace = s end)
makeFilterToggle(94, 30, 90, "Remotes", false, function(s) Logger.Config.Remotes = s end)

local logScroll = Instance.new("ScrollingFrame", loggerPage)
logScroll.Size = UDim2.new(1, 0, 1, -118)
logScroll.Position = UDim2.new(0, 0, 0, 68)
logScroll.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
logScroll.BorderSizePixel = 0
logScroll.ScrollBarThickness = 4
logScroll.ScrollBarImageColor3 = T.Accent
logScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
logScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
UI.corner(logScroll, 6)

local logLayout = Instance.new("UIListLayout", logScroll)
logLayout.Padding = UDim.new(0, 1)

local logOrder = 0
local logLabels = {}
local MAX_LOG = 200

local function addLogLine(entry)
    logOrder = logOrder + 1
    local lbl = Instance.new("TextLabel", logScroll)
    lbl.Size = UDim2.new(1, -6, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.Text = entry.text
    lbl.TextColor3 = entry.color or T.Text
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.LayoutOrder = logOrder

    table.insert(logLabels, lbl)
    if #logLabels > MAX_LOG then
        local old = table.remove(logLabels, 1)
        if old then old:Destroy() end
    end
    task.defer(function()
        logScroll.CanvasPosition = Vector2.new(0, logLayout.AbsoluteContentSize.Y)
    end)
end

Logger.OnLine = addLogLine
if Logger.start then Logger.start() end

local clearBtn = Instance.new("TextButton", loggerPage)
clearBtn.Size = UDim2.new(0, 80, 0, 28)
clearBtn.Position = UDim2.new(1, -80, 1, -34)
clearBtn.BackgroundColor3 = T.Red
clearBtn.BorderSizePixel = 0
clearBtn.Text = "Clear"
clearBtn.TextColor3 = Color3.new(1,1,1)
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 12
UI.corner(clearBtn, 6)
clearBtn.MouseButton1Click:Connect(function()
    for _, l in ipairs(logLabels) do l:Destroy() end
    logLabels = {}
end)

local tunerPage = makeTab("tuner", "Hat Tuner")

local accDropdown = Instance.new("TextButton", tunerPage)
accDropdown.Size = UDim2.new(1, 0, 0, 32)
accDropdown.Position = UDim2.new(0, 0, 0, 4)
accDropdown.BackgroundColor3 = T.Panel2
accDropdown.BorderSizePixel = 0
accDropdown.Text = "  select accessory..."
accDropdown.TextColor3 = T.Text
accDropdown.Font = Enum.Font.GothamBold
accDropdown.TextSize = 12
accDropdown.TextXAlignment = Enum.TextXAlignment.Left
UI.corner(accDropdown, 6)

local accList = Instance.new("ScrollingFrame", tunerPage)
accList.Size = UDim2.new(1, 0, 0, 120)
accList.Position = UDim2.new(0, 0, 0, 40)
accList.BackgroundColor3 = T.Panel
accList.BorderSizePixel = 0
accList.ScrollBarThickness = 4
accList.Visible = false
accList.CanvasSize = UDim2.new(0, 0, 0, 0)
accList.AutomaticCanvasSize = Enum.AutomaticSize.Y
UI.corner(accList, 6)

local accLayout = Instance.new("UIListLayout", accList)
accLayout.Padding = UDim.new(0, 2)

local function refreshAccList()
    for _, c in ipairs(accList:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local list = Tuner.listAccessories()
    if #list == 0 then
        local empty = Instance.new("TextLabel", accList)
        empty.Size = UDim2.new(1, 0, 0, 30)
        empty.BackgroundTransparency = 1
        empty.Text = "  no accessories on character"
        empty.TextColor3 = T.TextDim
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 11
        empty.TextXAlignment = Enum.TextXAlignment.Left
        return
    end
    for i, acc in ipairs(list) do
        local b = Instance.new("TextButton", accList)
        b.Size = UDim2.new(1, 0, 0, 30)
        b.BackgroundColor3 = T.Panel2
        b.BorderSizePixel = 0
        b.Text = "  " .. acc.Name .. "  (" .. i .. ")"
        b.TextColor3 = T.Text
        b.Font = Enum.Font.Gotham
        b.TextSize = 12
        b.TextXAlignment = Enum.TextXAlignment.Left
        UI.corner(b, 4)
        b.MouseButton1Click:Connect(function()
            Tuner.selectAcc(acc)
            accDropdown.Text = "  " .. acc.Name
            accList.Visible = false
            setStatus("selected: " .. acc.Name, T.Text)
        end)
    end
end

accDropdown.MouseButton1Click:Connect(function()
    accList.Visible = not accList.Visible
    if accList.Visible then refreshAccList() end
end)

local function makeInputRow(parentFrame, y, label, getVal, setVal, step)
    local row = Instance.new("Frame", parentFrame)
    row.Size = UDim2.new(1, 0, 0, 30)
    row.Position = UDim2.new(0, 0, 0, y)
    row.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0, 50, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = T.TextDim
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local minus = Instance.new("TextButton", row)
    minus.Size = UDim2.new(0, 30, 0, 26)
    minus.Position = UDim2.new(0, 54, 0.5, -13)
    minus.BackgroundColor3 = T.Panel2
    minus.BorderSizePixel = 0
    minus.Text = "-"
    minus.TextColor3 = T.Text
    minus.Font = Enum.Font.GothamBold
    minus.TextSize = 16
    UI.corner(minus, 5)

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 90, 0, 26)
    box.Position = UDim2.new(0, 88, 0.5, -13)
    box.BackgroundColor3 = T.Input
    box.BorderSizePixel = 0
    box.Text = string.format("%.2f", getVal())
    box.TextColor3 = T.Text
    box.Font = Enum.Font.Code
    box.TextSize = 12
    UI.corner(box, 5)

    local plus = Instance.new("TextButton", row)
    plus.Size = UDim2.new(0, 30, 0, 26)
    plus.Position = UDim2.new(0, 182, 0.5, -13)
    plus.BackgroundColor3 = T.Panel2
    plus.BorderSizePixel = 0
    plus.Text = "+"
    plus.TextColor3 = T.Text
    plus.Font = Enum.Font.GothamBold
    plus.TextSize = 16
    UI.corner(plus, 5)

    local function apply(v)
        setVal(v)
        box.Text = string.format("%.2f", v)
        Tuner.applyPreview()
    end

    minus.MouseButton1Click:Connect(function() apply(getVal() - step) end)
    plus.MouseButton1Click:Connect(function() apply(getVal() + step) end)
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then apply(n) else box.Text = string.format("%.2f", getVal()) end
    end)

    return { setText = function(v) box.Text = string.format("%.2f", v) end }
end

local rowY = 170

local posHeader = Instance.new("TextLabel", tunerPage)
posHeader.Size = UDim2.new(1, 0, 0, 20)
posHeader.Position = UDim2.new(0, 0, 0, rowY)
posHeader.BackgroundTransparency = 1
posHeader.Text = "Position (studs)"
posHeader.TextColor3 = T.Accent2
posHeader.Font = Enum.Font.GothamBold
posHeader.TextSize = 11
posHeader.TextXAlignment = Enum.TextXAlignment.Left
rowY = rowY + 22

local rowX_ = makeInputRow(tunerPage, rowY, "X:", function() return Tuner.OffX end, function(v) Tuner.OffX = v end, 0.1); rowY = rowY + 32
local rowY_ = makeInputRow(tunerPage, rowY, "Y:", function() return Tuner.OffY end, function(v) Tuner.OffY = v end, 0.1); rowY = rowY + 32
local rowZ_ = makeInputRow(tunerPage, rowY, "Z:", function() return Tuner.OffZ end, function(v) Tuner.OffZ = v end, 0.1); rowY = rowY + 32

rowY = rowY + 4

local rotHeader = Instance.new("TextLabel", tunerPage)
rotHeader.Size = UDim2.new(1, 0, 0, 20)
rotHeader.Position = UDim2.new(0, 0, 0, rowY)
rotHeader.BackgroundTransparency = 1
rotHeader.Text = "Rotation (degrees)"
rotHeader.TextColor3 = T.Accent2
rotHeader.Font = Enum.Font.GothamBold
rotHeader.TextSize = 11
rotHeader.TextXAlignment = Enum.TextXAlignment.Left
rowY = rowY + 22

local rowRX_ = makeInputRow(tunerPage, rowY, "RX:", function() return Tuner.RotX end, function(v) Tuner.RotX = v end, 5); rowY = rowY + 32
local rowRY_ = makeInputRow(tunerPage, rowY, "RY:", function() return Tuner.RotY end, function(v) Tuner.RotY = v end, 5); rowY = rowY + 32
local rowRZ_ = makeInputRow(tunerPage, rowY, "RZ:", function() return Tuner.RotZ end, function(v) Tuner.RotZ = v end, 5); rowY = rowY + 36

local actions = Instance.new("Frame", tunerPage)
actions.Size = UDim2.new(1, 0, 0, 34)
actions.Position = UDim2.new(0, 0, 0, rowY)
actions.BackgroundTransparency = 1

local function makeActionBtn(x, w, label, color, cb)
    local b = Instance.new("TextButton", actions)
    b.Size = UDim2.new(0, w, 1, 0)
    b.Position = UDim2.new(0, x, 0, 0)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = label
    b.TextColor3 = color == T.Accent and T.BG or Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    UI.corner(b, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

local BTN_W = (W - 16 - 8) / 3
makeActionBtn(0, BTN_W - 4, "Reset", T.Orange, function()
    Tuner.reset()
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    setStatus("preview reset", T.TextDim)
end)
makeActionBtn(BTN_W + 2, BTN_W - 4, "Cancel", T.Red, function()
    Tuner.cancel()
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    setStatus("cancelled", T.TextDim)
end)
makeActionBtn((BTN_W + 2) * 2, BTN_W - 4, "Commit", T.Green, function()
    Tuner.commit()
    setStatus("committed", T.Green)
end)

local aboutPage = makeTab("about", "About")

local aboutTitle = Instance.new("TextLabel", aboutPage)
aboutTitle.Size = UDim2.new(1, 0, 0, 30)
aboutTitle.Position = UDim2.new(0, 0, 0, 8)
aboutTitle.BackgroundTransparency = 1
aboutTitle.Text = "FE Toolkit"
aboutTitle.TextColor3 = T.Text
aboutTitle.Font = Enum.Font.GothamBold
aboutTitle.TextSize = 18
aboutTitle.TextXAlignment = Enum.TextXAlignment.Left

local aboutBy = Instance.new("TextLabel", aboutPage)
aboutBy.Size = UDim2.new(1, 0, 0, 20)
aboutBy.Position = UDim2.new(0, 0, 0, 40)
aboutBy.BackgroundTransparency = 1
aboutBy.Text = "by Infinix-Cyber  ·  local maze"
aboutBy.TextColor3 = T.TextDim
aboutBy.Font = Enum.Font.Gotham
aboutBy.TextSize = 12
aboutBy.TextXAlignment = Enum.TextXAlignment.Left

local aboutInfo = Instance.new("TextLabel", aboutPage)
aboutInfo.Size = UDim2.new(1, 0, 0, 0)
aboutInfo.Position = UDim2.new(0, 0, 0, 80)
aboutInfo.AutomaticSize = Enum.AutomaticSize.Y
aboutInfo.BackgroundTransparency = 1
aboutInfo.Text = "FE Toolkit - status check, logger, hat tuner.\n\nEvery 30s the status refreshes from data/status.txt on GitHub.\n\nTabs:\n  Logger - live log of character/joint changes\n  Hat Tuner - preview, cancel, commit accessory offset\n  About - this screen"
aboutInfo.TextColor3 = T.Text
aboutInfo.Font = Enum.Font.Gotham
aboutInfo.TextSize = 12
aboutInfo.TextWrapped = true
aboutInfo.TextXAlignment = Enum.TextXAlignment.Left

Status.onChange(function(state, info)
    local label = info and info.label or state
    setStatus(label, info and info.color or T.TextDim)
end)

if Status.check then Status.check() end

switchTab("logger")

print("[FE Toolkit] main loaded.")
