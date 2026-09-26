local Krypton = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/KadeTheExploiter/Krypton/main/Module.luau"
))()

while not Krypton or not Krypton.GetCharacter or not Krypton.GetCharacter() do
    task.wait(0.1)
end

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LP = Players.LocalPlayer

local Modes = {}
local CurrentMode = "default"
local DefaultMode = {}
local CameraConn = nil
local HeartbeatConn = nil
local OriginalCameraType = Camera.CameraType
local OriginalCameraSubject = Camera.CameraSubject

local function getFakeRig()
    local ok, rig = pcall(function() return Krypton.GetCharacter() end)
    if ok then return rig end
    return nil
end

local function getFakeHumanoid()
    local ok, hum = pcall(function() return Krypton.GetHumanoid() end)
    if ok then return hum end
    return nil
end

local function getFakeRoot()
    local ok, root = pcall(function() return Krypton.GetRootPart() end)
    if ok then return root end
    return nil
end

local function buildCFrameTable()
    local cframes = {}
    local rig = getFakeRig()
    if not rig then return cframes end
    for _, v in ipairs(rig:GetDescendants()) do
        if v:IsA("BasePart") then
            cframes[v] = v.CFrame
        end
    end
    return cframes
end

local function getPartByName(name)
    local rig = getFakeRig()
    if not rig then return nil end
    for _, v in ipairs(rig:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == name then
            return v
        end
    end
    for _, v in ipairs(rig:GetChildren()) do
        if v:IsA("Accessory") and v.Name == name then
            local h = v:FindFirstChild("Handle")
            if h then return h end
        end
    end
    return nil
end

local function getJointByName(name)
    local ok, joints = pcall(function() return Krypton.GetJoints() end)
    if ok and joints and joints[name] then
        return joints[name]
    end
    return {C0 = CFrame.new(), C1 = CFrame.new(), Part0 = nil, Part1 = nil, Name = name}
end

local function setCFrame(cf)
    local root = getFakeRoot()
    if root then
        root.CFrame = cf
    end
end

local function getVelocity()
    local root = getFakeRoot()
    if root then
        return root.AssemblyLinearVelocity
    end
    return Vector3.zero
end

local function isWalking()
    local hum = getFakeHumanoid()
    if hum then
        return hum.MoveDirection.Magnitude > 0.01
    end
    return false
end

local function refreshJoints(part)
    if not part then
        pcall(function() Krypton.InstantRefit() end)
        return
    end
    local cframes = buildCFrameTable()
    local rig = getFakeRig()
    if not rig then return end
    pcall(function()
        local joints = Krypton.GetJoints()
        for _, j in pairs(joints) do
            if j.Part0 == part or j.Part1 == part then
                if j.Part1 and cframes[j.Part0] then
                    cframes[j.Part1] = cframes[j.Part0] * j.C0 * j.C1:Inverse()
                elseif j.Part0 and cframes[j.Part1] then
                    cframes[j.Part0] = cframes[j.Part1] * j.C1 * j.C0:Inverse()
                end
            end
        end
    end)
end

local function raycastLegs()
    local root = getFakeRoot()
    if not root then return 0, 0 end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local rig = getFakeRig()
    if rig then
        params.FilterDescendantsInstances = {rig}
    end
    local origin = root.Position
    local down = Vector3.new(0, -1, 0) * 500
    local result = Workspace:Raycast(origin, down, params)
    if result then
        local dist = (origin.Y - result.Position.Y)
        return dist - 3, dist - 3
    end
    return 0, 0
end

local function velByCFRVec()
    local root = getFakeRoot()
    if not root then return 0, 0 end
    local vel = root.AssemblyLinearVelocity
    local look = root.CFrame.LookVector
    local right = root.CFrame.RightVector
    local fw = vel:Dot(look)
    local rt = vel:Dot(right)
    local speed = math.max(vel.Magnitude, 0.001)
    return fw / speed, rt / speed
end

local LastVelocity = Vector3.zero
local VelChgAccum = Vector3.zero
local function velChgByCFRVec()
    local root = getFakeRoot()
    if not root then return 0, 0 end
    local vel = root.AssemblyLinearVelocity
    VelChgAccum = VelChgAccum + (LastVelocity - vel)
    LastVelocity = vel
    VelChgAccum = VelChgAccum - VelChgAccum * 0.5
    local fw = VelChgAccum:Dot(root.CFrame.LookVector)
    local rt = VelChgAccum:Dot(root.CFrame.RightVector)
    return fw / 32, rt / 32
end

local LastYVel = 0
local VelYAccum = 0
local function velYChg()
    local root = getFakeRoot()
    if not root then return 0 end
    local vel = root.AssemblyLinearVelocity
    VelYAccum = math.clamp(VelYAccum + (LastYVel - vel.Y), -50, 50)
    LastYVel = vel.Y
    VelYAccum = VelYAccum - VelYAccum * 0.5
    return VelYAccum
end

local function addMode(key, mode)
    if type(key) ~= "string" or type(mode) ~= "table" then
        return
    end
    local cleaned = {}
    for k, v in pairs(mode) do
        if type(v) == "function" then
            cleaned[k] = v
        end
    end
    if key == "default" then
        DefaultMode = cleaned
        Modes["default"] = cleaned
    elseif #key == 1 then
        local kc = Enum.KeyCode[string.upper(key)]
        if kc then
            Modes[kc] = cleaned
        end
    end
end

local function fling(target)
    if target and typeof(target) == "Instance" then
        pcall(function()
            Krypton.CallFling(target)
        end)
    end
end

local function setWalkSpeed(n)
    local hum = getFakeHumanoid()
    if hum then
        hum.WalkSpeed = tonumber(n) or 16
    end
end

local function setJumpPower(n)
    local hum = getFakeHumanoid()
    if hum then
        hum.JumpPower = tonumber(n) or 50
    end
end

local function setGravity(n)
    Workspace.Gravity = tonumber(n) or 196.2
end

local function getCamCF()
    return Camera.CFrame
end

local function isFirstPerson()
    local dist = (Camera.CFrame.Position - Camera.Focus.Position).Magnitude
    return dist < 1
end

local function rotToMouse(alpha)
    local root = getFakeRoot()
    if not root then return end
    local mouse = LP:GetMouse()
    if mouse.Hit then
        local target = mouse.Hit.Position
        local pos = root.Position
        local newCF = CFrame.lookAt(pos, Vector3.new(target.X, pos.Y, target.Z))
        root.CFrame = root.CFrame:Lerp(newCF, alpha or 0.15)
    end
end

local function glitchJoint(joint, targetTime, delayFrom, delayTo, radiansFrom, radiansTo)
    if not joint then return targetTime or 0 end
    if os.clock() > (targetTime or 0) then
        local rf = (radiansFrom or 0) * 100
        local rt = (radiansTo or 0) * 100
        joint.C0 = joint.C0 * CFrame.Angles(
            math.rad(math.random(rf, rt) / 100),
            math.rad(math.random(rf, rt) / 100),
            math.rad(math.random(rf, rt) / 100)
        )
        return os.clock() + math.random((delayFrom or 0.2) * 100, (delayTo or 0.4) * 100) / 100
    end
    return targetTime
end

local function getPartFromMesh(meshId, textureId)
    local rig = getFakeRig()
    if not rig then return nil end
    for _, v in ipairs(rig:GetDescendants()) do
        if v:IsA("MeshPart") then
            if tostring(v.MeshId):find(tostring(meshId), 1, true) then
                return v
            end
        end
    end
    return nil
end

local function getPartJoint(part)
    local ok, joints = pcall(function() return Krypton.GetJoints() end)
    if not ok or not joints then return nil end
    for _, j in pairs(joints) do
        if j.Part0 == part or j.Part1 == part then
            return j
        end
    end
    return nil
end

local function getAccWeldFromMesh(meshId, textureId)
    local part = getPartFromMesh(meshId, textureId)
    if part then
        return getPartJoint(part)
    end
    return nil
end

local function onNewCamera()
    if CameraConn then
        CameraConn:Disconnect()
    end
    CameraConn = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
        local root = getFakeRoot()
        if root and Camera.CameraSubject ~= getFakeHumanoid() then
            Camera.CameraSubject = getFakeHumanoid()
        end
    end)
end

local function runModeLoop()
    if HeartbeatConn then
        HeartbeatConn:Disconnect()
    end
    HeartbeatConn = RunService.Heartbeat:Connect(function(dt)
        local mode = Modes[CurrentMode] or DefaultMode
        if not mode then return end
        local hum = getFakeHumanoid()
        local root = getFakeRoot()
        if not hum or not root then return end
        if hum.MoveDirection.Magnitude > 0.01 then
            if mode.walk then pcall(mode.walk, dt) end
        elseif root.AssemblyLinearVelocity.Y > 1 then
            if mode.jump then pcall(mode.jump, dt) end
        elseif root.AssemblyLinearVelocity.Y < -1 then
            if mode.fall then pcall(mode.fall, dt) end
        else
            if mode.idle then pcall(mode.idle, dt) end
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    local kc = input.KeyCode
    if Modes[kc] then
        if Modes[CurrentMode] and Modes[CurrentMode].modeLeft then
            pcall(Modes[CurrentMode].modeLeft)
        end
        if CurrentMode == kc then
            CurrentMode = "default"
        else
            CurrentMode = kc
        end
        if Modes[CurrentMode] and Modes[CurrentMode].modeEntered then
            pcall(Modes[CurrentMode].modeEntered)
        end
    end
end)

runModeLoop()
onNewCamera()

return {
    Reanim = function()
        return {
            cframes = buildCFrameTable(),
            joints = (function()
                local ok, j = pcall(function() return Krypton.GetJoints() end)
                return ok and j or {}
            end)(),
            fling = fling,
            predictionfling = fling,
            refreshjoints = refreshJoints,
            raycastlegs = raycastLegs,
            velbycfrvec = velByCFRVec,
            velchgbycfrvec = velChgByCFRVec,
            velYchg = velYChg,
            addmode = addMode,
            getPart = getPartByName,
            getPartFromMesh = getPartFromMesh,
            getAccWeldFromMesh = getAccWeldFromMesh,
            getJoint = getJointByName,
            getPartJoint = getPartJoint,
            rotToMouse = rotToMouse,
            glitchJoint = glitchJoint,
            setWalkSpeed = setWalkSpeed,
            setJumpPower = setJumpPower,
            setGravity = setGravity,
            setCfr = setCFrame,
            getVel = getVelocity,
            getCamCF = getCamCF,
            isFirstPerson = isFirstPerson,
            IsWalking = isWalking,
            onnewcamera = onNewCamera,
        }
    end,
    stopreanimate = function()
        pcall(function() Krypton.StopReanimate() end)
        if CameraConn then CameraConn:Disconnect() end
        if HeartbeatConn then HeartbeatConn:Disconnect() end
        Camera.CameraType = OriginalCameraType
        Camera.CameraSubject = OriginalCameraSubject
    end,
}
