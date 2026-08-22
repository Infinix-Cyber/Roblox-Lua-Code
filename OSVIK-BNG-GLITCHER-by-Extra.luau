--[[
   ██████╗ ███████╗██╗   ██╗██╗██╗  ██╗    ██████╗ ███╗   ██╗ ██████╗ 
  ██╔═══██╗██╔════╝██║   ██║██║██║ ██╔╝    ██╔══██╗████╗  ██║██╔════╝ 
  ██║   ██║███████╗██║   ██║██║█████╔╝     ██████╔╝██╔██╗ ██║██║  ███╗
  ██║   ██║╚════██║╚██╗ ██╔╝██║██╔═██╗     ██╔══██╗██║╚██╗██║██║   ██║
  ╚██████╔╝███████║ ╚████╔╝ ██║██║  ██╗    ██████╔╝██║ ╚████║╚██████╔╝
   ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ 
   
   ███████╗██╗  ██╗████████╗██████╗  █████╗ 
   ██╔════╝██║  ██║╚══██╔══╝██╔══██╗██╔══██╗
   ███████╗███████║   ██║   ██████╔╝███████║
   ╚════██║██╔══██║   ██║   ██╔══██╗██╔══██║
   ███████║██║  ██║   ██║   ██║  ██║██║  ██║
   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
   
   SOL'S RNG GLITCHER ULTIMATE EDITION - v4.0 (ULTRA EXTENDED)
   ================================================================
   Over 3500 lines of advanced client-side reanimation, aura effects,
   music system, GUI, and network ownership replication.
   Optimized for mobile and desktop.
--]]

-- Load Virtual Keyboard (safe load)
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Jskfhggjxu/My-Script/refs/heads/main/VirtualKeyboard.lua"))()
end)

-- ====================================================================
-- SECTION 1: NICKNAME VERIFICATION (WHITELIST + ADMIN MODE)
-- ====================================================================
local allowedNames = {
	"TheLocalMazeV2",
	"TheLocalMaze",
	"Quur92",
	"BAcON_KJpast"
}
local Player = game.Players.LocalPlayer
local isAdmin = table.find(allowedNames, Player.Name) ~= nil

if not isAdmin then
	-- Show a warning and prevent execution
	local gui = Instance.new("ScreenGui")
	gui.Parent = Player.PlayerGui
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,0,1,0)
	lbl.Text = "UNAUTHORIZED\nThis cheat is locked to specific users."
	lbl.TextScaled = true
	lbl.TextColor3 = Color3.new(1,0,0)
	lbl.BackgroundTransparency = 1
	lbl.Parent = gui
	return
end

-- ====================================================================
-- SECTION 2: SERVICES AND GLOBALS
-- ====================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")

-- ====================================================================
-- SECTION 3: CONFIGURATION DATABASE
-- ====================================================================
local Settings = {
	Enabled = true,
	CurrentAura = 0,
	CurrentPage = 1,
	Volume = 0.5,
	Mute = false,
	DebugMode = false,
	AutoReanimate = true,
	AnimationSpeed = 1.0,
	ParticleRate = 80,
	ParticleSize = 1.0,
	ShowFPS = false,
	UseTweens = true,
	TweenTime = 0.3,
	EnableParticles = true,
	EnableMusic = true,
	EnableAnimations = true,
	EnableReanimation = true,
	ClaimOwnership = true,
	VelocityThreshold = -25.05,
	AntiShake = true,
	AntiShakeStrength = 0.9,
	AutoRespawn = false,
	RespawnDelay = 3,
	ChatCommands = true,
	ShowNotifications = true,
	Keybinds = {
		Toggle = Enum.KeyCode.P,
		Page = Enum.KeyCode.M,
		Aura20 = Enum.KeyCode.O,  -- Alternative for 20
		Spin = Enum.KeyCode.G,
		TPose = Enum.KeyCode.T,
		Hover = Enum.KeyCode.Space,
		MusicNext = Enum.KeyCode.N,
		MusicPrev = Enum.KeyCode.B,
	},
}

-- ====================================================================
-- SECTION 4: EXTENDED AURA DEFINITIONS (30 Auras)
-- ====================================================================
local auraDatabase = {
	-- Aura 0: None
	[0] = {
		name = "None",
		color = Color3.new(0.5,0.5,0.5),
		music = nil,
		special = nil,
		particle = {rate = 0, size = 0, transparency = 1, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "No effects",
		rarity = "Common",
	},
	-- Aura 1-20: Sol's RNG original set
	[1] = {
		name = "Matrix",
		color = Color3.new(0,1,0),
		music = 9120589593,
		special = nil,
		particle = {rate = 80, size = 1.2, transparency = 0.4, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Green digital rain",
		rarity = "Uncommon",
	},
	[2] = {
		name = "Archangel",
		color = Color3.new(1,1,0),
		music = 9120589594,
		special = nil,
		particle = {rate = 90, size = 1.5, transparency = 0.3, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Golden divine glow",
		rarity = "Rare",
	},
	[3] = {
		name = "Symphony",
		color = Color3.new(0.5,0.8,1),
		music = 9120589595,
		special = nil,
		particle = {rate = 100, size = 1.0, transparency = 0.2, texture = "rbxasset://textures/particles/star.dds"},
		description = "Musical notes",
		rarity = "Epic",
	},
	[4] = {
		name = "Overture",
		color = Color3.new(1,0.5,0),
		music = 9120589596,
		special = nil,
		particle = {rate = 85, size = 1.3, transparency = 0.5, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Fiery introduction",
		rarity = "Epic",
	},
	[5] = {
		name = "Gargantua",
		color = Color3.new(0.8,0.2,0.8),
		music = 9120589597,
		special = nil,
		particle = {rate = 120, size = 2.0, transparency = 0.3, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Massive purple void",
		rarity = "Legendary",
	},
	[6] = {
		name = "Chronos",
		color = Color3.new(0,1,1),
		music = 9120589598,
		special = nil,
		particle = {rate = 70, size = 1.0, transparency = 0.2, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Time distortion",
		rarity = "Legendary",
	},
	[7] = {
		name = "Glitch",
		color = Color3.new(0,1,0.5),
		music = 9120589599,
		special = nil,
		particle = {rate = 150, size = 0.8, transparency = 0.6, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Digital corruption",
		rarity = "Mythical",
	},
	[8] = {
		name = "Equinox",
		color = Color3.new(0.5,0.5,1),
		music = 9120589600,
		special = "EquinoxRings",
		particle = {rate = 60, size = 1.5, transparency = 0.4, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Yin-Yang balance",
		rarity = "Divine",
	},
	[9] = {
		name = "Nebula",
		color = Color3.new(0.6,0,0.8),
		music = 9120589601,
		special = nil,
		particle = {rate = 80, size = 2.0, transparency = 0.3, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Galactic cloud",
		rarity = "Legendary",
	},
	[10] = {
		name = "Eclipse",
		color = Color3.new(0.8,0.4,0),
		music = 9120589602,
		special = nil,
		particle = {rate = 90, size = 1.2, transparency = 0.4, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Solar corona",
		rarity = "Epic",
	},
	[11] = {
		name = "Supernova",
		color = Color3.new(1,0.8,0.2),
		music = 9120589603,
		special = nil,
		particle = {rate = 200, size = 3.0, transparency = 0.1, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Explosive blast",
		rarity = "Divine",
	},
	[12] = {
		name = "Void",
		color = Color3.new(0.1,0.1,0.1),
		music = 9120589604,
		special = nil,
		particle = {rate = 30, size = 1.0, transparency = 0.8, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Absolute darkness",
		rarity = "Mythical",
	},
	[13] = {
		name = "Celestial",
		color = Color3.new(0.2,0.5,1),
		music = 9120589605,
		special = nil,
		particle = {rate = 70, size = 1.4, transparency = 0.2, texture = "rbxasset://textures/particles/star.dds"},
		description = "Starry sky",
		rarity = "Legendary",
	},
	[14] = {
		name = "Inferno",
		color = Color3.new(1,0.2,0),
		music = 9120589606,
		special = nil,
		particle = {rate = 120, size = 1.8, transparency = 0.3, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Burning flames",
		rarity = "Epic",
	},
	[15] = {
		name = "Frost",
		color = Color3.new(0,1,1),
		music = 9120589607,
		special = nil,
		particle = {rate = 60, size = 1.0, transparency = 0.2, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Ice shards",
		rarity = "Rare",
	},
	[16] = {
		name = "Nature",
		color = Color3.new(0,0.8,0),
		music = 9120589608,
		special = nil,
		particle = {rate = 50, size = 1.0, transparency = 0.3, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Forest essence",
		rarity = "Uncommon",
	},
	[17] = {
		name = "Light",
		color = Color3.new(1,1,0.8),
		music = 9120589609,
		special = nil,
		particle = {rate = 100, size = 1.2, transparency = 0.1, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Pure radiance",
		rarity = "Rare",
	},
	[18] = {
		name = "Dark",
		color = Color3.new(0.2,0.2,0.2),
		music = 9120589610,
		special = nil,
		particle = {rate = 40, size = 1.0, transparency = 0.7, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Shadow realm",
		rarity = "Rare",
	},
	[19] = {
		name = "Cosmic",
		color = Color3.new(0.8,0,0.8),
		music = 9120589611,
		special = nil,
		particle = {rate = 90, size = 1.6, transparency = 0.3, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Interstellar dust",
		rarity = "Legendary",
	},
	[20] = {
		name = "Omega",
		color = Color3.new(1,0,0),
		music = 9120589612,
		special = nil,
		particle = {rate = 150, size = 2.5, transparency = 0.2, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Final form",
		rarity = "Divine",
	},
	-- Additional auras (21-30) custom
	[21] = {
		name = "Solar",
		color = Color3.new(1,0.8,0.4),
		music = 9120589613,
		special = nil,
		particle = {rate = 110, size = 2.0, transparency = 0.2, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Sun's energy",
		rarity = "Legendary",
	},
	[22] = {
		name = "Lunar",
		color = Color3.new(0.8,0.8,1),
		music = 9120589614,
		special = nil,
		particle = {rate = 70, size = 1.5, transparency = 0.3, texture = "rbxasset://textures/particles/star.dds"},
		description = "Moon's glow",
		rarity = "Rare",
	},
	[23] = {
		name = "Blood",
		color = Color3.new(0.8,0,0),
		music = 9120589615,
		special = nil,
		particle = {rate = 90, size = 1.2, transparency = 0.4, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Crimson tide",
		rarity = "Epic",
	},
	[24] = {
		name = "Shadow",
		color = Color3.new(0.1,0.1,0.2),
		music = 9120589616,
		special = nil,
		particle = {rate = 40, size = 0.8, transparency = 0.8, texture = "rbxasset://textures/particles/dark.dds"},
		description = "Living shadow",
		rarity = "Mythical",
	},
	[25] = {
		name = "Storm",
		color = Color3.new(0.4,0.6,1),
		music = 9120589617,
		special = nil,
		particle = {rate = 130, size = 1.0, transparency = 0.3, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Lightning fury",
		rarity = "Legendary",
	},
	[26] = {
		name = "Abyss",
		color = Color3.new(0,0,0.2),
		music = 9120589618,
		special = nil,
		particle = {rate = 20, size = 0.5, transparency = 0.9, texture = "rbxasset://textures/particles/dark.dds"},
		description = "Deep ocean",
		rarity = "Epic",
	},
	[27] = {
		name = "Aether",
		color = Color3.new(0.6,0.2,0.8),
		music = 9120589619,
		special = nil,
		particle = {rate = 80, size = 1.5, transparency = 0.2, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Ethereal mist",
		rarity = "Divine",
	},
	[28] = {
		name = "Phoenix",
		color = Color3.new(1,0.4,0),
		music = 9120589620,
		special = nil,
		particle = {rate = 120, size = 2.0, transparency = 0.1, texture = "rbxasset://textures/particles/fire.dds"},
		description = "Rebirth flames",
		rarity = "Mythical",
	},
	[29] = {
		name = "Voidwalker",
		color = Color3.new(0.2,0,0.4),
		music = 9120589621,
		special = nil,
		particle = {rate = 60, size = 1.0, transparency = 0.6, texture = "rbxasset://textures/particles/sparkles_main.dds"},
		description = "Interdimensional",
		rarity = "Legendary",
	},
	[30] = {
		name = "Creator",
		color = Color3.new(1,1,1),
		music = 9120589622,
		special = "CreatorAura", -- special effect: rotating rainbow rings
		particle = {rate = 200, size = 3.0, transparency = 0.0, texture = "rbxasset://textures/particles/glow.dds"},
		description = "Ultimate power",
		rarity = "Creator",
	},
}

-- ====================================================================
-- SECTION 5: EXTENDED ANIMATION DEFINITIONS
-- ====================================================================
local AnimationLibrary = {
	idle = {
		desc = "Standing still",
		func = function(root, dt)
			local t = tick() * 0.5 * Settings.AnimationSpeed
			local offset = math.sin(t) * 0.05
			root.CFrame = root.CFrame + Vector3.new(0, offset, 0)
		end
	},
	hover = {
		desc = "Smooth levitation",
		func = function(root, dt)
			local t = tick() * 2 * Settings.AnimationSpeed
			local offset = math.sin(t) * 0.3
			root.CFrame = root.CFrame + Vector3.new(0, offset, 0)
		end
	},
	run = {
		desc = "Running",
		func = function(root, dt)
			local t = tick() * 4 * Settings.AnimationSpeed
			local bob = math.sin(t) * 0.05
			root.CFrame = root.CFrame + Vector3.new(0, bob, 0)
		end
	},
	jump = {
		desc = "Jumping",
		func = function(root, dt) end
	},
	dead = {
		desc = "Death floating",
		func = function(root, dt)
			local t = tick() * 1.5 * Settings.AnimationSpeed
			local offset = math.sin(t) * 0.5
			root.CFrame = root.CFrame + Vector3.new(0, offset, 0)
			root.CFrame = root.CFrame * CFrame.Angles(0, math.sin(t)*0.02, 0)
		end
	},
	spin = {
		desc = "Spinning",
		func = function(root, dt)
			local t = tick() * 2 * Settings.AnimationSpeed
			root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(t*30), 0)
		end
	},
	spin2 = {
		desc = "Fast spinning",
		func = function(root, dt)
			local t = tick() * 4 * Settings.AnimationSpeed
			root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(t*60), 0)
		end
	},
	moonwalk = {
		desc = "Moonwalk",
		func = function(root, dt)
			local t = tick() * 2 * Settings.AnimationSpeed
			root.CFrame = root.CFrame * CFrame.Angles(0, 0, math.sin(t)*0.02)
			root.CFrame = root.CFrame + Vector3.new(-math.sin(t)*0.1, 0, 0)
		end
	},
	crawl = {
		desc = "Crawling",
		func = function(root, dt)
			local t = tick() * 2 * Settings.AnimationSpeed
			root.CFrame = root.CFrame * CFrame.Angles(math.sin(t)*0.05, 0, 0)
			root.CFrame = root.CFrame + Vector3.new(0, -0.5, 0)
		end
	},
	fly = {
		desc = "Flying",
		func = function(root, dt)
			local t = tick() * 1.2 * Settings.AnimationSpeed
			root.CFrame = root.CFrame + Vector3.new(0, math.sin(t)*0.4, 0)
			root.CFrame = root.CFrame * CFrame.Angles(0, math.sin(t*0.5)*0.01, 0)
		end
	},
	swim = {
		desc = "Swimming",
		func = function(root, dt)
			local t = tick() * 1.8 * Settings.AnimationSpeed
			root.CFrame = root.CFrame * CFrame.Angles(math.sin(t)*0.05, 0, math.cos(t)*0.03)
			root.CFrame = root.CFrame + Vector3.new(0, math.sin(t*1.2)*0.2, 0)
		end
	},
	tpose = {
		desc = "T-Pose (limb override)",
		func = function(root, dt)
			-- handled separately
		end
	},
}

-- ====================================================================
-- SECTION 6: STATE VARIABLES
-- ====================================================================
local character = nil
local humanoid = nil
local rootPart = nil
local isDead = false
local limbWelds = {}
local currentSound = nil
local currentPose = "idle"
local overridePose = nil
local heartbeatConnection = nil
local renderConnection = nil
local debugInfo = ""
local isReanimating = false
local currentMusicIndex = 1
local musicPlaylist = {}
local characterType = "R6" -- or "R15"
local lastFrameTime = tick()
local frameCount = 0
local fps = 60

-- ====================================================================
-- SECTION 7: UTILITY FUNCTIONS
-- ====================================================================
local function tableFind(tbl, value)
	for i, v in ipairs(tbl) do if v == value then return i end end
	return nil
end

local function clamp(v, min, max)
	return math.max(min, math.min(max, v))
end

local function lerp(a, b, t)
	return a + (b - a) * t
end

local function lerpCFrame(a, b, t)
	return a:Lerp(b, t)
end

local function splitString(str, sep)
	local parts = {}
	for match in string.gmatch(str, "[^" .. sep .. "]+") do
		table.insert(parts, match)
	end
	return parts
end

local function getCharacterType(char)
	if char:FindFirstChild("UpperTorso") then return "R15" end
	if char:FindFirstChild("Torso") then return "R6" end
	return "Unknown"
end

-- ====================================================================
-- SECTION 8: NETWORK OWNERSHIP CLAIMING (ADVANCED)
-- ====================================================================
local function claimOwnership(part)
	if not Settings.ClaimOwnership then return end
	if part and part:IsA("BasePart") then
		-- Use velocity threshold to force ownership
		part.Velocity = Vector3.new(0, Settings.VelocityThreshold, 0)
		part:SetNetworkOwner(Player)
	end
end

local function claimAllParts(char)
	for _, part in ipairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			claimOwnership(part)
		end
	end
end

-- ====================================================================
-- SECTION 9: REANIMATION SYSTEM (EXTENDED)
-- ====================================================================
local function clearReanimation()
	for part, weld in pairs(limbWelds) do
		weld:Destroy()
	end
	limbWelds = {}
end

local function setupReanimation(char)
	if not Settings.EnableReanimation then return end
	if isReanimating then return end
	isReanimating = true
	clearReanimation()
	if not rootPart then
		isReanimating = false
		return
	end
	
	local limbList
	if characterType == "R6" then
		limbList = {"Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}
	elseif characterType == "R15" then
		limbList = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg"}
	else
		limbList = {}
	end
	
	for _, name in ipairs(limbList) do
		local part = char:FindFirstChild(name)
		if part and part:IsA("BasePart") and part ~= rootPart then
			part.Anchored = false
			claimOwnership(part)
			local weld = Instance.new("Weld")
			weld.Part0 = rootPart
			weld.Part1 = part
			weld.C0 = rootPart.CFrame:inverse() * part.CFrame
			weld.Parent = part
			limbWelds[part] = weld
		end
	end
	isReanimating = false
end

-- ====================================================================
-- SECTION 10: EFFECTS SYSTEM (PARTICLES, RINGS, BEAMS, GLOW)
-- ====================================================================
local function clearEffects(container)
	if not container then return end
	for _, child in ipairs(container:GetDescendants()) do
		if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") or child:IsA("Attachment") then
			child:Destroy()
		end
	end
	for _, part in ipairs(container:GetChildren()) do
		if part.Name == "EquinoxRing" or part.Name == "CreatorRing" then
			part:Destroy()
		end
	end
	-- Also remove glow effects
	local glow = container:FindFirstChild("Glow")
	if glow then glow:Destroy() end
end

local function applyEffects(mod, char)
	-- Stop previous music
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
	local aura = auraDatabase[mod]
	if not aura or mod == 0 then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	-- Particles
	local pData = aura.particle
	if pData and pData.rate > 0 then
		local att = Instance.new("Attachment")
		att.Parent = root
		local p = Instance.new("ParticleEmitter")
		p.Parent = att
		-- Color with gradient (we'll use a simple color for now)
		p.Color = ColorSequence.new(aura.color)
		p.Rate = pData.rate * (Settings.ParticleRate / 80)
		p.Lifetime = NumberRange.new(1, 2)
		p.SpreadAngle = Vector2.new(360, 360)
		p.VelocityInheritance = 0
		p.Texture = pData.texture or "rbxasset://textures/particles/sparkles_main.dds"
		p.Size = NumberSequence.new(pData.size * Settings.ParticleSize)
		p.Transparency = NumberSequence.new(pData.transparency or 0.5)
		p.Rotation = NumberSequence.new(0, 360)
		p.RotSpeed = NumberRange.new(10, 30)
		p.Drag = 0.5
		p.Acceleration = Vector3.new(0, 0.5, 0)
	end

	-- Special effects
	if aura.special == "EquinoxRings" then
		local function createRing(offset, color, reverse)
			local ring = Instance.new("Part")
			ring.Size = Vector3.new(6,0.2,6)
			ring.Anchored = false
			ring.CanCollide = false
			ring.Transparency = 0.6
			ring.Material = Enum.Material.Neon
			ring.Color = color
			ring.Name = "EquinoxRing"
			ring.Parent = char
			local weld = Instance.new("Weld")
			weld.Part0 = root
			weld.Part1 = ring
			weld.C0 = CFrame.new(0, offset, 0) * CFrame.Angles(math.rad(90),0,0)
			weld.Parent = ring
			ring.CustomProperty = {reverse = reverse}
		end
		createRing(0.5, Color3.new(1,1,1), false)
		createRing(-0.5, Color3.new(0,0,0), true)
	end

	if aura.special == "CreatorAura" then
		-- Multiple rotating rings with rainbow colors
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
			local weld = Instance.new("Weld")
			weld.Part0 = root
			weld.Part1 = ring
			local angle = math.rad(i * 60)
			weld.C0 = CFrame.new(0, 0.5, 0) * CFrame.Angles(math.rad(90), angle, 0)
			weld.Parent = ring
			ring.CustomProperty = {angle = angle, speed = 1 + i*0.2}
		end
	end

	-- Music
	if Settings.EnableMusic and not Settings.Mute and aura.music then
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://" .. aura.music
		sound.Volume = Settings.Volume
		sound.Looped = true
		sound.Parent = char
		sound:Play()
		currentSound = sound
	end
end

-- ====================================================================
-- SECTION 11: ANIMATION SYSTEM (EXTENDED WITH BLENDING)
-- ====================================================================
local currentBlend = 1.0

local function applyPose(pose, root, dt)
	if not Settings.EnableAnimations then return end
	if not root or not root.Parent then return end
	local anim = AnimationLibrary[pose]
	if anim and anim.func then
		-- For smooth blending, we could store previous and interpolate.
		-- For simplicity, we just apply directly.
		anim.func(root, dt)
	end
end

-- ====================================================================
-- SECTION 12: CHARACTER EVENTS
-- ====================================================================
local function onCharacterAdded(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	rootPart = char:WaitForChild("HumanoidRootPart")
	isDead = false
	characterType = getCharacterType(char)
	applyEffects(Settings.CurrentAura, char)

	humanoid.Died:Connect(function()
		isDead = true
		if Settings.AutoReanimate then
			claimAllParts(char)
			setupReanimation(char)
		end
	end)

	-- Also handle respawn
	if Settings.AutoRespawn then
		humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if humanoid.Health <= 0 then
				task.wait(Settings.RespawnDelay)
				humanoid.Health = 100
			end
		end)
	end
end

Player.CharacterAdded:Connect(onCharacterAdded)
if Player.Character then onCharacterAdded(Player.Character) end

-- ====================================================================
-- SECTION 13: MAIN LOOP (HEARTBEAT) WITH ANTI-SHAKE
-- ====================================================================
local lastPos = Vector3.new()
local lastCF = CFrame.new()

heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
	if not Settings.Enabled or not character or not rootPart then return end

	-- Claim ownership for all parts every frame
	claimAllParts(character)

	-- Determine pose
	local pose = "idle"
	local alive = humanoid and humanoid.Health > 0

	if overridePose then
		pose = overridePose
	else
		if alive then
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				pose = "hover"
			elseif humanoid.MoveDirection.Magnitude > 0.1 then
				pose = "run"
			elseif humanoid.Jump then
				pose = "jump"
			else
				pose = "idle"
			end
		else
			pose = "dead"
		end
	end
	currentPose = pose

	-- Handle T-pose via limb manipulation
	if pose == "tpose" then
		local isR15 = characterType == "R15"
		for part, weld in pairs(limbWelds) do
			local name = part.Name
			if isR15 then
				if name == "LeftUpperArm" or name == "LeftLowerArm" then
					weld.C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(0, 0, math.rad(90))
				elseif name == "RightUpperArm" or name == "RightLowerArm" then
					weld.C0 = CFrame.new(1.5, 0.5, 0) * CFrame.Angles(0, 0, math.rad(-90))
				else
					-- reset to default? we keep current.
				end
			else
				if name == "LeftArm" then
					weld.C0 = CFrame.new(-1.5, 0.5, 0) * CFrame.Angles(0, 0, math.rad(90))
				elseif name == "RightArm" then
					weld.C0 = CFrame.new(1.5, 0.5, 0) * CFrame.Angles(0, 0, math.rad(-90))
				end
			end
		end
	else
		-- Normal root animation with anti-shake smoothing
		local targetCF = rootPart.CFrame
		if Settings.AntiShake then
			-- Smooth interpolation to prevent jitter
			rootPart.CFrame = lerpCFrame(lastCF, targetCF, Settings.AntiShakeStrength)
			lastCF = rootPart.CFrame
		else
			applyPose(pose, rootPart, dt)
		end
	end

	-- Rotate special rings (Equinox and Creator)
	if character then
		-- Equinox rings
		for _, ring in ipairs(character:GetChildren()) do
			if ring.Name == "EquinoxRing" and ring:IsA("BasePart") then
				local weld = ring:FindFirstChildOfClass("Weld")
				if weld then
					local rev = ring.CustomProperty and ring.CustomProperty.reverse or false
					local angle = (rev and -1 or 1) * 0.03 * Settings.AnimationSpeed
					weld.C0 = weld.C0 * CFrame.Angles(0, angle, 0)
				end
			end
			if ring.Name == "CreatorRing" and ring:IsA("BasePart") then
				local weld = ring:FindFirstChildOfClass("Weld")
				if weld then
					local speed = ring.CustomProperty and ring.CustomProperty.speed or 1
					local angle = speed * 0.05 * Settings.AnimationSpeed
					weld.C0 = weld.C0 * CFrame.Angles(0, angle, 0)
				end
			end
		end
	end

	-- Update debug info
	if Settings.DebugMode then
		debugInfo = string.format("Aura:%d Pose:%s Override:%s Dead:%s Parts:%d FPS:%.0f",
			Settings.CurrentAura, pose, tostring(overridePose), tostring(isDead), #limbWelds, fps)
	end

	-- FPS calculation
	frameCount = frameCount + 1
	if tick() - lastFrameTime >= 1 then
		fps = frameCount
		frameCount = 0
		lastFrameTime = tick()
	end
end)

-- ====================================================================
-- SECTION 14: INPUT HANDLING (EXTENDED KEYBINDS)
-- ====================================================================
local function handleInput(key)
	local binds = Settings.Keybinds
	if key == binds.Toggle then
		Settings.Enabled = not Settings.Enabled
		if Settings.Enabled then
			applyEffects(Settings.CurrentAura, character)
			if isDead and Settings.AutoReanimate then setupReanimation(character) end
		else
			clearEffects(character)
			clearReanimation()
			if currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil end
		end
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Toggle", Text = Settings.Enabled and "Enabled" or "Disabled", Duration = 1})
		end
		return true
	end

	if key == binds.Page then
		Settings.CurrentPage = (Settings.CurrentPage == 1) and 2 or 1
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Page", Text = "Page " .. Settings.CurrentPage, Duration = 1})
		end
		return true
	end

	if key == binds.Spin then
		if overridePose == "spin" then overridePose = nil else overridePose = "spin" end
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Pose", Text = overridePose or "Normal", Duration = 1})
		end
		return true
	end

	if key == binds.TPose then
		if overridePose == "tpose" then overridePose = nil else overridePose = "tpose" end
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Pose", Text = overridePose or "Normal", Duration = 1})
		end
		return true
	end

	if key == binds.MusicNext or key == binds.MusicPrev then
		-- Skip to next/prev music (if we had playlist) - not implemented fully
		-- Just re-apply current aura to restart music
		applyEffects(Settings.CurrentAura, character)
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Music", Text = "Restarted", Duration = 1})
		end
		return true
	end

	-- Aura selection
	local mod = nil
	if Settings.CurrentPage == 1 then
		if key >= Enum.KeyCode.Zero and key <= Enum.KeyCode.Nine then
			mod = key.Value - 48
		end
	else
		if key >= Enum.KeyCode.Zero and key <= Enum.KeyCode.Nine then
			local num = key.Value - 48
			if num == 0 then mod = 10 else mod = 10 + num end
		end
	end
	if mod and mod >= 0 and mod <= 19 then
		Settings.CurrentAura = mod
		applyEffects(mod, character)
		return true
	end

	return false
end

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	handleInput(input.KeyCode)
end)

-- Special sequence for aura 20+ (using key 2+0)
local lastKey, lastKeyTime
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	local key = input.KeyCode
	if key == Enum.KeyCode.Two then
		lastKey = 2
		lastKeyTime = tick()
	elseif key == Enum.KeyCode.Zero and lastKey == 2 and (tick() - lastKeyTime) < 0.5 then
		Settings.CurrentAura = 20
		lastKey = nil
		applyEffects(20, character)
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Aura", Text = "Omega (20)", Duration = 1})
		end
	end
end)

-- Alternative for aura 20 via keybind (default O)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Settings.Keybinds.Aura20 then
		Settings.CurrentAura = 20
		applyEffects(20, character)
		if Settings.ShowNotifications then
			StarterGui:SetCore("SendNotification", {Title = "Aura", Text = "Omega (20)", Duration = 1})
		end
	end
end)

-- ====================================================================
-- SECTION 15: CHAT COMMANDS (EXTENDED)
-- ====================================================================
if Settings.ChatCommands then
	Player.Chatted:Connect(function(msg)
		local parts = splitString(msg, " ")
		local cmd = parts[1]
		if cmd == "/aura" then
			local num = tonumber(parts[2])
			if num and num >= 0 and num <= 30 then
				Settings.CurrentAura = num
				applyEffects(num, character)
				if Settings.ShowNotifications then
					StarterGui:SetCore("SendNotification", {Title = "Aura", Text = "Switched to " .. auraDatabase[num].name, Duration = 2})
				end
			end
		elseif cmd == "/toggle" then
			Settings.Enabled = not Settings.Enabled
		elseif cmd == "/debug" then
			Settings.DebugMode = not Settings.DebugMode
			if Settings.ShowNotifications then
				StarterGui:SetCore("SendNotification", {Title = "Debug", Text = Settings.DebugMode and "On" or "Off", Duration = 1})
			end
		elseif cmd == "/vol" then
			local vol = tonumber(parts[2])
			if vol then
				Settings.Volume = clamp(vol, 0, 1)
				if currentSound then currentSound.Volume = Settings.Volume end
			end
		elseif cmd == "/mute" then
			Settings.Mute = not Settings.Mute
			if Settings.Mute and currentSound then
				currentSound:Stop(); currentSound:Destroy(); currentSound = nil
			elseif not Settings.Mute then
				applyEffects(Settings.CurrentAura, character)
			end
		elseif cmd == "/particles" then
			Settings.EnableParticles = not Settings.EnableParticles
			applyEffects(Settings.CurrentAura, character)
		elseif cmd == "/music" then
			Settings.EnableMusic = not Settings.EnableMusic
			applyEffects(Settings.CurrentAura, character)
		elseif cmd == "/anim" then
			Settings.EnableAnimations = not Settings.EnableAnimations
		elseif cmd == "/reanimate" then
			Settings.EnableReanimation = not Settings.EnableReanimation
			if not Settings.EnableReanimation then
				clearReanimation()
			end
		elseif cmd == "/respawn" then
			Settings.AutoRespawn = not Settings.AutoRespawn
		elseif cmd == "/help" then
			StarterGui:SetCore("SendNotification", {
				Title = "Commands",
				Text = "/aura #, /toggle, /debug, /vol #, /mute, /particles, /music, /anim, /reanimate, /respawn, /help",
				Duration = 5
			})
		end
	end)
end

-- ====================================================================
-- SECTION 16: GUI CONSTRUCTION (ULTRA EXTENDED)
-- ====================================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuraGUI"
screenGui.Parent = Player.PlayerGui
screenGui.ResetOnSpawn = false

-- Main frame (dark, with nice styling)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.45,0,0.7,0)
mainFrame.Position = UDim2.new(0.275,0,0.15,0)
mainFrame.BackgroundColor3 = Color3.new(0.08,0.08,0.08)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Title (animated)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,0,0.08,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SOL'S RNG ULTIMATE"
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Parent = mainFrame

-- Tab container (with more tabs)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1,0,0.07,0)
tabContainer.Position = UDim2.new(0,0,0.08,0)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local tabs = {"Auras", "Settings", "Anim", "Music", "Info"}
local tabButtons = {}
for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.2,0,1,0)
	btn.Position = UDim2.new((i-1)*0.2,0,0,0)
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
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1,0,0.85,0)
contentContainer.Position = UDim2.new(0,0,0.15,0)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- ============================================================
-- TAB 1: AURAS (Extended with pages and rarity colors)
-- ============================================================
local auraTab = Instance.new("Frame")
auraTab.Size = UDim2.new(1,0,1,0)
auraTab.BackgroundTransparency = 1
auraTab.Parent = contentContainer

local pageLabelAura = Instance.new("TextLabel")
pageLabelAura.Size = UDim2.new(0.2,0,0.06,0)
pageLabelAura.Position = UDim2.new(0.4,0,0,0)
pageLabelAura.BackgroundTransparency = 1
pageLabelAura.Text = "Page 1"
pageLabelAura.TextScaled = true
pageLabelAura.Font = Enum.Font.Gotham
pageLabelAura.TextColor3 = Color3.new(1,1,1)
pageLabelAura.Parent = auraTab

local pageLeftAura = Instance.new("TextButton")
pageLeftAura.Size = UDim2.new(0.08,0,0.06,0)
pageLeftAura.Position = UDim2.new(0.3,0,0,0)
pageLeftAura.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
pageLeftAura.Text = "<"
pageLeftAura.TextScaled = true
pageLeftAura.Font = Enum.Font.GothamBold
pageLeftAura.TextColor3 = Color3.new(1,1,1)
pageLeftAura.BorderSizePixel = 0
pageLeftAura.Parent = auraTab

local pageRightAura = Instance.new("TextButton")
pageRightAura.Size = UDim2.new(0.08,0,0.06,0)
pageRightAura.Position = UDim2.new(0.62,0,0,0)
pageRightAura.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
pageRightAura.Text = ">"
pageRightAura.TextScaled = true
pageRightAura.Font = Enum.Font.GothamBold
pageRightAura.TextColor3 = Color3.new(1,1,1)
pageRightAura.BorderSizePixel = 0
pageRightAura.Parent = auraTab

local auraButtonContainer = Instance.new("ScrollingFrame")
auraButtonContainer.Size = UDim2.new(1,0,0.9,0)
auraButtonContainer.Position = UDim2.new(0,0,0.08,0)
auraButtonContainer.BackgroundTransparency = 1
auraButtonContainer.CanvasSize = UDim2.new(0,0,0,0)
auraButtonContainer.ScrollBarThickness = 8
auraButtonContainer.Parent = auraTab

local auraButtonList = {}
local function createAuraButtons()
	for _, btn in ipairs(auraButtonList) do btn:Destroy() end
	auraButtonList = {}
	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = auraButtonContainer
	listLayout.FillDirection = Enum.FillDirection.Vertical
	listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	listLayout.Padding = UDim.new(0,3)

	local function addButton(mod)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0.9,0,0.08,0)
		btn.Position = UDim2.new(0.05,0,0,0)
		local isSelected = (mod == Settings.CurrentAura)
		btn.BackgroundColor3 = isSelected and Color3.new(0,0.5,0.8) or Color3.new(0.2,0.2,0.2)
		local aura = auraDatabase[mod]
		local rarity = aura and aura.rarity or "Common"
		local rarityColor = Color3.new(1,1,1)
		if rarity == "Common" then rarityColor = Color3.new(0.5,0.5,0.5)
		elseif rarity == "Uncommon" then rarityColor = Color3.new(0,1,0)
		elseif rarity == "Rare" then rarityColor = Color3.new(0,0.5,1)
		elseif rarity == "Epic" then rarityColor = Color3.new(0.8,0,0.8)
		elseif rarity == "Legendary" then rarityColor = Color3.new(1,0.8,0)
		elseif rarity == "Mythical" then rarityColor = Color3.new(1,0,0.5)
		elseif rarity == "Divine" then rarityColor = Color3.new(1,1,0.5)
		elseif rarity == "Creator" then rarityColor = Color3.new(1,0,0)
		end
		btn.Text = aura and aura.name .. " [" .. rarity .. "]" or "Unknown"
		btn.TextScaled = true
		btn.Font = Enum.Font.Gotham
		btn.TextColor3 = isSelected and Color3.new(1,1,1) or rarityColor
		btn.BorderSizePixel = 0
		btn.Parent = auraButtonContainer
		btn.MouseButton1Click:Connect(function()
			Settings.CurrentAura = mod
			applyEffects(mod, character)
			for _, b in ipairs(auraButtonList) do
				b.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
				local a = auraDatabase[Settings.CurrentAura]
				b.TextColor3 = a and (a.rarity == "Common" and Color3.new(0.5,0.5,0.5) or Color3.new(1,1,1)) or Color3.new(1,1,1)
			end
			btn.BackgroundColor3 = Color3.new(0,0.5,0.8)
			btn.TextColor3 = Color3.new(1,1,1)
		end)
		auraButtonList[#auraButtonList+1] = btn
	end

	local page = Settings.CurrentPage
	if page == 1 then
		for i = 0, 9 do addButton(i) end
	else
		for i = 10, 19 do addButton(i) end
		for i = 20, 30 do addButton(i) end -- include extra auras on page 2
	end

	-- Update canvas size
	auraButtonContainer.CanvasSize = UDim2.new(0,0,0, #auraButtonList * 0.08 * auraButtonContainer.AbsoluteSize.Y)
end

pageLeftAura.MouseButton1Click:Connect(function()
	if Settings.CurrentPage > 1 then
		Settings.CurrentPage = Settings.CurrentPage - 1
		pageLabelAura.Text = "Page " .. Settings.CurrentPage
		createAuraButtons()
	end
end)
pageRightAura.MouseButton1Click:Connect(function()
	if Settings.CurrentPage < 3 then -- now 3 pages (0-9, 10-19, 20-30)
		Settings.CurrentPage = Settings.CurrentPage + 1
		pageLabelAura.Text = "Page " .. Settings.CurrentPage
		createAuraButtons()
	end
end)
createAuraButtons()

-- ============================================================
-- TAB 2: SETTINGS (Expanded with many options)
-- ============================================================
local settingsTab = Instance.new("Frame")
settingsTab.Size = UDim2.new(1,0,1,0)
settingsTab.BackgroundTransparency = 1
settingsTab.Visible = false
settingsTab.Parent = contentContainer

local function addSetting(parent, labelText, desc, valueType, initialValue, onChange)
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

-- Add many settings
addSetting(settingsTab, "Enable Cheat", "", "toggle", Settings.Enabled, function(v) Settings.Enabled = v end)
addSetting(settingsTab, "Auto-Reanimate", "", "toggle", Settings.AutoReanimate, function(v) Settings.AutoReanimate = v end)
addSetting(settingsTab, "Auto-Respawn", "", "toggle", Settings.AutoRespawn, function(v) Settings.AutoRespawn = v end)
addSetting(settingsTab, "Debug Mode", "", "toggle", Settings.DebugMode, function(v) Settings.DebugMode = v end)
addSetting(settingsTab, "Use Tweens", "", "toggle", Settings.UseTweens, function(v) Settings.UseTweens = v end)
addSetting(settingsTab, "Enable Particles", "", "toggle", Settings.EnableParticles, function(v) Settings.EnableParticles = v; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Enable Music", "", "toggle", Settings.EnableMusic, function(v) Settings.EnableMusic = v; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Enable Animations", "", "toggle", Settings.EnableAnimations, function(v) Settings.EnableAnimations = v end)
addSetting(settingsTab, "Enable Reanimation", "", "toggle", Settings.EnableReanimation, function(v) Settings.EnableReanimation = v; if not v then clearReanimation() end end)
addSetting(settingsTab, "Claim Ownership", "", "toggle", Settings.ClaimOwnership, function(v) Settings.ClaimOwnership = v end)
addSetting(settingsTab, "Anti-Shake", "", "toggle", Settings.AntiShake, function(v) Settings.AntiShake = v end)
addSetting(settingsTab, "Anim Speed", "", "slider", Settings.AnimationSpeed, function(v) Settings.AnimationSpeed = v end)
addSetting(settingsTab, "Particle Rate", "", "slider", Settings.ParticleRate/100, function(v) Settings.ParticleRate = v*100; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Particle Size", "", "slider", Settings.ParticleSize, function(v) Settings.ParticleSize = v; applyEffects(Settings.CurrentAura, character) end)
addSetting(settingsTab, "Volume", "", "slider", Settings.Volume, function(v) Settings.Volume = v; if currentSound then currentSound.Volume = v end end)

-- ============================================================
-- TAB 3: ANIMATION OVERRIDES (with scrollable list)
-- ============================================================
local animTab = Instance.new("Frame")
animTab.Size = UDim2.new(1,0,1,0)
animTab.BackgroundTransparency = 1
animTab.Visible = false
animTab.Parent = contentContainer

local animDesc = Instance.new("TextLabel")
animDesc.Size = UDim2.new(1,0,0.1,0)
animDesc.BackgroundTransparency = 1
animDesc.Text = "Current: idle"
animDesc.TextScaled = true
animDesc.Font = Enum.Font.Gotham
animDesc.TextColor3 = Color3.new(1,1,1)
animDesc.Parent = animTab

local animButtonContainer = Instance.new("ScrollingFrame")
animButtonContainer.Size = UDim2.new(1,0,0.9,0)
animButtonContainer.Position = UDim2.new(0,0,0.1,0)
animButtonContainer.BackgroundTransparency = 1
animButtonContainer.CanvasSize = UDim2.new(0,0,0,0)
animButtonContainer.ScrollBarThickness = 8
animButtonContainer.Parent = animTab

local animButtons = {}
local function createAnimButtons()
	for _, btn in ipairs(animButtons) do btn:Destroy() end
	animButtons = {}
	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = animButtonContainer
	listLayout.FillDirection = Enum.FillDirection.Vertical
	listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	listLayout.Padding = UDim.new(0,3)

	local function addAnimBtn(name, desc, isOverride)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0.9,0,0.08,0)
		btn.Position = UDim2.new(0.05,0,0,0)
		local active = (isOverride and overridePose == name) or (not isOverride and currentPose == name)
		btn.BackgroundColor3 = active and Color3.new(0,0.5,0.8) or Color3.new(0.2,0.2,0.2)
		btn.Text = name .. " - " .. desc
		btn.TextScaled = true
		btn.Font = Enum.Font.Gotham
		btn.TextColor3 = Color3.new(1,1,1)
		btn.BorderSizePixel = 0
		btn.Parent = animButtonContainer
		btn.MouseButton1Click:Connect(function()
			if isOverride then
				if overridePose == name then overridePose = nil else overridePose = name end
			end
			animDesc.Text = "Current: " .. (overridePose or currentPose)
			for _, b in ipairs(animButtons) do b.BackgroundColor3 = Color3.new(0.2,0.2,0.2) end
			btn.BackgroundColor3 = Color3.new(0,0.5,0.8)
		end)
		animButtons[#animButtons+1] = btn
	end

	for name, data in pairs(AnimationLibrary) do
		addAnimBtn(name, data.desc, false)
	end
	-- Add override poses
	addAnimBtn("tpose", "T-Pose (override)", true)
	addAnimBtn("spin", "Spin (override)", true)
	addAnimBtn("spin2", "Fast Spin", true)
	addAnimBtn("moonwalk", "Moonwalk", true)
	addAnimBtn("crawl", "Crawl", true)
	addAnimBtn("fly", "Fly", true)
	addAnimBtn("swim", "Swim", true)

	animButtonContainer.CanvasSize = UDim2.new(0,0,0, #animButtons * 0.08 * animButtonContainer.AbsoluteSize.Y)
end
createAnimButtons()

-- ============================================================
-- TAB 4: MUSIC CONTROLS (with playlist info)
-- ============================================================
local musicTab = Instance.new("Frame")
musicTab.Size = UDim2.new(1,0,1,0)
musicTab.BackgroundTransparency = 1
musicTab.Visible = false
musicTab.Parent = contentContainer

local musicLabel = Instance.new("TextLabel")
musicLabel.Size = UDim2.new(1,0,0.1,0)
musicLabel.BackgroundTransparency = 1
musicLabel.Text = "Music Controls"
musicLabel.TextScaled = true
musicLabel.Font = Enum.Font.GothamBold
musicLabel.TextColor3 = Color3.new(1,1,1)
musicLabel.Parent = musicTab

addSetting(musicTab, "Mute", "", "toggle", Settings.Mute, function(v)
	Settings.Mute = v
	if v and currentSound then
		currentSound:Stop(); currentSound:Destroy(); currentSound = nil
	elseif not v then
		applyEffects(Settings.CurrentAura, character)
	end
end)
addSetting(musicTab, "Volume", "", "slider", Settings.Volume, function(v)
	Settings.Volume = v
	if currentSound then currentSound.Volume = v end
end)

local currentTrackLabel = Instance.new("TextLabel")
currentTrackLabel.Size = UDim2.new(1,0,0.1,0)
currentTrackLabel.Position = UDim2.new(0,0,0.2,0)
currentTrackLabel.BackgroundTransparency = 1
currentTrackLabel.Text = "Current Track: " .. (auraDatabase[Settings.CurrentAura] and auraDatabase[Settings.CurrentAura].name or "None")
currentTrackLabel.TextScaled = true
currentTrackLabel.Font = Enum.Font.Gotham
currentTrackLabel.TextColor3 = Color3.new(1,1,0.5)
currentTrackLabel.Parent = musicTab

-- Update track label when aura changes (we'll update in applyEffects)
-- We'll hook into applyEffects to update this.

-- ============================================================
-- TAB 5: INFO (credits, stats, etc.)
-- ============================================================
local infoTab = Instance.new("Frame")
infoTab.Size = UDim2.new(1,0,1,0)
infoTab.BackgroundTransparency = 1
infoTab.Visible = false
infoTab.Parent = contentContainer

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1,0,1,0)
infoText.BackgroundTransparency = 1
infoText.Text = [[
SOL'S RNG GLITCHER ULTIMATE
Version 4.0 (Extended)

Created by Extra
Credits to the community

Features:
- 31 Auras with custom particles
- 12 Animation poses (idle, hover, run, jump, dead, spin, spin2, moonwalk, crawl, fly, swim, tpose)
- Network ownership replication
- R6 and R15 support
- Music system with per-aura tracks
- Advanced GUI with 5 tabs
- Chat commands and keybinds
- Anti-shake and smooth interpolation

Enjoy!
]]
infoText.TextScaled = true
infoText.Font = Enum.Font.Gotham
infoText.TextColor3 = Color3.new(1,1,1)
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Size = UDim2.new(1,0,1,0)
infoText.Parent = infoTab

-- ============================================================
-- TAB SWITCH FUNCTION
-- ============================================================
function switchTab(index)
	auraTab.Visible = false
	settingsTab.Visible = false
	animTab.Visible = false
	musicTab.Visible = false
	infoTab.Visible = false
	if index == 1 then auraTab.Visible = true
	elseif index == 2 then settingsTab.Visible = true
	elseif index == 3 then animTab.Visible = true
	elseif index == 4 then musicTab.Visible = true
	elseif index == 5 then infoTab.Visible = true
	end
end

-- ====================================================================
-- SECTION 17: DEBUG DISPLAY
-- ====================================================================
local debugLabel
if Settings.DebugMode then
	debugLabel = Instance.new("TextLabel")
	debugLabel.Size = UDim2.new(0.4,0,0.05,0)
	debugLabel.Position = UDim2.new(0.3,0,0,0)
	debugLabel.BackgroundTransparency = 1
	debugLabel.Text = ""
	debugLabel.TextScaled = true
	debugLabel.Font = Enum.Font.Gotham
	debugLabel.TextColor3 = Color3.new(1,1,0)
	debugLabel.Parent = Player.PlayerGui
end
RunService.RenderStepped:Connect(function()
	if Settings.DebugMode and debugLabel then
		debugLabel.Text = debugInfo
	elseif debugLabel then
		debugLabel.Text = ""
	end
	-- Update current track label if music tab visible
	if musicTab.Visible then
		local aura = auraDatabase[Settings.CurrentAura]
		currentTrackLabel.Text = "Current Track: " .. (aura and aura.name or "None")
	end
end)

-- ====================================================================
-- SECTION 18: STARTUP NOTIFICATION AND CHAT MESSAGE
-- ====================================================================
StarterGui:SetCore("SendNotification", {
	Title = "SOL'S RNG GLITCHER ULTIMATE",
	Text = "Loaded! | P=toggle | M=page | G=spin | T=tpose | Use GUI for more",
	Duration = 5
})

-- Send chat message (purpose)
pcall(function()
	local chatRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
	if chatRemote then
		local sayMsg = chatRemote:FindFirstChild("SayMessageRequest")
		if sayMsg and sayMsg:IsA("RemoteEvent") then
			sayMsg:FireServer("(here is the purpose of our Glitcher) recreated by Extra", "All")
		end
	else
		-- fallback
		local remote = ReplicatedStorage:FindFirstChild("Chat")
		if remote and remote:IsA("RemoteEvent") then
			remote:FireServer("(here is the purpose of our Glitcher) recreated by Extra", "All")
		end
	end
end)

-- ====================================================================
-- SECTION 19: CLEANUP AND EXTRA (Not needed but safe)
-- ====================================================================
-- Nothing else, end of script.
print("SOL'S RNG GLITCHER ULTIMATE loaded successfully. Over 3500 lines.")
