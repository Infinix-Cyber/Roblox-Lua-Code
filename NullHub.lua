-- NullHub [Universal]
-- Single-file universal hub for Roblox — mobile optimized (Delta, Fluxus, etc.)

-- ============================================================
-- LOAD NULL UI
-- ============================================================

local NullLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ginzuss/nullui/refs/heads/main/NullUI.lua"
))()

-- ============================================================
-- SERVICES
-- ============================================================

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TeleportService  = game:GetService("TeleportService")
local HttpService      = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- HELPERS
-- ============================================================

local function getHumanoid()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function isAlive(plr)
    local char = plr.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

-- ============================================================
-- STATE
-- ============================================================

local State = {
    -- Movement
    speedEnabled = false,  speedValue = 16,
    jumpEnabled  = false,  jumpValue  = 50,
    flyEnabled   = false,  flySpeed   = 50,
    noclipEnabled = false,
    infJumpEnabled = false,
    -- ESP
    espEnabled = false,
    espColor = Color3.fromRGB(255, 90, 90),
    espNames = true, espHealth = true, espDistance = true,
    -- Visual
    fullbright = false,
    -- Combat
    aimbotEnabled = false,
    aimbotFOV = 90,
    aimbotSmooth = 0.25,
    aimbotMode = "Closest",
    aimbotHold = false,
    aimbotTeamCheck = true,
    -- Misc
    antiAFK = false,
}

-- ============================================================
-- WINDOW
-- ============================================================

local Window = NullLib:CreateWindow({
    Name = "NullHub",
    Title = "NullHub [Universal]",
    Subtitle = "universal hub",
    BadgeText = "v1.0",
    ToggleKey = Enum.KeyCode.RightShift,
    ConfigFolder = "NullHub",
    ConfigName = "Default",
    TabPosition = "Left",
    ShowTabTitle = true,
    WelcomeNotification = true,
    UIWatermark = true,
})

-- Watermark
local elapsed, frames = 0, 0
RunService.RenderStepped:Connect(function(dt)
    elapsed += dt frames += 1
    if elapsed >= 0.5 then
        Window:SetWatermark(string.format(
            "NullHub | %s | %d FPS",
            LocalPlayer.Name,
            math.floor(frames / elapsed)
        ))
        elapsed, frames = 0, 0
    end
end)

-- ============================================================
-- MOVEMENT
-- ============================================================

local speedConn, jumpConn, infJumpConn, noclipConn

local function applySpeed()
    if speedConn then speedConn:Disconnect() speedConn = nil end
    if not State.speedEnabled then
        local hum = getHumanoid() if hum then hum.WalkSpeed = 16 end
        return
    end
    speedConn = RunService.Heartbeat:Connect(function()
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = State.speedValue end
    end)
end

local function applyJump()
    if jumpConn then jumpConn:Disconnect() jumpConn = nil end
    if not State.jumpEnabled then
        local hum = getHumanoid()
        if hum then hum.UseJumpPower = true hum.JumpPower = 50 end
        return
    end
    jumpConn = RunService.Heartbeat:Connect(function()
        local hum = getHumanoid()
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = State.jumpValue
        end
    end)
end

local function applyInfJump()
    if infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end
    if not State.infJumpEnabled then return end
    infJumpConn = UserInputService.JumpRequest:Connect(function()
        local hum = getHumanoid()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end

local function applyNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    if not State.noclipEnabled then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and not part.CanCollide then
                    part.CanCollide = true
                end
            end
        end
        return
    end
    noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
end

-- Fly
local flyBV, flyBG, flyConn
local flyKeys = {w=false,a=false,s=false,d=false,space=false,shift=false}

local function startFly()
    local root = getRoot() if not root then return end
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    if flyConn then flyConn:Disconnect() flyConn = nil end

    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyBV.Velocity = Vector3.zero
    flyBV.Parent = root

    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyBG.P = 9e4
    flyBG.Parent = root

    flyConn = RunService.RenderStepped:Connect(function()
        local r = getRoot()
        if not r or not flyBV or not flyBG then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if flyKeys.w then dir += cam.CFrame.LookVector end
        if flyKeys.s then dir -= cam.CFrame.LookVector end
        if flyKeys.a then dir -= cam.CFrame.RightVector end
        if flyKeys.d then dir += cam.CFrame.RightVector end
        if flyKeys.space then dir += Vector3.new(0,1,0) end
        if flyKeys.shift then dir -= Vector3.new(0,1,0) end
        flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * State.flySpeed or Vector3.zero
        flyBG.CFrame = cam.CFrame
    end)
end

local function stopFly()
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local root = getRoot()
    if root then root.Velocity = Vector3.zero end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe or not State.flyEnabled then return end
    if input.KeyCode == Enum.KeyCode.W then flyKeys.w = true
    elseif input.KeyCode == Enum.KeyCode.A then flyKeys.a = true
    elseif input.KeyCode == Enum.KeyCode.S then flyKeys.s = true
    elseif input.KeyCode == Enum.KeyCode.D then flyKeys.d = true
    elseif input.KeyCode == Enum.KeyCode.Space then flyKeys.space = true
    elseif input.KeyCode == Enum.KeyCode.LeftShift then flyKeys.shift = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if not State.flyEnabled then return end
    if input.KeyCode == Enum.KeyCode.W then flyKeys.w = false
    elseif input.KeyCode == Enum.KeyCode.A then flyKeys.a = false
    elseif input.KeyCode == Enum.KeyCode.S then flyKeys.s = false
    elseif input.KeyCode == Enum.KeyCode.D then flyKeys.d = false
    elseif input.KeyCode == Enum.KeyCode.Space then flyKeys.space = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift then flyKeys.shift = false end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if State.speedEnabled then applySpeed() end
    if State.jumpEnabled then applyJump() end
    if State.infJumpEnabled then applyInfJump() end
    if State.flyEnabled then task.wait(0.5) startFly() end
end)

-- ============================================================
-- ESP (BillboardGui)
-- ============================================================

local espCache = {}

local function createESP(plr)
    if espCache[plr] then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NullHubESP"
    billboard.Adornee = nil
    billboard.Size = UDim2.new(0, 120, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = false
    billboard.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = billboard

    -- Box outline
    local box = Instance.new("Frame")
    box.Name = "Box"
    box.Size = UDim2.new(0, 60, 0, 80)
    box.Position = UDim2.new(0.5, -30, 0.5, -40)
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 0
    box.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Color = State.espColor
    stroke.Thickness = 1.5
    stroke.Transparency = 0.2
    stroke.Parent = box

    -- Name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 14)
    nameLabel.Position = UDim2.new(0, 0, 0, -18)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = plr.Name
    nameLabel.Parent = mainFrame

    -- Distance
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0, 12)
    distLabel.Position = UDim2.new(0, 0, 1, 2)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(200,200,200)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextSize = 11
    distLabel.Font = Enum.Font.Gotham
    distLabel.Text = ""
    distLabel.Parent = mainFrame

    espCache[plr] = {
        billboard = billboard,
        box = box,
        stroke = stroke,
        nameLabel = nameLabel,
        distLabel = distLabel,
    }
end

local function removeESP(plr)
    local entry = espCache[plr]
    if entry and entry.billboard then
        entry.billboard:Destroy()
    end
    espCache[plr] = nil
end

local function updateESP()
    if not State.espEnabled then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            createESP(plr)
            local entry = espCache[plr]
            if entry then
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if hrp and hum and hum.Health > 0 then
                    entry.billboard.Adornee = hrp
                    entry.billboard.Enabled = true
                    entry.stroke.Color = State.espColor

                    entry.nameLabel.Text = plr.Name
                    entry.nameLabel.Visible = State.espNames

                    local dist = (hrp.Position - (getRoot() and getRoot().Position or Vector3.zero)).Magnitude
                    entry.distLabel.Text = string.format("%d studs", math.floor(dist))
                    entry.distLabel.Visible = State.espDistance

                    if State.espHealth then
                        local hpPercent = hum.Health / hum.MaxHealth
                        entry.stroke.Transparency = 0.2
                        -- subtle health tint on the box via stroke color blend
                        entry.stroke.Color = State.espColor:Lerp(Color3.fromRGB(0,255,0), hpPercent * 0.3)
                    end
                else
                    entry.billboard.Enabled = false
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    if State.espEnabled then updateESP() end
end)

Players.PlayerRemoving:Connect(removeESP)

local function setESPEnabled(enabled)
    State.espEnabled = enabled
    if not enabled then
        for plr, entry in pairs(espCache) do
            if entry.billboard then entry.billboard.Enabled = false end
        end
    end
end

-- ============================================================
-- VISUAL
-- ============================================================

local originalLighting = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
}

local function setFullbright(on)
    State.fullbright = on
    if on then
        Lighting.Ambient = Color3.fromRGB(178,178,178)
        Lighting.OutdoorAmbient = Color3.fromRGB(178,178,178)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
    else
        Lighting.Ambient = originalLighting.Ambient
        Lighting.OutdoorAmbient = originalLighting.OutdoorAmbient
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.FogEnd = originalLighting.FogEnd
    end
end

local function setFOV(v)
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = v end
end

-- ============================================================
-- COMBAT — camera aimbot
-- ============================================================

local aimbotHold = false
local aimbotConn

local function getClosestTarget()
    local cam = workspace.CurrentCamera
    if not cam then return nil end

    local myRoot = getRoot()
    if not myRoot then return nil end

    local closest, closestDist = nil, math.huge
    local screenCenter = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and isAlive(plr) then
            if State.aimbotTeamCheck and plr.Team == LocalPlayer.Team then
                continue
            end
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                if State.aimbotMode == "Closest" then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < closestDist then closest, closestDist = hrp, d end
                elseif State.aimbotMode == "Nearest Cursor" then
                    local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local d = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if d < closestDist then closest, closestDist = hrp, d end
                    end
                elseif State.aimbotMode == "Lowest HP" then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local hp = hum.Health
                        if not closest or hp < closestDist then
                            closest, closestDist = hrp, hp
                        end
                    end
                end
            end
        end
    end
    return closest
end

local function startAimbot()
    if aimbotConn then aimbotConn:Disconnect() aimbotConn = nil end
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not State.aimbotEnabled then return end
        if State.aimbotHold and not aimbotHold then return end

        local target = getClosestTarget()
        if target then
            local cam = workspace.CurrentCamera
            local targetCF = CFrame.new(cam.CFrame.Position, target.Position)
            cam.CFrame = cam.CFrame:Lerp(targetCF, 1 - State.aimbotSmooth)
        end
    end)
end

local function stopAimbot()
    if aimbotConn then aimbotConn:Disconnect() aimbotConn = nil end
end

-- ============================================================
-- MISC
-- ============================================================

local antiAFKConn
local function setAntiAFK(enabled)
    State.antiAFK = enabled
    if antiAFKConn then antiAFKConn:Disconnect() antiAFKConn = nil end
    if not enabled then return end
    antiAFKConn = LocalPlayer.Idled:Connect(function()
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end

local function rejoin()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

local function serverHop()
    local url = string.format(
        "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
        game.PlaceId
    )
    local ok, res = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if not ok or not res or not res.data then
        Window:Notify({Title = "Server Hop", Content = "Failed to fetch servers.", Icon = "alert-circle", Color = NullLib.Theme.Bad})
        return
    end
    local servers = {}
    for _, s in ipairs(res.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            table.insert(servers, s.id)
        end
    end
    if #servers == 0 then
        Window:Notify({Title = "Server Hop", Content = "No servers available.", Icon = "alert-circle", Color = NullLib.Theme.Bad})
        return
    end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
end

local function teleportToPlayer(name)
    local target = Players:FindFirstChild(name)
    if not target or not isAlive(target) then return end
    local myRoot = getRoot()
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if myRoot and tRoot then
        myRoot.CFrame = tRoot.CFrame + Vector3.new(0, 3, 0)
    end
end

local function teleportToCursor()
    local myRoot = getRoot()
    local cam = workspace.CurrentCamera
    local mouse = LocalPlayer:GetMouse()
    if not myRoot or not cam then return end
    -- raycast forward from camera
    local origin = cam.CFrame.Position
    local dir = cam.CFrame.LookVector * 500
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local hit = workspace:Raycast(origin, dir, params)
    if hit then
        myRoot.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
    end
end

-- ============================================================
-- UI
-- ============================================================

local MovementTab = Window:CreateTab({Name = "Movement", Icon = "move",       Description = "Speed, Jump, Fly, Noclip"})
local VisualTab   = Window:CreateTab({Name = "Visual",   Icon = "eye",        Description = "ESP, Fullbright, FOV"})
local CombatTab   = Window:CreateTab({Name = "Combat",   Icon = "crosshair",  Description = "Aimbot"})
local MiscTab     = Window:CreateTab({Name = "Misc",     Icon = "settings-2", Description = "Anti-AFK, Rejoin, TP"})
local ConfigTab   = Window:CreateTab({Name = "Configs",  Icon = "save",       Description = "Save / Load"})

-- --- Movement ---
local SpeedSec = MovementTab:CreateSection({Title = "Speed", Icon = "gauge", Side = "Left"})
SpeedSec:AddToggle({
    Text = "Enable Speed", Flag = "SpeedEnabled", Default = false,
    Callback = function(s) State.speedEnabled = s applySpeed() end
})
SpeedSec:AddTextbox({
    Placeholder = "Speed value", Flag = "SpeedValue", Default = "50",
    Callback = function(t)
        local n = tonumber(t)
        if n and n > 0 then
            State.speedValue = n
            if State.speedEnabled then applySpeed() end
        end
    end
})

local JumpSec = MovementTab:CreateSection({Title = "Jump", Icon = "arrow-up", Side = "Left"})
JumpSec:AddToggle({
    Text = "Enable Jump Power", Flag = "JumpEnabled", Default = false,
    Callback = function(s) State.jumpEnabled = s applyJump() end
})
JumpSec:AddTextbox({
    Placeholder = "Jump value", Flag = "JumpValue", Default = "100",
    Callback = function(t)
        local n = tonumber(t)
        if n and n > 0 then
            State.jumpValue = n
            if State.jumpEnabled then applyJump() end
        end
    end
})
JumpSec:AddToggle({
    Text = "Infinite Jump", Flag = "InfJump", Default = false,
    Callback = function(s) State.infJumpEnabled = s applyInfJump() end
})

local FlySec = MovementTab:CreateSection({Title = "Fly", Icon = "plane", Side = "Right"})
FlySec:AddToggle({
    Text = "Enable Fly", Description = "WASD + Space/Shift", Flag = "FlyEnabled", Default = false,
    Callback = function(s)
        State.flyEnabled = s
        if s then startFly() else stopFly() end
    end
})
FlySec:AddSlider({
    Text = "Fly Speed", Flag = "FlySpeed", Min = 10, Max = 300, Default = 50,
    Callback = function(v) State.flySpeed = v end
})

local NoclipSec = MovementTab:CreateSection({Title = "Noclip", Icon = "ghost", Side = "Right"})
NoclipSec:AddToggle({
    Text = "Enable Noclip", Description = "walk through walls", Flag = "Noclip", Default = false,
    Callback = function(s) State.noclipEnabled = s applyNoclip() end
})

-- --- Visual ---
local ESPSec = VisualTab:CreateSection({Title = "ESP", Icon = "scan-eye", Side = "Left"})
ESPSec:AddToggle({
    Text = "Enable ESP", Flag = "ESPEnabled", Default = false,
    Callback = function(s) setESPEnabled(s) end
})
ESPSec:AddColorPicker({
    Text = "ESP Color", Flag = "ESPColor",
    DefaultColor = Color3.fromRGB(255,90,90), DefaultAlpha = 0.9,
    Callback = function(c) State.espColor = c end
})
ESPSec:AddToggle({Text = "Show Names",    Flag = "ESPNames",    Default = true, Callback = function(s) State.espNames = s end})
ESPSec:AddToggle({Text = "Show Distance", Flag = "ESPDistance", Default = true, Callback = function(s) State.espDistance = s end})
ESPSec:AddToggle({Text = "Show Health",   Flag = "ESPHealth",   Default = true, Callback = function(s) State.espHealth = s end})

local LightSec = VisualTab:CreateSection({Title = "Lighting", Icon = "sun", Side = "Right"})
LightSec:AddToggle({
    Text = "Fullbright", Flag = "Fullbright", Default = false,
    Callback = function(s) setFullbright(s) end
})
LightSec:AddSlider({
    Text = "Field of View", Flag = "FOV", Min = 70, Max = 120, Default = 70,
    Callback = function(v) setFOV(v) end
})

-- --- Combat ---
local AimSec = CombatTab:CreateSection({Title = "Aimbot", Icon = "crosshair", Side = "Left"})
AimSec:AddToggle({
    Text = "Enable Aimbot", Description = "camera lock", Flag = "AimbotEnabled", Default = false,
    Callback = function(s)
        State.aimbotEnabled = s
        if s then startAimbot() else stopAimbot() end
    end
})
AimSec:AddSlider({
    Text = "Smoothness", Flag = "AimbotSmooth", Decimals = true,
    Min = 0.05, Max = 1.00, Default = 0.25,
    Callback = function(v) State.aimbotSmooth = v end
})
AimSec:AddDropdown({
    Text = "Target Mode", Flag = "AimbotMode",
    Values = {"Closest", "Lowest HP", "Nearest Cursor"}, Default = "Closest",
    Callback = function(v) State.aimbotMode = tostring(v) end
})
AimSec:AddToggle({
    Text = "Hold Mode", Description = "only aim while key held", Flag = "AimbotHold", Default = false,
    Callback = function(s) State.aimbotHold = s end
})
AimSec:AddKeybind({
    Text = "Aimbot Key", Flag = "AimbotKey",
    DefaultKey = Enum.KeyCode.E, Mode = "Hold",
    Callback = function(st) aimbotHold = st end,
})
AimSec:AddToggle({
    Text = "Team Check", Flag = "AimbotTeam", Default = true,
    Callback = function(s) State.aimbotTeamCheck = s end
})

-- --- Misc ---
local UtilSec = MiscTab:CreateSection({Title = "Utility", Icon = "wrench", Side = "Left"})
UtilSec:AddToggle({
    Text = "Anti-AFK", Flag = "AntiAFK", Default = false,
    Callback = function(s) setAntiAFK(s) end
})
UtilSec:AddButton({
    Text = "Rejoin Server", Icon = "rotate-cw",
    Callback = function() rejoin() end
})
UtilSec:AddButton({
    Text = "Server Hop", Icon = "shuffle",
    Callback = function() serverHop() end
})

local TPSec = MiscTab:CreateSection({Title = "Teleport", Icon = "map-pin", Side = "Right"})

local TPDropdown = TPSec:AddDropdown({
    Text = "Target Player", Flag = "TPTarget",
    Values = {}, Default = nil,
    Callback = function() end
})

local function refreshPlayers()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(names, p.Name) end
    end
    if #names == 0 then names = {"(no players)"} end
    TPDropdown:SetValues(names, true)
end
refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

TPSec:AddButton({
    Text = "Teleport To Player", Icon = "navigation",
    Callback = function()
        local t = TPDropdown:Get()
        if t and t ~= "(no players)" then teleportToPlayer(tostring(t)) end
    end
})
TPSec:AddButton({
    Text = "Teleport To Cursor", Icon = "mouse-pointer-2",
    Callback = function() teleportToCursor() end
})

-- --- Configs ---
local CfgSec = ConfigTab:CreateSection({Title = "Config Manager", Icon = "folder", Side = "Left"})
local CfgNameBox = CfgSec:AddTextbox({
    Placeholder = "Config name...", Flag = "ConfigNameInput", Default = "Default"
})
CfgSec:AddButton({
    Text = "Save Config", Icon = "save",
    Callback = function()
        local n = CfgNameBox:GetText() or "Default"
        Window:SaveConfig(n)
        Window:Notify({Title = "Config", Content = "Saved: "..n, Icon = "check", Color = NullLib.Theme.Good})
    end
})
CfgSec:AddButton({
    Text = "Load Config", Icon = "download",
    Callback = function()
        local n = CfgNameBox:GetText() or "Default"
        Window:LoadConfig(n)
        Window:Notify({Title = "Config", Content = "Loaded: "..n, Icon = "check", Color = NullLib.Theme.Good})
    end
})
local CfgList = CfgSec:AddDropdown({
    Text = "Config List", Flag = "ConfigList",
    Values = Window:RefreshConfigs(), Default = "Default",
    Callback = function(v) CfgNameBox:Set(tostring(v), true) end
})
CfgSec:AddButton({
    Text = "Refresh", Icon = "refresh-cw",
    Callback = function() CfgList:SetValues(Window:RefreshConfigs(), true) end
})
CfgSec:AddButton({
    Text = "Delete Selected", Icon = "trash-2",
    Callback = function()
        local n = CfgList:Get()
        if n then
            Window:DeleteConfig(tostring(n))
            CfgList:SetValues(Window:RefreshConfigs(), true)
        end
    end
})

local ThemeSec = ConfigTab:CreateSection({Title = "Theme", Icon = "palette", Side = "Right"})
ThemeSec:AddDropdown({
    Text = "Preset", Flag = "ThemePreset",
    Values = NullLib:ListThemes(), Default = "Null",
    Callback = function(v) Window:SetThemeByName(tostring(v)) end
})

-- ============================================================
-- READY
-- ============================================================

Window:Notify({
    Title = "NullHub",
    Content = "Universal loaded. RightShift to toggle.",
    Icon = "check",
    Color = NullLib.Theme.Good,
    Duration = 5,
})
