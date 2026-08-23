-- Full script with 100 unique orbit modes and GUI title "Extra's orbit"
-- All original functionality preserved – only updateOrbit and GUI title changed.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local plr = Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")
local bp = plr:WaitForChild("Backpack")
local targetHRP = hrp

local SETTINGS = {
    SimulationRadius = math.huge,
    VelocityY = 2.5,
    LerpSpeed = 12,
    ToolRotSpeed = 15,
    Offset = 4,
    NumTools = 8,
    OrbitMode = 0,
    Angle = 0,
    ResyncCooldown = 0.3,
    MaxOrbitDist = 8
}

local handles = {}
local orbitParts = {}
local movers = {}
local connections = {}
local toolNames = {}
local lastResyncTime = {}
local toolsEnabled = true

local lastHRPPos = hrp.Position
local hrpVel = Vector3.zero
local targetMonitor = nil
local toolAddedConnection = nil
local currentCharAddedConn = nil

-- ===== CLEANUP & SETUP (unchanged) =====
local function cleanupTool(tool)
    if connections[tool] then
        connections[tool]:Disconnect()
        connections[tool] = nil
    end
    local h = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
    if h and movers[h] then
        if movers[h].align then movers[h].align:Destroy() end
        if movers[h].angular then movers[h].angular:Destroy() end
        movers[h] = nil
    end
    for i, v in ipairs(handles) do
        if v == h then
            table.remove(handles, i)
            table.remove(orbitParts, i)
            break
        end
    end
end

local function setupTool(tool)
    if not tool or not tool.Parent then return end
    cleanupTool(tool)
    local h = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
    if not h then return end
    h.CanCollide = false
    h.Massless = true
    h:BreakJoints()
    table.insert(handles, h)

    local orbitPart = Instance.new("Part")
    orbitPart.Size = Vector3.new(0.5, 0.5, 0.5)
    orbitPart.Anchored = true
    orbitPart.CanCollide = false
    orbitPart.Transparency = 1
    orbitPart.Parent = workspace
    table.insert(orbitParts, orbitPart)

    local align = Instance.new("AlignPosition")
    align.Parent = h
    align.Mode = Enum.PositionAlignmentMode.OneAttachment
    align.MaxForce = math.huge
    align.MaxVelocity = math.huge
    align.Responsiveness = 200
    align.ApplyAtCenterOfMass = true

    local att1 = Instance.new("Attachment", h)
    att1.Position = Vector3.zero
    align.Attachment0 = att1

    local att2 = Instance.new("Attachment", orbitPart)
    att2.Position = Vector3.zero
    align.Attachment1 = att2

    local angular = Instance.new("AngularVelocity")
    angular.Parent = h
    angular.AngularVelocity = Vector3.new(0, SETTINGS.ToolRotSpeed * (10 + (#handles % 30)), 0)
    angular.MaxTorque = math.huge

    movers[h] = {align = align, angular = angular}
    toolNames[tool] = tool.Name

    local conn = tool.AncestryChanged:Connect(function()
        if not tool.Parent or tool.Parent ~= chr and tool.Parent ~= bp then
            cleanupTool(tool)
        end
    end)
    connections[tool] = conn

    lastResyncTime[h] = os.clock()
end

-- ===== GENERATE 100 UNIQUE PATTERNS =====
local function generatePatterns()
    local patterns = {}
    for n = 0, 99 do
        local seed = n + 1
        local shapeType = n % 12
        local freq1 = 1 + (n % 5)
        local freq2 = 2 + (n % 7)
        local freq3 = 3 + (n % 9)
        local phase1 = n * 0.137
        local phase2 = n * 0.271
        local phase3 = n * 0.413
        local ampMul = 0.6 + 0.4 * (n % 5) / 4
        local ampYMul = 0.3 + 0.7 * (n % 7) / 6

        patterns[n+1] = function(currentAngle, time, offset, i)
            local a = currentAngle + time * 0.3
            local b = currentAngle * 2 + time * 0.5
            local c = currentAngle * 3 + time * 0.7

            local x, y, z
            if shapeType == 0 then
                local r = offset * (0.7 + 0.3 * math.sin(a * freq1 + phase1))
                x = math.cos(a) * r
                z = math.sin(a) * r
                y = math.sin(b * freq2 + phase2) * offset * 0.3 * ampYMul
            elseif shapeType == 1 then
                local rx = offset * (0.6 + 0.4 * math.sin(phase1))
                local rz = offset * (0.6 + 0.4 * math.cos(phase2))
                local rot = time * 0.2
                local ca = math.cos(rot)
                local sa = math.sin(rot)
                local ex = math.cos(a) * rx
                local ez = math.sin(a) * rz
                x = ex * ca - ez * sa
                z = ex * sa + ez * ca
                y = math.sin(b * freq2 + phase2) * offset * 0.3 * ampYMul
            elseif shapeType == 2 then
                x = math.cos(a) * offset * 0.9
                z = math.sin(b * 0.5 + phase1) * offset * 0.9
                y = math.sin(c * 0.3 + phase2) * offset * 0.4 * ampYMul
            elseif shapeType == 3 then
                local r = offset * (0.5 + 0.5 * math.sin(a * 0.7 + time * 0.2))
                x = math.cos(a) * r
                z = math.sin(a) * r
                y = math.sin(b + phase1) * offset * 0.4 * ampYMul
            elseif shapeType == 4 then
                local petals = 3 + (n % 7)
                local r = offset * (0.5 + 0.5 * math.sin(currentAngle * petals + time * 0.5))
                x = math.cos(currentAngle) * r
                z = math.sin(currentAngle) * r
                y = math.sin(currentAngle * 2 + time) * offset * 0.3 * ampYMul
            elseif shapeType == 5 then
                local points = 4 + (n % 8)
                local r = offset * (0.5 + 0.5 * math.sin(currentAngle * points + time * 0.4))
                x = math.cos(currentAngle) * r
                z = math.sin(currentAngle) * r
                y = math.cos(currentAngle * 3 + time * 0.7) * offset * 0.4 * ampYMul
            elseif shapeType == 6 then
                local ratioX = 1 + (n % 4)
                local ratioZ = 1 + ((n+1) % 5)
                x = math.cos(a * ratioX + phase1) * offset * 0.8
                z = math.sin(b * ratioZ + phase2) * offset * 0.8
                y = math.sin(c + phase3) * offset * 0.3 * ampYMul
            elseif shapeType == 7 then
                local sq = math.sign(math.sin(a * 2 + time * 0.5))
                local r = offset * (0.5 + 0.5 * sq)
                x = math.cos(a) * r
                z = math.sin(a) * r
                y = math.sin(b + time) * offset * 0.4 * ampYMul
            elseif shapeType == 8 then
                local tri = math.abs(math.sin(a * 1.5 + time * 0.3)) * 2 - 1
                local r = offset * (0.5 + 0.5 * tri)
                x = math.cos(a) * r
                z = math.sin(a) * r
                y = math.cos(b + phase1) * offset * 0.4 * ampYMul
            elseif shapeType == 9 then
                local bounce = math.abs(math.sin(a * 2 + time * 1.2))
                local r = offset * (0.7 + 0.3 * math.sin(b + time * 0.2))
                x = math.cos(a) * r
                z = math.sin(a) * r
                y = bounce * offset * 0.7 * ampYMul
            elseif shapeType == 10 then
                local pendAngle = a + time * 0.4
                local length = offset * (0.7 + 0.3 * math.sin(phase1))
                x = math.sin(pendAngle) * length
                z = 0
                y = -math.cos(pendAngle) * length + offset * 0.5
            else -- shapeType == 11 (mixed)
                local mix = 0.5 + 0.5 * math.sin(phase2)
                local cx = math.cos(a) * offset * 0.8
                local cz = math.sin(a) * offset * 0.8
                local fx = math.cos(b) * offset * 0.6
                local fz = math.sin(b * 0.5 + phase1) * offset * 0.6
                x = cx * (1 - mix) + fx * mix
                z = cz * (1 - mix) + fz * mix
                y = math.sin(c + phase3) * offset * 0.4 * ampYMul
            end

            y = y + math.sin(time * 0.5 + i) * offset * 0.05
            return Vector3.new(x, y, z)
        end
    end
    return patterns
end

local movementPatterns = generatePatterns()

-- ===== UPDATED ORBIT FUNCTION (100 modes) =====
local function updateOrbit(dt, time)
    local numTools = #handles
    if numTools == 0 or not targetHRP or not targetHRP.Parent then return end
    local mode = SETTINGS.OrbitMode
    local angle = SETTINGS.Angle
    local offset = SETTINGS.Offset
    local lerpSpeed = SETTINGS.LerpSpeed
    local toolRotSpeed = SETTINGS.ToolRotSpeed

    for i, h in ipairs(handles) do
        if not h or not h.Parent then continue end
        local targetCFrame
        local fixedAngle = math.rad((i - 1) * (360 / numTools))
        local currentAngle = angle + fixedAngle

        -- Original modes 0-6 (unchanged)
        if mode == 0 then
            targetCFrame = targetHRP.CFrame * CFrame.Angles(0, fixedAngle, 0) * CFrame.new(offset, 0, 0)
        elseif mode == 1 then
            targetCFrame = targetHRP.CFrame * CFrame.Angles(0, currentAngle, 0) * CFrame.new(offset, 0, 0)
        elseif mode == 2 then
            local yOff = math.sin(time * 2 + i) * 2
            targetCFrame = targetHRP.CFrame * CFrame.new(math.cos(currentAngle) * offset, yOff, math.sin(currentAngle) * offset)
        elseif mode == 3 then
            targetCFrame = targetHRP.CFrame * CFrame.Angles(currentAngle, currentAngle, 0) * CFrame.new(offset, 0, 0)
        elseif mode == 4 then
            targetCFrame = CFrame.new(targetHRP.Position) * CFrame.Angles(0, currentAngle, 0) * CFrame.new(offset, 0, 0)
        elseif mode == 5 then
            targetCFrame = targetHRP.CFrame * CFrame.new(math.cos(currentAngle) * offset, math.sin(currentAngle) * offset, math.sin(currentAngle) * offset)
        elseif mode == 6 then
            targetCFrame = targetHRP.CFrame * CFrame.Angles(currentAngle, 0, currentAngle) * CFrame.new(offset, 0, 0)
        else
            -- 100 patterns (subType 0-99)
            local subType = mode % 100
            local pattern = movementPatterns[subType + 1]
            if pattern then
                local pos = pattern(currentAngle, time, offset, i)
                local tiltX = math.rad(math.sin(currentAngle + time) * 5)
                local tiltZ = math.rad(math.cos(currentAngle * 0.7 + time) * 5)
                targetCFrame = targetHRP.CFrame * CFrame.new(pos) * CFrame.Angles(tiltX, 0, tiltZ)
            else
                -- fallback
                targetCFrame = targetHRP.CFrame * CFrame.new(math.cos(currentAngle) * offset, 0, math.sin(currentAngle) * offset)
            end

            if mode > 20 then
                local slowWobble = math.rad(math.sin(time) * 15)
                targetCFrame = targetCFrame * CFrame.Angles(slowWobble, 0, slowWobble)
            end
        end

        local alpha = 1 - math.exp(-lerpSpeed * dt)
        h.CFrame = h.CFrame:Lerp(targetCFrame, alpha)

        local ang = movers[h] and movers[h].angular
        if ang then
            local spinVar = (mode % 30)
            ang.AngularVelocity = Vector3.new(0, toolRotSpeed * (10 + spinVar), 0)
        end
    end
end

-- ===== HANDLE CHARACTER (unchanged) =====
local function handleCharacter(c)
    chr = c
    hrp = c:WaitForChild("HumanoidRootPart")
    targetHRP = hrp
    lastHRPPos = hrp.Position

    for _, p in ipairs(orbitParts) do p:Destroy() end
    for _, h in ipairs(handles) do
        cleanupTool(h.Parent)
    end
    table.clear(handles)
    table.clear(orbitParts)
    table.clear(movers)
    table.clear(connections)
    table.clear(toolNames)
    table.clear(lastResyncTime)

    for _, v in ipairs(c:GetChildren()) do
        if v:IsA("Tool") then setupTool(v) end
    end

    if toolAddedConnection then toolAddedConnection:Disconnect() end
    toolAddedConnection = c.ChildAdded:Connect(function(child)
        task.wait()
        if child:IsA("Tool") and toolsEnabled then setupTool(child) end
    end)
end

-- ===== GUI (title changed to "Extra's orbit") =====
local function createButtonGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = plr.PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 220, 0, 360)
    mainFrame.Position = UDim2.new(0, 10, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.Parent = screenGui

    -- New title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 200, 0, 30)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.Text = "Extra's orbit"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.BackgroundTransparency = 1
    title.Parent = mainFrame

    -- Mode buttons (unchanged)
    local modes = {"Fixed", "Rotate", "Bounce", "Tilt", "Lock", "Spiral", "Wobble", "Custom"}
    for i, name in ipairs(modes) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 180, 0, 30)
        btn.Position = UDim2.new(0, 10, 0, 40 + (i-1) * 35)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Parent = mainFrame
        btn.MouseButton1Click:Connect(function()
            SETTINGS.OrbitMode = i - 1
        end)
    end

    -- Offset slider (unchanged)
    local offsetLabel = Instance.new("TextLabel")
    offsetLabel.Size = UDim2.new(0, 180, 0, 20)
    offsetLabel.Position = UDim2.new(0, 10, 0, 40 + #modes * 35 + 10)
    offsetLabel.Text = "Offset: " .. tostring(SETTINGS.Offset)
    offsetLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    offsetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    offsetLabel.Parent = mainFrame

    local offsetBox = Instance.new("TextBox")
    offsetBox.Size = UDim2.new(0, 180, 0, 20)
    offsetBox.Position = UDim2.new(0, 10, 0, 40 + #modes * 35 + 35)
    offsetBox.Text = tostring(SETTINGS.Offset)
    offsetBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    offsetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    offsetBox.Parent = mainFrame
    offsetBox.FocusLost:Connect(function()
        local val = tonumber(offsetBox.Text)
        if val then SETTINGS.Offset = val end
        offsetBox.Text = tostring(SETTINGS.Offset)
        offsetLabel.Text = "Offset: " .. tostring(SETTINGS.Offset)
    end)
end

-- ===== MAIN LOOP & EVENTS =====
RunService.Heartbeat:Connect(function(dt)
    local time = os.clock()
    updateOrbit(dt, time)
end)

-- Velocity tracking
RunService.PostSimulation:Connect(function(dt)
    if not targetHRP or not targetHRP.Parent then return end
    local currentPos = hrp.Position
    if dt > 0 then hrpVel = (currentPos - lastHRPPos) / dt end
    lastHRPPos = currentPos
    local predicted = currentPos + hrpVel * 0.1
    local antiSleep = Vector3.new(0, math.sin(os.clock() * 15) * 0.0015, 0)
    for _, h in ipairs(handles) do
        if h and h:IsA("BasePart") then
            local dir = predicted - h.Position
            local xz = Vector3.new(dir.X, 0, dir.Z)
            local velXZ = Vector3.zero
            if xz.Magnitude > 0 then velXZ = xz.Unit * xz.Magnitude * 2 end
            h.AssemblyLinearVelocity = Vector3.new(velXZ.X, SETTINGS.VelocityY + math.sin(os.clock()), velXZ.Z)
            h.AssemblyAngularVelocity = Vector3.new(0, 9e9, 9e9)
            h.CFrame = h.CFrame + antiSleep
        end
    end
end)

-- Resync distant tools
task.spawn(function()
    while getgenv().OrbitToolsy do
        task.wait(0.1)
        local now = os.clock()
        for i = #handles, 1, -1 do
            local h = handles[i]
            local orbitPart = orbitParts[i]
            if h and h.Parent and orbitPart then
                if (h.Position - orbitPart.Position).Magnitude > SETTINGS.MaxOrbitDist then
                    local lastTime = lastResyncTime[h] or 0
                    if now - lastTime >= SETTINGS.ResyncCooldown then
                        local item = h.Parent
                        if item:IsA("Tool") and item.Parent == chr then
                            cleanupTool(item)
                            setupTool(item)
                            lastResyncTime[h] = now
                        elseif item:IsA("Accessory") and item.Parent == chr then
                            item.Parent = nil
                            task.wait()
                            item.Parent = chr
                            lastResyncTime[h] = now
                        end
                    end
                end
            end
        end
    end
end)

-- Character respawn
plr.CharacterAdded:Connect(function(c)
    if currentCharAddedConn then currentCharAddedConn:Disconnect() end
    currentCharAddedConn = c:WaitForChild("HumanoidRootPart"):GetPropertyChangedSignal("Parent"):Connect(function()
        if c.Parent then
            task.wait(0.1)
            handleCharacter(c)
        end
    end)
    task.wait(0.1)
    handleCharacter(c)
end)

-- Initial setup
if hrp and hrp.Parent then
    handleCharacter(chr)
end

createButtonGUI()

-- Optional simulation radius
pcall(function()
    if sethiddenproperty then
        sethiddenproperty(plr, "SimulationRadius", math.huge)
    end
end)
