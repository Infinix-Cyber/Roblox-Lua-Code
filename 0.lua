-- FE Rotate Tool v2
-- by Infinix-Cyber / local maze

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer

local Tuner = {
    Selected = nil,
    OriginalWeld = nil,
    OriginalC0 = nil,
    OriginalC1 = nil,
    PreviewWeld = nil,
    Highlight = nil,
    OffX = 0, OffY = 0, OffZ = 0,
    RotX = 0, RotY = 0, RotZ = 0,
}

local function computeOffset()
    return CFrame.new(Tuner.OffX, Tuner.OffY, Tuner.OffZ)
        * CFrame.Angles(math.rad(Tuner.RotX), math.rad(Tuner.RotY), math.rad(Tuner.RotZ))
end

local function findAccWeld(acc)
    local h = acc:FindFirstChild("Handle")
    if not h then return nil, nil end
    for _, c in ipairs(h:GetChildren()) do
        if c:IsA("Weld") or c:IsA("Motor6D") then
            return c, h
        end
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
    if Tuner.Highlight then
        Tuner.Highlight:Destroy()
        Tuner.Highlight = nil
    end
    if not acc then return end
    local hl = Instance.new("Highlight")
    hl.Name = "__FE_SelHL"
    hl.FillColor = Color3.fromRGB(255, 255, 255)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 1
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = acc
    hl.Parent = acc
    Tuner.Highlight = hl
end

local function clearPreview()
    if Tuner.PreviewWeld then
        Tuner.PreviewWeld:Destroy()
        Tuner.PreviewWeld = nil
    end
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

    if not acc then
        setHighlight(nil)
        return
    end

    local w = findAccWeld(acc)
    if not w then
        setHighlight(nil)
        return
    end

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

-- UI ----------------------------------------------------------

local parent = (gethui and gethui()) or CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "FE_Rotate_" .. tostring(math.random(1e4, 1e6))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = parent

local W, H = 270, 340

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0, 20, 0.5, -H/2)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(70, 70, 70)
stroke.Thickness = 1

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 34)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Active = true
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleFill = Instance.new("Frame", titleBar)
titleFill.Size = UDim2.new(1, 0, 0, 12)
titleFill.Position = UDim2.new(0, 0, 1, -12)
titleFill.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleFill.BorderSizePixel = 0
titleFill.ZIndex = titleBar.ZIndex

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FE Rotate Tool"
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.ZIndex = 2

local dragging = false
local dragStart, startPos
local dragInput

titleBar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inp.Position
        startPos = main.Position
        dragInput = inp
    end
end)

UIS.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local delta = inp.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -16, 1, -46)
content.Position = UDim2.new(0, 8, 0, 40)
content.BackgroundTransparency = 1

-- target dropdown
local accDropdown = Instance.new("TextButton", content)
accDropdown.Size = UDim2.new(1, 0, 0, 28)
accDropdown.Position = UDim2.new(0, 0, 0, 0)
accDropdown.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
accDropdown.BorderSizePixel = 0
accDropdown.Text = "  Target: [ none ]"
accDropdown.TextColor3 = Color3.fromRGB(230, 230, 230)
accDropdown.Font = Enum.Font.GothamBold
accDropdown.TextSize = 12
accDropdown.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", accDropdown).CornerRadius = UDim.new(0, 6)

local accList = Instance.new("ScrollingFrame", content)
accList.Size = UDim2.new(1, 0, 0, 110)
accList.Position = UDim2.new(0, 0, 0, 32)
accList.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
accList.BorderSizePixel = 0
accList.ScrollBarThickness = 3
accList.Visible = false
accList.CanvasSize = UDim2.new(0, 0, 0, 0)
accList.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", accList).CornerRadius = UDim.new(0, 6)
local accStroke = Instance.new("UIStroke", accList)
accStroke.Color = Color3.fromRGB(60, 60, 60)
accStroke.Thickness = 1

local accLayout = Instance.new("UIListLayout", accList)
accLayout.Padding = UDim.new(0, 2)

local function refreshAccList()
    for _, c in ipairs(accList:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
    end
    local list = listAccs()
    if #list == 0 then
        local lbl = Instance.new("TextLabel", accList)
        lbl.Size = UDim2.new(1, 0, 0, 28)
        lbl.BackgroundTransparency = 1
        lbl.Text = "  no accessories on character"
        lbl.TextColor3 = Color3.fromRGB(120, 120, 120)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        return
    end
    for i, acc in ipairs(list) do
        local selected = (Tuner.Selected == acc)
        local b = Instance.new("TextButton", accList)
        b.Size = UDim2.new(1, 0, 0, 30)
        b.BackgroundColor3 = selected and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(30, 30, 30)
        b.BorderSizePixel = 0
        b.Text = (selected and "  > " or "  ") .. acc.Name .. " (" .. i .. ")"
        b.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(220, 220, 220)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
        if selected then
            local sel = Instance.new("UIStroke", b)
            sel.Color = Color3.fromRGB(255, 255, 255)
            sel.Thickness = 1.5
        end
        b.MouseButton1Click:Connect(function()
            selectAcc(acc)
            accDropdown.Text = "  Target: " .. acc.Name
            accList.Visible = false
            updateStatus()
        end)
    end
end

accDropdown.MouseButton1Click:Connect(function()
    accList.Visible = not accList.Visible
    if accList.Visible then refreshAccList() end
end)

-- sliders
local function makeRow(yPos, label, getV, setV, step)
    local row = Instance.new("Frame", content)
    row.Size = UDim2.new(1, 0, 0, 26)
    row.Position = UDim2.new(0, 0, 0, yPos)
    row.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0, 42, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(160, 160, 160)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local minus = Instance.new("TextButton", row)
    minus.Size = UDim2.new(0, 28, 0, 22)
    minus.Position = UDim2.new(0, 46, 0.5, -11)
    minus.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    minus.BorderSizePixel = 0
    minus.Text = "-"
    minus.TextColor3 = Color3.new(1,1,1)
    minus.Font = Enum.Font.GothamBold
    minus.TextSize = 14
    minus.AutoButtonColor = false
    Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 5)

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 80, 0, 22)
    box.Position = UDim2.new(0, 78, 0.5, -11)
    box.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    box.BorderSizePixel = 0
    box.Text = string.format("%.2f", getV())
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Code
    box.TextSize = 11
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)

    local plus = Instance.new("TextButton", row)
    plus.Size = UDim2.new(0, 28, 0, 22)
    plus.Position = UDim2.new(0, 162, 0.5, -11)
    plus.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    plus.BorderSizePixel = 0
    plus.Text = "+"
    plus.TextColor3 = Color3.new(1,1,1)
    plus.Font = Enum.Font.GothamBold
    plus.TextSize = 14
    plus.AutoButtonColor = false
    Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 5)

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

local rowY = 150

local posH = Instance.new("TextLabel", content)
posH.Size = UDim2.new(1, 0, 0, 16)
posH.Position = UDim2.new(0, 0, 0, rowY)
posH.BackgroundTransparency = 1
posH.Text = "Position (studs)"
posH.TextColor3 = Color3.fromRGB(200, 200, 200)
posH.Font = Enum.Font.GothamBold
posH.TextSize = 10
posH.TextXAlignment = Enum.TextXAlignment.Left
rowY = rowY + 18

local rowX_ = makeRow(rowY, "X:", function() return Tuner.OffX end, function(v) Tuner.OffX = v end, 0.1); rowY = rowY + 28
local rowY_ = makeRow(rowY, "Y:", function() return Tuner.OffY end, function(v) Tuner.OffY = v end, 0.1); rowY = rowY + 28
local rowZ_ = makeRow(rowY, "Z:", function() return Tuner.OffZ end, function(v) Tuner.OffZ = v end, 0.1); rowY = rowY + 30

local rotH = Instance.new("TextLabel", content)
rotH.Size = UDim2.new(1, 0, 0, 16)
rotH.Position = UDim2.new(0, 0, 0, rowY)
rotH.BackgroundTransparency = 1
rotH.Text = "Rotation (degrees)"
rotH.TextColor3 = Color3.fromRGB(200, 200, 200)
rotH.Font = Enum.Font.GothamBold
rotH.TextSize = 10
rotH.TextXAlignment = Enum.TextXAlignment.Left
rowY = rowY + 18

local rowRX_ = makeRow(rowY, "RX:", function() return Tuner.RotX end, function(v) Tuner.RotX = v end, 5); rowY = rowY + 28
local rowRY_ = makeRow(rowY, "RY:", function() return Tuner.RotY end, function(v) Tuner.RotY = v end, 5); rowY = rowY + 28
local rowRZ_ = makeRow(rowY, "RZ:", function() return Tuner.RotZ end, function(v) Tuner.RotZ = v end, 5); rowY = rowY + 32

-- actions
local actions = Instance.new("Frame", content)
actions.Size = UDim2.new(1, 0, 0, 30)
actions.Position = UDim2.new(0, 0, 0, rowY)
actions.BackgroundTransparency = 1

local function makeBtn(x, w, label, color, cb)
    local b = Instance.new("TextButton", actions)
    b.Size = UDim2.new(0, w, 1, 0)
    b.Position = UDim2.new(0, x, 0, 0)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = label
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

local BW = (W - 16 - 8) / 3
makeBtn(0, BW - 4, "Reset", Color3.fromRGB(140, 95, 30), function()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    applyPreview()
    updateStatus()
end)

makeBtn(BW + 2, BW - 4, "Cancel", Color3.fromRGB(140, 40, 40), function()
    cancelAll()
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    updateStatus()
end)

makeBtn((BW + 2) * 2, BW - 4, "Commit", Color3.fromRGB(40, 130, 70), function()
    commit()
    updateStatus("committed")
end)

-- status bar
local statusBar = Instance.new("TextLabel", main)
statusBar.Size = UDim2.new(1, -16, 0, 18)
statusBar.Position = UDim2.new(0, 8, 1, -22)
statusBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
statusBar.BorderSizePixel = 0
statusBar.Text = "  target: none"
statusBar.TextColor3 = Color3.fromRGB(150, 150, 150)
statusBar.Font = Enum.Font.Code
statusBar.TextSize = 10
statusBar.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0, 4)

function updateStatus(extra)
    local t = Tuner.Selected and Tuner.Selected.Name or "none"
    local line = "  target: " .. t
        .. "  |  X=" .. string.format("%.1f", Tuner.OffX)
        .. " Y=" .. string.format("%.1f", Tuner.OffY)
        .. " Z=" .. string.format("%.1f", Tuner.OffZ)
    if extra then line = line .. "  |  " .. extra end
    statusBar.Text = line
end

closeBtn.MouseButton1Click:Connect(function()
    restoreOriginal()
    setHighlight(nil)
    gui:Destroy()
end)

print("[FE Rotate Tool v2] loaded.")
