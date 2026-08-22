--[[
   SOL'S RNG GLITCHER ULTIMATE v6.0 (GUI-CENTRIC)
   All features controlled via an intuitive on‑screen GUI.
   Keyboard still works, but you can do everything with taps.
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
    CurrentAura = 1,
    CurrentPage = 1,
    Volume = 0.5,
    Mute = false,
    DebugMode = false,
    AutoReanimate = true,
    AnimationSpeed = 1.0,
    ParticleRate = 80,
    ParticleSize = 1.0,
    EnableParticles = true,
    EnableMusic = true,
    EnableAnimations = true,
    EnableReanimation = true,
}

-- Auras (31)
local auras = {
    [0] = {name="None", color=Color3.new(0.5,0.5,0.5), music=nil, particle={rate=0,size=0,transparency=1,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Common"},
    [1] = {name="Matrix", color=Color3.new(0,1,0), music=9120589593, particle={rate=80,size=1.2,transparency=0.4,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Uncommon"},
    [2] = {name="Archangel", color=Color3.new(1,1,0), music=9120589594, particle={rate=90,size=1.5,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Rare"},
    [3] = {name="Symphony", color=Color3.new(0.5,0.8,1), music=9120589595, particle={rate=100,size=1.0,transparency=0.2,texture="rbxasset://textures/particles/star.dds"}, rarity="Epic"},
    [4] = {name="Overture", color=Color3.new(1,0.5,0), music=9120589596, particle={rate=85,size=1.3,transparency=0.5,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [5] = {name="Gargantua", color=Color3.new(0.8,0.2,0.8), music=9120589597, particle={rate=120,size=2.0,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [6] = {name="Chronos", color=Color3.new(0,1,1), music=9120589598, particle={rate=70,size=1.0,transparency=0.2,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Legendary"},
    [7] = {name="Glitch", color=Color3.new(0,1,0.5), music=9120589599, particle={rate=150,size=0.8,transparency=0.6,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Mythical"},
    [8] = {name="Equinox", color=Color3.new(0.5,0.5,1), music=9120589600, special="EquinoxRings", particle={rate=60,size=1.5,transparency=0.4,texture="rbxasset://textures/particles/glow.dds"}, rarity="Divine"},
    [9] = {name="Nebula", color=Color3.new(0.6,0,0.8), music=9120589601, particle={rate=80,size=2.0,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [10] = {name="Eclipse", color=Color3.new(0.8,0.4,0), music=9120589602, particle={rate=90,size=1.2,transparency=0.4,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [11] = {name="Supernova", color=Color3.new(1,0.8,0.2), music=9120589603, particle={rate=200,size=3.0,transparency=0.1,texture="rbxasset://textures/particles/glow.dds"}, rarity="Divine"},
    [12] = {name="Void", color=Color3.new(0.1,0.1,0.1), music=9120589604, particle={rate=30,size=1.0,transparency=0.8,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Mythical"},
    [13] = {name="Celestial", color=Color3.new(0.2,0.5,1), music=9120589605, particle={rate=70,size=1.4,transparency=0.2,texture="rbxasset://textures/particles/star.dds"}, rarity="Legendary"},
    [14] = {name="Inferno", color=Color3.new(1,0.2,0), music=9120589606, particle={rate=120,size=1.8,transparency=0.3,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [15] = {name="Frost", color=Color3.new(0,1,1), music=9120589607, particle={rate=60,size=1.0,transparency=0.2,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Rare"},
    [16] = {name="Nature", color=Color3.new(0,0.8,0), music=9120589608, particle={rate=50,size=1.0,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Uncommon"},
    [17] = {name="Light", color=Color3.new(1,1,0.8), music=9120589609, particle={rate=100,size=1.2,transparency=0.1,texture="rbxasset://textures/particles/glow.dds"}, rarity="Rare"},
    [18] = {name="Dark", color=Color3.new(0.2,0.2,0.2), music=9120589610, particle={rate=40,size=1.0,transparency=0.7,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Rare"},
    [19] = {name="Cosmic", color=Color3.new(0.8,0,0.8), music=9120589611, particle={rate=90,size=1.6,transparency=0.3,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [20] = {name="Omega", color=Color3.new(1,0,0), music=9120589612, particle={rate=150,size=2.5,transparency=0.2,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Divine"},
    [21] = {name="Solar", color=Color3.new(1,0.8,0.4), music=9120589613, particle={rate=110,size=2.0,transparency=0.2,texture="rbxasset://textures/particles/glow.dds"}, rarity="Legendary"},
    [22] = {name="Lunar", color=Color3.new(0.8,0.8,1), music=9120589614, particle={rate=70,size=1.5,transparency=0.3,texture="rbxasset://textures/particles/star.dds"}, rarity="Rare"},
    [23] = {name="Blood", color=Color3.new(0.8,0,0), music=9120589615, particle={rate=90,size=1.2,transparency=0.4,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Epic"},
    [24] = {name="Shadow", color=Color3.new(0.1,0.1,0.2), music=9120589616, particle={rate=40,size=0.8,transparency=0.8,texture="rbxasset://textures/particles/dark.dds"}, rarity="Mythical"},
    [25] = {name="Storm", color=Color3.new(0.4,0.6,1), music=9120589617, particle={rate=130,size=1.0,transparency=0.3,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Legendary"},
    [26] = {name="Abyss", color=Color3.new(0,0,0.2), music=9120589618, particle={rate=20,size=0.5,transparency=0.9,texture="rbxasset://textures/particles/dark.dds"}, rarity="Epic"},
    [27] = {name="Aether", color=Color3.new(0.6,0.2,0.8), music=9120589619, particle={rate=80,size=1.5,transparency=0.2,texture="rbxasset://textures/particles/glow.dds"}, rarity="Divine"},
    [28] = {name="Phoenix", color=Color3.new(1,0.4,0), music=9120589620, particle={rate=120,size=2.0,transparency=0.1,texture="rbxasset://textures/particles/fire.dds"}, rarity="Mythical"},
    [29] = {name="Voidwalker", color=Color3.new(0.2,0,0.4), music=9120589621, particle={rate=60,size=1.0,transparency=0.6,texture="rbxasset://textures/particles/sparkles_main.dds"}, rarity="Legendary"},
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
    if rootPart then
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 2, 0)
        bv.MaxForce = Vector3.new(0, 1000, 0)
        bv.Parent = rootPart
        task.wait(0.5)
        bv:Destroy()
    end
end

-- Effects
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
    if not Settings.Enabled or not char or not Settings.EnableParticles then
        clearEffects(char)
        return
    end
    clearEffects(char)
    local aura = auras[mod]
    if not aura or mod == 0 then return end

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
    dead = function(root) local t=tick()*1.5*Settings.AnimationSpeed; root.CFrame=root.CFrame+Vector3.new(0,math.sin(t)*0.5,0); root.CFrame=root.CFrame*CFrame.Angles(0,math.sin(t)*0.02,0) end,
    spin = function(root) local t=tick()*2*Settings.AnimationSpeed; root.CFrame=root.CFrame*CFrame.Angles(0,math.rad(t*30),0) end,
    tpose = function(root) end,
}

local function applyPose(pose, root)
    if not Settings.EnableAnimations then return end
    local anim = animations[pose]
    if anim then anim(root) end
end

-- Screen flash effect
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
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.2}):Play()
    task.wait(0.5)
    TweenService:Create(frame, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.9}):Play()
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

-- ====================================================================
-- NEW GUI (Primary Interface)
-- ====================================================================
local gui = Instance.new("ScreenGui")
gui.Name = "AuraGUI"
gui.Parent = Player.PlayerGui
gui.ResetOnSpawn = false

-- Main frame (dark, slightly transparent)
local main = Instance.new("Frame")
main.Size = UDim2.new(0.45,0,0.75,0)
main.Position = UDim2.new(0.275,0,0.125,0)
main.BackgroundColor3 = Color3.new(0.08,0.08,0.08)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.07,0)
title.BackgroundTransparency = 1
title.Text = "SOL'S RNG ULTIMATE"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main

-- Tab buttons
local tabs = {"Auras","Animations","Settings"}
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1,0,0.07,0)
tabContainer.Position = UDim2.new(0,0,0.07,0)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = main

local tabButtons = {}
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabs,0,1,0)
    btn.Position = UDim2.new((i-1)/#tabs,0,0,0)
    btn.BackgroundColor3 = (i==1) and Color3.new(0.2,0.4,0.6) or Color3.new(0.2,0.2,0.2)
    btn.Text = name
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.Parent = tabContainer
    btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(tabButtons) do b.BackgroundColor3 = Color3.new(0.2,0.2,0.2) end
        btn.BackgroundColor3 = Color3.new(0.2,0.4,0.6)
        switchTab(i)
    end)
    tabButtons[i] = btn
end

-- Content container
local content = Instance.new("Frame")
content.Size = UDim2.new(1,0,0.86,0)
content.Position = UDim2.new(0,0,0.14,0)
content.BackgroundTransparency = 1
content.Parent = main

-- ==================== TAB 1: AURAS ====================
local auraTab = Instance.new("Frame")
auraTab.Size = UDim2.new(1,0,1,0)
auraTab.BackgroundTransparency = 1
auraTab.Parent = content

local pageLbl = Instance.new("TextLabel")
pageLbl.Size = UDim2.new(0.2,0,0.06,0)
pageLbl.Position = UDim2.new(0.4,0,0,0)
pageLbl.BackgroundTransparency = 1
pageLbl.Text = "Page 1"
pageLbl.TextScaled = true
pageLbl.Font = Enum.Font.Gotham
pageLbl.TextColor3 = Color3.new(1,1,1)
pageLbl.Parent = auraTab

local pageLeft = Instance.new("TextButton")
pageLeft.Size = UDim2.new(0.08,0,0.06,0)
pageLeft.Position = UDim2.new(0.3,0,0,0)
pageLeft.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
pageLeft.Text = "<"
pageLeft.TextScaled = true
pageLeft.Font = Enum.Font.GothamBold
pageLeft.TextColor3 = Color3.new(1,1,1)
pageLeft.BorderSizePixel = 0
pageLeft.Parent = auraTab

local pageRight = Instance.new("TextButton")
pageRight.Size = UDim2.new(0.08,0,0.06,0)
pageRight.Position = UDim2.new(0.62,0,0,0)
pageRight.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
pageRight.Text = ">"
pageRight.TextScaled = true
pageRight.Font = Enum.Font.GothamBold
pageRight.TextColor3 = Color3.new(1,1,1)
pageRight.BorderSizePixel = 0
pageRight.Parent = auraTab

local auraContainer = Instance.new("ScrollingFrame")
auraContainer.Size = UDim2.new(1,0,0.9,0)
auraContainer.Position = UDim2.new(0,0,0.08,0)
auraContainer.BackgroundTransparency = 1
auraContainer.CanvasSize = UDim2.new(0,0,0,0)
auraContainer.ScrollBarThickness = 8
auraContainer.Parent = auraTab

local auraBtnList = {}
local function buildAuraButtons()
    for _, b in ipairs(auraBtnList) do b:Destroy() end
    auraBtnList = {}
    local layout = Instance.new("UIListLayout")
    layout.Parent = auraContainer
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Padding = UDim.new(0,3)

    local function add(mod)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.9,0,0.08,0)
        b.Position = UDim2.new(0.05,0,0,0)
        local sel = (mod == Settings.CurrentAura)
        b.BackgroundColor3 = sel and Color3.new(0,0.5,0.8) or Color3.new(0.2,0.2,0.2)
        local a = auras[mod]
        local rarity = a and a.rarity or "Common"
        local col = Color3.new(1,1,1)
        if rarity == "Common" then col = Color3.new(0.5,0.5,0.5)
        elseif rarity == "Uncommon" then col = Color3.new(0,1,0)
        elseif rarity == "Rare" then col = Color3.new(0,0.5,1)
        elseif rarity == "Epic" then col = Color3.new(0.8,0,0.8)
        elseif rarity == "Legendary" then col = Color3.new(1,0.8,0)
        elseif rarity == "Mythical" then col = Color3.new(1,0,0.5)
        elseif rarity == "Divine" then col = Color3.new(1,1,0.5)
        elseif rarity == "Creator" then col = Color3.new(1,0,0)
        end
        b.Text = a and a.name or "Unknown"
        b.TextScaled = true
        b.Font = Enum.Font.Gotham
        b.TextColor3 = sel and Color3.new(1,1,1) or col
        b.BorderSizePixel = 0
        b.Parent = auraContainer
        b.MouseButton1Click:Connect(function()
            Settings.CurrentAura = mod
            applyEffects(mod, character)
            for _, b2 in ipairs(auraBtnList) do
                b2.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
                local a2 = auras[Settings.CurrentAura]
                b2.TextColor3 = a2 and (a2.rarity == "Common" and Color3.new(0.5,0.5,0.5) or Color3.new(1,1,1)) or Color3.new(1,1,1)
            end
            b.BackgroundColor3 = Color3.new(0,0.5,0.8)
            b.TextColor3 = Color3.new(1,1,1)
        end)
        auraBtnList[#auraBtnList+1] = b
    end

    if Settings.CurrentPage == 1 then
        for i = 0, 9 do add(i) end
    else
        for i = 10, 19 do add(i) end
        for i = 20, 30 do add(i) end
    end
    auraContainer.CanvasSize = UDim2.new(0,0,0, #auraBtnList * 0.08 * auraContainer.AbsoluteSize.Y)
end

pageLeft.MouseButton1Click:Connect(function()
    if Settings.CurrentPage > 1 then
        Settings.CurrentPage = Settings.CurrentPage - 1
        pageLbl.Text = "Page "..Settings.CurrentPage
        buildAuraButtons()
    end
end)
pageRight.MouseButton1Click:Connect(function()
    if Settings.CurrentPage < 3 then
        Settings.CurrentPage = Settings.CurrentPage + 1
        pageLbl.Text = "Page "..Settings.CurrentPage
        buildAuraButtons()
    end
end)
buildAuraButtons()
pageLbl.Text = "Page "..Settings.CurrentPage

-- ==================== TAB 2: ANIMATIONS ====================
local animTab = Instance.new("Frame")
animTab.Size = UDim2.new(1,0,1,0)
animTab.BackgroundTransparency = 1
animTab.Visible = false
animTab.Parent = content

local animDesc = Instance.new("TextLabel")
animDesc.Size = UDim2.new(1,0,0.08,0)
animDesc.BackgroundTransparency = 1
animDesc.Text = "Current: idle"
animDesc.TextScaled = true
animDesc.Font = Enum.Font.Gotham
animDesc.TextColor3 = Color3.new(1,1,1)
animDesc.Parent = animTab

local animContainer = Instance.new("ScrollingFrame")
animContainer.Size = UDim2.new(1,0,0.9,0)
animContainer.Position = UDim2.new(0,0,0.08,0)
animContainer.BackgroundTransparency = 1
animContainer.CanvasSize = UDim2.new(0,0,0,0)
animContainer.ScrollBarThickness = 8
animContainer.Parent = animTab

local animBtnList = {}
local function buildAnimButtons()
    for _, b in ipairs(animBtnList) do b:Destroy() end
    animBtnList = {}
    local layout = Instance.new("UIListLayout")
    layout.Parent = animContainer
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Padding = UDim.new(0,3)

    local function addAnim(name, desc, isOverride)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.9,0,0.08,0)
        b.Position = UDim2.new(0.05,0,0,0)
        local active = (isOverride and overridePose == name) or (not isOverride and currentPose == name)
        b.BackgroundColor3 = active and Color3.new(0,0.5,0.8) or Color3.new(0.2,0.2,0.2)
        b.Text = name .. " - " .. desc
        b.TextScaled = true
        b.Font = Enum.Font.Gotham
        b.TextColor3 = Color3.new(1,1,1)
        b.BorderSizePixel = 0
        b.Parent = animContainer
        b.MouseButton1Click:Connect(function()
            if isOverride then
                if overridePose == name then overridePose = nil else overridePose = name end
            end
            animDesc.Text = "Current: " .. (overridePose or currentPose)
            for _, b2 in ipairs(animBtnList) do b2.BackgroundColor3 = Color3.new(0.2,0.2,0.2) end
            b.BackgroundColor3 = Color3.new(0,0.5,0.8)
        end)
        animBtnList[#animBtnList+1] = b
    end

    for name, data in pairs(animations) do
        addAnim(name, data.desc or name, false)
    end
    addAnim("tpose", "T-Pose (override)", true)
    addAnim("spin", "Spin (override)", true)
    -- Also add "hover" as an override? but it's already a normal pose, we can add an override for "fly" etc.
    addAnim("fly", "Fly (override)", true)   -- we can define fly animation later
    animContainer.CanvasSize = UDim2.new(0,0,0, #animBtnList * 0.08 * animContainer.AbsoluteSize.Y)
end
buildAnimButtons()

-- ==================== TAB 3: SETTINGS ====================
local settingsTab = Instance.new("Frame")
settingsTab.Size = UDim2.new(1,0,1,0)
settingsTab.BackgroundTransparency = 1
settingsTab.Visible = false
settingsTab.Parent = content

local function addSetting(parent, labelText, valueType, initialValue, onChange)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0.08,0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextScaled = true
    lbl.Font = Enum.Font.Gotham
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    if valueType == "toggle" then
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.2,0,0.8,0)
        btn.Position = UDim2.new(0.8,0,0.1,0)
        btn.BackgroundColor3 = initialValue and Color3.new(0,0.6,0) or Color3.new(0.6,0,0)
        btn.Text = initialValue and "ON" or "OFF"
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BorderSizePixel = 0
        btn.Parent = frame
        btn.MouseButton1Click:Connect(function()
            initialValue = not initialValue
            btn.BackgroundColor3 = initialValue and Color3.new(0,0.6,0) or Color3.new(0.6,0,0)
            btn.Text = initialValue and "ON" or "OFF"
            onChange(initialValue)
        end)
    elseif valueType == "slider" then
        local dec = Instance.new("TextButton")
        dec.Size = UDim2.new(0.06,0,0.6,0)
        dec.Position = UDim2.new(0.7,0,0.2,0)
        dec.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
        dec.Text = "-"
        dec.TextScaled = true
        dec.Font = Enum.Font.GothamBold
        dec.TextColor3 = Color3.new(1,1,1)
        dec.BorderSizePixel = 0
        dec.Parent = frame
        local valLabel = Instance.new("TextLabel")
        valLabel.Size = UDim2.new(0.08,0,0.6,0)
        valLabel.Position = UDim2.new(0.77,0,0.2,0)
        valLabel.BackgroundTransparency = 1
        valLabel.Text = string.format("%.2f", initialValue)
        valLabel.TextScaled = true
        valLabel.Font = Enum.Font.Gotham
        valLabel.TextColor3 = Color3.new(1,1,1)
        valLabel.Parent = frame
        local inc = Instance.new("TextButton")
        inc.Size = UDim2.new(0.06,0,0.6,0)
        inc.Position = UDim2.new(0.86,0,0.2,0)
        inc.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
        inc.Text = "+"
        inc.TextScaled = true
        inc.Font = Enum.Font.GothamBold
        inc.TextColor3 = Color3.new(1,1,1)
        inc.BorderSizePixel = 0
        inc.Parent = frame
        local function updateValue(val)
            initialValue = val
            valLabel.Text = string.format("%.2f", val)
            onChange(val)
        end
        dec.MouseButton1Click:Connect(function() updateValue(math.max(0, initialValue - 0.05)) end)
        inc.MouseButton1Click:Connect(function() updateValue(math.min(1, initialValue + 0.05)) end)
    end
end

addSetting(settingsTab, "Enable Cheat", "toggle", Settings.Enabled, function(v) Settings.Enabled = v end)
addSetting(settingsTab, "Auto-Reanimate", "toggle", Settings.AutoReanimate, function(v) Settings.AutoReanimate = v end)
addSetting(settingsTab, "Enable Particles", "toggle", Settings.EnableParticles, function(v) Settings.EnableParticles = v; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Enable Music", "toggle", Settings.EnableMusic, function(v) Settings.EnableMusic = v; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Enable Animations", "toggle", Settings.EnableAnimations, function(v) Settings.EnableAnimations = v end)
addSetting(settingsTab, "Mute", "toggle", Settings.Mute, function(v) Settings.Mute = v; if v and currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil else applyEffects(Settings.CurrentAura, character) end end)
addSetting(settingsTab, "Animation Speed", "slider", Settings.AnimationSpeed, function(v) Settings.AnimationSpeed = v end)
addSetting(settingsTab, "Particle Rate", "slider", Settings.ParticleRate/100, function(v) Settings.ParticleRate = v*100; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Particle Size", "slider", Settings.ParticleSize, function(v) Settings.ParticleSize = v; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Volume", "slider", Settings.Volume, function(v) Settings.Volume = v; if currentSound then currentSound.Volume = v end end)
addSetting(settingsTab, "Debug Mode", "toggle", Settings.DebugMode, function(v) Settings.DebugMode = v end)

-- ==================== TAB SWITCH ====================
function switchTab(index)
    auraTab.Visible = false
    animTab.Visible = false
    settingsTab.Visible = false
    if index == 1 then auraTab.Visible = true
    elseif index == 2 then animTab.Visible = true
    elseif index == 3 then settingsTab.Visible = true
    end
end

-- ==================== EXTRA: KILL BUTTON ====================
local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(0.15,0,0.06,0)
killBtn.Position = UDim2.new(0.85,0,0.92,0)
killBtn.BackgroundColor3 = Color3.new(0.6,0,0)
killBtn.Text = "💀 KILL"
killBtn.TextScaled = true
killBtn.Font = Enum.Font.GothamBold
killBtn.TextColor3 = Color3.new(1,1,1)
killBtn.BorderSizePixel = 0
killBtn.Parent = gui
killBtn.MouseButton1Click:Connect(function()
    if humanoid then humanoid.Health = 0 end
end)

-- ==================== DEBUG LABEL ====================
local debugLbl
if Settings.DebugMode then
    debugLbl = Instance.new("TextLabel")
    debugLbl.Size = UDim2.new(0.4,0,0.04,0)
    debugLbl.Position = UDim2.new(0.3,0,0,0)
    debugLbl.BackgroundTransparency = 1
    debugLbl.Text = ""
    debugLbl.TextScaled = true
    debugLbl.Font = Enum.Font.Gotham
    debugLbl.TextColor3 = Color3.new(1,1,0)
    debugLbl.Parent = Player.PlayerGui
end
RunService.RenderStepped:Connect(function()
    if Settings.DebugMode and debugLbl then
        debugLbl.Text = string.format("Aura:%d Pose:%s Override:%s Dead:%s Welds:%d",
            Settings.CurrentAura, currentPose, overridePose or "none", tostring(isDead), #limbWelds)
    elseif debugLbl then
        debugLbl.Text = ""
    end
end)

-- ==================== STARTUP ====================
StarterGui:SetCore("SendNotification", {
    Title = "SOL'S RNG ULTIMATE",
    Text = "GUI loaded! Use tabs to control everything. Press K or tap KILL to die.",
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
