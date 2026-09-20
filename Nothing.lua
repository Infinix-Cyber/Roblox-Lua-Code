-- FE Rotate Tool
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
    if not acc then return end
    local w = findAccWeld(acc)
    if not w then return end
    Tuner.Selected = acc
    Tuner.OriginalWeld = w
    Tuner.OriginalC0 = w.C0
    Tuner.OriginalC1 = w.C1
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

local parent = (gethui and gethui()) or CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "FE_Rotate_" .. tostring(math.random(1e4, 1e6))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = parent

local W, H = 320, 520

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0.5, -W/2, 0.5, -H/2)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(60, 60, 60)
stroke.Thickness = 1

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

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
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.ZIndex = 2

local drag, dStart, sPos
titleBar.InputBegan:Connect(function(inp)
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

closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -16, 1, -50)
content.Position = UDim2.new(0, 8, 0, 44)
content.BackgroundTransparency = 1

local accDropdown = Instance.new("TextButton", content)
accDropdown.Size = UDim2.new(1, 0, 0, 30)
accDropdown.Position = UDim2.new(0, 0, 0, 0)
accDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
accDropdown.BorderSizePixel = 0
accDropdown.Text = "  select accessory..."
accDropdown.TextColor3 = Color3.fromRGB(220, 220, 220)
accDropdown.Font = Enum.Font.GothamBold
accDropdown.TextSize = 12
accDropdown.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", accDropdown).CornerRadius = UDim.new(0, 6)

local accList = Instance.new("ScrollingFrame", content)
accList.Size = UDim2.new(1, 0, 0, 100)
accList.Position = UDim2.new(0, 0, 0, 34)
accList.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
accList.BorderSizePixel = 0
accList.ScrollBarThickness = 4
accList.Visible = false
accList.CanvasSize = UDim2.new(0, 0, 0, 0)
accList.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", accList).CornerRadius = UDim.new(0, 6)

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
        local b = Instance.new("TextButton", accList)
        b.Size = UDim2.new(1, 0, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        b.BorderSizePixel = 0
        b.Text = "  " .. acc.Name .. " (" .. i .. ")"
        b.TextColor3 = Color3.fromRGB(220, 220, 220)
        b.Font = Enum.Font.Gotham
        b.TextSize = 12
        b.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
        b.MouseButton1Click:Connect(function()
            selectAcc(acc)
            accDropdown.Text = "  " .. acc.Name
            accList.Visible = false
        end)
    end
end

accDropdown.MouseButton1Click:Connect(function()
    accList.Visible = not accList.Visible
    if accList.Visible then refreshAccList() end
end)

local function makeRow(yPos, label, getV, setV, step)
    local row = Instance.new("Frame", content)
    row.Size = UDim2.new(1, 0, 0, 28)
    row.Position = UDim2.new(0, 0, 0, yPos)
    row.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0, 46, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(150, 150, 150)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local minus = Instance.new("TextButton", row)
    minus.Size = UDim2.new(0, 30, 0, 24)
    minus.Position = UDim2.new(0, 50, 0.5, -12)
    minus.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    minus.BorderSizePixel = 0
    minus.Text = "-"
    minus.TextColor3 = Color3.new(1,1,1)
    minus.Font = Enum.Font.GothamBold
    minus.TextSize = 14
    Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 5)

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 90, 0, 24)
    box.Position = UDim2.new(0, 84, 0.5, -12)
    box.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    box.BorderSizePixel = 0
    box.Text = string.format("%.2f", getV())
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Code
    box.TextSize = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)

    local plus = Instance.new("TextButton", row)
    plus.Size = UDim2.new(0, 30, 0, 24)
    plus.Position = UDim2.new(0, 178, 0.5, -12)
    plus.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    plus.BorderSizePixel = 0
    plus.Text = "+"
    plus.TextColor3 = Color3.new(1,1,1)
    plus.Font = Enum.Font.GothamBold
    plus.TextSize = 14
    Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 5)

    local function apply(v)
        setV(v)
        box.Text = string.format("%.2f", v)
        applyPreview()
    end

    minus.MouseButton1Click:Connect(function() apply(getV() - step) end)
    plus.MouseButton1Click:Connect(function() apply(getV() + step) end)
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then apply(n) else box.Text = string.format("%.2f", getV()) end
    end)

    return { setText = function(v) box.Text = string.format("%.2f", v) end }
end

local rowY = 140

local posH = Instance.new("TextLabel", content)
posH.Size = UDim2.new(1, 0, 0, 18)
posH.Position = UDim2.new(0, 0, 0, rowY)
posH.BackgroundTransparency = 1
posH.Text = "Position (studs)"
posH.TextColor3 = Color3.fromRGB(200, 200, 200)
posH.Font = Enum.Font.GothamBold
posH.TextSize = 11
posH.TextXAlignment = Enum.TextXAlignment.Left
rowY = rowY + 20

local rowX_ = makeRow(rowY, "X:", function() return Tuner.OffX end, function(v) Tuner.OffX = v end, 0.1); rowY = rowY + 30
local rowY_ = makeRow(rowY, "Y:", function() return Tuner.OffY end, function(v) Tuner.OffY = v end, 0.1); rowY = rowY + 30
local rowZ_ = makeRow(rowY, "Z:", function() return Tuner.OffZ end, function(v) Tuner.OffZ = v end, 0.1); rowY = rowY + 32

local rotH = Instance.new("TextLabel", content)
rotH.Size = UDim2.new(1, 0, 0, 18)
rotH.Position = UDim2.new(0, 0, 0, rowY)
rotH.BackgroundTransparency = 1
rotH.Text = "Rotation (degrees)"
rotH.TextColor3 = Color3.fromRGB(200, 200, 200)
rotH.Font = Enum.Font.GothamBold
rotH.TextSize = 11
rotH.TextXAlignment = Enum.TextXAlignment.Left
rowY = rowY + 20

local rowRX_ = makeRow(rowY, "RX:", function() return Tuner.RotX end, function(v) Tuner.RotX = v end, 5); rowY = rowY + 30
local rowRY_ = makeRow(rowY, "RY:", function() return Tuner.RotY end, function(v) Tuner.RotY = v end, 5); rowY = rowY + 30
local rowRZ_ = makeRow(rowY, "RZ:", function() return Tuner.RotZ end, function(v) Tuner.RotZ = v end, 5); rowY = rowY + 34

local actions = Instance.new("Frame", content)
actions.Size = UDim2.new(1, 0, 0, 32)
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
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

local BW = (W - 16 - 8) / 3
makeBtn(0, BW - 4, "Reset", Color3.fromRGB(150, 100, 30), function()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
    applyPreview()
end)

makeBtn(BW + 2, BW - 4, "Cancel", Color3.fromRGB(140, 40, 40), function()
    cancelAll()
    rowX_.setText(0); rowY_.setText(0); rowZ_.setText(0)
    rowRX_.setText(0); rowRY_.setText(0); rowRZ_.setText(0)
end)

makeBtn((BW + 2) * 2, BW - 4, "Commit", Color3.fromRGB(40, 130, 70), function()
    commit()
end)

print("[FE Rotate Tool] loaded.")
