-- FE Toolkit - hat tuner
-- by Infinix-Cyber / local maze
-- preview / cancel / commit

local Tuner = {}

Tuner.Selected = nil
Tuner.OriginalWeld = nil
Tuner.OriginalC0 = nil
Tuner.OriginalC1 = nil
Tuner.PreviewWeld = nil
Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
Tuner.OnUpdate = nil

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

    local LP = game:GetService("Players").LocalPlayer
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

function Tuner.clearPreview()
    if Tuner.PreviewWeld then
        Tuner.PreviewWeld:Destroy()
        Tuner.PreviewWeld = nil
    end
end

function Tuner.restoreOriginal()
    if not Tuner.Selected then return end
    local h = Tuner.Selected:FindFirstChild("Handle")
    if not h then return end

    Tuner.clearPreview()

    local LP = game:GetService("Players").LocalPlayer
    if LP.Character then
        for _, bp in ipairs(LP.Character:GetChildren()) do
            if bp:IsA("BasePart") then
                for _, w in ipairs(bp:GetChildren()) do
                    if (w:IsA("Weld") or w:IsA("Motor6D")) and (w.Part0 == h or w.Part1 == h) and w ~= Tuner.OriginalWeld then
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

function Tuner.applyPreview()
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

function Tuner.selectAcc(acc)
    Tuner.restoreOriginal()
    Tuner.Selected = nil
    Tuner.OriginalWeld = nil
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0

    if not acc then
        if Tuner.OnUpdate then Tuner.OnUpdate() end
        return
    end

    local w, h = findAccWeld(acc)
    if not w then
        if Tuner.OnUpdate then Tuner.OnUpdate() end
        return
    end

    Tuner.Selected = acc
    Tuner.OriginalWeld = w
    Tuner.OriginalC0 = w.C0
    Tuner.OriginalC1 = w.C1

    if Tuner.OnUpdate then Tuner.OnUpdate() end
end

function Tuner.cancel()
    Tuner.restoreOriginal()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
    if Tuner.OnUpdate then Tuner.OnUpdate() end
end

function Tuner.commit()
    if not Tuner.Selected or not Tuner.OriginalWeld then return end
    local h = Tuner.Selected:FindFirstChild("Handle")
    if not h then return end

    local newWeld = Instance.new("Weld")
    newWeld.Name = "AccessoryWeld"
    newWeld.Part0 = Tuner.OriginalWeld.Part0
    newWeld.Part1 = Tuner.OriginalWeld.Part1
    newWeld.C1 = Tuner.OriginalC1
    newWeld.C0 = Tuner.OriginalC0 * computeOffset()
    newWeld.Parent = h

    Tuner.clearPreview()
    if Tuner.OriginalWeld and Tuner.OriginalWeld.Parent then
        Tuner.OriginalWeld:Destroy()
    end

    Tuner.OriginalWeld = newWeld
    Tuner.OriginalC0 = newWeld.C0
    if Tuner.OnUpdate then Tuner.OnUpdate() end
end

function Tuner.reset()
    Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
    Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
    Tuner.applyPreview()
    if Tuner.OnUpdate then Tuner.OnUpdate() end
end

function Tuner.listAccessories()
    local list = {}
    local LP = game:GetService("Players").LocalPlayer
    if not LP.Character then return list end
    for _, c in ipairs(LP.Character:GetChildren()) do
        if c:IsA("Accessory") and c:FindFirstChild("Handle") then
            table.insert(list, c)
        end
    end
    return list
end

return Tuner
