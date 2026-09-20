-- FE Toolkit - live logger
-- by Infinix-Cyber / local maze

local Logger = {}

Logger.Config = {
    Enabled   = true,
    Character = true,
    Joints    = true,
    Workspace = false,
    Remotes   = false,
}

Logger.Lines = {}
Logger.MaxLines = 250
Logger.OnLine = nil

local function fmt(inst)
    if not inst then return "nil" end
    if typeof(inst) == "Instance" then return inst.ClassName .. "/" .. inst.Name end
    return tostring(inst)
end

local function jointStr(w)
    local p = { w.ClassName, w.Name }
    if w.Part0 then table.insert(p, "P0=" .. w.Part0.Name) end
    if w.Part1 then table.insert(p, "P1=" .. w.Part1.Name) end
    if w.C0 then table.insert(p, "C0=" .. tostring(w.C0)) end
    if w.C1 then table.insert(p, "C1=" .. tostring(w.C1)) end
    return table.concat(p, " | ")
end

local function push(text, color)
    if not Logger.Config.Enabled then return end
    local entry = { text = text, color = color, time = tick() }
    table.insert(Logger.Lines, entry)
    if #Logger.Lines > Logger.MaxLines then
        table.remove(Logger.Lines, 1)
    end
    if Logger.OnLine then
        pcall(Logger.OnLine, entry)
    end
    print("[FE] " .. text)
end

function Logger.start()
    local Players = game:GetService("Players")
    local RS = game:GetService("ReplicatedStorage")
    local WS = workspace
    local LP = Players.LocalPlayer

    RS.DescendantAdded:Connect(function(inst)
        if not Logger.Config.Remotes then return end
        if inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction") then
            push("[RS] " .. fmt(inst), Color3.fromRGB(150, 80, 220))
        end
    end)

    local function hookRemote(remote)
        if not remote:IsA("RemoteEvent") then return end
        remote.OnClientEvent:Connect(function(...)
            if not Logger.Config.Remotes then return end
            local args = {...}
            local parts = {}
            for i, v in ipairs(args) do
                table.insert(parts, "[" .. i .. "]=" .. fmt(v))
            end
            push("[REMOTE] " .. remote:GetFullName() .. " -> " .. table.concat(parts, " "), Color3.fromRGB(150, 80, 220))
        end)
    end

    for _, inst in ipairs(RS:GetDescendants()) do
        if inst:IsA("RemoteEvent") then pcall(hookRemote, inst) end
    end
    RS.DescendantAdded:Connect(function(inst)
        if inst:IsA("RemoteEvent") then pcall(hookRemote, inst) end
    end)

    WS.ChildAdded:Connect(function(inst)
        if not Logger.Config.Workspace then return end
        push("[WS+] " .. fmt(inst), Color3.fromRGB(120, 120, 120))
    end)
    WS.ChildRemoved:Connect(function(inst)
        if not Logger.Config.Workspace then return end
        push("[WS-] " .. fmt(inst), Color3.fromRGB(120, 120, 120))
    end)

    local function watchChar(char)
        push("[CHAR] " .. char.Name, Color3.fromRGB(60, 200, 90))

        char.DescendantAdded:Connect(function(inst)
            if (inst:IsA("Weld") or inst:IsA("Motor6D") or inst:IsA("WeldConstraint")) and Logger.Config.Joints then
                push("JOINT+ " .. jointStr(inst), Color3.fromRGB(230, 190, 60))
            elseif Logger.Config.Character then
                if inst:IsA("Accessory") then
                    push("ACC+ " .. inst.Name, Color3.fromRGB(150, 80, 220))
                else
                    push("+ " .. fmt(inst), Color3.fromRGB(240, 240, 240))
                end
            end
        end)

        char.DescendantRemoving:Connect(function(inst)
            if (inst:IsA("Weld") or inst:IsA("Motor6D") or inst:IsA("WeldConstraint")) and Logger.Config.Joints then
                push("JOINT- " .. jointStr(inst), Color3.fromRGB(220, 60, 60))
            elseif Logger.Config.Character and inst:IsA("Accessory") then
                push("ACC- " .. inst.Name, Color3.fromRGB(220, 60, 60))
            end
        end)
    end

    if LP.Character then watchChar(LP.Character) end
    LP.CharacterAdded:Connect(watchChar)
end

return Logger
