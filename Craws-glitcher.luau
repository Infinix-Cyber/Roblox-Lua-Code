--[[
   SOL'S RNG GLITCHER ULTIMATE v8.0 (FINAL)
   - All 31 auras with proper colors (no green default)
   - Equinox rings, Creator rings
   - Reanimation, animations, music
   - Debug label shows status
   - Auto-kill on load, K to kill again
--]]

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Jskfhggjxu/My-Script/refs/heads/main/VirtualKeyboard.lua"))()
end)

-- Whitelist
local allowed = {"TheLocalMazeV2","TheLocalMaze","Quur92","BAcON_KJpast"}
local Player = game.Players.LocalPlayer
if not table.find(allowed, Player.Name) then
    local g = Instance.new("ScreenGui")
    g.Parent = Player.PlayerGui
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,1,0)
    l.Text = "UNAUTHORIZED"
    l.TextScaled = true
    l.TextColor3 = Color3.new(1,0,0)
    l.BackgroundTransparency = 1
    l.Parent = g
    return
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Settings
local Settings = {
    Enabled = true,
    CurrentAura = 0,          -- None (no particles)
    CurrentPage = 1,
    Volume = 0.5,
    Mute = false,
    DebugMode = true,
    AutoReanimate = true,
    AnimationSpeed = 1.0,
    ParticleRate = 80,
    ParticleSize = 1.0,
    EnableParticles = true,
    EnableMusic = true,
    EnableAnimations = true,
    EnableReanimation = true,
}

-- ==================== ALL 31 AURAS (Correct Colors) ====================
local auras = {
    [0] = {name="None", color=Color3.new(0.5,0.5,0.5), music=nil, special=nil, particle={rate=0,size=0,transparency=1,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Common"},
    [1] = {name="Matrix", color=Color3.new(0,1,0), music=9120589593, special=nil, particle={rate=80,size=1.2,transparency=0.4,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Uncommon"},
    [2] = {name="Archangel", color=Color3.new(1,1,0), music=9120589594, special=nil, particle={rate=90,size=1.5,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Rare"},
    [3] = {name="Symphony", color=Color3.new(0.5,0.8,1), music=9120589595, special=nil, particle={rate=100,size=1.0,transparency=0.2,texture="rbxasset://textures/particles/star.dds"}, rarity="Epic"},
    [4] = {name="Overture", color=Color3.new(1,0.5,0), music=9120589596, special=nil, particle={rate=85,size=1.3,transparency=0.5,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [5] = {name="Gargantua", color=Color3.new(0.8,0.2,0.8), music=9120589597, special=nil, particle={rate=120,size=2.0,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [6] = {name="Chronos", color=Color3.new(0,1,1), music=9120589598, special=nil, particle={rate=70,size=1.0,transparency=0.2,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Legendary"},
    [7] = {name="Glitch", color=Color3.new(0,1,0.5), music=9120589599, special=nil, particle={rate=150,size=0.8,transparency=0.6,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Mythical"},
    [8] = {name="Equinox", color=Color3.new(0.5,0.5,1), music=9120589600, special="EquinoxRings", particle={rate=60,size=1.5,transparency=0.4,texture="rbxasset://textures/particles/glow.dds"}, rarity="Divine"},
    [9] = {name="Nebula", color=Color3.new(0.6,0,0.8), music=9120589601, special=nil, particle={rate=80,size=2.0,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [10] = {name="Eclipse", color=Color3.new(0.8,0.4,0), music=9120589602, special=nil, particle={rate=90,size=1.2,transparency=0.4,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [11] = {name="Supernova", color=Color3.new(1,0.8,0.2), music=9120589603, special=nil, particle={rate=200,size=3.0,transparency=0.1,texture="rbxasset://textures/particles/glow.dds"}, rarity="Divine"},
    [12] = {name="Void", color=Color3.new(0.1,0.1,0.1), music=9120589604, special=nil, particle={rate=30,size=1.0,transparency=0.8,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Mythical"},
    [13] = {name="Celestial", color=Color3.new(0.2,0.5,1), music=9120589605, special=nil, particle={rate=70,size=1.4,transparency=0.2,texture="rbxasset://textures/particles/star.dds"}, rarity="Legendary"},
    [14] = {name="Inferno", color=Color3.new(1,0.2,0), music=9120589606, special=nil, particle={rate=120,size=1.8,transparency=0.3,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [15] = {name="Frost", color=Color3.new(0,1,1), music=9120589607, special=nil, particle={rate=60,size=1.0,transparency=0.2,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Rare"},
    [16] = {name="Nature", color=Color3.new(0,0.8,0), music=9120589608, special=nil, particle={rate=50,size=1.0,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Uncommon"},
    [17] = {name="Light", color=Color3.new(1,1,0.8), music=9120589609, special=nil, particle={rate=100,size=1.2,transparency=0.1,texture="rbxasset://textures/particles/glow.dds"}, rarity="Rare"},
    [18] = {name="Dark", color=Color3.new(0.2,0.2,0.2), music=9120589610, special=nil, particle={rate=40,size=1.0,transparency=0.7,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Rare"},
    [19] = {name="Cosmic", color=Color3.new(0.8,0,0.8), music=9120589611, special=nil, particle={rate=90,size=1.6,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [20] = {name="Omega", color=Color3.new(1,0,0), music=9120589612, special=nil, particle={rate=150,size=2.5,transparency=0.2,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Divine"},
    [21] = {name="Solar", color=Color3.new(1,0.8,0.4), music=9120589613, special=nil, particle={rate=110,size=2.0,transparency=0.2,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [22] = {name="Lunar", color=Color3.new(0.8,0.8,1), music=9120589614, special=nil, particle={rate=70,size=1.5,transparency=0.3,texture="rbxasset://textures/particles/star.dds"}, rarity="Rare"},
    [23] = {name="Blood", color=Color3.new(0.8,0,0), music=9120589615, special=nil, particle={rate=90,size=1.2,transparency=0.4,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [24] = {name="Shadow", color=Color3.new(0.1,0.1,0.2), music=9120589616, special=nil, particle={rate=40,size=0.8,transparency=0.8,texture="rbxasset://textures/particles/dark.dds"}, rarity="Mythical"},
    [25] = {name="Storm", color=Color3.new(0.4,0.6,1), music=9120589617, special=nil, particle={rate=130,size=1.0,transparency=0.3,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Legendary"},
    [26] = {name="Abyss", color=Color3.new(0,0,0.2), music=9120589618, special=nil, particle={rate=20,size=0.5,transparency=0.9,texture="rbxasset://textures/particles/dark.dds"}, rarity="Epic"},
    [27] = {name="Aether", color=Color3.new(0.6,0.2,0.8), music=9120589619, special=nil, particle={rate=80,size=1.5,transparency=0.2,texture="rbxasset://textures/particles/glow.dds"}, rarity="Divine"},
    [28] = {name="Phoenix", color=Color3.new(1,0.4,0), music=9120589620, special=nil, particle={rate=120,size=2.0,transparency=0.1,texture="rbxasset://textures/particles/fire.dds"}, rarity="Mythical"},
    [29] = {name="Voidwalker", color=Color3.new(0.2,0,0.4), music=9120589621, special=nil, particle={rate=60,size=1.0,transparency=0.6,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Legendary"},
    [30] = {name="Creator", color=Color3.new(1,1,1), music=9120589622, special="CreatorRings", particle={rate=200,size=3.0,transparency=0.0,texture="rbxasset://textures/particles/glow.dds"}, rarity="Creator"},
}

-- State
local character, humanoid, rootPart
local isDead = false
local limbWelds = {}
local currentSound = nil
local currentPose = "idle"
local overridePose = nil
local heartbeatConn
local killDone = false
local flashGui = nil

-- Limb names
local limbNamesR6 = {"Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg"}
local limbNamesR15 = {"Head","UpperTorso","LowerTorso","LeftUpperArm","RightUpperArm","LeftLowerArm","RightLowerArm","LeftUpperLeg","RightUpperLeg","LeftLowerLeg","RightLowerLeg"}

-- Utilities
local function getCharType(char)
    return char:FindFirstChild("UpperTorso") and "R15" or "R6"
end

-- Network ownership
local function claim(part)
    if part and part:IsA("BasePart") then
        part.Velocity = Vector3.new(0, -25.05, 0)
        part:SetNetworkOwner(Player)
    end
end

-- Reanimation
local function clearWelds()
    for _, w in pairs(limbWelds) do w:Destroy() end
    limbWelds = {}
end

local function setupReanimation(char)
    if not Settings.EnableReanimation then return end
    clearWelds()
    if not rootPart then return end
    local isR15 = getCharType(char) == "R15"
    local list = isR15 and limbNamesR15 or limbNamesR6
    for _, name in ipairs(list) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") and part ~= rootPart then
            part.Anchored = false
            claim(part)
            local w = Instance.new("Weld")
            w.Part0 = rootPart
            w.Part1 = part
            w.C0 = rootPart.CFrame:inverse() * part.CFrame
            w.Parent = part
            limbWelds[part] = w
        end
    end
    -- Gentle float
    if rootPart then
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 2, 0)
        bv.MaxForce = Vector3.new(0, 1000, 0)
        bv.Parent = rootPart
        task.wait(0.5)
        bv:Destroy()
    end
end

-- Effects (clear first, apply only if aura != 0)
local function clearEffects(char)
    if not char then return end
    for _, child in ipairs(char:GetDescendants()) do
        if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") or child:IsA("Attachment") then
            child:Destroy()
        end
    end
    for _, part in ipairs(char:GetChildren()) do
        if part.Name == "EquinoxRing" or part.Name == "CreatorRing" then
            part:Destroy()
        end
    end
end

local function applyEffects(mod, char)
    if currentSound then
        currentSound:Stop()
        currentSound:Destroy()
        currentSound = nil
    end
    if not Settings.Enabled or not char then
        clearEffects(char)
        return
    end
    clearEffects(char) -- always clear first
    if mod == 0 then return end -- None: no particles, no music
    if not Settings.EnableParticles then return end

    local aura = auras[mod]
    if not aura then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Particles
    local p = aura.particle
    if p and p.rate > 0 then
        local att = Instance.new("Attachment")
        att.Parent = root
        local emit = Instance.new("ParticleEmitter")
        emit.Parent = att
        emit.Color = ColorSequence.new(aura.color)
        emit.Rate = p.rate * (Settings.ParticleRate / 80)
        emit.Lifetime = NumberRange.new(1,2)
        emit.SpreadAngle = Vector2.new(360,360)
        emit.VelocityInheritance = 0
        emit.Texture = p.texture or "rbxasset://textures/particles/sparkles_main.dds"
        emit.Size = NumberSequence.new(p.size * Settings.ParticleSize)
        emit.Transparency = NumberSequence.new(p.transparency or 0.5)
        emit.Rotation = NumberSequence.new(0,360)
        emit.RotSpeed = NumberRange.new(10,30)
        emit.Drag = 0.5
    end

    -- Special rings
    if aura.special == "EquinoxRings" then
        local function createRing(off, col, rev)
            local ring = Instance.new("Part")
            ring.Size = Vector3.new(6,0.2,6)
            ring.Anchored = false
            ring.CanCollide = false
            ring.Transparency = 0.6
            ring.Material = Enum.Material.Neon
            ring.Color = col
            ring.Name = "EquinoxRing"
            ring.Parent = char
            local w = Instance.new("Weld")
            w.Part0 = root
            w.Part1 = ring
            w.C0 = CFrame.new(0, off, 0) * CFrame.Angles(math.rad(90),0,0)
            w.Parent = ring
            ring.CustomProperty = {reverse = rev}
        end
        createRing(0.5, Color3.new(1,1,1), false)
        createRing(-0.5, Color3.new(0,0,0), true)
    end
    if aura.special == "CreatorRings" then
        for i = 1, 6 do
            local ring = Instance.new("Part")
            ring.Size = Vector3.new(8,0.1,8)
            ring.Anchored = false
            ring.CanCollide = false
            ring.Transparency = 0.4
            ring.Material = Enum.Material.Neon
            ring.Color = Color3.fromHSV((i-1)/6, 1, 1)
            ring.Name = "CreatorRing"
            ring.Parent = char
            local w = Instance.new("Weld")
            w.Part0 = root
            w.Part1 = ring
            local angle = math.rad(i * 60)
            w.C0 = CFrame.new(0, 0.5, 0) * CFrame.Angles(math.rad(90), angle, 0)
            w.Parent = ring
            ring.CustomProperty = {speed = 1 + i * 0.2}
        end
    end

    -- Music
    if Settings.EnableMusic and not Settings.Mute and aura.music then
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://" .. aura.music
        s.Volume = Settings.Volume
        s.Looped = true
        s.Parent = char
        s:Play()
        currentSound = s
    end
end

-- Animation library
local animations = {
    idle = function(root) local t=tick()*0.5*Settings.AnimationSpeed; root.CFrame=root.CFrame+Vector3.new(0,math.sin(t)*0.05,0) end,
    hover = function(root) local t=tick()*2*Settings.AnimationSpeed; root.CFrame=root.CFrame+Vector3.new(0,math.sin(t)*0.3,0) end,
    run = function(root) local t=tick()*4*Settings.AnimationSpeed; root.CFrame=root.CFrame+Vector3.new(0,math.sin(t)*0.05,0) end,
    jump = function(root) end,
    dead = function(root) 
        local t = tick() * 1.5 * Settings.AnimationSpeed
        root.CFrame = root.CFrame + Vector3.new(0, math.sin(t) * 0.5, 0)
        root.CFrame = root.CFrame * CFrame.Angles(0, math.sin(t) * 0.02, 0)
    end,
    spin = function(root) local t=tick()*2*Settings.AnimationSpeed; root.CFrame=root.CFrame*CFrame.Angles(0,math.rad(t*30),0) end,
    tpose = function(root) end,
}

local function applyPose(pose, root)
    if not Settings.EnableAnimations then return end
    local anim = animations[pose]
    if anim then anim(root) end
end

-- Screen flash
local function showDeathEffect()
    if flashGui then flashGui:Destroy() end
    flashGui = Instance.new("ScreenGui")
    flashGui.Parent = Player.PlayerGui
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundColor3 = Color3.new(0.8,0,0)
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel = 0
    frame.Parent = flashGui
    TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 0.2}):Play()
    task.wait(0.5)
    TweenService:Create(frame, TweenInfo.new(0.8), {BackgroundTransparency = 0.9}):Play()
    task.wait(0.8)
    flashGui:Destroy()
    flashGui = nil
end

-- Character events
local function onCharacterAdded(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    isDead = false
    clearWelds()
    applyEffects(Settings.CurrentAura, char)

    humanoid.Died:Connect(function()
        isDead = true
        if Settings.AutoReanimate then
            for _, p in ipairs(char:GetChildren()) do
                if p:IsA("BasePart") then claim(p) end
            end
            setupReanimation(char)
            showDeathEffect()
        end
    end)

    if not killDone then
        killDone = true
        task.wait(0.5)
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0
        end
    end
end

Player.CharacterAdded:Connect(onCharacterAdded)
if Player.Character then onCharacterAdded(Player.Character) end

-- Main loop
heartbeatConn = RunService.Heartbeat:Connect(function()
    if not Settings.Enabled or not character or not rootPart then return end

    for _, p in ipairs(character:GetChildren()) do
        if p:IsA("BasePart") then claim(p) end
    end

    local pose = "idle"
    local alive = humanoid and humanoid.Health > 0
    if overridePose then
        pose = overridePose
    elseif alive then
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            pose = "hover"
        elseif humanoid.MoveDirection.Magnitude > 0.1 then
            pose = "run"
        elseif humanoid.Jump then
            pose = "jump"
        end
    else
        pose = "dead"
    end
    currentPose = pose

    if pose == "tpose" then
        local isR15 = getCharType(character) == "R15"
        for part, w in pairs(limbWelds) do
            local name = part.Name
            if isR15 then
                if name == "LeftUpperArm" or name == "LeftLowerArm" then
                    w.C0 = CFrame.new(-1.5,0.5,0) * CFrame.Angles(0,0,math.rad(90))
                elseif name == "RightUpperArm" or name == "RightLowerArm" then
                    w.C0 = CFrame.new(1.5,0.5,0) * CFrame.Angles(0,0,math.rad(-90))
                end
            else
                if name == "LeftArm" then
                    w.C0 = CFrame.new(-1.5,0.5,0) * CFrame.Angles(0,0,math.rad(90))
                elseif name == "RightArm" then
                    w.C0 = CFrame.new(1.5,0.5,0) * CFrame.Angles(0,0,math.rad(-90))
                end
            end
        end
    else
        applyPose(pose, rootPart)
    end

    -- Rotate special rings
    for _, child in ipairs(character:GetChildren()) do
        if child.Name == "EquinoxRing" and child:IsA("BasePart") then
            local w = child:FindFirstChildOfClass("Weld")
            if w then
                local rev = child.CustomProperty and child.CustomProperty.reverse or false
                local a = (rev and -1 or 1) * 0.03 * Settings.AnimationSpeed
                w.C0 = w.C0 * CFrame.Angles(0, a, 0)
            end
        end
        if child.Name == "CreatorRing" and child:IsA("BasePart") then
            local w = child:FindFirstChildOfClass("Weld")
            if w then
                local speed = child.CustomProperty and child.CustomProperty.speed or 1
                local a = speed * 0.05 * Settings.AnimationSpeed
                w.C0 = w.C0 * CFrame.Angles(0, a, 0)
            end
        end
    end
end)

-- ==================== DEBUG LABEL ====================
local debugLabel = Instance.new("TextLabel")
debugLabel.Size = UDim2.new(0.5,0,0.05,0)
debugLabel.Position = UDim2.new(0.25,0,0,0)
debugLabel.BackgroundTransparency = 1
debugLabel.Text = ""
debugLabel.TextScaled = true
debugLabel.Font = Enum.Font.Gotham
debugLabel.TextColor3 = Color3.new(1,1,0)
debugLabel.Parent = Player.PlayerGui

RunService.RenderStepped:Connect(function()
    debugLabel.Text = string.format(
        "Aura:%d | Pose:%s | Override:%s | Dead:%s | Welds:%d | Owned:%s",
        Settings.CurrentAura,
        currentPose,
        overridePose or "none",
        tostring(isDead),
        #limbWelds,
        tostring(rootPart and rootPart:GetNetworkOwner() == Player)
    )
end)

-- ==================== KEYBINDS ====================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    local key = input.KeyCode

    if key == Enum.KeyCode.K then
        if humanoid then humanoid.Health = 0 end
        return
    end
    if key == Enum.KeyCode.P then
        Settings.Enabled = not Settings.Enabled
        if Settings.Enabled then
            applyEffects(Settings.CurrentAura, character)
            if isDead then setupReanimation(character) end
        else
            clearEffects(character)
            clearWelds()
            if currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil end
        end
        return
    end
    if key == Enum.KeyCode.M then
        Settings.CurrentPage = Settings.CurrentPage == 1 and 2 or 1
        return
    end
    if key == Enum.KeyCode.G then
        overridePose = overridePose == "spin" and nil or "spin"
        return
    end
    if key == Enum.KeyCode.T then
        overridePose = overridePose == "tpose" and nil or "tpose"
        return
    end

    local mod = nil
    if Settings.CurrentPage == 1 then
        if key >= Enum.KeyCode.Zero and key <= Enum.KeyCode.Nine then
            mod = key.Value - 48
        end
    else
        if key >= Enum.KeyCode.Zero and key <= Enum.KeyCode.Nine then
            local num = key.Value - 48
            mod = num == 0 and 10 or 10 + num
        end
    end
    if mod and mod >= 0 and mod <= 19 then
        Settings.CurrentAura = mod
        applyEffects(mod, character)
    end
end)

-- ==================== SIMPLE GUI ====================
local gui = Instance.new("ScreenGui")
gui.Name = "AuraGUI"
gui.Parent = Player.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0.3,0,0.35,0)
main.Position = UDim2.new(0.35,0,0.35,0)
main.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
main.BackgroundTransparency = 0.3
main.BorderSizePixel = 0
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.12,0)
title.BackgroundTransparency = 1
title.Text = "SOL'S RNG ULTIMATE"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(0.4,0,0.15,0)
killBtn.Position = UDim2.new(0.3,0,0.15,0)
killBtn.BackgroundColor3 = Color3.new(0.6,0,0)
killBtn.Text = "💀 KILL"
killBtn.TextScaled = true
killBtn.Font = Enum.Font.GothamBold
killBtn.TextColor3 = Color3.new(1,1,1)
killBtn.BorderSizePixel = 0
killBtn.Parent = main
killBtn.MouseButton1Click:Connect(function()
    if humanoid then humanoid.Health = 0 end
end)

local auraLabel = Instance.new("TextLabel")
auraLabel.Size = UDim2.new(1,0,0.15,0)
auraLabel.Position = UDim2.new(0,0,0.35,0)
auraLabel.BackgroundTransparency = 1
auraLabel.Text = "Aura: None"
auraLabel.TextScaled = true
auraLabel.Font = Enum.Font.Gotham
auraLabel.TextColor3 = Color3.new(1,1,1)
auraLabel.Parent = main

local function updateAuraLabel()
    local a = auras[Settings.CurrentAura]
    auraLabel.Text = "Aura: " .. (a and a.name or "Unknown")
end
updateAuraLabel()

-- Override applyEffects to update label
local oldApply = applyEffects
applyEffects = function(mod, char)
    oldApply(mod, char)
    updateAuraLabel()
end

local instr = Instance.new("TextLabel")
instr.Size = UDim2.new(1,0,0.15,0)
instr.Position = UDim2.new(0,0,0.55,0)
instr.BackgroundTransparency = 1
instr.Text = "P=toggle | M=page | 0-9=auras | G=spin | T=tpose | K=kill"
instr.TextScaled = true
instr.Font = Enum.Font.Gotham
instr.TextColor3 = Color3.new(0.7,0.7,0.7)
instr.Parent = main

-- ==================== STARTUP ====================
StarterGui:SetCore("SendNotification", {
    Title = "SOL'S RNG ULTIMATE",
    Text = "Auto-kill enabled. Aura 0 = None (no green sparkles). Press K to die.",
    Duration = 5
})

pcall(function()
    local chat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chat then
        local say = chat:FindFirstChild("SayMessageRequest")
        if say and say:IsA("RemoteEvent") then
            say:FireServer("(here is the purpose of our Glitcher) recreated by Extra", "All")
        end
    end
end)
