local Players, TextChatService, Stats, Market = game:GetService("Players"), game:GetService("TextChatService"), game:GetService("Stats"), game:GetService("MarketplaceService")
local Player = Players.LocalPlayer
while not Player do task.wait(0.1) Player = Players.LocalPlayer end

local currentExecutor = "Unknown"
if identifyexecutor then pcall(function() currentExecutor = identifyexecutor() end) end

local topbarGui, creditsLabel, isPanic, isBlocked = nil, nil, false, false
local places = { [142376088] = true, [2753915549] = true } 
local placeId, gName = game.PlaceId, "Unknown Game"
if places[placeId] then isBlocked = true end

pcall(function() local i = Market:GetProductInfo(placeId) if i and i.Name then gName = i.Name end end)

local function randName()
    local c, s = "abcdefghijklmnopqrstuvwxyz0123456789", "_"
    for i = 1, Random.new():NextInteger(12, 16) do local r = Random.new():NextInteger(1, #c) s = s .. string.sub(c, r, r) end
    return s
end

local function panic()
    if isPanic then return end isPanic = true
    pcall(function() if topbarGui then topbarGui:Destroy() end end)
    task.defer(function() pcall(function() Player:Kick("Emergency dislocation activated.") end) end)
end

local function checkAdmin(p)
    if not p or p == Player then return end
    pcall(function() if p:GetRankInGroup(game.CreatorId) >= 200 or p.IsCreator then panic() end end)
    pcall(function() for _, id in ipairs({1200769, 50, 16}) do if p:IsInGroup(id) then panic() break end end end)
end

local function drawWatermark()
    if isPanic then return end
    if topbarGui and topbarGui.Parent and creditsLabel and creditsLabel.Parent then 
        pcall(function()
            local rx, ry = Random.new():NextNumber(-0.005, 0.005), Random.new():NextNumber(-0.005, 0.005)
            creditsLabel.Position = UDim2.new(1, -112, 0, 36) + UDim2.new(0, rx, 0, ry)
        end)
        return 
    end
    pcall(function()
        local CGui = game:GetService("CoreGui")
        topbarGui = Instance.new("ScreenGui")
        topbarGui.Name, topbarGui.ResetOnSpawn, topbarGui.IgnoreGuiInset = randName(), false, true
        creditsLabel = Instance.new("TextLabel")
        creditsLabel.Name, creditsLabel.Size, creditsLabel.BackgroundTransparency = randName(), UDim2.new(0, 100, 0, 15), 1
        creditsLabel.Position = UDim2.new(1, -112, 0, 36)
        creditsLabel.Text, creditsLabel.TextSize, creditsLabel.Font = "by local maze", 10, Enum.Font.SourceSansBold
        creditsLabel.TextColor3, creditsLabel.TextTransparency = Color3.fromRGB(150, 150, 150), 0.4
        creditsLabel.TextXAlignment, creditsLabel.TextYAlignment = Enum.TextXAlignment.Right, Enum.TextYAlignment.Top
        creditsLabel.Parent = topbarGui
        local pGui = Player:WaitForChild("PlayerGui", 15) or CGui
        if pGui then topbarGui.Parent = pGui end
    end)
end

task.spawn(function() for _, p in ipairs(Players:GetPlayers()) do checkAdmin(p) end Players.PlayerAdded:Connect(checkAdmin) end)
task.spawn(function() while task.wait(0.5) do if isPanic then break end pcall(drawWatermark) end end)

local function getPing()
    local net = Stats:FindFirstChild("Network")
    local smp = net and net:FindFirstChild("ServerPingLastSample")
    local fbk = Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats:FindFirstChild("Ping")
    local v = 0
    if smp then pcall(function() v = math.round(smp:GetValue()) end) end
    if v == 0 and fbk then pcall(function() v = math.round(fbk:GetValue()) end) end
    return v
end

local function getFPS() local fps = 60 pcall(function() fps = math.round(1 / task.wait()) end) return fps end
local function isInsideTool(obj) return obj:FindFirstAncestorOfClass("Tool") ~= nil end
local function removeMeshFromCurrentTool(targetPlayer)
    local char = targetPlayer.Character if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool") if not tool then return false end
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") then pcall(function() obj:Destroy() end)
        elseif obj:IsA("MeshPart") then pcall(function() obj.MeshId, obj.Transparency = "", 1 end) end
    end
    return true
end

local function removeMeshFromBody(partName, targetPlayer)
    local char = targetPlayer.Character if not char then return end
    pcall(function()
        for _, obj in ipairs(char:GetDescendants()) do
            if not isInsideTool(obj) and (obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") or obj:IsA("MeshPart")) then
                if partName == "all" or string.find(obj.Parent.Name:lower(), partName:lower()) then
                    if obj:IsA("MeshPart") then obj.MeshId, obj.Transparency = "", 1 else obj:Destroy() end
                end
            end
        end
    end)
end

local function sendMsg(m) 
    if isPanic then return end
    local replication = game:GetService("ReplicatedStorage")
    local chatEvents = replication:FindFirstChild("DefaultChatSystemChatEvents")
    local request = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
    if request then pcall(function() request:FireServer(m, "All") end)
    else pcall(function() local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral") if ch then ch:SendAsync(m) end end) end 
end

local CGui = game:GetService("CoreGui")
pcall(function() if CGui:FindFirstChild("Dupe") then CGui.Dupe:Destroy() end end)
pcall(function() if CGui:FindFirstChild("Kill") then CGui.Kill:Destroy() end end)

local ScreenGui = Instance.new("ScreenGui", CGui)
ScreenGui.Name = "Dupe"
ScreenGui.Enabled = false 

local ui = Instance.new("Frame", ScreenGui)
ui.Name = "ui"
local Username = Instance.new("TextBox", ui)
Username.Name = "F20 FR"
Username.Text = ""
local Kill = Instance.new("TextButton", ui)
Kill.Name = "Stick"

local Haha = " ..."

local function gplr(String)
	local Found = {}
	local strl = String:lower()
	if strl == "all" then return Players:GetPlayers()
	elseif strl == "others" then for _,v in pairs(Players:GetPlayers()) do if v.Name ~= Player.Name then table.insert(Found,v) end end 
	elseif strl == "me" then table.insert(Found, Player)
	else for _,v in pairs(Players:GetPlayers()) do if v.Name:lower():sub(1, #String) == String:lower() then table.insert(Found,v) end end end
	return Found 
end

Kill.MouseButton1Click:Connect(function()
	local TargetList = gplr(Username.Text)
	if TargetList and #TargetList > 0 then
		sendMsg("")
		_G.Killed = false
		if _G.Killed == true then return end
		
		for _, Target in ipairs(TargetList) do
			if Target == Player then continue end
			if Player.Character and Player.Character.PrimaryPart ~= nil then
				local Character = Player.Character
				Character.Archivable = true
				local Clone = Character:Clone()
				Player.Character = Clone
				task.wait(.1)
				Player.Character = Character
				task.wait(.1)
				if Player.Character and Target.Character and Target.Character.PrimaryPart ~= nil then
					if Player.Character:FindFirstChildOfClass("Humanoid") then pcall(function() Player.Character:FindFirstChildOfClass("Humanoid"):Destroy() end) end
					local Humanoid = Instance.new("Humanoid")
					Humanoid.Parent = Player.Character
					local Tool = Player.Backpack:FindFirstChildOfClass("Tool")
					if Tool then
						Tool.Parent = Player.Character
						task.wait(0.05)
						local startTime = tick()
						while tick() - startTime < 1.5 do
							if Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("HumanoidRootPart") then
								Player.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
							end
							task.wait()
						end
					end
				end
			end
		end
		task.wait(0.5)
		sendMsg("-re "..tostring(Haha))
	end
end)

local function findTargetByAnyName(searchString)
    if not searchString or searchString == "" then return nil end
    searchString = searchString:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #searchString) == searchString or (p.DisplayName and p.DisplayName:lower():sub(1, #searchString) == searchString) then return p end
    end
    return nil
end

local cache = {}
local isCommandRunning = false

local function processCommand(text, sender)
    if cache[text] or isCommandRunning then return end
    if sender ~= Player then return end

    if string.sub(text, 1, 16) == "-# DisplayAttack:" then
        isCommandRunning = true
        local extractedName = string.sub(text, 17):match("^%s*(.-)%s*$")
        local targetPlayer = findTargetByAnyName(extractedName)
        if targetPlayer then
            Username.Text = targetPlayer.Name 
            task.spawn(function()
                local executed = false
                pcall(function() if getconnections then for _, connection in pairs(getconnections(Kill.MouseButton1Click)) do connection:Fire() executed = true end end end)
                if not executed then pcall(function() if Kill.MouseButton1Click then Kill:Click() end end) end
            end)
        end
        task.wait(0.5) isCommandRunning = false
    elseif text == "-# ping" or text == "-# Ping" then
        isCommandRunning = true cache[text] = true
        sendMsg("Pong! (" .. tostring(getPing()) .. "ms)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
        
    elseif text == "-# fps" or text == "-# Fps" then
        isCommandRunning = true cache[text] = true
        local currentFps = getFPS()
        if currentFps >= 50 then
            sendMsg("Frames win games! (" .. tostring(currentFps) .. " fps)")
        else
            sendMsg("Cinema mode activated! (" .. tostring(currentFps) .. " fps)")
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
        
    elseif string.sub(text, 1, 11) == "-# meshBody" or string.sub(text, 1, 11) == "-# meshbody" then
        isCommandRunning = true cache[text] = true
        local arg = string.sub(text, 1, 12) == "-# meshBody " and string.sub(text, 13) or string.sub(text, 12)
        if arg and arg ~= "" then pcall(function() removeMeshFromBody(arg, sender) end) sendMsg("Body mesh cleaner executed for: " .. tostring(arg))
        else sendMsg("Usage: -# meshBody [head/legs/arms/torso/all]") end
        task.delay(2, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
    elseif text == "-# meshTool" or text == "-# meshtool" then
        isCommandRunning = true cache[text] = true
        local success = false pcall(function() success = removeMeshFromCurrentTool(sender) end)
        if success then sendMsg("Tool mesh successfully cleared!") else sendMsg("Error: No tool equipped.") end
        task.delay(2, function() cache[text] = nil end)
        task.wait(0.5) isCommandRunning = false
    end
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.MessageReceived:Connect(function(msg) pcall(function() if msg.TextSource then local sender = Players:GetPlayerByUserId(msg.TextSource.UserId) if sender then processCommand(msg.Text, sender) end end end) end)
else
    pcall(function()
        local onMsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents", 5):WaitForChild("OnMessageDoneFiltering", 5)
        if onMsg and onMsg:IsA("RemoteEvent") then onMsg.OnClientEvent:Connect(function(data) pcall(function() if data and data.FromSpeaker and data.Message then local sender = Players:FindFirstChild(data.FromSpeaker) if sender then processCommand(data.Message, sender) end end end) end) end
    end)
end

task.spawn(function()
    task.wait(1.2)
    pcall(function() sendMsg("Crazy gui By Crazy Maze (Public!) ⚡") end)
    task.wait(3.0)
    pcall(function() sendMsg("This script is 100% custom made. Every line of code and chat sorting logic was completely written by hand without AI generators to keep the script optimization clean and fast.") end)
    task.wait(3.0)
    pcall(function() sendMsg("The brilliant concept was originally borrowed from the old Local Maze profile. Crazy Maze took that pure layout idea, fully redesigned the core and reconstructed it into this remote.") end)
    task.wait(3.0)
    pcall(function() sendMsg("Commands: '-# ping' for server speed, '-# fps' for frame specs, '-# meshbody [part]' or '-# meshtool' to strip meshes and run '-# DisplayAttack: [username]' to target someone.") end)
end)
