-- FE Profiler v1.0 - Remote + Script + GUI spy
-- by Infinix-Cyber / local maze

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local RS = game:GetService("ReplicatedStorage")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local LP = Players.LocalPlayer

local API = {
    getscriptbytecode = type(getscriptbytecode) == "function",
    getsenv           = type(getsenv) == "function",
    getrawmetatable   = type(getrawmetatable) == "function",
    hookfunction      = type(hookfunction) == "function",
    hookmetamethod    = type(hookmetamethod) == "function",
    newcclosure       = type(newcclosure) == "function",
    checkcaller       = type(checkcaller) == "function",
    getconnections    = type(getconnections) == "function",
    getcallbackvalue  = type(getcallbackvalue) == "function",
    getloadedmodules  = type(getloadedmodules) == "function",
    debug_getinfo     = type(debug.getinfo) == "function",
    debug_getupvalue  = type(debug.getupvalue) == "function",
    debug_getlocal    = type(debug.getlocal) == "function",
    setclipboard      = type(setclipboard) == "function",
}

local State = {
    RemoteLog     = {},
    ClickLog      = {},
    ScriptList    = {},
    GuiTree       = {},
    HooksActive   = false,
    LogRemote     = true,
    LogClick      = true,
    LogServer     = true,
    MaxLog        = 200,
    StartTime     = tick(),
    RemoteCallMap = {},
    TrackRemote   = true,
}

local Connections = {}

local function safeNewc(fn)
    if API.newcclosure then
        return newcclosure(fn)
    end
    return fn
end

local function fmt(t, depth)
    depth = depth or 0
    if depth > 3 then return "..." end
    if t == nil then return "nil" end
    local ty = typeof(t)
    if ty == "string" then
        if #t > 80 then return '"' .. t:sub(1, 77) .. '..."' end
        return '"' .. t .. '"'
    elseif ty == "number" then
        return tostring(t)
    elseif ty == "boolean" then
        return tostring(t)
    elseif ty == "Instance" then
        return t.ClassName .. "(" .. t.Name .. ")"
    elseif ty == "Vector3" then
        return string.format("Vector3(%.1f,%.1f,%.1f)", t.X, t.Y, t.Z)
    elseif ty == "CFrame" then
        return "CFrame(...)"
    elseif ty == "table" then
        local parts = {}
        local count = 0
        for k, v in pairs(t) do
            count = count + 1
            if count > 8 then
                table.insert(parts, "...")
                break
            end
            local key = typeof(k) == "string" and k or tostring(k)
            table.insert(parts, key .. "=" .. fmt(v, depth + 1))
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    end
    return ty
end

local function pushRemoteLog(entry)
    table.insert(State.RemoteLog, 1, entry)
    while #State.RemoteLog > State.MaxLog do
        table.remove(State.RemoteLog)
    end
    if State.OnRemoteLog then
        pcall(State.OnRemoteLog, entry)
    end
end

local function pushClickLog(entry)
    table.insert(State.ClickLog, 1, entry)
    while #State.ClickLog > State.MaxLog do
        table.remove(State.ClickLog)
    end
    if State.OnClickLog then
        pcall(State.OnClickLog, entry)
    end
end

local function timestamp()
    local t = tick() - State.StartTime
    local mins = math.floor(t / 60)
    local secs = math.floor(t % 60)
    local ms = math.floor((t % 1) * 100)
    return string.format("%02d:%02d.%02d", mins, secs, ms)
end

local function shortPath(inst)
    if not inst then return "nil" end
    local full = inst:GetFullName()
    if #full > 55 then
        return "..." .. full:sub(#full - 51)
    end
    return full
end

local function hookRemotes()
    if State.HooksActive then return end
    if not API.getrawmetatable or not API.hookmetamethod then
        warn("[FE] no metatable hook - remote spy disabled")
        return
    end

    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = safeNewc(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" then
            if State.LogRemote then
                local args = {...}
                local argStrings = {}
                for i, v in ipairs(args) do
                    table.insert(argStrings, "[" .. i .. "] " .. fmt(v))
                end
                local stack = ""
                if API.debug_getinfo then
                    local info = debug.getinfo(2, "Sl")
                    if info then
                        stack = (info.short_src or "?") .. ":" .. (info.currentline or 0)
                    end
                end
                pushRemoteLog({
                    time = timestamp(),
                    kind = "FireServer",
                    remote = shortPath(self),
                    args = table.concat(argStrings, ", "),
                    argCount = #args,
                    stack = stack,
                })
                if State.TrackRemote and self then
                    State.RemoteCallMap[self] = tick()
                end
            end
        elseif method == "InvokeServer" then
            if State.LogRemote then
                local args = {...}
                local argStrings = {}
                for i, v in ipairs(args) do
                    table.insert(argStrings, "[" .. i .. "] " .. fmt(v))
                end
                pushRemoteLog({
                    time = timestamp(),
                    kind = "InvokeServer",
                    remote = shortPath(self),
                    args = table.concat(argStrings, ", "),
                    argCount = #args,
                })
            end
        end
        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
    State.HooksActive = true
    print("[FE] remote hook installed")
end

local function watchRemoteEvents()
    local function hookRemote(remote)
        if not remote:IsA("RemoteEvent") then return end
        if remote:GetAttribute("__FE_Hooked") then return end
        remote:SetAttribute("__FE_Hooked", true)

        local conn = remote.OnClientEvent:Connect(function(...)
            if not State.LogRemote or not State.LogServer then return end
            local args = {...}
            local argStrings = {}
            for i, v in ipairs(args) do
                table.insert(argStrings, "[" .. i .. "] " .. fmt(v))
            end
            pushRemoteLog({
                time = timestamp(),
                kind = "OnClientEvent",
                remote = shortPath(remote),
                args = table.concat(argStrings, ", "),
                argCount = #args,
            })
        end)
        table.insert(Connections, conn)
    end

    for _, d in ipairs(RS:GetDescendants()) do
        pcall(hookRemote, d)
    end

    local conn = RS.DescendantAdded:Connect(function(d)
        task.wait(0.1)
        pcall(hookRemote, d)
    end)
    table.insert(Connections, conn)
end

local function trackClicks()
    local globalConn = UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if not State.LogClick then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
           and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local pos = input.Position
        local guiHit = nil
        pcall(function()
            local ray = UIS:GetMouseLocation()
            for _, layer in ipairs({CoreGui, PlayerGui}) do
                for _, d in ipairs(layer:GetDescendants()) do
                    if d:IsA("GuiObject") and d.Visible and d.Active then
                        local topLeft = d.AbsolutePosition
                        local size = d.AbsoluteSize
                        if pos.X >= topLeft.X and pos.X <= topLeft.X + size.X
                           and pos.Y >= topLeft.Y and pos.Y <= topLeft.Y + size.Y then
                            if d:IsA("TextButton") or d:IsA("ImageButton") or d:IsA("TextLabel") then
                                guiHit = d
                                break
                            end
                        end
                    end
                end
                if guiHit then break end
            end
        end)

        local entry = {
            time = timestamp(),
            kind = "click",
            pos = string.format("(%.0f, %.0f)", pos.X, pos.Y),
            gui = guiHit and (guiHit.ClassName .. "(" .. guiHit.Name .. ")") or "world",
            guiFull = guiHit and shortPath(guiHit) or "",
        }
        pushClickLog(entry)

        if State.TrackRemote and guiHit then
            task.delay(0.2, function()
                local newest = nil
                local newestTime = 0
                for remote, t in pairs(State.RemoteCallMap) do
                    if t > newestTime then
                        newestTime = t
                        newest = remote
                    end
                end
                if newest and (tick() - newestTime) < 0.3 then
                    entry.triggeredRemote = shortPath(newest)
                    if State.OnClickLog then
                        pcall(State.OnClickLog, entry)
                    end
                end
            end)
        end
    end)
    table.insert(Connections, globalConn)
end

local function safeGetCode(script)
    if API.getscriptbytecode then
        local ok, res = pcall(getscriptbytecode, script)
        if ok and res and #tostring(res) > 0 then
            return tostring(res), "getscriptbytecode"
        end
    end
    if API.getsenv then
        local ok, res = pcall(getsenv, script)
        if ok and res then
            local parts = {}
            for k, v in pairs(res) do
                if type(k) == "string" and type(v) ~= "function" then
                    table.insert(parts, k .. " = " .. tostring(v))
                end
            end
            return table.concat(parts, "\n"), "getsenv"
        end
    end
    return nil, "unavailable"
end

local function scanScripts()
    State.ScriptList = {}
    for _, s in ipairs(game:GetDescendants()) do
        if s:IsA("LocalScript") or s:IsA("ModuleScript") then
            table.insert(State.ScriptList, s)
        end
    end
    if State.OnScriptsScanned then
        pcall(State.OnScriptsScanned, State.ScriptList)
    end
end

local function uiDumpRecursive(inst, depth, out, parentVar)
    if depth > 10 then return end
    if not inst:IsA("GuiObject") and not inst:IsA("LayerCollector") then
        if not inst:IsA("ScreenGui") and not inst:IsA("Folder") and not inst:IsA("UIBase") then return end
    end
    local varName = "__v" .. tostring(#out) 
    local lines = {}
    local cls = inst.ClassName
    table.insert(lines, varName .. ' = Instance.new("' .. cls .. '")')
    table.insert(lines, varName .. '.Name = "' .. inst.Name .. '"')
    if inst:IsA("GuiObject") then
        local size = inst.Size
        local pos = inst.Position
        table.insert(lines, string.format('%s.Size = UDim2.new(%.3f, %.1f, %.3f, %.1f)', varName, size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset))
        table.insert(lines, string.format('%s.Position = UDim2.new(%.3f, %.1f, %.3f, %.1f)', varName, pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset))
        table.insert(lines, varName .. '.BackgroundColor3 = Color3.fromRGB(' .. math.floor(inst.BackgroundColor3.R*255) .. ',' .. math.floor(inst.BackgroundColor3.G*255) .. ',' .. math.floor(inst.BackgroundColor3.B*255) .. ')')
        table.insert(lines, varName .. '.BackgroundTransparency = ' .. string.format("%.3f", inst.BackgroundTransparency))
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            table.insert(lines, varName .. '.Text = [[' .. inst.Text .. ']]')
            table.insert(lines, varName .. '.TextColor3 = Color3.fromRGB(' .. math.floor(inst.TextColor3.R*255) .. ',' .. math.floor(inst.TextColor3.G*255) .. ',' .. math.floor(inst.TextColor3.B*255) .. ')')
            table.insert(lines, varName .. '.TextSize = ' .. tostring(inst.TextSize))
            table.insert(lines, varName .. '.Font = Enum.Font.' .. tostring(inst.Font))
        end
    end
    if parentVar then
        table.insert(lines, varName .. '.Parent = ' .. parentVar)
    end
    table.insert(out, table.concat(lines, "\n"))

    for _, child in ipairs(inst:GetChildren()) do
        if child:IsA("GuiObject") or child:IsA("Folder") or child:IsA("UIBase") then
            uiDumpRecursive(child, depth + 1, out, varName)
        end
    end
end

local function dumpGui(root)
    local out = {}
    local name = "__root" .. tostring(math.random(100, 999))
    table.insert(out, name .. ' = Instance.new("' .. root.ClassName .. '")')
    table.insert(out, name .. '.Name = "' .. root.Name .. '"')
    if root:IsA("ScreenGui") then
        table.insert(out, name .. '.ResetOnSpawn = ' .. tostring(root.ResetOnSpawn))
    end
    for _, child in ipairs(root:GetChildren()) do
        if child:IsA("GuiObject") or child:IsA("Folder") or child:IsA("UIBase") then
            uiDumpRecursive(child, 0, out, name)
        end
    end
    return "local " .. name .. ' = nil\n' .. table.concat(out, "\n\n")
end

State.hookRemotes = hookRemotes
State.watchRemoteEvents = watchRemoteEvents
State.trackClicks = trackClicks
State.scanScripts = scanScripts
State.dumpGui = dumpGui
State.safeGetCode = safeGetCode
State.fmt = fmt
State.API = API
State.timestamp = timestamp
State.shortPath = shortPath
State.safeNewc = safeNewc
State.Connections = Connections
-- ═══════════════════════════════════════════════════════
-- THEME + HELPERS
-- ═══════════════════════════════════════════════════════

local T = {
    BG1 = Color3.fromRGB(10, 12, 20),
    BG2 = Color3.fromRGB(18, 22, 36),
    Panel = Color3.fromRGB(22, 26, 40),
    Panel2 = Color3.fromRGB(30, 36, 52),
    Input = Color3.fromRGB(14, 16, 26),
    Accent = Color3.fromRGB(140, 190, 255),
    Accent2 = Color3.fromRGB(90, 150, 230),
    Accent3 = Color3.fromRGB(190, 220, 255),
    Text = Color3.fromRGB(240, 244, 250),
    TextDim = Color3.fromRGB(150, 160, 180),
    TextMute = Color3.fromRGB(100, 110, 130),
    Green = Color3.fromRGB(80, 210, 130),
    Red = Color3.fromRGB(230, 90, 100),
    Orange = Color3.fromRGB(230, 170, 80),
    Purple = Color3.fromRGB(170, 100, 240),
    Snow = Color3.fromRGB(255, 255, 255),
    Stroke = Color3.fromRGB(50, 58, 78),
    StrokeHi = Color3.fromRGB(110, 130, 170),
}

local function corner(inst, r)
    local c = Instance.new("UICorner", inst)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end

local function stroke(inst, col, th, trans)
    local s = Instance.new("UIStroke", inst)
    s.Color = col or T.Stroke
    s.Thickness = th or 1
    if trans then s.Transparency = trans end
    return s
end

local function gradient(inst, c1, c2, rot)
    local g = Instance.new("UIGradient", inst)
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 90
    return g
end

local function dragify(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local function animate(inst, props, time, style)
    local ti = TweenInfo.new(time or 0.25, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tw = TweenService:Create(inst, ti, props)
    tw:Play()
    return tw
end

-- ═══════════════════════════════════════════════════════
-- ROOT
-- ═══════════════════════════════════════════════════════

local parent = (gethui and gethui()) or CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "FE_Profiler_" .. tostring(math.random(1e4, 1e6))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = parent

local MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled
local W = MOBILE and 340 or 380
local H = MOBILE and 500 or 520

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, W, 0, 0)
main.Position = UDim2.new(0, 24, 0.5, -H/2)
main.BackgroundColor3 = T.BG1
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
corner(main, 16)
gradient(main, T.BG2, T.BG1, 90)
stroke(main, T.StrokeHi, 1.2, 0.3)

-- ═══════════════════════════════════════════════════════
-- SNOW
-- ═══════════════════════════════════════════════════════

local snowFrame = Instance.new("Frame", main)
snowFrame.Name = "Snow"
snowFrame.Size = UDim2.new(1, 0, 1, 0)
snowFrame.BackgroundTransparency = 1
snowFrame.ClipsDescendants = true
snowFrame.ZIndex = 0

local snowRunning = true
task.spawn(function()
    while gui.Parent and snowRunning do
        local flake = Instance.new("Frame", snowFrame)
        flake.BackgroundColor3 = T.Snow
        flake.BackgroundTransparency = math.random(60, 90) / 100
        flake.BorderSizePixel = 0
        local size = math.random(2, 4)
        flake.Size = UDim2.new(0, size, 0, size)
        corner(flake, size)
        flake.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.05, 0)
        flake.ZIndex = 0

        local life = math.random(5, 9)
        local swing = math.random(-20, 20) / 1000
        local tw = TweenService:Create(flake,
            TweenInfo.new(life, Enum.EasingStyle.Linear),
            { Position = UDim2.new(flake.Position.X.Scale + swing, 0, 1.05, 0) })
        tw:Play()
        tw.Completed:Connect(function() flake:Destroy() end)

        task.wait(math.random(15, 50) / 100)
    end
end)

-- ═══════════════════════════════════════════════════════
-- TITLE BAR
-- ═══════════════════════════════════════════════════════

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 42)
titleBar.BackgroundColor3 = T.Panel
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.ZIndex = 2
corner(titleBar, 16)
gradient(titleBar, T.Panel2, T.Panel, 90)

local barLine = Instance.new("Frame", titleBar)
barLine.Size = UDim2.new(1, 0, 0, 1)
barLine.Position = UDim2.new(0, 0, 1, -1)
barLine.BackgroundColor3 = T.StrokeHi
barLine.BorderSizePixel = 0
barLine.BackgroundTransparency = 0.5
barLine.ZIndex = 2

local accentDot = Instance.new("Frame", titleBar)
accentDot.Size = UDim2.new(0, 10, 0, 10)
accentDot.Position = UDim2.new(0, 14, 0.5, -5)
accentDot.BackgroundColor3 = T.Accent
accentDot.BorderSizePixel = 0
accentDot.ZIndex = 3
corner(accentDot, 5)
stroke(accentDot, T.Accent3, 1.5, 0)

local dotPulse = Instance.new("Frame", accentDot)
dotPulse.Size = UDim2.new(1, 0, 1, 0)
dotPulse.BackgroundColor3 = T.Accent3
dotPulse.BackgroundTransparency = 0.7
dotPulse.BorderSizePixel = 0
corner(dotPulse, 5)
dotPulse.ZIndex = 3
task.spawn(function()
    while gui.Parent do
        animate(dotPulse, {Size = UDim2.new(2.4, 0, 2.4, 0), BackgroundTransparency = 1}, 1.2, Enum.EasingStyle.Quad)
        task.wait(1.2)
        dotPulse.Size = UDim2.new(1, 0, 1, 0)
        dotPulse.BackgroundTransparency = 0.7
    end
end)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 32, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FE PROFILER"
title.TextColor3 = T.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3

local titleVer = Instance.new("TextLabel", titleBar)
titleVer.Size = UDim2.new(0, 45, 1, 0)
titleVer.Position = UDim2.new(1, -82, 0, 0)
titleVer.BackgroundTransparency = 1
titleVer.Text = "v1.0"
titleVer.TextColor3 = T.Accent2
titleVer.Font = Enum.Font.Code
titleVer.TextSize = 10
titleVer.TextXAlignment = Enum.TextXAlignment.Right
titleVer.ZIndex = 3

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -62, 0.5, -13)
minBtn.BackgroundColor3 = T.Panel2
minBtn.Text = "_"
minBtn.TextColor3 = T.Text
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 12
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false
minBtn.ZIndex = 3
corner(minBtn, 8)
stroke(minBtn, T.Stroke, 1)
minBtn.MouseEnter:Connect(function() animate(minBtn, {BackgroundColor3 = T.Accent2}, 0.15) end)
minBtn.MouseLeave:Connect(function() animate(minBtn, {BackgroundColor3 = T.Panel2}, 0.15) end)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
closeBtn.BackgroundColor3 = T.Panel2
closeBtn.Text = "X"
closeBtn.TextColor3 = T.Text
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 3
corner(closeBtn, 8)
stroke(closeBtn, T.Stroke, 1)
closeBtn.MouseEnter:Connect(function() animate(closeBtn, {BackgroundColor3 = T.Red}, 0.15) end)
closeBtn.MouseLeave:Connect(function() animate(closeBtn, {BackgroundColor3 = T.Panel2}, 0.15) end)

dragify(main, titleBar)

-- ═══════════════════════════════════════════════════════
-- TABS BAR
-- ═══════════════════════════════════════════════════════

local tabsBar = Instance.new("Frame", main)
tabsBar.Size = UDim2.new(1, -24, 0, 32)
tabsBar.Position = UDim2.new(0, 12, 0, 50)
tabsBar.BackgroundTransparency = 1
tabsBar.ZIndex = 2

local tabsLayout = Instance.new("UIListLayout", tabsBar)
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.Padding = UDim.new(0, 4)

local pages = {}
local tabBtns = {}
local activeTab = nil

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -24, 1, -160)
content.Position = UDim2.new(0, 12, 0, 88)
content.BackgroundTransparency = 1
content.ClipsDescendants = true
content.ZIndex = 2

local function switchTab(name)
    if activeTab == name then return end
    activeTab = name
    for n, p in pairs(pages) do p.Visible = (n == name) end
    for n, b in pairs(tabBtns) do
        b.BackgroundColor3 = (n == name) and T.Accent2 or T.Panel2
        b.TextColor3 = (n == name) and Color3.new(1,1,1) or T.TextDim
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
    btn.TextSize = 11
    btn.AutoButtonColor = false
    corner(btn, 8)
    stroke(btn, T.Stroke, 1)

    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ZIndex = 2

    pages[name] = page
    tabBtns[name] = btn
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
    return page
end

-- ═══════════════════════════════════════════════════════
-- LOGGER TAB
-- ═══════════════════════════════════════════════════════

local loggerPage = makeTab("logger", "Logger")

local filterRow = Instance.new("Frame", loggerPage)
filterRow.Size = UDim2.new(1, 0, 0, 60)
filterRow.BackgroundTransparency = 1

local function makeFilterToggle(x, y, w, label, default, onChange)
    local b = Instance.new("TextButton", filterRow)
    b.Size = UDim2.new(0, w, 0, 26)
    b.Position = UDim2.new(0, x, 0, y)
    b.BackgroundColor3 = default and T.Accent2 or T.Panel2
    b.BorderSizePixel = 0
    b.Text = label
    b.TextColor3 = default and Color3.new(1,1,1) or T.TextDim
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.AutoButtonColor = false
    corner(b, 6)
    stroke(b, T.Stroke, 1)
    local state = default
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and T.Accent2 or T.Panel2
        b.TextColor3 = state and Color3.new(1,1,1) or T.TextDim
        if onChange then onChange(state) end
    end)
    return b
end

makeFilterToggle(0, 0, 90, "FireServer", true, function(s) State.LogRemote = s end)
makeFilterToggle(94, 0, 90, "OnClient", true, function(s) State.LogServer = s end)
makeFilterToggle(188, 0, 90, "Clicks", true, function(s) State.LogClick = s end)
makeFilterToggle(0, 30, 90, "Track Remotes", true, function(s) State.TrackRemote = s end)

local clearBtn = Instance.new("TextButton", filterRow)
clearBtn.Size = UDim2.new(0, 80, 0, 26)
clearBtn.Position = UDim2.new(1, -80, 0, 30)
clearBtn.BackgroundColor3 = T.Red
clearBtn.BorderSizePixel = 0
clearBtn.Text = "Clear"
clearBtn.TextColor3 = Color3.new(1,1,1)
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 10
clearBtn.AutoButtonColor = false
corner(clearBtn, 6)
stroke(clearBtn, T.Red, 1)

local logScroll = Instance.new("ScrollingFrame", loggerPage)
logScroll.Size = UDim2.new(1, 0, 1, -68)
logScroll.Position = UDim2.new(0, 0, 0, 66)
logScroll.BackgroundColor3 = T.Input
logScroll.BorderSizePixel = 0
logScroll.ScrollBarThickness = 4
logScroll.ScrollBarImageColor3 = T.Accent
logScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
logScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
corner(logScroll, 8)
stroke(logScroll, T.Stroke, 1)

local logLayout = Instance.new("UIListLayout", logScroll)
logLayout.Padding = UDim.new(0, 3)
local logPad = Instance.new("UIPadding", logScroll)
logPad.PaddingTop = UDim.new(0, 6)
logPad.PaddingBottom = UDim.new(0, 6)
logPad.PaddingLeft = UDim.new(0, 6)
logPad.PaddingRight = UDim.new(0, 6)

local logOrder = 0
local logLines = {}

local function makeLogLine(entry)
    logOrder = logOrder + 1
    local line = Instance.new("TextButton", logScroll)
    line.Size = UDim2.new(1, 0, 0, 0)
    line.AutomaticSize = Enum.AutomaticSize.Y
    line.BackgroundColor3 = T.Panel
    line.BackgroundTransparency = 0.3
    line.BorderSizePixel = 0
    line.Text = ""
    line.AutoButtonColor = false
    line.LayoutOrder = logOrder
    corner(line, 6)

    local innerPad = Instance.new("UIPadding", line)
    innerPad.PaddingTop = UDim.new(0, 5)
    innerPad.PaddingBottom = UDim.new(0, 5)
    innerPad.PaddingLeft = UDim.new(0, 8)
    innerPad.PaddingRight = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel", line)
    lbl.Size = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.Text = ""
    lbl.TextColor3 = T.Text
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true

    local color = T.Text
    local prefix = ""
    if entry.kind == "FireServer" then color = T.Accent; prefix = "> " 
    elseif entry.kind == "InvokeServer" then color = T.Purple; prefix = ">> "
    elseif entry.kind == "OnClientEvent" then color = T.Green; prefix = "< "
    elseif entry.kind == "click" then color = T.Orange; prefix = "* "
    end

    local txt = "[" .. entry.time .. "] " .. prefix .. entry.kind .. "\n"
    txt = txt .. "  " .. (entry.remote or entry.gui or "?") .. "\n"
    if entry.args and #entry.args > 0 then
        txt = txt .. "  args: " .. entry.args .. "\n"
    end
    if entry.stack and #entry.stack > 0 then
        txt = txt .. "  stack: " .. entry.stack .. "\n"
    end
    if entry.triggeredRemote then
        txt = txt .. "  -> probably: " .. entry.triggeredRemote .. "\n"
    end

    lbl.Text = txt
    lbl.TextColor3 = color

    line.MouseButton1Click:Connect(function()
        local copy = entry.time .. " " .. entry.kind .. " " .. (entry.remote or entry.gui or "")
        if entry.args then copy = copy .. " | " .. entry.args end
        if entry.stack then copy = copy .. " | " .. entry.stack end
        if API.setclipboard then
            setclipboard(copy)
            local orig = line.BackgroundColor3
            line.BackgroundColor3 = T.Green
            task.wait(0.15)
            line.BackgroundColor3 = orig
        end
    end)

    table.insert(logLines, line)
    while #logLines > State.MaxLog do
        local old = table.remove(logLines, 1)
        if old then old:Destroy() end
    end

    task.defer(function()
        logScroll.CanvasPosition = Vector2.new(0, logLayout.AbsoluteContentSize.Y)
    end)
end

State.OnRemoteLog = makeLogLine
State.OnClickLog = makeLogLine

clearBtn.MouseButton1Click:Connect(function()
    for _, l in ipairs(logLines) do l:Destroy() end
    logLines = {}
    State.RemoteLog = {}
    State.ClickLog = {}
end)
-- ═══════════════════════════════════════════════════════
-- SCRIPTS TAB
-- ═══════════════════════════════════════════════════════

local scriptsPage = makeTab("scripts", "Scripts")

local scriptsTop = Instance.new("Frame", scriptsPage)
scriptsTop.Size = UDim2.new(1, 0, 0, 30)
scriptsTop.BackgroundTransparency = 1

local scanScriptsBtn = Instance.new("TextButton", scriptsTop)
scanScriptsBtn.Size = UDim2.new(0, 130, 1, 0)
scanScriptsBtn.Position = UDim2.new(0, 0, 0, 0)
scanScriptsBtn.BackgroundColor3 = T.Accent2
scanScriptsBtn.BorderSizePixel = 0
scanScriptsBtn.Text = "SCAN SCRIPTS"
scanScriptsBtn.TextColor3 = Color3.new(1,1,1)
scanScriptsBtn.Font = Enum.Font.GothamBold
scanScriptsBtn.TextSize = 11
scanScriptsBtn.AutoButtonColor = false
corner(scanScriptsBtn, 6)
stroke(scanScriptsBtn, T.Accent, 1.5, 0.3)

local copyAllScriptsBtn = Instance.new("TextButton", scriptsTop)
copyAllScriptsBtn.Size = UDim2.new(0, 130, 1, 0)
copyAllScriptsBtn.Position = UDim2.new(0, 136, 0, 0)
copyAllScriptsBtn.BackgroundColor3 = T.Purple
copyAllScriptsBtn.BorderSizePixel = 0
copyAllScriptsBtn.Text = "COPY ALL NAMES"
copyAllScriptsBtn.TextColor3 = Color3.new(1,1,1)
copyAllScriptsBtn.Font = Enum.Font.GothamBold
copyAllScriptsBtn.TextSize = 11
copyAllScriptsBtn.AutoButtonColor = false
corner(copyAllScriptsBtn, 6)
stroke(copyAllScriptsBtn, T.Purple, 1)

local scriptScroll = Instance.new("ScrollingFrame", scriptsPage)
scriptScroll.Size = UDim2.new(1, 0, 1, -36)
scriptScroll.Position = UDim2.new(0, 0, 0, 36)
scriptScroll.BackgroundColor3 = T.Input
scriptScroll.BorderSizePixel = 0
scriptScroll.ScrollBarThickness = 4
scriptScroll.ScrollBarImageColor3 = T.Accent
scriptScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
corner(scriptScroll, 8)
stroke(scriptScroll, T.Stroke, 1)

local scriptLayout = Instance.new("UIListLayout", scriptScroll)
scriptLayout.Padding = UDim.new(0, 3)
local scriptPad = Instance.new("UIPadding", scriptScroll)
scriptPad.PaddingTop = UDim.new(0, 6)
scriptPad.PaddingBottom = UDim.new(0, 6)
scriptPad.PaddingLeft = UDim.new(0, 6)
scriptPad.PaddingRight = UDim.new(0, 6)

local scriptOrder = 0

local function addScriptRow(script)
    scriptOrder = scriptOrder + 1
    local row = Instance.new("TextButton", scriptScroll)
    row.Size = UDim2.new(1, 0, 0, 0)
    row.AutomaticSize = Enum.AutomaticSize.Y
    row.BackgroundColor3 = T.Panel
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.LayoutOrder = scriptOrder
    corner(row, 6)

    local rp = Instance.new("UIPadding", row)
    rp.PaddingTop = UDim.new(0, 5)
    rp.PaddingBottom = UDim.new(0, 5)
    rp.PaddingLeft = UDim.new(0, 8)
    rp.PaddingRight = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = T.Text
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true

    local code, method = State.safeGetCode(script)
    local readStatus = "cannot read"
    local color = T.TextMute
    if code then
        readStatus = "READABLE via " .. method .. " (" .. #code .. " chars)"
        color = T.Green
    else
        readStatus = "cannot read (" .. method .. ")"
        color = T.Red
    end

    lbl.Text = script.ClassName .. ": " .. script.Name .. "\n" ..
               "  " .. State.shortPath(script) .. "\n" ..
               "  " .. readStatus
    lbl.TextColor3 = color

    row.MouseButton1Click:Connect(function()
        if code and API.setclipboard then
            setclipboard(code)
            local orig = row.BackgroundColor3
            row.BackgroundColor3 = T.Green
            task.wait(0.2)
            row.BackgroundColor3 = orig
        end
    end)

    if code then
        local codeBtn = Instance.new("TextButton", row)
        codeBtn.Size = UDim2.new(0, 60, 0, 20)
        codeBtn.Position = UDim2.new(1, -66, 0, 0)
        codeBtn.BackgroundColor3 = T.Accent2
        codeBtn.BorderSizePixel = 0
        codeBtn.Text = "COPY CODE"
        codeBtn.TextColor3 = Color3.new(1,1,1)
        codeBtn.Font = Enum.Font.GothamBold
        codeBtn.TextSize = 9
        codeBtn.AutoButtonColor = false
        corner(codeBtn, 5)
        stroke(codeBtn, T.Accent, 1)
        codeBtn.MouseButton1Click:Connect(function()
            if API.setclipboard then
                setclipboard(code)
                codeBtn.Text = "COPIED!"
                task.wait(1)
                codeBtn.Text = "COPY CODE"
            end
        end)
    end
end

scanScriptsBtn.MouseButton1Click:Connect(function()
    for _, c in ipairs(scriptScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    scriptOrder = 0
    State.scanScripts()
    for _, s in ipairs(State.ScriptList) do
        pcall(addScriptRow, s)
    end
end)

copyAllScriptsBtn.MouseButton1Click:Connect(function()
    local lines = {}
    for _, s in ipairs(State.ScriptList) do
        table.insert(lines, s.ClassName .. ": " .. s:GetFullName())
    end
    if API.setclipboard then
        setclipboard(table.concat(lines, "\n"))
        copyAllScriptsBtn.Text = "COPIED!"
        task.wait(1)
        copyAllScriptsBtn.Text = "COPY ALL NAMES"
    end
end)

-- ═══════════════════════════════════════════════════════
-- GUI DUMP TAB
-- ═══════════════════════════════════════════════════════

local dumpPage = makeTab("dump", "GUI Dump")

local dumpTop = Instance.new("Frame", dumpPage)
dumpTop.Size = UDim2.new(1, 0, 0, 30)
dumpTop.BackgroundTransparency = 1

local dumpAllBtn = Instance.new("TextButton", dumpTop)
dumpAllBtn.Size = UDim2.new(0, 130, 1, 0)
dumpAllBtn.Position = UDim2.new(0, 0, 0, 0)
dumpAllBtn.BackgroundColor3 = T.Accent2
dumpAllBtn.BorderSizePixel = 0
dumpAllBtn.Text = "DUMP MY GUI"
dumpAllBtn.TextColor3 = Color3.new(1,1,1)
dumpAllBtn.Font = Enum.Font.GothamBold
dumpAllBtn.TextSize = 11
dumpAllBtn.AutoButtonColor = false
corner(dumpAllBtn, 6)
stroke(dumpAllBtn, T.Accent, 1.5, 0.3)

local dumpCopyBtn = Instance.new("TextButton", dumpTop)
dumpCopyBtn.Size = UDim2.new(0, 130, 1, 0)
dumpCopyBtn.Position = UDim2.new(0, 136, 0, 0)
dumpCopyBtn.BackgroundColor3 = T.Green
dumpCopyBtn.BorderSizePixel = 0
dumpCopyBtn.Text = "COPY RESULT"
dumpCopyBtn.TextColor3 = Color3.new(1,1,1)
dumpCopyBtn.Font = Enum.Font.GothamBold
dumpCopyBtn.TextSize = 11
dumpCopyBtn.AutoButtonColor = false
corner(dumpCopyBtn, 6)
stroke(dumpCopyBtn, T.Green, 1)

local dumpScroll = Instance.new("ScrollingFrame", dumpPage)
dumpScroll.Size = UDim2.new(1, 0, 1, -36)
dumpScroll.Position = UDim2.new(0, 0, 0, 36)
dumpScroll.BackgroundColor3 = T.Input
dumpScroll.BorderSizePixel = 0
dumpScroll.ScrollBarThickness = 4
dumpScroll.ScrollBarImageColor3 = T.Accent
dumpScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
dumpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
corner(dumpScroll, 8)
stroke(dumpScroll, T.Stroke, 1)

local dumpPad = Instance.new("UIPadding", dumpScroll)
dumpPad.PaddingTop = UDim.new(0, 6)
dumpPad.PaddingBottom = UDim.new(0, 6)
dumpPad.PaddingLeft = UDim.new(0, 8)
dumpPad.PaddingRight = UDim.new(0, 8)

local dumpOutput = Instance.new("TextLabel", dumpScroll)
dumpOutput.Size = UDim2.new(1, 0, 0, 0)
dumpOutput.AutomaticSize = Enum.AutomaticSize.Y
dumpOutput.BackgroundTransparency = 1
dumpOutput.Text = "-- click DUMP MY GUI"
dumpOutput.TextColor3 = T.TextDim
dumpOutput.Font = Enum.Font.Code
dumpOutput.TextSize = 10
dumpOutput.TextXAlignment = Enum.TextXAlignment.Left
dumpOutput.TextWrapped = true

local lastDumpCode = ""

dumpAllBtn.MouseButton1Click:Connect(function()
    local parts = {}
    table.insert(parts, "-- GUI DUMP generated by FE Profiler")
    table.insert(parts, "-- " .. os.date("%Y-%m-%d %H:%M:%S"))
    table.insert(parts, "")
    local ok, code = pcall(State.dumpGui, PlayerGui)
    if ok and code then
        table.insert(parts, code)
    else
        table.insert(parts, "-- failed: " .. tostring(code))
    end
    lastDumpCode = table.concat(parts, "\n")
    dumpOutput.Text = lastDumpCode
end)

dumpCopyBtn.MouseButton1Click:Connect(function()
    if #lastDumpCode > 0 and API.setclipboard then
        setclipboard(lastDumpCode)
        dumpCopyBtn.Text = "COPIED!"
        task.wait(1)
        dumpCopyBtn.Text = "COPY RESULT"
    end
end)

-- ═══════════════════════════════════════════════════════
-- CLICKS TAB
-- ═══════════════════════════════════════════════════════

local clicksPage = makeTab("clicks", "Clicks")

local clicksTop = Instance.new("Frame", clicksPage)
clicksTop.Size = UDim2.new(1, 0, 0, 30)
clicksTop.BackgroundTransparency = 1

local clearClicksBtn = Instance.new("TextButton", clicksTop)
clearClicksBtn.Size = UDim2.new(0, 130, 1, 0)
clearClicksBtn.Position = UDim2.new(0, 0, 0, 0)
clearClicksBtn.BackgroundColor3 = T.Red
clearClicksBtn.BorderSizePixel = 0
clearClicksBtn.Text = "CLEAR CLICKS"
clearClicksBtn.TextColor3 = Color3.new(1,1,1)
clearClicksBtn.Font = Enum.Font.GothamBold
clearClicksBtn.TextSize = 11
clearClicksBtn.AutoButtonColor = false
corner(clearClicksBtn, 6)
stroke(clearClicksBtn, T.Red, 1)

local copyClicksBtn = Instance.new("TextButton", clicksTop)
copyClicksBtn.Size = UDim2.new(0, 130, 1, 0)
copyClicksBtn.Position = UDim2.new(0, 136, 0, 0)
copyClicksBtn.BackgroundColor3 = T.Purple
copyClicksBtn.BorderSizePixel = 0
copyClicksBtn.Text = "COPY ALL"
copyClicksBtn.TextColor3 = Color3.new(1,1,1)
copyClicksBtn.Font = Enum.Font.GothamBold
copyClicksBtn.TextSize = 11
copyClicksBtn.AutoButtonColor = false
corner(copyClicksBtn, 6)
stroke(copyClicksBtn, T.Purple, 1)

local clicksScroll = Instance.new("ScrollingFrame", clicksPage)
clicksScroll.Size = UDim2.new(1, 0, 1, -36)
clicksScroll.Position = UDim2.new(0, 0, 0, 36)
clicksScroll.BackgroundColor3 = T.Input
clicksScroll.BorderSizePixel = 0
clicksScroll.ScrollBarThickness = 4
clicksScroll.ScrollBarImageColor3 = T.Accent
clicksScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
clicksScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
corner(clicksScroll, 8)
stroke(clicksScroll, T.Stroke, 1)

local clicksLayout = Instance.new("UIListLayout", clicksScroll)
clicksLayout.Padding = UDim.new(0, 3)
local clicksPad = Instance.new("UIPadding", clicksScroll)
clicksPad.PaddingTop = UDim.new(0, 6)
clicksPad.PaddingBottom = UDim.new(0, 6)
clicksPad.PaddingLeft = UDim.new(0, 6)
clicksPad.PaddingRight = UDim.new(0, 6)

local clickOrder = 0
local clickLines = {}

local function addClickRow(entry)
    clickOrder = clickOrder + 1
    local row = Instance.new("TextButton", clicksScroll)
    row.Size = UDim2.new(1, 0, 0, 0)
    row.AutomaticSize = Enum.AutomaticSize.Y
    row.BackgroundColor3 = T.Panel
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.LayoutOrder = clickOrder
    corner(row, 6)

    local rp = Instance.new("UIPadding", row)
    rp.PaddingTop = UDim.new(0, 5)
    rp.PaddingBottom = UDim.new(0, 5)
    rp.PaddingLeft = UDim.new(0, 8)
    rp.PaddingRight = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = T.Text
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true

    local txt = "[" .. entry.time .. "] click at " .. entry.pos .. "\n"
    txt = txt .. "  on: " .. entry.gui
    if entry.guiFull and #entry.guiFull > 0 then
        txt = txt .. "\n  path: " .. entry.guiFull
    end
    if entry.triggeredRemote then
        txt = txt .. "\n  -> remote: " .. entry.triggeredRemote
    end

    lbl.Text = txt
    lbl.TextColor3 = entry.triggeredRemote and T.Green or T.Orange

    row.MouseButton1Click:Connect(function()
        local copy = txt
        if API.setclipboard then
            setclipboard(copy)
            row.BackgroundColor3 = T.Green
            task.wait(0.15)
            row.BackgroundColor3 = T.Panel
        end
    end)

    table.insert(clickLines, row)
    while #clickLines > 100 do
        local old = table.remove(clickLines, 1)
        if old then old:Destroy() end
    end

    task.defer(function()
        clicksScroll.CanvasPosition = Vector2.new(0, clicksLayout.AbsoluteContentSize.Y)
    end)
end

State.OnClickLog = function(entry)
    if entry.kind == "click" then
        addClickRow(entry)
    end
end

clearClicksBtn.MouseButton1Click:Connect(function()
    for _, l in ipairs(clickLines) do l:Destroy() end
    clickLines = {}
end)

copyClicksBtn.MouseButton1Click:Connect(function()
    local lines = {}
    for _, l in ipairs(clickLines) do
        if l:FindFirstChildOfClass("TextLabel") then
            table.insert(lines, l:FindFirstChildOfClass("TextLabel").Text)
        end
    end
    if API.setclipboard then
        setclipboard(table.concat(lines, "\n\n"))
        copyClicksBtn.Text = "COPIED!"
        task.wait(1)
        copyClicksBtn.Text = "COPY ALL"
    end
end)

-- ═══════════════════════════════════════════════════════
-- ABOUT TAB
-- ═══════════════════════════════════════════════════════

local aboutPage = makeTab("about", "About")

local aboutTitle = Instance.new("TextLabel", aboutPage)
aboutTitle.Size = UDim2.new(1, 0, 0, 26)
aboutTitle.Position = UDim2.new(0, 0, 0, 6)
aboutTitle.BackgroundTransparency = 1
aboutTitle.Text = "FE Profiler v1.0"
aboutTitle.TextColor3 = T.Text
aboutTitle.Font = Enum.Font.GothamBold
aboutTitle.TextSize = 16
aboutTitle.TextXAlignment = Enum.TextXAlignment.Left

local aboutBy = Instance.new("TextLabel", aboutPage)
aboutBy.Size = UDim2.new(1, 0, 0, 18)
aboutBy.Position = UDim2.new(0, 0, 0, 34)
aboutBy.BackgroundTransparency = 1
aboutBy.Text = "by Infinix-Cyber / local maze"
aboutBy.TextColor3 = T.TextDim
aboutBy.Font = Enum.Font.Gotham
aboutBy.TextSize = 11
aboutBy.TextXAlignment = Enum.TextXAlignment.Left

local apiList = Instance.new("TextLabel", aboutPage)
apiList.Size = UDim2.new(1, 0, 0, 0)
apiList.Position = UDim2.new(0, 0, 0, 66)
apiList.AutomaticSize = Enum.AutomaticSize.Y
apiList.BackgroundTransparency = 1
apiList.TextColor3 = T.Text
apiList.Font = Enum.Font.Code
apiList.TextSize = 10
apiList.TextXAlignment = Enum.TextXAlignment.Left
apiList.TextWrapped = true

local apiLines = {"-- Delta API check --"}
local function addApi(name, ok)
    local mark = ok and "[+]" or "[-]"
    local color = ok and "OK" or "MISSING"
    table.insert(apiLines, mark .. " " .. name .. " (" .. color .. ")")
end
addApi("getrawmetatable", API.getrawmetatable)
addApi("hookmetamethod", API.hookmetamethod)
addApi("hookfunction", API.hookfunction)
addApi("newcclosure", API.newcclosure)
addApi("checkcaller", API.checkcaller)
addApi("getscriptbytecode", API.getscriptbytecode)
addApi("getsenv", API.getsenv)
addApi("getconnections", API.getconnections)
addApi("debug.getinfo", API.debug_getinfo)
addApi("debug.getupvalue", API.debug_getupvalue)
addApi("setclipboard", API.setclipboard)
apiList.Text = table.concat(apiLines, "\n")

local aboutInfo = Instance.new("TextLabel", aboutPage)
aboutInfo.Size = UDim2.new(1, 0, 0, 0)
aboutInfo.Position = UDim2.new(0, 0, 0, 240)
aboutInfo.AutomaticSize = Enum.AutomaticSize.Y
aboutInfo.BackgroundTransparency = 1
aboutInfo.Text = "\nTabs:\n" ..
    "  Logger - remotes + clicks in real time\n" ..
    "  Scripts - scan LocalScripts, try read code\n" ..
    "  GUI Dump - export your GUI as Lua script\n" ..
    "  Clicks - detailed click tracker with remote link\n\n" ..
    "Click any line to copy to clipboard."
aboutInfo.TextColor3 = T.TextDim
aboutInfo.Font = Enum.Font.Gotham
aboutInfo.TextSize = 10
aboutInfo.TextXAlignment = Enum.TextXAlignment.Left
aboutInfo.TextWrapped = true

-- ═══════════════════════════════════════════════════════
-- FLOATING BALL
-- ═══════════════════════════════════════════════════════

local ball = Instance.new("TextButton", gui)
ball.Name = "Ball"
ball.Size = UDim2.new(0, 50, 0, 50)
ball.Position = UDim2.new(0, 24, 0.5, -25)
ball.BackgroundColor3 = T.Accent2
ball.Text = "FE"
ball.TextColor3 = Color3.new(1,1,1)
ball.Font = Enum.Font.GothamBold
ball.TextSize = 16
ball.BorderSizePixel = 0
ball.AutoButtonColor = false
ball.Visible = false
corner(ball, 25)
stroke(ball, T.Accent3, 2, 0)

local ballDrag, ballStart, ballStartPos, ballMoved
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
        if math.abs(d.X) + math.abs(d.Y) > 6 then ballMoved = true end
        ball.Position = UDim2.new(ballStartPos.X.Scale, ballStartPos.X.Offset + d.X, ballStartPos.Y.Scale, ballStartPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        if ballDrag and not ballMoved then
            ball.Visible = false
            main.Visible = true
            main.Size = UDim2.new(0, W, 0, 0)
            content.Visible = false
            animate(main, {Size = UDim2.new(0, W, 0, H)}, 0.35)
            task.wait(0.25)
            content.Visible = true
        end
        ballDrag = false
    end
end)

minBtn.MouseButton1Click:Connect(function()
    content.Visible = false
    local t = animate(main, {Size = UDim2.new(0, W, 0, 42)}, 0.25)
    t.Completed:Connect(function()
        content.Visible = false
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    content.Visible = false
    local t = animate(main, {Size = UDim2.new(0, W, 0, 0)}, 0.25)
    t.Completed:Connect(function()
        main.Visible = false
        ball.Visible = true
        ball.Position = UDim2.new(0, 24, 0.5, -25)
    end)
end)

-- ═══════════════════════════════════════════════════════
-- START
-- ═══════════════════════════════════════════════════════

main.Size = UDim2.new(0, W, 0, 0)
content.Visible = false
task.spawn(function()
    task.wait(0.05)
    animate(main, {Size = UDim2.new(0, W, 0, H)}, 0.5, Enum.EasingStyle.Quint)
    task.wait(0.3)
    content.Visible = true
end)

switchTab("logger")

pcall(function()
    State.hookRemotes()
    State.watchRemoteEvents()
    State.trackClicks()
end)

print("[FE Profiler v1.0] loaded")
print("  remote hook: " .. tostring(State.HooksActive))
print("  API available:")
for k, v in pairs(API) do
    print("    " .. k .. ": " .. tostring(v))
end)
print("  use tabs: Logger / Scripts / GUI Dump / Clicks / About")
