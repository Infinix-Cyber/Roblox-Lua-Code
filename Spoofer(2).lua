local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
local Player = Players.LocalPlayer
while not Player do task.wait() Player = Players.LocalPlayer end

local allowedPlaces = {
    [123974602339071] = true,
}
local placeId = game.PlaceId

if not allowedPlaces[placeId] then
    Player:Kick("This script only works in Just a baseplate.")
    return
end

local gName = "Unknown Game"
pcall(function()
    local info = MarketplaceService:GetProductInfo(placeId)
    if info and info.Name then gName = info.Name end
end)

local function getPing()
    local net = Stats:FindFirstChild("Network")
    local smp = net and net:FindFirstChild("ServerPingLastSample")
    local fbk = Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats:FindFirstChild("Ping")
    local v = 0
    if smp then pcall(function() v = math.round(smp:GetValue()) end) end
    if v == 0 and fbk then pcall(function() v = math.round(fbk:GetValue()) end) end
    return v
end

local function getFPS()
    local fps = 60
    pcall(function() fps = math.round(1 / task.wait()) end)
    return fps
end

local function sendMsg(m)
    if isPanic then return end
    local replication = game:GetService("ReplicatedStorage")
    local chatEvents = replication:FindFirstChild("DefaultChatSystemChatEvents")
    local request = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
    if request then
        pcall(function() request:FireServer(m, "All") end)
    else
        pcall(function()
            local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if ch then ch:SendAsync(m) end
        end)
    end
end

local function removeMeshFromCurrentTool(targetPlayer)
    local char = targetPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return false end
    pcall(function()
        for _, obj in ipairs(tool:GetDescendants()) do
            if obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") then
                obj:Destroy()
            elseif obj:IsA("MeshPart") then
                pcall(function()
                    obj:ApplyMesh("")
                    obj.TextureID = ""
                    obj.Transparency = 1
                end)
            end
        end
    end)
    return true
end

local cache = {}
local isCommandRunning = false

local function processCommand(text, sender)
    if cache[text] or isCommandRunning then return end
    if sender ~= Player then return end

    isCommandRunning = true
    cache[text] = true

    local function finish()
        task.delay(2, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false
    end

    if text == "- ping" then
        sendMsg("Pong! (" .. tostring(getPing()) .. "ms)")
        finish()

    elseif text == "- fps" then
        local currentFps = getFPS()
        if currentFps >= 50 then
            sendMsg("Frames win games! (" .. tostring(currentFps) .. " fps)")
        else
            sendMsg("Cinema mode activated! (" .. tostring(currentFps) .. " fps)")
        end
        finish()

    elseif string.lower(string.sub(text, 1, 10)) == "- meshbody" then
        local arg = string.sub(text, 12):match("^%s*(.-)%s*$")
        if arg and arg ~= "" then
            pcall(function()
                local char = sender.Character
                if not char then return end
                task.wait(0.15)
                local targetName = arg:lower()
                for _, obj in ipairs(char:GetDescendants()) do
                    if obj:IsA("BasePart") and string.find(obj.Name:lower(), targetName) then
                        if obj:IsA("MeshPart") then
                            pcall(function()
                                obj:ApplyMesh("")
                                obj.TextureID = ""
                                obj.Transparency = 1
                                obj.Size = Vector3.new(0.1, 0.1, 0.1)
                            end)
                        elseif obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") then
                            pcall(function() obj:Destroy() end)
                        end
                    end
                end
            end)
        end
        finish()

    elseif string.lower(text) == "- meshtool" then
        pcall(function() removeMeshFromCurrentTool(sender) end)
        finish()

    elseif text == "- skeletal" then
        pcall(function()
            local char = sender.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.RigType ~= Enum.HumanoidRigType.R6 then return end
            local torso = char:FindFirstChild("Torso")
            if not torso then return end
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    if part.Name == "Head" then part.Size = Vector3.new(1.5, 1.5, 1.5)
                    elseif part.Name == "Torso" then part.Size = Vector3.new(1, 1.5, 0.5)
                    elseif part.Name:match("Arm") then part.Size = Vector3.new(0.5, 1.8, 0.5)
                    elseif part.Name:match("Leg") then part.Size = Vector3.new(0.5, 1.8, 0.5)
                    end
                    part.BrickColor = BrickColor.new("Institutional white")
                    part.Material = Enum.Material.Neon
                end
            end
            for _, child in ipairs(torso:GetChildren()) do
                if child:IsA("Motor6D") then
                    local x, y, z = child.C0:components()
                    child.C0 = CFrame.new(x * 0.8, y * 1.2, z * 0.8)
                end
            end
        end)
        finish()

    elseif text == "- wraith" then
        pcall(function()
            local char = sender.Character
            if not char then return end
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.6
                    part.BrickColor = BrickColor.new("Black")
                    part.Material = Enum.Material.Neon
                end
            end
        end)
        finish()

    elseif text == "- titan" then
        pcall(function()
            local char = sender.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.RigType ~= Enum.HumanoidRigType.R6 then return end
            local torso = char:FindFirstChild("Torso")
            if not torso then return end
            local scale = 3
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    if part.Name == "Torso" or part.Name == "HumanoidRootPart" then
                        part.Size = part.Size * scale
                    else
                        part.Size = part.Size * 1.2
                    end
                end
            end
            for _, child in ipairs(torso:GetChildren()) do
                if child:IsA("Motor6D") then
                    local x, y, z = child.C0:components()
                    child.C0 = CFrame.new(x * 1.2, y * scale * 0.5, z * 1.2)
                end
            end
        end)
        finish()

    elseif text == "- melt" then
        pcall(function()
            local char = sender.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.RigType ~= Enum.HumanoidRigType.R6 then return end
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Size = Vector3.new(part.Size.X * 1.5, 0.3, part.Size.Z * 1.5)
                    part.Transparency = 0.5
                    part.Material = Enum.Material.SmoothPlastic
                end
            end
            local torso = char:FindFirstChild("Torso")
            if torso then
                for _, child in ipairs(torso:GetChildren()) do
                    if child:IsA("Motor6D") then
                        local x, y, z = child.C0:components()
                        child.C0 = CFrame.new(x, y * 0.2, z)
                    end
                end
            end
        end)
        finish()

    elseif text == "- ghostwalk" then
        pcall(function()
            local char = sender.Character
            if not char then return end
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    if part.Name == "Head" then part.Transparency = 0.9
                    elseif part.Name == "Torso" then part.Transparency = 0.7
                    elseif part.Name:match("Arm") then part.Transparency = 0.8
                    elseif part.Name:match("Leg") then part.Transparency = 0.6
                    end
                end
            end
        end)
        finish()

    elseif text == "- shrink" then
        pcall(function()
            local char = sender.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.RigType ~= Enum.HumanoidRigType.R6 then return end
            local torso = char:FindFirstChild("Torso")
            if not torso then return end
            local scale = 0.15
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * scale
                end
            end
            for _, child in ipairs(torso:GetChildren()) do
                if child:IsA("Motor6D") then
                    local x, y, z = child.C0:components()
                    child.C0 = CFrame.new(x * scale, y * scale, z * scale)
                end
            end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Size = hrp.Size * scale end
        end)
        finish()

    else
        finish()
    end
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.MessageReceived:Connect(function(msg)
        pcall(function()
            if msg.TextSource then
                local sender = Players:GetPlayerByUserId(msg.TextSource.UserId)
                if sender then processCommand(msg.Text, sender) end
            end
        end)
    end)
else
    pcall(function()
        local onMsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents", 5):WaitForChild("OnMessageDoneFiltering", 5)
        if onMsg and onMsg:IsA("RemoteEvent") then
            onMsg.OnClientEvent:Connect(function(data)
                pcall(function()
                    if data and data.FromSpeaker and data.Message then
                        local sender = Players:FindFirstChild(data.FromSpeaker)
                        if sender then processCommand(data.Message, sender) end
                    end
                end)
            end)
        end
    end)
end

task.wait(1.2)
pcall(function() sendMsg("Modified Crazy gui by Blitz") end)
