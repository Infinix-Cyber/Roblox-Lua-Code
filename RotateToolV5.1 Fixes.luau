-- FE Rotate Tool v5.1
-- by Infinix-Cyber / local maze
-- v5.1: fixed player-launch bug, added snow animation

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer

local Tuner = {
    Selected = nil,
    Handle = nil,
    OriginalWeld = nil,
    OriginalCFrame = nil,
    OriginalAnchored = nil,
    Highlight = nil,
    LoopConn = nil,
    Anchor = nil,
    AlignPos = nil,
    AlignOri = nil,
    Attach0 = nil,
    Attach1 = nil,
    OffX = 0, OffY = 0, OffZ = 0,
    RotX = 0, RotY = 0, RotZ = 0,
    Active = false,
    Ticks = 0,
}

local Verify = {
    Log = {},
    Verdict = "unknown",
    Score = 0,
    OnFinish = nil,
}

local function computeOffset()
    return CFrame.new(Tuner.OffX, Tuner.OffY, Tuner.OffZ)
        * CFrame.Angles(math.rad(Tuner.RotX), math.rad(Tuner.RotY), math.rad(Tuner.RotZ))
end

local function findAccWeld(acc)
    local h = acc:FindFirstChild("Handle")
    if not h then return nil, nil end
    for _, c in ipairs(h:GetChildren()) do
        if c:IsA("Weld") or c:IsA("Motor6D") then return c, h end
    end
    if LP.Character then
        for _, bp in ipairs(LP.Character:GetChildren()) do
            if bp:IsA("BasePart") then
                for _, w in ipairs(bp:GetChildren()) do
                    if (w:IsA("Weld") or w:IsA("Motor6D")) and (w.Part0 == h or w.Part1 == h) then
                        return w, h
                    end
                end
            end
        end
    end
    return nil, h
end

local function setHighlight(acc)
    if Tuner.Highlight then Tuner.Highlight:Destroy(); Tuner.Highlight = nil end
    if not acc then return end
    local hl = Instance.new("Highlight")
    hl.Name = "__FE_SelHL"
    hl.FillColor = Color3.fromRGB(120, 180, 255)
    hl.OutlineColor = Color3.fromRGB(120, 180, 255)
    hl.FillTransparency = 0.85
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = acc
    hl.Parent = acc
    Tuner.Highlight = hl
end

local function removeAllWeldsToHandle(h)
    if not h then return end
    for _, w in ipairs(h:GetChildren()) do
        if w:IsA("Weld") or w:IsA("Motor6D") then w:Destroy() end
    end
    if LP.Character then
        for _, bp in ipairs(LP.Character:GetChildren()) do
            if bp:IsA("BasePart") then
                for _, w in ipairs(bp:GetChildren()) do
                    if (w:IsA("Weld") or w:IsA("Motor6D")) and (w.Part0 == h or w.Part1 == h) then
                        w:Destroy()
                    end
                end
            end
        end
    end
end

local function createPhysicsAttach()
    if not Tuner.Handle then return end
    if Tuner.Anchor then Tuner.Anchor:Destroy(); Tuner.Anchor = nil end
    if Tuner.AlignPos then Tuner.AlignPos:Destroy(); Tuner.AlignPos = nil end
    if Tuner.AlignOri then Tuner.AlignOri:Destroy(); Tuner.AlignOri = nil end

    local anchor = Instance.new("Part")
    anchor.Name = "__FE_Anchor"
    anchor.Size = Vector3.new(0.1, 0.1, 0.1)
    anchor.Transparency = 1
    anchor.CanCollide = false
    anchor.Anchored = true
    anchor.Massless = true
    anchor.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
    anchor.Parent = workspace

    local a0 = Instance.new("Attachment")
    a0.Name = "__FE_AnchorAttach"
    a0.Parent = anchor

    local a1 = Instance.new("Attachment")
    a1.Name = "__FE_HandleAttach"
    a1.Parent = Tuner.Handle

    local ap = Instance.new("AlignPosition")
    ap.Name = "__FE_AlignPos"
    ap.Attachment0 = a1
    ap.Attachment1 = a0
    ap.MaxForce = math.huge
    ap.MaxVelocity = math.huge
    ap.Responsiveness = 200
    ap.Position = anchor.Position
    ap.Mode = Enum.PositionAlignmentMode.OneAttachment
    ap.Enabled = true
    ap.Parent = Tuner.Handle

    local ao = Instance.new("AlignOrientation")
    ao.Name = "__FE_AlignOri"
    ao.Attachment0 = a1
    ao.Attachment1 = a0
    ao.MaxTorque = math.huge
    ao.MaxAngularVelocity = math.huge
    ao.Responsiveness = 200
    ao.Mode = Enum.OrientationAlignmentMode.OneAttachment
    ao.CFrame = anchor.CFrame
    ao.Enabled = true
    ao.Parent = Tuner.Handle

    Tuner.Anchor = anchor
    Tuner.Attach0 = a0
    Tuner.Attach1 = a1
    Tuner.AlignPos = ap
    Tuner.AlignOri = ao
end

local function destroyPhysicsAttach()
    if Tuner.AlignPos then Tuner.AlignPos:Destroy(); Tuner.AlignPos = nil end
    if Tuner.AlignOri then Tuner.AlignOri:Destroy(); Tuner.AlignOri = nil end
    if Tuner.Attach0 then Tuner.Attach0:Destroy(); Tuner.Attach0 = nil end
    if Tuner.Attach1 then Tuner.Attach1:Destroy(); Tuner.Attach1 = nil end
    if Tuner.Anchor then Tuner.Anchor:Destroy(); Tuner.Anchor = nil end
end

local function stopLoop()
    if Tuner.LoopConn then
        Tuner.LoopConn:Disconnect()
        Tuner.LoopConn = nil
    end
    Tuner.Active = false
end

local function startLoop()
    stopLoop()
    if not Tuner.Handle then return end
    if not Tuner.Anchor then createPhysicsAttach() end

    Tuner.Active = true
    Tuner.Ticks = 0

    Tuner.LoopConn = RunService.Heartbeat:Connect(function(dt)
        if not Tuner.Handle or not Tuner.Handle.Parent then return end
        if not Tuner.Anchor or not Tuner.Anchor.Parent then return end
        if not LP.Character then return end
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        Tuner.Ticks = Tuner.Ticks + 1

        local targetCF = hrp.CFrame * computeOffset()

        Tuner.Anchor.CFrame = targetCF
        if Tuner.AlignPos then
            Tuner.AlignPos.Position = targetCF.Position
        end
        if Tuner.AlignOri then
            Tuner.AlignOri.CFrame = targetCF
        end

        Tuner.Handle.AssemblyLinearVelocity = Vector3.zero
        Tuner.Handle.AssemblyAngularVelocity = Vector3.zero

        if Tuner.Ticks % 30 == 0 then
            print(string.format("[FE Debug] tick=%d pos=(%.2f,%.2f,%.2f) hrp=(%.2f,%.2f,%.2f)",
                Tuner.Ticks,
                Tuner.Handle.Position.X, Tuner.Handle.Position.Y, Tuner.Handle.Position.Z,
                hrp.Position.X, hrp.Position.Y, hrp.Position.Z))
        end
    end)
end

local function restoreOriginal()
    stopLoop()
    destroyPhysicsAttach()
    if Tuner.Handle then
        pcall(function() Tuner.Handle:SetNetworkOwner(nil) end)
    end
    if Tuner.Handle and Tuner.OriginalCFrame then
        pcall(function() Tuner.Handle.CFrame = Tuner.OriginalCFrame end)
    end
    if Tuner.Handle and Tuner.OriginalAnchored ~= nil then
        pcall(function() Tuner.Handle.Anchored = Tuner.OriginalAnchored end)
    end
    if Tuner.Handle and Tuner.OriginalWeld then
        pcall(function()
            local w = Instance.new("Weld")
            w.Name = "AccessoryWeld"
            w.Part0 = Tuner.OriginalWeld.Part0
            w.Part1 = Tuner.OriginalWeld.Part1
            w.C0 = Tuner.OriginalWeld.C0
            w.C1 = Tuner.OriginalWeld.C1
            w.Parent = Tuner.Handle
        end)
    end
end

local function selectAcc(acc)
    restoreOriginal()
    Tuner.Selected = nil
    Tuner.Handle = nil
    Tuner.OriginalWeld = nil
    Tuner.OriginalCFrame = nil
    Tuner.OriginalAnchored = nil
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0

    if not acc then
        setHighlight(nil)
        return
    end

    local w, h = findAccWeld(acc)
    if not h then
        setHighlight(nil)
        return
    end

    Tuner.Selected = acc
    Tuner.Handle = h
    if w then
        Tuner.OriginalWeld = {
            Part0 = w.Part0,
            Part1 = w.Part1,
            C0 = w.C0,
            C1 = w.C1,
        }
        w:Destroy()
    end
    Tuner.OriginalCFrame = h.CFrame
    Tuner.OriginalAnchored = h.Anchored

    pcall(function()
        h.Massless = true
        h.CanCollide = false
        h.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
    end)

    setHighlight(acc)
end

local function cancelAll()
    restoreOriginal()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
end

local function commit()
    if not Tuner.Selected or not Tuner.Handle then return end
    pcall(function() Tuner.Handle:SetNetworkOwner(LP) end)
    createPhysicsAttach()
    startLoop()
end

local function listAccs()
    local list = {}
    if not LP.Character then return list end
    for _, c in ipairs(LP.Character:GetChildren()) do
        if c:IsA("Accessory") and c:FindFirstChild("Handle") then
            table.insert(list, c)
        end
    end
    return list
end

local function vLog(t)
    table.insert(Verify.Log, t)
    print("[FE Verify] " .. t)
end

function Verify.run()
    Verify.Log = {}
    Verify.Score = 0
    Verify.Verdict = "unknown"

    print("=====================================")
    print("  FE VERIFICATION v5.1")
    print("=====================================")

    if not Tuner.Selected or not Tuner.Handle then
        vLog("no accessory selected")
        if Verify.OnFinish then Verify.OnFinish() end
        return
    end

    local h = Tuner.Handle
    vLog("testing: " .. Tuner.Selected.Name)

    local inChar = false
    local p = h.Parent
    while p do
        if p == LP.Character then inChar = true; break end
        p = p.Parent
    end
    if inChar then vLog("[1/5] handle in character (OK)") else vLog("[1/5] NOT in character (FAIL)") end

    if not h.Anchored then vLog("[2/5] not anchored (OK)") else vLog("[2/5] anchored (FAIL)") end

    local hasAnchor = Tuner.Anchor and Tuner.Anchor.Parent ~= nil
    if hasAnchor then vLog("[3/5] physics anchor exists (OK)") else vLog("[3/5] no anchor - press COMMIT (FAIL)") end

    local hasAlign = Tuner.AlignPos and Tuner.AlignPos.Parent ~= nil
    if hasAlign then vLog("[4/5] AlignPosition active (OK)") else vLog("[4/5] no AlignPosition (FAIL)") end

    if Tuner.Active then
        task.wait(2)
        if LP.Character then
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local distFromHRP = (h.Position - hrp.Position).Magnitude
                if distFromHRP < 15 then
                    vLog("[5/5] handle near you (dist=" .. string.format("%.1f", distFromHRP) .. ") (OK)")
                else
                    vLog("[5/5] handle far away (dist=" .. string.format("%.1f", distFromHRP) .. ") (FAIL)")
                end
            end
        end
    else
        vLog("[5/5] loop not active")
    end

    if inChar then Verify.Score = Verify.Score + 1 end
    if not h.Anchored then Verify.Score = Verify.Score + 1 end
    if hasAnchor then Verify.Score = Verify.Score + 1 end
    if hasAlign then Verify.Score = Verify.Score + 1 end
    if Tuner.Active then Verify.Score = Verify.Score + 1 end

    print("=====================================")
    print("  SCORE: " .. Verify.Score .. "/5")
    if Verify.Score >= 4 then
        Verify.Verdict = "works"
        print("  VERDICT: WORKS")
    elseif Verify.Score == 3 then
        Verify.Verdict = "partial"
        print("  VERDICT: PARTIAL")
    else
        Verify.Verdict = "broken"
        print("  VERDICT: BROKEN")
    end
    print("=====================================")

    if Verify.OnFinish then Verify.OnFinish() end
end

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

local parent = (gethui and gethui()) or CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "FE_Rotate_" .. tostring(math.random(1e4, 1e6))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = parent

local MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled
local W = MOBILE and 300 or 320
local H = MOBILE and 420 or 440

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

-- snow canvas
local snowFrame = Instance.new("Frame", main)
snowFrame.Name = "Snow"
snowFrame.Size = UDim2.new(1, 0, 1, 0)
snowFrame.BackgroundTransparency = 1
snowFrame.ClipsDescendants = true
snowFrame.ZIndex = 0

local snowflakes = {}
local function spawnSnowflake()
    local flake = Instance.new("Frame", snowFrame)
    flake.BackgroundColor3 = T.Snow
    flake.BackgroundTransparency = math.random(60, 90) / 100
    flake.BorderSizePixel = 0
    local size = math.random(2, 4)
    flake.Size = UDim2.new(0, size, 0, size)
    corner(flake, size)
    flake.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.05, 0)
    flake.ZIndex = 0

    local speed = math.random(15, 40) / 1000
    local swing = math.random(-15, 15)
    local life = math.random(4, 8)

    local tw = TweenService:Create(flake,
        TweenInfo.new(life, Enum.EasingStyle.Linear),
        { Position = UDim2.new(flake.Position.X.Scale + swing/1000, 0, 1.05, 0) })
    tw:Play()
    tw.Completed:Connect(function() flake:Destroy() end)

    table.insert(snowflakes, flake)
end

task.spawn(function()
    while gui.Parent do
        spawnSnowflake()
        task.wait(math.random(2, 5) / 20)
    end
end)

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
        animate(dotPulse, {Size = UDim2.new(2.2, 0, 2.2, 0), BackgroundTransparency = 1}, 1.2, Enum.EasingStyle.Quad)
        task.wait(1.2)
        dotPulse.Size = UDim2.new(1, 0, 1, 0)
        dotPulse.BackgroundTransparency = 0.7
    end
end)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 32, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FE ROTATE"
title.TextColor3 = T.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3

local titleVer = Instance.new("TextLabel", titleBar)
titleVer.Size = UDim2.new(0, 40, 1, 0)
titleVer.Position = UDim2.new(1, -75, 0, 0)
titleVer.BackgroundTransparency = 1
titleVer.Text = "v5.1"
titleVer.TextColor3 = T.Accent2
titleVer.Font = Enum.Font.Code
titleVer.TextSize = 10
titleVer.TextXAlignment = Enum.TextXAlignment.Right
titleVer.ZIndex = 3

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

local targetBtn = Instance.new("TextButton", main)
targetBtn.Size = UDim2.new(1, -24, 0, 36)
targetBtn.Position = UDim2.new(0, 12, 0, 54)
targetBtn.BackgroundColor3 = T.Panel
targetBtn.BorderSizePixel = 0
targetBtn.Text = "   Target:  [ none ]"
targetBtn.TextColor3 = T.Text
targetBtn.Font = Enum.Font.GothamBold
targetBtn.TextSize = 12
targetBtn.TextXAlignment = Enum.TextXAlignment.Left
targetBtn.AutoButtonColor = false
targetBtn.ZIndex = 2
corner(targetBtn, 10)
stroke(targetBtn, T.Stroke, 1)

local arrow = Instance.new("TextLabel", targetBtn)
arrow.Size = UDim2.new(0, 20, 1, 0)
arrow.Position = UDim2.new(1, -26, 0, 0)
arrow.BackgroundTransparency = 1
arrow.Text = "v"
arrow.TextColor3 = T.Accent
arrow.Font = Enum.Font.GothamBold
arrow.TextSize = 14
arrow.ZIndex = 2

local accList = Instance.new("ScrollingFrame", main)
accList.Size = UDim2.new(1, -24, 0, 120)
accList.Position = UDim2.new(0, 12, 0, 94)
accList.BackgroundColor3 = T.BG1
accList.BorderSizePixel = 0
accList.ScrollBarThickness = 3
accList.ScrollBarImageColor3 = T.Accent
accList.Visible = false
accList.CanvasSize = UDim2.new(0, 0, 0, 0)
accList.AutomaticCanvasSize = Enum.AutomaticSize.Y
corner(accList, 10)
stroke(accList, T.StrokeHi, 1.2, 0.3)
accList.ZIndex = 5

local accLayout = Instance.new("UIListLayout", accList)
accLayout.Padding = UDim.new(0, 2)
local accPad = Instance.new("UIPadding", accList)
accPad.PaddingTop = UDim.new(0, 4)
accPad.PaddingBottom = UDim.new(0, 4)
accPad.PaddingLeft = UDim.new(0, 4)
accPad.PaddingRight = UDim.new(0, 4)

local function refreshAccList()
    for _, c in ipairs(accList:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
    end
    local list = listAccs()
    if #list == 0 then
        local lbl = Instance.new("TextLabel", accList)
        lbl.Size = UDim2.new(1, -8, 0, 30)
        lbl.BackgroundTransparency = 1
        lbl.Text = "no accessories on character"
        lbl.TextColor3 = T.TextMute
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11
        return
    end
    for i, acc in ipairs(list) do
        local isSel = (Tuner.Selected == acc)
        local b = Instance.new("TextButton", accList)
        b.Size = UDim2.new(1, -8, 0, 32)
        b.BackgroundColor3 = isSel and T.Accent2 or T.Panel2
        b.BorderSizePixel = 0
        b.Text = "   " .. acc.Name
        b.TextColor3 = T.Text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.AutoButtonColor = false
        corner(b, 8)
        if isSel then stroke(b, T.Accent3, 1.5, 0) end
        b.MouseButton1Click:Connect(function()
            selectAcc(acc)
            targetBtn.Text = "   Target:  " .. acc.Name
            accList.Visible = false
            updateStatus()
        end)
    end
end

targetBtn.MouseButton1Click:Connect(function()
    accList.Visible = not accList.Visible
    if accList.Visible then refreshAccList() end
end)

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -24, 1, -280)
scroll.Position = UDim2.new(0, 12, 0, 94)
scroll.BackgroundColor3 = T.Panel
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = T.Accent
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Visible = false
scroll.ZIndex = 2
corner(scroll, 10)
stroke(scroll, T.Stroke, 1)

local sLayout = Instance.new("UIListLayout", scroll)
sLayout.Padding = UDim.new(0, 4)
local sPad = Instance.new("UIPadding", scroll)
sPad.PaddingTop = UDim.new(0, 8)
sPad.PaddingBottom = UDim.new(0, 8)
sPad.PaddingLeft = UDim.new(0, 10)
sPad.PaddingRight = UDim.new(0, 10)

local function sectionHeader(parentFrame, text)
    local h = Instance.new("TextLabel", parentFrame)
    h.Size = UDim2.new(1, 0, 0, 18)
    h.BackgroundTransparency = 1
    h.Text = text
    h.TextColor3 = T.Accent
    h.Font = Enum.Font.GothamBold
    h.TextSize = 10
    h.TextXAlignment = Enum.TextXAlignment.Left
    return h
end

local function makeRow(parentFrame, label, getV, setV, step)
    local row = Instance.new("Frame", parentFrame)
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0, 40, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = T.TextDim
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local minus = Instance.new("TextButton", row)
    minus.Size = UDim2.new(0, 26, 0, 22)
    minus.Position = UDim2.new(0, 44, 0.5, -11)
    minus.BackgroundColor3 = T.Panel2
    minus.BorderSizePixel = 0
    minus.Text = "-"
    minus.TextColor3 = T.Text
    minus.Font = Enum.Font.GothamBold
    minus.TextSize = 14
    minus.AutoButtonColor = false
    corner(minus, 6)
    stroke(minus, T.Stroke, 1)

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 88, 0, 22)
    box.Position = UDim2.new(0, 74, 0.5, -11)
    box.BackgroundColor3 = T.Input
    box.BorderSizePixel = 0
    box.Text = string.format("%.2f", getV())
    box.TextColor3 = T.Text
    box.Font = Enum.Font.Code
    box.TextSize = 11
    corner(box, 6)
    stroke(box, T.Stroke, 1)

    local plus = Instance.new("TextButton", row)
    plus.Size = UDim2.new(0, 26, 0, 22)
    plus.Position = UDim2.new(0, 166, 0.5, -11)
    plus.BackgroundColor3 = T.Panel2
    plus.BorderSizePixel = 0
    plus.Text = "+"
    plus.TextColor3 = T.Text
    plus.Font = Enum.Font.GothamBold
    plus.TextSize = 14
    plus.AutoButtonColor = false
    corner(plus, 6)
    stroke(plus, T.Stroke, 1)

    local function apply(v)
        setV(v)
        box.Text = string.format("%.2f", v)
        updateStatus()
    end

    minus.MouseButton1Click:Connect(function() apply(getV() - step) end)
    plus.MouseButton1Click:Connect(function() apply(getV() + step) end)
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then apply(n) else box.Text = string.format("%.2f", getV()) end
    end)

    return { setText = function(v) box.Text = string.format("%.2f", v) end }
end

sectionHeader(scroll, "POSITION (studs)")
local rowX_ = makeRow(scroll, "X", function() return Tuner.OffX end, function(v) Tuner.OffX = v end, 0.1)
local rowY_ = makeRow(scroll, "Y", function() return Tuner.OffY end, function(v) Tuner.OffY = v end, 0.1)
local rowZ_ = makeRow(scroll, "Z", function() return Tuner.OffZ end, function(v) Tuner.OffZ = v end, 0.1)

sectionHeader(scroll, "ROTATION (degrees)")
local rowRX_ = makeRow(scroll, "RX", function() return Tuner.RotX end, function(v) Tuner.RotX = v end, 5)
local rowRY_ = makeRow(scroll, "RY", function() return Tuner.RotY end, function(v) Tuner.RotY = v end, 5)
local rowRZ_ = makeRow(scroll, "RZ", function() return Tuner.RotZ end, function(v) Tuner.RotZ = v end, 5)

local verifyBtn = Instance.new("TextButton", scroll)
verifyBtn.Size = UDim2.new(1, 0, 0, 34)
verifyBtn.BackgroundColor3 = T.Accent2
verifyBtn.BorderSizePixel = 0
verifyBtn.Text = "RUN VERIFICATION"
verifyBtn.TextColor3 = Color3.new(1,1,1)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 12
verifyBtn.AutoButtonColor = false
corner(verifyBtn, 8)
stroke(verifyBtn, T.Accent3, 1.5, 0.3)
verifyBtn.MouseEnter:Connect(function() animate(verifyBtn, {BackgroundColor3 = T.Accent}, 0.15) end)
verifyBtn.MouseLeave:Connect(function() animate(verifyBtn, {BackgroundColor3 = T.Accent2}, 0.15) end)

local dumpBtn = Instance.new("TextButton", scroll)
dumpBtn.Size = UDim2.new(1, 0, 0, 30)
dumpBtn.BackgroundColor3 = T.Purple
dumpBtn.BorderSizePixel = 0
dumpBtn.Text = "DUMP STATE (check F9)"
dumpBtn.TextColor3 = Color3.new(1,1,1)
dumpBtn.Font = Enum.Font.GothamBold
dumpBtn.TextSize = 11
dumpBtn.AutoButtonColor = false
corner(dumpBtn, 8)
stroke(dumpBtn, T.Purple, 1)
dumpBtn.MouseEnter:Connect(function() animate(dumpBtn, {BackgroundColor3 = T.Purple:Lerp(Color3.new(1,1,1), 0.2)}, 0.15) end)
dumpBtn.MouseLeave:Connect(function() animate(dumpBtn, {BackgroundColor3 = T.Purple}, 0.15) end)

local verifyResult = Instance.new("TextLabel", scroll)
verifyResult.Size = UDim2.new(1, 0, 0, 40)
verifyResult.BackgroundColor3 = T.Input
verifyResult.BorderSizePixel = 0
verifyResult.Text = "  click to test replication"
verifyResult.TextColor3 = T.TextDim
verifyResult.Font = Enum.Font.Code
verifyResult.TextSize = 10
verifyResult.TextXAlignment = Enum.TextXAlignment.Left
verifyResult.TextWrapped = true
corner(verifyResult, 6)
stroke(verifyResult, T.Stroke, 1)

verifyBtn.MouseButton1Click:Connect(function()
    verifyBtn.Text = "TESTING..."
    verifyBtn.BackgroundColor3 = T.Orange
    task.spawn(function()
        Verify.run()
        task.wait(0.1)
        local score = Verify.Score
        local color, txt
        if score >= 4 then
            color = T.Green
            txt = "WORKS " .. score .. "/5 (check F9)"
        elseif score == 3 then
            color = T.Orange
            txt = "PARTIAL " .. score .. "/5"
        else
            color = T.Red
            txt = "BROKEN " .. score .. "/5"
        end
        verifyResult.Text = "  " .. txt
        verifyResult.TextColor3 = color
        verifyBtn.Text = "RUN VERIFICATION"
        verifyBtn.BackgroundColor3 = T.Accent2
    end)
end)

dumpBtn.MouseButton1Click:Connect(function()
    dumpState()
    verifyResult.Text = "  state dumped to F9"
    verifyResult.TextColor3 = T.Accent
end)

local actions = Instance.new("Frame", main)
actions.Size = UDim2.new(1, -24, 0, 34)
actions.Position = UDim2.new(0, 12, 1, -72)
actions.BackgroundTransparency = 1
actions.ZIndex = 2

local BW = (W - 24 - 8) / 3

local function makeActionBtn(x, label, color, cb)
    local b = Instance.new("TextButton", actions)
    b.Size = UDim2.new(0, BW - 4, 1, 0)
    b.Position = UDim2.new(0, x, 0, 0)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = label
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    corner(b, 8)
    stroke(b, color, 1)
    b.MouseEnter:Connect(function() animate(b, {BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2)}, 0.15) end)
    b.MouseLeave:Connect(function() animate(b, {BackgroundColor3 = color}, 0.15) end)
    b.MouseButton1Click:Connect(cb)
    return b
end

makeActionBtn(0, "Reset", T.Orange, function()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    updateStatus()
end)

makeActionBtn(BW, "Cancel", T.Red, function()
    cancelAll()
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    updateStatus("cancelled")
end)

makeActionBtn(BW * 2, "Commit", T.Green, function()
    commit()
    updateStatus("committed")
end)

local statusBar = Instance.new("TextLabel", main)
statusBar.Size = UDim2.new(1, -24, 0, 20)
statusBar.Position = UDim2.new(0, 12, 1, -32)
statusBar.BackgroundColor3 = T.Input
statusBar.BorderSizePixel = 0
statusBar.Text = "  target: none | idle"
statusBar.TextColor3 = T.TextDim
statusBar.Font = Enum.Font.Code
statusBar.TextSize = 10
statusBar.TextXAlignment = Enum.TextXAlignment.Left
statusBar.ZIndex = 2
corner(statusBar, 6)
stroke(statusBar, T.Stroke, 1)

function updateStatus(extra)
    local t = Tuner.Selected and Tuner.Selected.Name or "none"
    local state = Tuner.Active and "ACTIVE" or "idle"
    local line = "  target: " .. t .. " | " .. state
    if extra then line = line .. " | " .. extra end
    statusBar.Text = line
end

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
            scroll.Visible = false
            animate(main, {Size = UDim2.new(0, W, 0, H)}, 0.35)
            task.wait(0.25)
            scroll.Visible = true
        end
        ballDrag = false
    end
end)

main.Size = UDim2.new(0, W, 0, 0)
scroll.Visible = false
task.spawn(function()
    task.wait(0.05)
    animate(main, {Size = UDim2.new(0, W, 0, H)}, 0.5, Enum.EasingStyle.Quint)
    task.wait(0.3)
    scroll.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    stopLoop()
    destroyPhysicsAttach()
    setHighlight(nil)
    scroll.Visible = false
    local t = animate(main, {Size = UDim2.new(0, W, 0, 0)}, 0.25)
    t.Completed:Connect(function()
        main.Visible = false
        ball.Visible = true
        ball.Position = UDim2.new(0, 24, 0.5, -25)
    end)
end)

LP.CharacterAdded:Connect(function()
    stopLoop()
    destroyPhysicsAttach()
    Tuner.Selected = nil
    Tuner.Handle = nil
    Tuner.Active = false
    if Tuner.Highlight then Tuner.Highlight:Destroy(); Tuner.Highlight = nil end
    targetBtn.Text = "   Target:  [ none ]"
    updateStatus("respawned")
end)

updateStatus()

print("[FE Rotate Tool v5.1] loaded.")
print("  - fixed player-launch bug (Weld removed, AlignPosition used)")
print("  - added snow animation + pulse dot")
print("  - verify module updated")
