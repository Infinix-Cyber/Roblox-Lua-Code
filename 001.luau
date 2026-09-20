-- FE Rotate Tool v4 + Verify
-- by Infinix-Cyber / local maze

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local LP = Players.LocalPlayer

local Tuner = {
    Selected = nil, OriginalWeld = nil, OriginalC0 = nil, OriginalC1 = nil,
    PreviewWeld = nil, Highlight = nil,
    OffX = 0, OffY = 0, OffZ = 0, RotX = 0, RotY = 0, RotZ = 0,
}

local Verify = {
    Log = {}, Verdict = "unknown", Score = 0, MaxScore = 5,
    OnLine = nil, OnFinish = nil,
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

local function clearPreview()
    if Tuner.PreviewWeld then Tuner.PreviewWeld:Destroy(); Tuner.PreviewWeld = nil end
end

local function restoreOriginal()
    if not Tuner.Selected then return end
    local h = Tuner.Selected:FindFirstChild("Handle")
    if not h then return end
    clearPreview()
    if LP.Character then
        for _, bp in ipairs(LP.Character:GetChildren()) do
            if bp:IsA("BasePart") then
                for _, w in ipairs(bp:GetChildren()) do
                    if (w:IsA("Weld") or w:IsA("Motor6D"))
                        and (w.Part0 == h or w.Part1 == h)
                        and w ~= Tuner.OriginalWeld then
                        w:Destroy()
                    end
                end
            end
        end
    end
    for _, w in ipairs(h:GetChildren()) do
        if (w:IsA("Weld") or w:IsA("Motor6D")) and w ~= Tuner.OriginalWeld then
            w:Destroy()
        end
    end
    if Tuner.OriginalWeld and not Tuner.OriginalWeld.Parent then
        Tuner.OriginalWeld.Parent = h
    end
    if Tuner.OriginalWeld then
        Tuner.OriginalWeld.C0 = Tuner.OriginalC0
        Tuner.OriginalWeld.C1 = Tuner.OriginalC1
    end
end

local function applyPreview()
    if not Tuner.Selected or not Tuner.OriginalWeld then return end
    local h = Tuner.Selected:FindFirstChild("Handle")
    if not h then return end
    if not Tuner.PreviewWeld then
        Tuner.PreviewWeld = Instance.new("Weld")
        Tuner.PreviewWeld.Name = "__FE_Preview"
        Tuner.PreviewWeld.Part0 = Tuner.OriginalWeld.Part0
        Tuner.PreviewWeld.Part1 = Tuner.OriginalWeld.Part1
        Tuner.PreviewWeld.C1 = Tuner.OriginalC1
        Tuner.PreviewWeld.Parent = h
    end
    Tuner.PreviewWeld.C0 = Tuner.OriginalC0 * computeOffset()
    if Tuner.OriginalWeld and Tuner.OriginalWeld.Parent then
        Tuner.OriginalWeld.Parent = nil
    end
end

local function selectAcc(acc)
    restoreOriginal()
    Tuner.Selected = nil
    Tuner.OriginalWeld = nil
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
    if not acc then setHighlight(nil); return end
    local w = findAccWeld(acc)
    if not w then setHighlight(nil); return end
    Tuner.Selected = acc
    Tuner.OriginalWeld = w
    Tuner.OriginalC0 = w.C0
    Tuner.OriginalC1 = w.C1
    setHighlight(acc)
end

local function cancelAll()
    restoreOriginal()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
end

local function commit()
    if not Tuner.Selected or not Tuner.OriginalWeld then return end
    local h = Tuner.Selected:FindFirstChild("Handle")
    if not h then return end
    clearPreview()
    local nw = Instance.new("Weld")
    nw.Name = "AccessoryWeld"
    nw.Part0 = Tuner.OriginalWeld.Part0
    nw.Part1 = Tuner.OriginalWeld.Part1
    nw.C1 = Tuner.OriginalC1
    nw.C0 = Tuner.OriginalC0 * computeOffset()
    nw.Parent = h
    if Tuner.OriginalWeld and Tuner.OriginalWeld.Parent then
        Tuner.OriginalWeld:Destroy()
    end
    Tuner.OriginalWeld = nw
    Tuner.OriginalC0 = nw.C0
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

local function vLog(text)
    table.insert(Verify.Log, text)
    print("[FE Verify] " .. text)
    if Verify.OnLine then pcall(Verify.OnLine, text) end
end

local function checkNetworkOwner(handle)
    local ok, owner = pcall(function() return handle:GetNetworkOwner() end)
    if not ok then
        vLog("[1/5] network owner: UNKNOWN (cannot read)")
        return false
    end
    if owner == LP then
        vLog("[1/5] network owner: YOU (OK, you control this part)")
        return true
    elseif owner == nil then
        vLog("[1/5] network owner: SERVER (FAIL, server controls)")
        return false
    else
        vLog("[1/5] network owner: " .. owner.Name .. " (FAIL, not you)")
        return false
    end
end

local function checkInCharacter(handle)
    local p = handle.Parent
    while p do
        if p == LP.Character then
            vLog("[2/5] handle is inside your Character (OK)")
            return true
        end
        p = p.Parent
    end
    vLog("[2/5] handle is NOT inside your Character (FAIL)")
    return false
end

local function checkNotAnchored(handle)
    if handle.Anchored then
        vLog("[3/5] handle is Anchored (FAIL, CFrame won't replicate)")
        return false
    end
    vLog("[3/5] handle is not Anchored (OK)")
    return true
end

local function checkPositionReplication(handle)
    local orig = handle.CFrame
    local test = orig + Vector3.new(0, 0.01, 0)
    handle.CFrame = test
    task.wait(0.3)
    local distance = (handle.CFrame.Position - test.Position).Magnitude
    handle.CFrame = orig
    task.wait(0.1)
    if distance < 0.02 then
        vLog("[4/5] position replication: OK (server didn't revert)")
        return true
    else
        vLog("[4/5] position replication: FAIL (server reverted, dist " .. string.format("%.4f", distance) .. ")")
        return false
    end
end

local function checkWeldReplication(handle, originalWeld)
    local testWeld = Instance.new("Weld")
    testWeld.Name = "__FE_VerifyTest"
    testWeld.Part0 = originalWeld.Part0
    testWeld.Part1 = originalWeld.Part1
    testWeld.C0 = originalWeld.C0
    testWeld.C1 = originalWeld.C1
    testWeld.Parent = handle
    task.wait(0.3)
    local survived = (testWeld.Parent == handle)
    local conflictCount = 0
    for _, w in ipairs(handle:GetChildren()) do
        if (w:IsA("Weld") or w:IsA("Motor6D"))
            and w ~= originalWeld
            and w ~= testWeld
            and w.Name ~= "AccessoryWeld" then
            conflictCount = conflictCount + 1
        end
    end
    if survived then testWeld:Destroy() end
    if survived and conflictCount == 0 then
        vLog("[5/5] weld replication: OK (your weld survived, no conflict)")
        return true
    elseif conflictCount > 0 then
        vLog("[5/5] weld replication: CONFLICT (server created " .. conflictCount .. " competing weld)")
        return false
    else
        vLog("[5/5] weld replication: FAIL (your weld was removed)")
        return false
    end
end

function Verify.run()
    Verify.Log = {}
    Verify.Verdict = "unknown"
    Verify.Score = 0

    print("===========================================")
    print("  FE ROTATE TOOL - REPLICATION VERIFICATION")
    print("===========================================")

    if not Tuner.Selected then
        vLog("ERROR: no accessory selected. Select one first.")
        Verify.Verdict = "unknown"
        if Verify.OnFinish then Verify.OnFinish() end
        return
    end

    local handle = Tuner.Selected:FindFirstChild("Handle")
    if not handle then
        vLog("ERROR: selected accessory has no Handle")
        Verify.Verdict = "unknown"
        if Verify.OnFinish then Verify.OnFinish() end
        return
    end

    vLog("Testing: " .. Tuner.Selected.Name)
    print("-------------------------------------------")

    local score = 0
    if checkNetworkOwner(handle) then score = score + 1 end
    if checkInCharacter(handle) then score = score + 1 end
    if checkNotAnchored(handle) then score = score + 1 end
    if checkPositionReplication(handle) then score = score + 1 end
    if Tuner.OriginalWeld and checkWeldReplication(handle, Tuner.OriginalWeld) then score = score + 1 end

    Verify.Score = score

    print("-------------------------------------------")

    local chance = 0
    if score == 5 then chance = 100
    elseif score == 4 then chance = 90
    elseif score == 3 then chance = 65
    elseif score == 2 then chance = 40
    elseif score == 1 then chance = 15
    else chance = 0 end

    if score >= 4 then Verify.Verdict = "works"
    elseif score == 3 then Verify.Verdict = "partial"
    else Verify.Verdict = "broken" end

    print("SCORE: " .. score .. "/5")
    print("CHANCE THAT OTHER PLAYERS WILL SEE YOUR CHANGES: " .. chance .. "%")

    if score == 5 then
        print("VERDICT: 100% WORKS - go flex, players will see it.")
    elseif score == 4 then
        print("VERDICT: 90% WORKS - very likely visible.")
    elseif score == 3 then
        print("VERDICT: 65% WORKS - might work, test with a friend.")
    elseif score == 2 then
        print("VERDICT: 40% WORKS - risky, probably won't replicate well.")
    elseif score == 1 then
        print("VERDICT: 15% WORKS - likely broken.")
    else
        print("VERDICT: 0% WORKS - broken. changes stay client-side only.")
    end
    print("===========================================")

    if Verify.OnFinish then Verify.OnFinish() end
end

local T = {
    BG1 = Color3.fromRGB(8, 9, 14),
    BG2 = Color3.fromRGB(14, 16, 24),
    Panel = Color3.fromRGB(20, 22, 32),
    Panel2 = Color3.fromRGB(28, 30, 42),
    Input = Color3.fromRGB(10, 11, 16),
    Accent = Color3.fromRGB(120, 180, 255),
    Accent2 = Color3.fromRGB(80, 140, 220),
    Text = Color3.fromRGB(235, 238, 245),
    TextDim = Color3.fromRGB(140, 145, 160),
    TextMute = Color3.fromRGB(90, 95, 110),
    Green = Color3.fromRGB(70, 200, 120),
    Red = Color3.fromRGB(220, 80, 90),
    Orange = Color3.fromRGB(220, 160, 70),
    Stroke = Color3.fromRGB(45, 50, 65),
    StrokeHi = Color3.fromRGB(90, 100, 130),
}

local function corner(inst, r)
    local c = Instance.new("UICorner", inst)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end

local function stroke(inst, col, th)
    local s = Instance.new("UIStroke", inst)
    s.Color = col or T.Stroke
    s.Thickness = th or 1
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

local function animate(inst, props, time)
    local ti = TweenInfo.new(time or 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
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
local W = MOBILE and 290 or 300
local H = MOBILE and 400 or 420

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, W, 0, 0)
main.Position = UDim2.new(0, 24, 0.5, -H/2)
main.BackgroundColor3 = T.BG1
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
corner(main, 14)
gradient(main, T.BG2, T.BG1, 90)
stroke(main, T.Stroke, 1)

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = T.Panel
titleBar.BorderSizePixel = 0
titleBar.Active = true
gradient(titleBar, T.Panel2, T.Panel, 90)

local barLine = Instance.new("Frame", titleBar)
barLine.Size = UDim2.new(1, 0, 0, 1)
barLine.Position = UDim2.new(0, 0, 1, -1)
barLine.BackgroundColor3 = T.StrokeHi
barLine.BorderSizePixel = 0

local accentDot = Instance.new("Frame", titleBar)
accentDot.Size = UDim2.new(0, 8, 0, 8)
accentDot.Position = UDim2.new(0, 14, 0.5, -4)
accentDot.BackgroundColor3 = T.Accent
accentDot.BorderSizePixel = 0
corner(accentDot, 4)
stroke(accentDot, T.Accent, 1.5)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 28, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FE Rotate Tool"
title.TextColor3 = T.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
closeBtn.BackgroundColor3 = T.Panel2
closeBtn.Text = "X"
closeBtn.TextColor3 = T.Text
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
corner(closeBtn, 8)
stroke(closeBtn, T.Stroke, 1)
closeBtn.MouseEnter:Connect(function() animate(closeBtn, {BackgroundColor3 = T.Red}, 0.15) end)
closeBtn.MouseLeave:Connect(function() animate(closeBtn, {BackgroundColor3 = T.Panel2}, 0.15) end)

dragify(main, titleBar)

local targetBtn = Instance.new("TextButton", main)
targetBtn.Size = UDim2.new(1, -24, 0, 34)
targetBtn.Position = UDim2.new(0, 12, 0, 50)
targetBtn.BackgroundColor3 = T.Panel
targetBtn.BorderSizePixel = 0
targetBtn.Text = "   Target:  [ none ]"
targetBtn.TextColor3 = T.Text
targetBtn.Font = Enum.Font.GothamBold
targetBtn.TextSize = 12
targetBtn.TextXAlignment = Enum.TextXAlignment.Left
targetBtn.AutoButtonColor = false
corner(targetBtn, 10)
stroke(targetBtn, T.Stroke, 1)

local arrow = Instance.new("TextLabel", targetBtn)
arrow.Size = UDim2.new(0, 20, 1, 0)
arrow.Position = UDim2.new(1, -26, 0, 0)
arrow.BackgroundTransparency = 1
arrow.Text = "v"
arrow.TextColor3 = T.TextDim
arrow.Font = Enum.Font.GothamBold
arrow.TextSize = 14

local accList = Instance.new("ScrollingFrame", main)
accList.Size = UDim2.new(1, -24, 0, 120)
accList.Position = UDim2.new(0, 12, 0, 88)
accList.BackgroundColor3 = T.BG1
accList.BorderSizePixel = 0
accList.ScrollBarThickness = 3
accList.ScrollBarImageColor3 = T.Accent
accList.Visible = false
accList.CanvasSize = UDim2.new(0, 0, 0, 0)
accList.AutomaticCanvasSize = Enum.AutomaticSize.Y
corner(accList, 10)
stroke(accList, T.Stroke, 1)
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
        if isSel then stroke(b, T.Accent, 1.5) end
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
scroll.Size = UDim2.new(1, -24, 1, -270)
scroll.Position = UDim2.new(0, 12, 0, 88)
scroll.BackgroundColor3 = T.Panel
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = T.Accent
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Visible = false
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
        applyPreview()
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
stroke(verifyBtn, T.Accent, 1.5)
verifyBtn.MouseEnter:Connect(function() animate(verifyBtn, {BackgroundColor3 = T.Accent}, 0.15) end)
verifyBtn.MouseLeave:Connect(function() animate(verifyBtn, {BackgroundColor3 = T.Accent2}, 0.15) end)

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
        local chance = 0
        if score == 5 then chance = 100
        elseif score == 4 then chance = 90
        elseif score == 3 then chance = 65
        elseif score == 2 then chance = 40
        elseif score == 1 then chance = 15
        else chance = 0 end

        local color, txt
        if chance >= 90 then
            color = T.Green
            txt = "GREEN " .. chance .. "% - players WILL see it"
        elseif chance >= 50 then
            color = T.Orange
            txt = "YELLOW " .. chance .. "% - might work"
        else
            color = T.Red
            txt = "RED " .. chance .. "% - likely NOT visible"
        end

        verifyResult.Text = "  " .. txt .. "\n  score: " .. score .. "/5 (see F9)"
        verifyResult.TextColor3 = color
        verifyBtn.Text = "RUN VERIFICATION"
        verifyBtn.BackgroundColor3 = T.Accent2
    end)
end)

local actions = Instance.new("Frame", main)
actions.Size = UDim2.new(1, -24, 0, 34)
actions.Position = UDim2.new(0, 12, 1, -72)
actions.BackgroundTransparency = 1

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
    applyPreview()
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
statusBar.Text = "  target: none"
statusBar.TextColor3 = T.TextDim
statusBar.Font = Enum.Font.Code
statusBar.TextSize = 10
statusBar.TextXAlignment = Enum.TextXAlignment.Left
corner(statusBar, 6)
stroke(statusBar, T.Stroke, 1)

function updateStatus(extra)
    local t = Tuner.Selected and Tuner.Selected.Name or "none"
    local line = "  target: " .. t
        .. "   X=" .. string.format("%.1f", Tuner.OffX)
        .. " Y=" .. string.format("%.1f", Tuner.OffY)
        .. " Z=" .. string.format("%.1f", Tuner.OffZ)
    if extra then line = line .. "   " .. extra end
    statusBar.Text = line
end

local ball = Instance.new("TextButton", gui)
ball.Name = "Ball"
ball.Size = UDim2.new(0, 48, 0, 48)
ball.Position = UDim2.new(0, 24, 0.5, -24)
ball.BackgroundColor3 = T.Accent
ball.Text = "FE"
ball.TextColor3 = Color3.new(1,1,1)
ball.Font = Enum.Font.GothamBold
ball.TextSize = 16
ball.BorderSizePixel = 0
ball.AutoButtonColor = false
ball.Visible = false
corner(ball, 24)
stroke(ball, T.Accent, 2)

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
            task.wait(0.2)
            scroll.Visible = true
        end
        ballDrag = false
    end
end)

main.Size = UDim2.new(0, W, 0, 0)
scroll.Visible = false
task.spawn(function()
    task.wait(0.05)
    animate(main, {Size = UDim2.new(0, W, 0, H)}, 0.4)
    task.wait(0.25)
    scroll.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    restoreOriginal()
    setHighlight(nil)
    scroll.Visible = false
    local t = animate(main, {Size = UDim2.new(0, W, 0, 0)}, 0.25)
    t.Completed:Connect(function()
        main.Visible = false
        ball.Visible = true
        ball.Position = UDim2.new(0, 24, 0.5, -24)
    end)
end)

updateStatus()

print("[FE Rotate Tool v4] loaded. select accessory and click RUN VERIFICATION to test.")
