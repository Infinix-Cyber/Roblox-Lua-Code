-- FE Toolkit - hat tuner
-- by Infinix-Cyber / local maze
-- preview / cancel / commit

local Tuner = {}

Tuner.Selected = nil
Tuner.OriginalWeld = nil
Tuner.OriginalC0 = nil
Tuner.OriginalC1 = nil
Tuner.PreviewWeld = nil
Tuner.CommittedWeld = nil
Tuner.KeeperConn = nil
Tuner.OffX, Tuner.OffY, Tuner.OffZ = 0, 0, 0
Tuner.RotX, Tuner.RotY, Tuner.RotZ = 0, 0, 0
Tuner.OnUpdate = nil

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

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

    local lp = Players.LocalPlayer
    if lp.Character then
        for _, bp in ipairs(lp.Character:GetChildren()) do
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

function Tuner.stopKeeper()
    if Tuner.KeeperConn then
        Tuner.KeeperConn:Disconnect()
        Tuner.KeeperConn = nil
    end
end

function Tuner.startKeeper()
    Tuner.stopKeeper()

    Tuner.KeeperConn = RunService.Heartbeat:Connect(function()
        if not Tuner.Selected or not Tuner.CommittedWeld then return end
        if not Tuner.CommittedWeld.Parent then
            -- наш Weld кто-то удалил — пересоздать
            local h = Tuner.Selected:FindFirstChild("Handle")
            if not h then return end
            local p0 = Tuner.CommittedWeld.Part0
            local p1 = Tuner.CommittedWeld.Part1
            if not p0 or not p1 then return end

            local nw = Instance.new("Weld")
            nw.Name = "__FE_CommittedWeld"
            nw.Part0 = p0
            nw.Part1 = p1
            nw.C0 = Tuner.CommittedWeld.C0
            nw.C1 = Tuner.CommittedWeld.C1
            nw.Parent = h
            Tuner.CommittedWeld = nw
        end

        -- удалить чужие Weld'ы к этому Handle (серверные)
        local h = Tuner.Selected:FindFirstChild("Handle")
        if not h then return end
        local lp = Players.LocalPlayer
        if lp.Character then
            for _, bp in ipairs(lp.Character:GetChildren()) do
                if bp:IsA("BasePart") then
                    for _, w in ipairs(bp:GetChildren()) do
                        if (w:IsA("Weld") or w:IsA("Motor6D"))
                            and (w.Part0 == h or w.Part1 == h)
                            and w ~= Tuner.CommittedWeld
                            and w ~= Tuner.PreviewWeld then
                            w:Destroy()
                        end
                    end
                end
            end
        end
        for _, w in ipairs(h:GetChildren()) do
            if (w:IsA("Weld") or w:IsA("Motor6D"))
                and w ~= Tuner.CommittedWeld
                and w ~= Tuner.PreviewWeld then
                w:Destroy()
            end
        end
    end)
end

function Tuner.restoreOriginal()
    if not Tuner.Selected then return end
    local h = Tuner.Selected:FindFirstChild("Handle")
    if not h then return end

    Tuner.stopKeeper()
    Tuner.clearPreview()

    -- удалить всё что не оригинал
    local lp = Players.LocalPlayer
    if lp.Character then
        for _, bp in ipairs(lp.Character:GetChildren()) do
            if bp:IsA("BasePart") then
                for _, w in ipairs(bp:GetChildren()) do
                    if (w:IsA("Weld") or w:IsA("Motor6D"))
                        and (w.Part0 == h or w.Part1 == h)
                        and w ~= Tuner.OriginalWeld
                        and w ~= Tuner.CommittedWeld then
                        w:Destroy()
                    end
                end
            end
        end
    end
    for _, w in ipairs(h:GetChildren()) do
        if (w:IsA("Weld") or w:IsA("Motor6D"))
            and w ~= Tuner.OriginalWeld
            and w ~= Tuner.CommittedWeld then
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

    if Tuner.CommittedWeld then
        Tuner.CommittedWeld:Destroy()
        Tuner.CommittedWeld = nil
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
    if Tuner.CommittedWeld and Tuner.CommittedWeld.Parent then
        Tuner.CommittedWeld.Parent = nil
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

    Tuner.clearPreview()

    if Tuner.CommittedWeld then
        Tuner.CommittedWeld:Destroy()
        Tuner.CommittedWeld = nil
    end

    local nw = Instance.new("Weld")
    nw.Name = "__FE_CommittedWeld"
    nw.Part0 = Tuner.OriginalWeld.Part0
    nw.Part1 = Tuner.OriginalWeld.Part1
    nw.C1 = Tuner.OriginalC1
    nw.C0 = Tuner.OriginalC0 * computeOffset()
    nw.Parent = h

    if Tuner.OriginalWeld and Tuner.OriginalWeld.Parent then
        Tuner.OriginalWeld:Destroy()
    end
    Tuner.OriginalWeld = nil

    Tuner.CommittedWeld = nw
    Tuner.startKeeper()

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
    local lp = Players.LocalPlayer
    if not lp.Character then return list end
    for _, c in ipairs(lp.Character:GetChildren()) do
        if c:IsA("Accessory") and c:FindFirstChild("Handle") then
            table.insert(list, c)
        end
    end
    return list
end

return Tuner
