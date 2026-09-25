local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local Stats = game:GetService("Stats")
local Market = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
while not Player do task.wait(0.1) Player = Players.LocalPlayer end

local Exec = {}
local function pickFn(names)
    for _, n in ipairs(names) do
        local f = rawget(_G, n)
        if type(f) == "function" then return f end
        if getgenv then
            local g = getgenv()[n]
            if type(g) == "function" then return g end
        end
    end
    return nil
end

Exec.identify = pickFn({"identifyexecutor", "getexecutorname", "get_exploit_name", "identify_executor"})
Exec.gethui = pickFn({"gethui", "get_hidden_gui", "gethiddenui"})
Exec.setclipboard = pickFn({"setclipboard", "toclipboard", "writeclipboard"})
Exec.getconnections = pickFn({"getconnections", "get_connections"})
Exec.firetouchinterest = pickFn({"firetouchinterest", "firetouch", "firetouchtransmitter"})
Exec.request = pickFn({"request", "http_request", "syn.request", "httprequest"})

local function detectExecutor()
    if Exec.identify then
        local ok, name = pcall(Exec.identify)
        if ok and name and name ~= "" then return name end
    end
    local function has(t) return rawget(_G, t) ~= nil end
    if has("syn") or has("Synapse") then return "Synapse X" end
    if has("KRNL_LOADED") or has("krnl") then return "Krnl" end
    if has("Solara") or has("SOLARA_LOADED") then return "Solara" end
    if has("Fluxus") then return "Fluxus" end
    if has("is_sirhurt") then return "SirHurt" end
    if has("Delta") or has("DELTA_LOADED") then return "Delta" end
    if has("Wave") or has("WAVE_LOADED") then return "Wave" end
    if has("Codex") or has("CODEX_LOADED") then return "Codex" end
    if has("WeAreDevs") then return "WeAreDevs" end
    if has("OxygenU") then return "Oxygen U" end
    if has("ScriptWare") then return "Script-Ware" end
    if has("Trigon") then return "Trigon" end
    if has("Hydrogen") then return "Hydrogen" end
    if has("VegaX") then return "Vega X" end
    if has("MacSploit") then return "MacSploit" end
    return "Unknown"
end

local currentExecutor = detectExecutor()

local DEBUG = true
local function dbg(tag, msg)
    if not DEBUG then return end
    local ts = os.date("%H:%M:%S")
    print("[TAGME CMD] [" .. ts .. "] [" .. tag .. "] " .. tostring(msg))
end
local function dbgErr(msg) dbg("ERR", msg) end
local function dbgOK(msg) dbg("OK", msg) end

local topbarGui, creditsLabel, isPanic = nil, nil, false
local watermarkEnabled = true
local antiAdminEnabled = true

local placeId, gName = game.PlaceId, "Unknown Game"
pcall(function()
    local i = Market:GetProductInfo(placeId)
    if i and i.Name then gName = i.Name end
end)

local SEPARATOR = string.char(239, 191, 184)

local function craftBypass(text)
    if type(text) ~= "string" then text = tostring(text) end
    if #text < 2 then return text end
    local result = ""
    local len = utf8.len(text)
    if not len then
        for i = 1, #text do
            result = result .. text:sub(i, i)
            if i < #text then result = result .. SEPARATOR end
        end
        return result
    end
    for i = 1, len do
        local char = utf8.sub(text, i, i)
        if char then
            result = result .. char
            if i < len then
                result = result .. SEPARATOR
            end
        end
    end
    return result
end

local function randName()
    local c = "abcdefghijklmnopqrstuvwxyz0123456789"
    local s = "_"
    for i = 1, Random.new():NextInteger(12, 16) do
        local r = Random.new():NextInteger(1, #c)
        s = s .. string.sub(c, r, r)
    end
    return s
end

local function panic()
    if isPanic then return end
    isPanic = true
    dbg("PANIC", "emergency dislocation")
    pcall(function() if topbarGui then topbarGui:Destroy() end end)
    task.defer(function() pcall(function() Player:Kick("Emergency dislocation activated.") end) end)
end

local function checkAdmin(p)
    if not antiAdminEnabled then return end
    if not p or p == Player then return end
    pcall(function()
        if p:GetRankInGroup(game.CreatorId) >= 200 or p.IsCreator then panic() end
    end)
    pcall(function()
        for _, id in ipairs({1200769, 50, 16}) do
            if p:IsInGroup(id) then panic() break end
        end
    end)
end

local function drawWatermark()
    if isPanic then return end
    if not watermarkEnabled then
        if topbarGui then
            pcall(function() topbarGui:Destroy() end)
            topbarGui = nil
            creditsLabel = nil
        end
        return
    end
    if topbarGui and topbarGui.Parent and creditsLabel and creditsLabel.Parent then return end
    pcall(function()
        topbarGui = Instance.new("ScreenGui")
        topbarGui.Name = randName()
        topbarGui.ResetOnSpawn = false
        topbarGui.IgnoreGuiInset = true
        creditsLabel = Instance.new("TextLabel")
        creditsLabel.Name = randName()
        creditsLabel.Size = UDim2.new(0, 130, 0, 15)
        creditsLabel.BackgroundTransparency = 1
        creditsLabel.Position = UDim2.new(1, -142, 0, 36)
        creditsLabel.Text = "by local maze"
        creditsLabel.TextSize = 10
        creditsLabel.Font = Enum.Font.SourceSansBold
        creditsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        creditsLabel.TextTransparency = 0.4
        creditsLabel.TextXAlignment = Enum.TextXAlignment.Right
        creditsLabel.TextYAlignment = Enum.TextYAlignment.Top
        creditsLabel.Parent = topbarGui
        local pGui = Player:WaitForChild("PlayerGui", 15) or CoreGui
        if pGui then topbarGui.Parent = pGui end
    end)
end

task.spawn(function()
    for _, p in ipairs(Players:GetPlayers()) do checkAdmin(p) end
    Players.PlayerAdded:Connect(checkAdmin)
end)

task.spawn(function()
    while task.wait(0.5) do
        if isPanic then break end
        pcall(drawWatermark)
    end
end)

local fpsRender, fpsHeartbeat, fpsStepped, fpsCurrent = 0, 0, 0, 0
local fpsLastTime = os.clock()

RunService.RenderStepped:Connect(function() fpsRender = fpsRender + 1 end)
RunService.Heartbeat:Connect(function() fpsHeartbeat = fpsHeartbeat + 1 end)
RunService.Stepped:Connect(function() fpsStepped = fpsStepped + 1 end)

task.spawn(function()
    while task.wait(1) do
        local now = os.clock()
        local delta = now - fpsLastTime
        if delta <= 0 then delta = 1 end
        local mid = math.floor(fpsRender / delta)
        local hb = math.floor(fpsHeartbeat / delta)
        local st = math.floor(fpsStepped / delta)
        if hb < mid then mid = hb end
        if st < mid then mid = st end
        if mid < 1 then mid = 1 end
        if mid > 999 then mid = 999 end
        fpsCurrent = mid
        fpsRender = 0
        fpsHeartbeat = 0
        fpsStepped = 0
        fpsLastTime = now
    end
end)

local function getFPS() return fpsCurrent end

local function getPing()
    local v = 0
    pcall(function()
        local n = Stats:FindFirstChild("Network")
        local s = n and n:FindFirstChild("ServerPingLastSample")
        if s then v = math.round(s:GetValue()) end
    end)
    if v == 0 then
        pcall(function()
            local ps = Stats:FindFirstChild("PerformanceStats")
            local f = ps and ps:FindFirstChild("Ping")
            if f then v = math.round(f:GetValue()) end
        end)
    end
    if v < 0 then v = 0 end
    if v > 9999 then v = 9999 end
    return v
end

local function getMem()
    local v = 0
    pcall(function()
        if Stats.GetTotalMemoryUsageMb then
            v = Stats:GetTotalMemoryUsageMb()
        end
    end)
    if v == 0 then
        pcall(function()
            if Stats.GetMemoryUsageMb then
                v = Stats:GetMemoryUsageMb()
            end
        end)
    end
    if v == 0 then
        pcall(function()
            local ps = Stats:FindFirstChild("PerformanceStats")
            if ps then
                local m = ps:FindFirstChild("Memory")
                if m then v = m:GetValue() end
            end
        end)
    end
    if v == 0 then
        pcall(function()
            local ps = Stats:FindFirstChild("PerformanceStats")
            if ps then
                local m = ps:FindFirstChild("LuaHeap")
                if m then v = m:GetValue() end
            end
        end)
    end
    if v == 0 then
        pcall(function()
            local n = Stats:FindFirstChild("Network")
            if n then
                local m = n:FindFirstChild("ServerMemory")
                if m then v = m:GetValue() end
            end
        end)
    end
    if v < 0 then v = 0 end
    if v > 99999 then v = 99999 end
    return math.floor(v * 100) / 100
end

local function getVRAM()
    local v = 0
    pcall(function()
        local ps = Stats:FindFirstChild("PerformanceStats")
        if ps then
            local t = ps:FindFirstChild("TextureMemory")
            if t then v = t:GetValue() end
        end
    end)
    if v == 0 then
        pcall(function()
            local ps = Stats:FindFirstChild("PerformanceStats")
            if ps then
                local t = ps:FindFirstChild("GraphicsTextureMemory")
                if t then v = t:GetValue() end
            end
        end)
    end
    if v == 0 then
        pcall(function()
            local r = game:GetService("RenderSettings")
            if r then
                local t = r:FindFirstChild("TextureMemory")
                if t then v = t:GetValue() end
            end
        end)
    end
    if v == 0 then
        pcall(function()
            local r = game:GetService("Renderer")
            if r then
                local t = r:FindFirstChild("TextureMemory")
                if t then v = t:GetValue() end
            end
        end)
    end
    if v < 0 then v = 0 end
    if v > 99999 then v = 99999 end
    return math.floor(v * 100) / 100
end

local function getCPU()
    local v = 0
    pcall(function()
        local ps = Stats:FindFirstChild("PerformanceStats")
        if ps then
            local c = ps:FindFirstChild("CPU")
            if c then v = c:GetValue() end
        end
    end)
    if v < 0 then v = 0 end
    if v > 9999 then v = 9999 end
    return math.floor(v * 100) / 100
end

local function getGPU()
    local v = 0
    pcall(function()
        local ps = Stats:FindFirstChild("PerformanceStats")
        if ps then
            local g = ps:FindFirstChild("GPU")
            if g then v = g:GetValue() end
        end
    end)
    if v < 0 then v = 0 end
    if v > 9999 then v = 9999 end
    return math.floor(v * 100) / 100
end

local function getSent()
    local v = 0
    pcall(function()
        local n = Stats:FindFirstChild("Network")
        if n then
            local s = n:FindFirstChild("DataSent")
            if s then v = s:GetValue() end
        end
    end)
    if v < 0 then v = 0 end
    if v > 999999 then v = 999999 end
    return math.floor(v * 100) / 100
end

local function getRecv()
    local v = 0
    pcall(function()
        local n = Stats:FindFirstChild("Network")
        if n then
            local r = n:FindFirstChild("DataReceived")
            if r then v = r:GetValue() end
        end
    end)
    if v < 0 then v = 0 end
    if v > 999999 then v = 999999 end
    return math.floor(v * 100) / 100
end

local function getInstanceCount() return #game:GetDescendants() end

local function getPartCount()
    local n = 0
    for _, d in ipairs(game:GetDescendants()) do
        if d:IsA("BasePart") then n = n + 1 end
    end
    return n
end

local function getScriptCounts()
    local ls, s, ms = 0, 0, 0
    for _, d in ipairs(game:GetDescendants()) do
        if d:IsA("LocalScript") then ls = ls + 1
        elseif d:IsA("Script") then s = s + 1
        elseif d:IsA("ModuleScript") then ms = ms + 1 end
    end
    return ls, s, ms
end

local function getPlayerCount() return #Players:GetPlayers() end

local function getUptime()
    local v = 0
    pcall(function()
        local n = Stats:FindFirstChild("Network")
        local u = n and n:FindFirstChild("ServerUptime")
        if u then v = u:GetValue() end
    end)
    return math.floor(v)
end

local function getRegion()
    local r = "Unknown"
    pcall(function()
        local n = Stats:FindFirstChild("Network")
        local reg = n and n:FindFirstChild("ServerLocation")
        if reg then r = tostring(reg:GetValue()) end
    end)
    return r
end

local function getJobId()
    local j = game.JobId
    if #j > 8 then j = string.sub(j, 1, 8) .. "..." end
    return j
end

local function getMyHealth()
    local c = Player.Character
    if not c then return 0, 0 end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h then return 0, 0 end
    return math.floor(h.Health), math.floor(h.MaxHealth)
end

local function getMyPosition()
    local c = Player.Character
    if not c then return "n/a" end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return "n/a" end
    local p = hrp.Position
    return string.format("(%.1f, %.1f, %.1f)", p.X, p.Y, p.Z)
end

local function getMySpeed()
    local c = Player.Character
    if not c then return 0 end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local v = hrp.AssemblyLinearVelocity
    return math.floor(math.sqrt(v.X*v.X + v.Y*v.Y + v.Z*v.Z) * 100) / 100
end

local function getTools()
    local list = {}
    for _, t in ipairs(Player.Backpack:GetChildren()) do
        if t:IsA("Tool") then table.insert(list, t.Name) end
    end
    return list
end

local function getEquipped()
    local c = Player.Character
    if not c then return "none" end
    local t = c:FindFirstChildOfClass("Tool")
    return t and t.Name or "none"
end

local function isInsideTool(obj)
    return obj:FindFirstAncestorOfClass("Tool") ~= nil
end

local function removeMeshFromCurrentTool(targetPlayer)
    local char = targetPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return false end
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") then
            pcall(function() obj:Destroy() end)
        elseif obj:IsA("MeshPart") then
            pcall(function()
                obj.MeshId = ""
                obj.Transparency = 1
            end)
        end
    end
    return true
end

local function removeMeshFromBody(partName, targetPlayer)
    local char = targetPlayer.Character
    if not char then return end
    pcall(function()
        for _, obj in ipairs(char:GetDescendants()) do
            if not isInsideTool(obj) and (obj:IsA("SpecialMesh") or obj:IsA("CharacterMesh") or obj:IsA("MeshPart")) then
                if partName == "all" or string.find(obj.Parent.Name:lower(), partName:lower()) then
                    if obj:IsA("MeshPart") then
                        obj.MeshId = ""
                        obj.Transparency = 1
                    else
                        obj:Destroy()
                    end
                end
            end
        end
    end)
end

local function sendMsg(m)
    if isPanic then return end
    local bypassed = craftBypass(m)
    local replication = game:GetService("ReplicatedStorage")
    local chatEvents = replication:FindFirstChild("DefaultChatSystemChatEvents")
    local request = chatEvents and chatEvents:FindFirstChild("SayMessageRequest")
    if request then
        pcall(function() request:FireServer(bypassed, "All") end)
    else
        pcall(function()
            local ch = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if ch then ch:SendAsync(bypassed) end
        end)
    end
end
local function findPlayerByName(name)
    if not name or name == "" then return nil end
    local lower = name:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == lower or (p.DisplayName and p.DisplayName:lower() == lower) then
            return p
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #lower) == lower then
            return p
        end
    end
    return nil
end

local function getTargetHealth(p)
    local c = p.Character
    if not c then return 0, 0 end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h then return 0, 0 end
    return math.floor(h.Health), math.floor(h.MaxHealth)
end

local function getTargetPosition(p)
    local c = p.Character
    if not c then return "n/a" end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return "n/a" end
    local pos = hrp.Position
    return string.format("(%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)
end

local function getTargetSpeed(p)
    local c = p.Character
    if not c then return 0 end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    local v = hrp.AssemblyLinearVelocity
    return math.floor(math.sqrt(v.X*v.X + v.Y*v.Y + v.Z*v.Z) * 100) / 100
end

local function getTargetDistance(p)
    local myChar = Player.Character
    local tChar = p.Character
    if not myChar or not tChar then return -1 end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local tHRP = tChar:FindFirstChild("HumanoidRootPart")
    if not myHRP or not tHRP then return -1 end
    return math.floor((myHRP.Position - tHRP.Position).Magnitude)
end

local function getTargetTools(p)
    local list = {}
    local bp = p:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") then table.insert(list, t.Name) end
        end
    end
    return list
end

local function getTargetEquipped(p)
    local c = p.Character
    if not c then return "none" end
    local t = c:FindFirstChildOfClass("Tool")
    return t and t.Name or "none"
end

local function getTargetTeam(p)
    if p.Team then return p.Team.Name end
    return "none"
end

local function getPlayerDevice(p)
    if p.UserId == Player.UserId then
        if UIS.TouchEnabled and not UIS.KeyboardEnabled then return "Mobile" end
        if UIS.KeyboardEnabled and UIS.MouseEnabled then return "PC" end
        if UIS.GamepadEnabled then return "Console" end
    end
    local ok, jd = pcall(function() return p:GetJoinData() end)
    if ok and jd and jd.Platform then
        return tostring(jd.Platform)
    end
    return "Unknown"
end

local function analyzePlayerBehavior(p)
    local signs = {}
    local char = p.Character
    if not char then return signs end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if hrp:FindFirstChildOfClass("BodyVelocity") then table.insert(signs, "BodyVelocity") end
        if hrp:FindFirstChildOfClass("BodyAngularVelocity") then table.insert(signs, "BodyAngularVelocity") end
        if hrp:FindFirstChildOfClass("AlignPosition") then table.insert(signs, "AlignPosition") end
        if hrp:FindFirstChildOfClass("BodyGyro") then table.insert(signs, "BodyGyro") end
        if hrp:FindFirstChildOfClass("BodyPosition") then table.insert(signs, "BodyPosition") end
        if hrp.Anchored then table.insert(signs, "Anchored") end
        if hrp.AssemblyLinearVelocity.Magnitude > 100 then table.insert(signs, "HugeVelocity") end
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.WalkSpeed > 50 then table.insert(signs, "SpeedHack=" .. math.floor(hum.WalkSpeed)) end
        if hum.JumpPower and hum.JumpPower > 100 then table.insert(signs, "InfJump=" .. math.floor(hum.JumpPower)) end
        if hum.Health > hum.MaxHealth then table.insert(signs, "GodMode") end
    end

    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Accessory") and c:FindFirstChild("Handle") then
            local h = c.Handle
            if h:FindFirstChildOfClass("AlignPosition") then
                table.insert(signs, "AccessoryOrbit")
                break
            end
        end
    end

    return signs
end

local function getSuspicionLevel(signs)
    local n = #signs
    if n == 0 then return "Clean", 0 end
    if n <= 1 then return "Low", 1 end
    if n <= 3 then return "Suspicious", 2 end
    return "Cheating", 3
end

local function apiGet(url)
    local ok, res = pcall(function()
        return game:HttpGet(url, true)
    end)
    if not ok or not res then return nil end
    local ok2, data = pcall(function()
        return HttpService:JSONDecode(res)
    end)
    if not ok2 then return nil end
    return data
end

local function getUserInfo(userId)
    return apiGet("https://users.roblox.com/v1/users/" .. tostring(userId))
end

local function getFriendCount(userId)
    local d = apiGet("https://friends.roblox.com/v1/users/" .. tostring(userId) .. "/friends/count")
    return d and d.count or 0
end

local function getFollowerCount(userId)
    local d = apiGet("https://friends.roblox.com/v1/users/" .. tostring(userId) .. "/followers/count")
    return d and d.count or 0
end

local function getFollowingCount(userId)
    local d = apiGet("https://friends.roblox.com/v1/users/" .. tostring(userId) .. "/followings/count")
    return d and d.count or 0
end

local function getGroups(userId)
    local d = apiGet("https://groups.roblox.com/v1/users/" .. tostring(userId) .. "/groups/roles")
    if not d or not d.data then return {} end
    local list = {}
    for _, g in ipairs(d.data) do
        if g.group then table.insert(list, g.group.Name) end
    end
    return list
end

local function getAccountAge(userId)
    local d = getUserInfo(userId)
    if not d or not d.created then return 0 end
    local created = d.created
    local y, m, day = created:match("(%d+)-(%d+)-(%d+)T")
    if not y then return 0 end
    local createdTime = os.time({year = tonumber(y), month = tonumber(m), day = tonumber(day), hour = 0, min = 0, sec = 0})
    local now = os.time()
    local days = math.floor((now - createdTime) / 86400)
    if days < 0 then days = 0 end
    return days
end

local function teleportToServer(pid, jobId)
    pcall(function()
        local TS = game:GetService("TeleportService")
        if jobId and jobId ~= "" then
            TS:TeleportToPlaceInstance(pid, jobId, Player)
        else
            TS:Teleport(pid, Player)
        end
    end)
end

local function findRandomServer()
    local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?limit=100"
    local ok, res = pcall(function() return game:HttpGet(url, true) end)
    if not ok or not res then return nil end
    local ok2, data = pcall(function() return HttpService:JSONDecode(res) end)
    if not ok2 or not data or not data.data then return nil end
    local servers = {}
    for _, s in ipairs(data.data) do
        if s.id and s.id ~= game.JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers then
            table.insert(servers, s.id)
        end
    end
    if #servers == 0 then return nil end
    return servers[math.random(1, #servers)]
end

local cache = {}
local isCommandRunning = false
local function processCommand(text, sender)
    if cache[text] or isCommandRunning then return end
    if sender ~= Player then return end

    dbg("CHAT", sender.Name .. ": " .. text)
    local lower = text:lower()

    if lower == "-# ping" then
        isCommandRunning = true
        cache[text] = true
        local p = getPing()
        dbg("OUT", "ping=" .. p)
        sendMsg("Pong! (" .. tostring(p) .. "ms)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# fps" then
        isCommandRunning = true
        cache[text] = true
        local f = getFPS()
        dbg("OUT", "fps=" .. f)
        if f >= 50 then
            sendMsg("Frames win games! (" .. tostring(f) .. " fps)")
        elseif f >= 30 then
            sendMsg("Playable, but meh. (" .. tostring(f) .. " fps)")
        elseif f >= 20 then
            sendMsg("Cinema mode activated! (" .. tostring(f) .. " fps)")
        else
            sendMsg("PowerPoint presentation. (" .. tostring(f) .. " fps)")
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# mem" then
        isCommandRunning = true
        cache[text] = true
        local m = getMem()
        dbg("OUT", "mem=" .. m)
        sendMsg("You mean meme? (" .. tostring(m) .. " MB)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# cpu" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("CPU cooking pasta? (" .. tostring(getCPU()) .. " ms)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# gpu" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("GPU smelling burnt toast? (" .. tostring(getGPU()) .. " ms)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# vram" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("VRAM swallowed your textures? (" .. tostring(getVRAM()) .. " MB)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# sent" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Sent to the shadow realm! (" .. tostring(getSent()) .. " KB/s)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# recv" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Recv like a boss! (" .. tostring(getRecv()) .. " KB/s)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# netping" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("NetworkPing: " .. tostring(getPing()) .. "ms")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# instances" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Instances everywhere! (" .. tostring(getInstanceCount()) .. " total)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# parts" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Parts gonna break the server? (" .. tostring(getPartCount()) .. " BaseParts)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# scripts" then
        isCommandRunning = true
        cache[text] = true
        local ls, s, ms = getScriptCounts()
        sendMsg("Scripts: " .. ls .. " Local / " .. s .. " Server / " .. ms .. " Module")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# players" then
        isCommandRunning = true
        cache[text] = true
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            local h, _ = getTargetHealth(p)
            table.insert(list, p.Name .. "(" .. h .. ")")
        end
        sendMsg("Players (" .. #list .. "): " .. table.concat(list, ", "))
        task.delay(8, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# uptime" then
        isCommandRunning = true
        cache[text] = true
        local up = getUptime()
        local mins = math.floor(up / 60)
        local hrs = math.floor(mins / 60)
        sendMsg("Server up: " .. hrs .. "h " .. (mins % 60) .. "m")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# region" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Region: " .. getRegion())
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# jobid" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("JobId: " .. getJobId())
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# server" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Server info:")
        task.wait(0.8)
        sendMsg("Region: " .. getRegion())
        task.wait(0.8)
        sendMsg("Ping: " .. getPing() .. "ms")
        task.wait(0.8)
        sendMsg("Players: " .. getPlayerCount())
        task.delay(6, function() cache[text] = nil end)
        isCommandRunning = false

    elseif lower == "-# me" then
        isCommandRunning = true
        cache[text] = true
        local h, mh = getMyHealth()
        sendMsg("You: " .. Player.Name)
        task.wait(0.8)
        sendMsg("HP: " .. h .. "/" .. mh)
        task.wait(0.8)
        sendMsg("Position: " .. getMyPosition())
        task.wait(0.8)
        sendMsg("Speed: " .. getMySpeed() .. " studs/s")
        task.delay(6, function() cache[text] = nil end)
        isCommandRunning = false

    elseif lower == "-# health" then
        isCommandRunning = true
        cache[text] = true
        local h, mh = getMyHealth()
        sendMsg("HP: " .. h .. "/" .. mh)
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# position" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Position: " .. getMyPosition())
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# speed" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Speed: " .. getMySpeed() .. " studs/s")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# tools" then
        isCommandRunning = true
        cache[text] = true
        local t = getTools()
        if #t == 0 then
            sendMsg("Backpack empty.")
        else
            sendMsg("Tools (" .. #t .. "): " .. table.concat(t, ", "))
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# equipped" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Equipped: " .. getEquipped())
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# executor" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Executor: " .. currentExecutor .. " | TagMe Cmd Script (early access)")
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 7) == "-# who " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(8):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            local h, mh = getTargetHealth(target)
            local dist = getTargetDistance(target)
            local dev = getPlayerDevice(target)
            sendMsg("Who: " .. target.Name)
            task.wait(0.8)
            sendMsg("HP: " .. h .. "/" .. mh)
            task.wait(0.8)
            sendMsg("Dist: " .. dist)
            task.wait(0.8)
            sendMsg("Device: " .. dev)
        end
        task.delay(6, function() cache[text] = nil end)
        isCommandRunning = false

    elseif string.sub(lower, 1, 10) == "-# health " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(11):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            local h, mh = getTargetHealth(target)
            sendMsg(target.Name .. " HP: " .. h .. "/" .. mh)
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 12) == "-# position " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(13):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            sendMsg(target.Name .. " Pos: " .. getTargetPosition(target))
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 9) == "-# speed " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(10):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            sendMsg(target.Name .. " Speed: " .. getTargetSpeed(target) .. " studs/s")
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 9) == "-# tools " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(10):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            local t = getTargetTools(target)
            if #t == 0 then
                sendMsg(target.Name .. " backpack empty.")
            else
                sendMsg(target.Name .. " tools (" .. #t .. "): " .. table.concat(t, ", "))
            end
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 12) == "-# equipped " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(13):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            sendMsg(target.Name .. " equipped: " .. getTargetEquipped(target))
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 9) == "-# device " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(10):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            local dev = getPlayerDevice(target)
            sendMsg(target.Name .. " platform: " .. dev)
        end
        task.delay(5, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif string.sub(lower, 1, 9) == "-# check " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(10):match("^%s*(.-)%s*$")
        local target = findPlayerByName(rest)
        if not target then
            sendMsg("Player not found: " .. tostring(rest))
        else
            local signs = analyzePlayerBehavior(target)
            local level, score = getSuspicionLevel(signs)
            sendMsg(target.Name .. " | " .. level)
            task.wait(0.8)
            if #signs > 0 then
                local list = table.concat(signs, ", ")
                if #list > 120 then list = list:sub(1, 120) .. "..." end
                sendMsg("Signs: " .. list)
            else
                sendMsg("No signs")
            end
        end
        task.delay(5, function() cache[text] = nil end)
        isCommandRunning = false

    elseif string.sub(lower, 1, 8) == "-# info " then
        isCommandRunning = true
        cache[text] = true
        local rest = text:sub(9):match("^%s*(.-)%s*$")
        local parts = {}
        for word in rest:gmatch("%S+") do table.insert(parts, word) end
        if #parts == 0 then
            sendMsg("Usage: -# info <username> <id/name/age/bio/friends/followers/groups/device/all>")
        else
            local target = findPlayerByName(parts[1])
            if not target then
                sendMsg("Player not found: " .. parts[1])
            else
                local field = (parts[2] or "all"):lower()
                if field == "id" then
                    sendMsg("ID: " .. target.UserId)
                elseif field == "name" then
                    sendMsg("Display: " .. target.DisplayName)
                elseif field == "age" then
                    local age = getAccountAge(target.UserId)
                    local y = math.floor(age / 365)
                    local d = age % 365
                    sendMsg(target.Name .. " account age: " .. y .. "y " .. d .. "d")
                elseif field == "bio" then
                    local info = getUserInfo(target.UserId)
                    local bio = info and info.description or ""
                    if bio == "" then bio = "(empty)" end
                    if #bio > 120 then bio = bio:sub(1, 120) .. "..." end
                    sendMsg(target.Name .. " bio: " .. bio)
                elseif field == "friends" then
                    sendMsg(target.Name .. " friends: " .. getFriendCount(target.UserId))
                elseif field == "followers" then
                    sendMsg(target.Name .. " followers: " .. getFollowerCount(target.UserId))
                elseif field == "following" then
                    sendMsg(target.Name .. " following: " .. getFollowingCount(target.UserId))
                elseif field == "groups" then
                    local g = getGroups(target.UserId)
                    if #g == 0 then
                        sendMsg(target.Name .. " has no groups")
                    else
                        local list = table.concat(g, ", ")
                        if #list > 120 then list = list:sub(1, 120) .. "..." end
                        sendMsg(target.Name .. " groups: " .. list)
                    end
                elseif field == "verified" then
                    local info = getUserInfo(target.UserId)
                    sendMsg(target.Name .. " verified: " .. tostring(info and info.hasVerifiedBadge))
                elseif field == "device" then
                    sendMsg(target.Name .. " device: " .. getPlayerDevice(target))
                elseif field == "all" then
                    local age = getAccountAge(target.UserId)
                    local y = math.floor(age / 365)
                    local d = age % 365
                    local dev = getPlayerDevice(target)
                    local fr = getFriendCount(target.UserId)
                    local fol = getFollowerCount(target.UserId)
                    local h, mh = getTargetHealth(target)
                    sendMsg("Info about " .. target.Name)
                    task.wait(0.9)
                    sendMsg("ID: " .. target.UserId)
                    task.wait(0.9)
                    sendMsg("Age: " .. y .. "y " .. d .. "d")
                    task.wait(0.9)
                    sendMsg("Device: " .. dev)
                    task.wait(0.9)
                    sendMsg("Friends: " .. fr)
                    task.wait(0.9)
                    sendMsg("Followers: " .. fol)
                    task.wait(0.9)
                    sendMsg("HP: " .. h .. "/" .. mh)
                else
                    sendMsg("Unknown field: " .. field)
                end
            end
        end
        task.delay(10, function() cache[text] = nil end)
        isCommandRunning = false

    elseif lower == "-# watermark on" then
        isCommandRunning = true
        cache[text] = true
        watermarkEnabled = true
        drawWatermark()
        sendMsg("Watermark: ON")
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# watermark off" then
        isCommandRunning = true
        cache[text] = true
        watermarkEnabled = false
        if topbarGui then
            pcall(function() topbarGui:Destroy() end)
            topbarGui = nil
            creditsLabel = nil
        end
        sendMsg("Watermark: OFF")
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# watermark" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Watermark: " .. (watermarkEnabled and "ON" or "OFF"))
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# antiadmin on" then
        isCommandRunning = true
        cache[text] = true
        antiAdminEnabled = true
        sendMsg("Anti-Admin: ON")
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# antiadmin off" then
        isCommandRunning = true
        cache[text] = true
        antiAdminEnabled = false
        sendMsg("Anti-Admin: OFF")
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# antiadmin" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Anti-Admin: " .. (antiAdminEnabled and "ON" or "OFF"))
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# rejoin" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Rejoining...")
        task.wait(0.5)
        teleportToServer(game.PlaceId, game.JobId)
        isCommandRunning = false

    elseif lower == "-# serverhop" or lower == "-# sv_hop" then
        isCommandRunning = true
        cache[text] = true
        sendMsg("Hopping to another server...")
        task.wait(0.5)
        task.spawn(function()
            local jobId = findRandomServer()
            if jobId then
                teleportToServer(game.PlaceId, jobId)
            else
                sendMsg("No servers available. Rejoining...")
                task.wait(0.5)
                teleportToServer(game.PlaceId)
            end
        end)
        isCommandRunning = false

    elseif lower == "-# commands" or lower == "-# help" then
        isCommandRunning = true
        cache[text] = true
        local lines = {
            "TagMe Cmd (early access)",
            "Info: ping fps mem cpu gpu vram sent recv netping instances parts scripts players uptime region jobid server me health position speed tools equipped executor",
            "Target: who health position speed tools equipped device check info",
            "Utility: rejoin serverhop watermark on/off antiadmin on/off",
            "Mesh: meshBody meshTool",
            "Commands: commands / help",
        }
        for _, line in ipairs(lines) do
            sendMsg(line)
            task.wait(1.0)
        end
        task.delay(15, function() cache[text] = nil end)
        isCommandRunning = false

    elseif string.sub(lower, 1, 11) == "-# meshbody" then
        isCommandRunning = true
        cache[text] = true
        local arg
        if string.sub(text, 1, 12) == "-# meshBody " or string.sub(text, 1, 12) == "-# meshbody " then
            arg = string.sub(text, 13)
        else
            arg = string.sub(text, 12)
        end
        if arg and arg ~= "" then
            pcall(function() removeMeshFromBody(arg, sender) end)
            sendMsg("Body mesh cleaner: " .. tostring(arg))
        else
            sendMsg("Usage: -# meshBody [head/legs/arms/torso/all]")
        end
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false

    elseif lower == "-# meshtool" then
        isCommandRunning = true
        cache[text] = true
        local success = false
        pcall(function() success = removeMeshFromCurrentTool(sender) end)
        if success then
            sendMsg("Tool mesh cleared!")
        else
            sendMsg("Error: No tool equipped.")
        end
        task.delay(3, function() cache[text] = nil end)
        task.wait(0.5)
        isCommandRunning = false
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
        local rstorage = game:GetService("ReplicatedStorage")
        local chatEvents = rstorage:WaitForChild("DefaultChatSystemChatEvents", 5)
        if chatEvents then
            local onMsg = chatEvents:WaitForChild("OnMessageDoneFiltering", 5)
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
        end
    end)
end

task.spawn(function()
    task.wait(0.5)
    dbg("BOOT", "===========================================")
    dbg("BOOT", "  TAGME CMD (early access)")
    dbg("BOOT", "===========================================")
    dbg("BOOT", "Loaded: " .. os.date("%Y-%m-%d %H:%M:%S"))
    dbg("BOOT", "Place: " .. gName .. " (" .. tostring(placeId) .. ")")
    dbg("BOOT", "Player: " .. Player.Name .. " (" .. tostring(Player.UserId) .. ")")
    dbg("BOOT", "Executor: " .. currentExecutor)
    dbg("BOOT", "Anti-admin: " .. (antiAdminEnabled and "ON" or "OFF"))
    dbg("BOOT", "Watermark: " .. (watermarkEnabled and "ON" or "OFF"))
    dbg("BOOT", "-------------------------------------------")
    dbg("BOOT", 'Type "-# help" in chat to see commands')
    dbg("BOOT", "===========================================")
end)

task.spawn(function()
    task.wait(2.0)
    pcall(function()
        sendMsg("TagMe Cmd Script (early access)")
    end)
    dbg("BOOT", "welcome message sent")
end)
