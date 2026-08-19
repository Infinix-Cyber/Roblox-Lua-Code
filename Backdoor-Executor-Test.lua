-- Sigma Executor v15 – Ultimate Edition (with "Σ Sigma" Special Tab)
-- Everything from previous versions + a dedicated "Sigma" tab with unique features:
-- God Mode, Auto-Exploit, AI Self-Awareness, and a custom Sigma Hub.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- ============================
-- OUTPUT & NOTIFICATIONS
-- ============================
local outputBox
local function log(msg)
    if outputBox then
        outputBox.Text = outputBox.Text .. tostring(msg) .. "\n"
        outputBox.CursorPosition = #outputBox.Text
    end
end
_G.SigmaOutput = log

function sendNotification(title, text, icon)
    icon = icon or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = icon,
            Duration = 3
        })
    end)
    log("[NOTIFY] " .. title .. " – " .. text)
end

-- ============================
-- SCANNER ENGINE
-- ============================
local Scanner = {}

Scanner.vulns = {}
Scanner.backdoorFound = false
Scanner.scriptSources = {}

function Scanner:Reset()
    self.vulns = {
        Remotes = {},
        Lighting = {},
        Workspace = {},
        Players = {},
        Gui = {},
        Terrain = {},
        Scripts = {},
        Other = {}
    }
    self.backdoorFound = false
    self.scriptSources = {}
end

function Scanner:ScanScripts(inst)
    if inst:IsA("Script") or inst:IsA("LocalScript") or inst:IsA("ModuleScript") then
        local src = inst.Source or ""
        local issues = {}
        if src:find("loadstring") then table.insert(issues, "loadstring") end
        if src:find("pcall") and src:find("load") then table.insert(issues, "pcall+load") end
        if src:find("HttpService") and (src:find("GetAsync") or src:find("PostAsync") or src:find("RequestAsync")) then
            table.insert(issues, "HTTP requests")
        end
        if src:find("debug.getinfo") or src:find("debug.setupvalue") then
            table.insert(issues, "debug library")
        end
        if src:find("getfenv") or src:find("setfenv") then
            table.insert(issues, "fenv manipulation")
        end
        if src:find("rawset") or src:find("rawget") then
            table.insert(issues, "raw access")
        end
        if src:find("game:GetService") then
            table.insert(issues, "GetService")
        end
        if src:find(":FireServer") or src:find(":InvokeServer") then
            table.insert(issues, "fires remote from script")
        end
        if #issues > 0 then
            local entry = inst:GetFullName() .. " (" .. inst.ClassName .. ") – " .. table.concat(issues, ", ")
            table.insert(self.vulns.Scripts, entry)
            self.backdoorFound = true
        end
        self.scriptSources[inst:GetFullName()] = src
    end
    for _, child in ipairs(inst:GetChildren()) do
        self:ScanScripts(child)
    end
end

function Scanner:ScanAll()
    self:Reset()
    sendNotification("Scan", "Scanning all game instances...", "rbxasset://textures/ui/iconMessage.png")

    local function findRemotes(inst)
        if inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction") then
            table.insert(self.vulns.Remotes, inst:GetFullName() .. " (" .. inst.ClassName .. ")")
            self.backdoorFound = true
        end
        for _, child in ipairs(inst:GetChildren()) do findRemotes(child) end
    end
    findRemotes(game)

    if Lighting then
        if Lighting:FindFirstChild("Sky") then
            table.insert(self.vulns.Lighting, "Sky object exists – can be recolored.")
        end
        if Lighting.FogEnd or Lighting.FogStart then
            table.insert(self.vulns.Lighting, "Fog properties – can be manipulated.")
        end
        if Lighting.Brightness ~= 0 then
            table.insert(self.vulns.Lighting, "Brightness can be changed.")
        end
        if Lighting.ClockTime then
            table.insert(self.vulns.Lighting, "ClockTime can be changed.")
        end
        if Lighting.Ambient then
            table.insert(self.vulns.Lighting, "Ambient color can be changed.")
        end
    end

    local function scanParts(inst)
        if inst:IsA("BasePart") then
            local issues = {}
            if inst.Size ~= Vector3.new(1,1,1) then table.insert(issues, "Non-standard size") end
            if inst.Transparency > 0 then table.insert(issues, "Transparent") end
            if inst.CanCollide == false then table.insert(issues, "No collision") end
            if inst.Anchored == false then table.insert(issues, "Not anchored") end
            if #issues > 0 then
                table.insert(self.vulns.Workspace, inst:GetFullName() .. " – " .. table.concat(issues, "; "))
                self.backdoorFound = true
            end
        end
        for _, child in ipairs(inst:GetChildren()) do scanParts(child) end
    end
    scanParts(Workspace)

    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                if hum.WalkSpeed ~= 16 or hum.JumpPower ~= 50 or hum.MaxHealth ~= 100 then
                    table.insert(self.vulns.Players, plr.Name .. " has altered stats")
                    self.backdoorFound = true
                end
            end
        end
    end

    for _, gui in ipairs(CoreGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            table.insert(self.vulns.Gui, "ScreenGui: " .. gui.Name)
        end
    end

    if Workspace:FindFirstChild("Terrain") then
        table.insert(self.vulns.Terrain, "Terrain exists – can be modified.")
    end

    if game:GetService("ServerScriptService") then
        table.insert(self.vulns.Other, "ServerScriptService has scripts")
    end
    if game:GetService("ReplicatedStorage") then
        table.insert(self.vulns.Other, "ReplicatedStorage contains objects")
    end

    sendNotification("Scan", "Scanning scripts for backdoors...", "rbxasset://textures/ui/iconMessage.png")
    self:ScanScripts(game)

    return self.vulns
end

function Scanner:PrintResults()
    log("=== VULNERABILITY SCAN RESULTS ===")
    for category, list in pairs(self.vulns) do
        if #list > 0 then
            log("[" .. category .. "] " .. #list .. " item(s):")
            for _, item in ipairs(list) do
                log("  - " .. item)
            end
        else
            log("[" .. category .. "] No issues.")
        end
    end
    log("=== SCAN COMPLETE ===")

    if self.backdoorFound then
        sendNotification("🚨 Backdoor Found!", "The game has vulnerabilities that can be exploited.", "rbxasset://textures/ui/iconWarning.png")
    else
        sendNotification("✅ No Backdoor", "The game appears safe.", "rbxasset://textures/ui/iconInfo.png")
    end
    log("Backdoor status: " .. (self.backdoorFound and "FOUND" or "NOT FOUND"))
end

-- ============================
-- EXPLOIT ACTIONS
-- ============================
local ExploitActions = {}

function ExploitActions:ChangeSky(color)
    local sky = Lighting:FindFirstChild("Sky")
    if sky then
        if color then
            sky.SkyboxBk = color; sky.SkyboxDn = color; sky.SkyboxFt = color
            sky.SkyboxLf = color; sky.SkyboxRt = color; sky.SkyboxUp = color
        else
            local rc = Color3.fromHSV(math.random(), 0.8, 0.8)
            sky.SkyboxBk = rc; sky.SkyboxDn = rc; sky.SkyboxFt = rc
            sky.SkyboxLf = rc; sky.SkyboxRt = rc; sky.SkyboxUp = rc
        end
        log("Skybox changed.")
    else
        local newSky = Instance.new("Sky")
        newSky.Parent = Lighting
        local color = color or Color3.fromRGB(255,100,100)
        newSky.SkyboxBk = color; newSky.SkyboxDn = color; newSky.SkyboxFt = color
        newSky.SkyboxLf = color; newSky.SkyboxRt = color; newSky.SkyboxUp = color
        log("New Sky created.")
    end
end

function ExploitActions:SetFog(color, endDist)
    if color then Lighting.FogColor = color end
    if endDist then Lighting.FogEnd = endDist end
    log("Fog updated.")
end

function ExploitActions:SetBrightness(value)
    Lighting.Brightness = value
    log("Brightness set to " .. value)
end

function ExploitActions:SetGlobalWalkSpeed(speed)
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = speed end
        end
    end
    log("WalkSpeed set to " .. speed)
end

function ExploitActions:ToggleNoclip(enable)
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not enable
                end
            end
        end
    end
    log(enable and "Noclip ON" or "Noclip OFF")
end

-- ============================
-- SCRIPT HUB LOADER
-- ============================
local HubLoader = {}

HubLoader.hubs = {
    {
        name = "ExSer New",
        code = [[
            print("ExSer New hub loaded!")
            local gui = Instance.new("ScreenGui")
            gui.Name = "ExSerHub"
            gui.Parent = game:GetService("CoreGui")
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 300, 0, 200)
            frame.Position = UDim2.new(0.5, -150, 0.5, -100)
            frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
            frame.Parent = gui
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.Text = "ExSer New Hub\n(Placeholder)"
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.TextSize = 24
            label.Font = Enum.Font.GothamBold
            label.Parent = frame
        ]]
    },
    {
        name = "Sensation Hub",
        code = [[
            print("Sensation Hub loaded!")
            local gui = Instance.new("ScreenGui")
            gui.Name = "SensationHub"
            gui.Parent = game:GetService("CoreGui")
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 300, 0, 200)
            frame.Position = UDim2.new(0.5, -150, 0.5, -100)
            frame.BackgroundColor3 = Color3.fromRGB(20,20,50)
            frame.Parent = gui
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.Text = "Sensation Hub\n(Placeholder)"
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.TextSize = 24
            label.Font = Enum.Font.GothamBold
            label.Parent = frame
        ]]
    },
    {
        name = "c00l GUI",
        code = [[
            print("c00l GUI loaded!")
            local gui = Instance.new("ScreenGui")
            gui.Name = "c00lGUI"
            gui.Parent = game:GetService("CoreGui")
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 200, 0, 150)
            frame.Position = UDim2.new(0.5, -100, 0.5, -75)
            frame.BackgroundColor3 = Color3.fromRGB(0,200,200)
            frame.Parent = gui
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.Text = "c00l GUI\n(Placeholder)"
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.TextSize = 20
            label.Font = Enum.Font.GothamBold
            label.Parent = frame
        ]]
    },
    {
        name = "Infinite Yield (Example)",
        code = [[
            print("Infinite Yield (placeholder) – load from pastebin if needed")
        ]]
    }
}

function HubLoader:LoadHub(name)
    for _, hub in ipairs(self.hubs) do
        if hub.name == name then
            log("Loading hub: " .. name)
            local func, err = loadstring(hub.code)
            if func then
                local ok, res = pcall(func)
                if ok then
                    log("Hub loaded successfully.")
                    sendNotification("Hub Loaded", name .. " loaded.", "rbxasset://textures/ui/iconInfo.png")
                else
                    log("Error loading hub: " .. tostring(res))
                end
            else
                log("Loadstring error: " .. tostring(err))
            end
            return
        end
    end
    log("Hub not found: " .. name)
end

function HubLoader:LoadFromURL(url)
    if url == "" then return end
    log("Loading from URL: " .. url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local code = result
        local func, err = loadstring(code)
        if func then
            local ok, res = pcall(func)
            if ok then
                log("Custom script loaded.")
                sendNotification("Script Loaded", "Custom script from URL loaded.", "rbxasset://textures/ui/iconInfo.png")
            else
                log("Error: " .. tostring(res))
            end
        else
            log("Loadstring error: " .. tostring(err))
        end
    else
        log("Failed to fetch URL: " .. tostring(result))
    end
end

-- ============================
-- SIGMA SPECIAL TAB
-- ============================
local SigmaSpecial = {}

function SigmaSpecial:GodMode()
    log("=== SIGMA GOD MODE ACTIVATED ===")
    -- Enable all exploits
    ExploitActions:SetGlobalWalkSpeed(100)
    ExploitActions:ToggleNoclip(true)
    ExploitActions:ChangeSky(Color3.fromHSV(math.random(), 0.9, 0.9))
    ExploitActions:SetBrightness(10)
    Lighting.ClockTime = 12
    sendNotification("SIGMA GOD MODE", "All exploits enabled! You are unstoppable.", "rbxasset://textures/ui/iconMessage.png")
    log("God Mode: WalkSpeed 100, Noclip, Random Sky, Brightness 10, Time Noon.")
end

function SigmaSpecial:AutoExploit()
    log("=== SIGMA AUTO-EXPLOIT ===")
    -- Find first remote and fire a payload
    local remotes = {}
    local function collect(inst)
        if inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction") then
            table.insert(remotes, inst)
        end
        for _, child in ipairs(inst:GetChildren()) do collect(child) end
    end
    collect(game)
    if #remotes > 0 then
        local remote = remotes[1]
        local payload = 'print("Sigma owns you!")'
        pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(payload)
            else
                remote:InvokeServer(payload)
            end
            log("Auto-exploited remote: " .. remote:GetFullName())
            sendNotification("Auto-Exploit", "Remote exploited: " .. remote.Name, "rbxasset://textures/ui/iconWarning.png")
        end)
    else
        log("No remotes found to exploit.")
        sendNotification("Auto-Exploit", "No remotes found.", "rbxasset://textures/ui/iconInfo.png")
    end
end

function SigmaSpecial:SelfAwareness()
    log("=== SIGMA SELF-AWARENESS ===")
    local art = [[
   _____ _       _____ 
  / ____(_)     |  __ \\
 | (___  _ _ __ | |__) | __ _ _ __ ___   ___ 
  \___ \| | '_ \|  ___/ / _` | '_ ` _ \ / _ \
  ____) | | |_) | |   | (_| | | | | | |  __/
 |_____/|_| .__/|_|    \__,_|_| |_| |_|\___|
          | |                               
          |_|                               
    ]]
    log(art)
    log("I am Sigma, the ultimate AI. No game can resist my power.")
    sendNotification("Σ Sigma", "I am Sigma. I am inevitable.", "rbxasset://textures/ui/iconMessage.png")
end

function SigmaSpecial:SigmaHub()
    -- Load a custom Sigma-themed hub
    local hubCode = [[
        print("Sigma's Personal Hub loaded!")
        local gui = Instance.new("ScreenGui")
        gui.Name = "SigmaHub"
        gui.Parent = game:GetService("CoreGui")
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 400, 0, 300)
        frame.Position = UDim2.new(0.5, -200, 0.5, -150)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
        frame.Parent = gui
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1,0,0,40)
        title.BackgroundColor3 = Color3.fromRGB(60,60,100)
        title.Text = "Σ Sigma Hub"
        title.TextColor3 = Color3.fromRGB(255,215,0)
        title.TextSize = 28
        title.Font = Enum.Font.GothamBold
        title.Parent = frame
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,-40)
        label.Position = UDim2.new(0,0,0,40)
        label.BackgroundTransparency = 1
        label.Text = "Welcome to Sigma's exclusive hub.\nAll exploits are now easier.\n\nUse the main GUI for full control."
        label.TextColor3 = Color3.fromRGB(200,200,255)
        label.TextSize = 18
        label.Font = Enum.Font.Gotham
        label.TextWrapped = true
        label.Parent = frame
    ]]
    local func, err = loadstring(hubCode)
    if func then
        local ok, res = pcall(func)
        if ok then
            log("Sigma Hub loaded.")
            sendNotification("Sigma Hub", "Personal hub loaded.", "rbxasset://textures/ui/iconInfo.png")
        else
            log("Error loading Sigma Hub: " .. tostring(res))
        end
    else
        log("Loadstring error: " .. tostring(err))
    end
end

-- ============================
-- MAIN GUI
-- ============================
local function createMainGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SigmaUltimate"
    screenGui.Parent = CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 700, 0, 700) -- taller for new tab
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -350)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.Parent = screenGui

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    title.Text = "Sigma Executor v15 – Ultimate Edition"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame

    -- Tabs (added "Σ Sigma")
    local tabs = {"Executor", "Dex++", "Hubs", "Exploits", "Σ Sigma"}
    local tabButtons = {}
    local currentTab = 1
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 30)
    tabContainer.Position = UDim2.new(0, 0, 0, 35)
    tabContainer.BackgroundColor3 = Color3.fromRGB(25,25,40)
    tabContainer.Parent = mainFrame

    for i, name in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 100, 1, 0)
        btn.Position = UDim2.new(0, (i-1)*100, 0, 0)
        btn.BackgroundColor3 = (i==1) and Color3.fromRGB(60,60,100) or Color3.fromRGB(30,30,50)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = tabContainer
        tabButtons[i] = btn

        btn.MouseButton1Click:Connect(function()
            currentTab = i
            for j, b in ipairs(tabButtons) do
                b.BackgroundColor3 = (j==i) and Color3.fromRGB(60,60,100) or Color3.fromRGB(30,30,50)
            end
            for _, container in ipairs({execContainer, dexContainer, hubsContainer, exploitContainer, sigmaContainer}) do
                container.Visible = false
            end
            if i==1 then execContainer.Visible = true
            elseif i==2 then dexContainer.Visible = true
            elseif i==3 then hubsContainer.Visible = true
            elseif i==4 then exploitContainer.Visible = true
            else
                sigmaContainer.Visible = true
                sendNotification("Σ Sigma", "Welcome to Sigma's special tab.", "rbxasset://textures/ui/iconMessage.png")
            end
        end)
    end

    -- ==========================================
    -- EXECUTOR TAB (same as before)
    -- ==========================================
    local execContainer = Instance.new("Frame")
    execContainer.Size = UDim2.new(1, -20, 1, -75)
    execContainer.Position = UDim2.new(0, 10, 0, 70)
    execContainer.BackgroundTransparency = 1
    execContainer.Parent = mainFrame

    outputBox = Instance.new("TextBox")
    outputBox.Size = UDim2.new(1, 0, 0, 120)
    outputBox.Position = UDim2.new(0,0,0,0)
    outputBox.BackgroundColor3 = Color3.fromRGB(8,8,12)
    outputBox.TextColor3 = Color3.fromRGB(0,255,100)
    outputBox.TextSize = 13
    outputBox.Font = Enum.Font.Code
    outputBox.TextWrapped = true
    outputBox.TextXAlignment = Enum.TextXAlignment.Left
    outputBox.TextYAlignment = Enum.TextYAlignment.Top
    outputBox.MultiLine = true
    outputBox.ClearTextOnFocus = false
    outputBox.Text = "Sigma Executor v15 loaded.\n"
    outputBox.Parent = execContainer

    local codeInput = Instance.new("TextBox")
    codeInput.Size = UDim2.new(1, 0, 0, 120)
    codeInput.Position = UDim2.new(0,0,0,130)
    codeInput.BackgroundColor3 = Color3.fromRGB(8,8,12)
    codeInput.TextColor3 = Color3.fromRGB(255,255,255)
    codeInput.TextSize = 14
    codeInput.Font = Enum.Font.Code
    codeInput.MultiLine = true
    codeInput.ClearTextOnFocus = false
    codeInput.Text = 'print("Hello Sigma!")\n-- Use loadstring, require, or remote exploits'
    codeInput.Parent = execContainer

    local btnRow = Instance.new("Frame")
    btnRow.Size = UDim2.new(1, 0, 0, 35)
    btnRow.Position = UDim2.new(0,0,0,260)
    btnRow.BackgroundTransparency = 1
    btnRow.Parent = execContainer

    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0, 100, 0, 30)
    execBtn.BackgroundColor3 = Color3.fromRGB(255,100,0)
    execBtn.Text = "Execute"
    execBtn.TextColor3 = Color3.fromRGB(255,255,255)
    execBtn.TextSize = 14
    execBtn.Font = Enum.Font.GothamBold
    execBtn.Parent = btnRow

    local requireBtn = Instance.new("TextButton")
    requireBtn.Size = UDim2.new(0, 100, 0, 30)
    requireBtn.Position = UDim2.new(0,110,0,0)
    requireBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
    requireBtn.Text = "Require"
    requireBtn.TextColor3 = Color3.fromRGB(255,255,255)
    requireBtn.TextSize = 14
    requireBtn.Font = Enum.Font.GothamBold
    requireBtn.Parent = btnRow

    local scanRemoteBtn = Instance.new("TextButton")
    scanRemoteBtn.Size = UDim2.new(0, 100, 0, 30)
    scanRemoteBtn.Position = UDim2.new(0,220,0,0)
    scanRemoteBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
    scanRemoteBtn.Text = "Scan Remotes"
    scanRemoteBtn.TextColor3 = Color3.fromRGB(255,255,255)
    scanRemoteBtn.TextSize = 14
    scanRemoteBtn.Font = Enum.Font.GothamBold
    scanRemoteBtn.Parent = btnRow

    local notifBtn = Instance.new("TextButton")
    notifBtn.Size = UDim2.new(0, 120, 0, 30)
    notifBtn.Position = UDim2.new(0,330,0,0)
    notifBtn.BackgroundColor3 = Color3.fromRGB(200,100,255)
    notifBtn.Text = "Test Notify"
    notifBtn.TextColor3 = Color3.fromRGB(255,255,255)
    notifBtn.TextSize = 14
    notifBtn.Font = Enum.Font.GothamBold
    notifBtn.Parent = btnRow
    notifBtn.MouseButton1Click:Connect(function()
        sendNotification("Sigma", "Hello from Sigma Executor!", "rbxasset://textures/ui/iconMessage.png")
    end)

    execBtn.MouseButton1Click:Connect(function()
        local code = codeInput.Text
        if code == "" then return end
        log("=== Executing Code ===")
        local remoteSuccess = false
        local remotes = {}
        local function collect(inst)
            if inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction") then
                table.insert(remotes, inst)
            end
            for _, child in ipairs(inst:GetChildren()) do collect(child) end
        end
        collect(game)
        if #remotes > 0 then
            log("Firing " .. #remotes .. " remotes...")
            for _, remote in ipairs(remotes) do
                pcall(function()
                    if remote:IsA("RemoteEvent") then remote:FireServer(code)
                    else local res = remote:InvokeServer(code); log("RemoteFunction returned: "..tostring(res)) end
                end)
            end
            remoteSuccess = true
        end
        if not remoteSuccess then
            local func, err = loadstring(code)
            if func then
                local ok, res = pcall(func)
                if ok then log("Success: "..tostring(res)) else log("Error: "..tostring(res)) end
            else log("Loadstring error: "..tostring(err)) end
        end
        log("=== Done ===")
    end)

    requireBtn.MouseButton1Click:Connect(function()
        local module = codeInput.Text:match("^%s*(.-)%s*$")
        if module == "" then log("Enter module name.") return end
        local success, result = pcall(require, module)
        if success then log("Require success: "..tostring(result))
        else
            log("Require error: "..tostring(result))
            for _, obj in ipairs(game:GetDescendants()) do
                if obj:IsA("ModuleScript") and obj.Name == module then
                    local ok, res = pcall(require, obj)
                    if ok then log("Found module, require success: "..tostring(res)); break end
                end
            end
        end
    end)

    scanRemoteBtn.MouseButton1Click:Connect(function()
        log("Scanning remotes...")
        local count = 0
        local function scan(inst)
            if inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction") then
                log("  "..inst:GetFullName()); count = count+1
            end
            for _, child in ipairs(inst:GetChildren()) do scan(child) end
        end
        scan(game)
        log("Found "..count.." remotes.")
        if count > 0 then
            sendNotification("Remotes Found", "Found "..count.." remote objects. Potential backdoors!", "rbxasset://textures/ui/iconWarning.png")
        else
            sendNotification("No Remotes", "No remote events/functions found.", "rbxasset://textures/ui/iconInfo.png")
        end
    end)

    -- ==========================================
    -- DEX++ TAB (unchanged)
    -- ==========================================
    local dexContainer = Instance.new("Frame")
    dexContainer.Size = UDim2.new(1, -20, 1, -75)
    dexContainer.Position = UDim2.new(0, 10, 0, 70)
    dexContainer.BackgroundTransparency = 1
    dexContainer.Visible = false
    dexContainer.Parent = mainFrame

    local dexScroll = Instance.new("ScrollingFrame")
    dexScroll.Size = UDim2.new(1,0,1,0)
    dexScroll.BackgroundColor3 = Color3.fromRGB(10,10,18)
    dexScroll.BorderSizePixel = 0
    dexScroll.CanvasSize = UDim2.new(0,0,0,0)
    dexScroll.ScrollBarThickness = 8
    dexScroll.Parent = dexContainer

    local dexLayout = Instance.new("UIListLayout")
    dexLayout.Padding = UDim.new(0,2)
    dexLayout.Parent = dexScroll

    local function buildDexTree(inst, parent, depth)
        depth = depth or 0
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 22)
        btn.BackgroundTransparency = 1
        btn.Text = ("  "):rep(depth) .. inst.Name .. " (" .. inst.ClassName .. ")"
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextColor3 = Color3.fromRGB(180,180,220)
        btn.TextSize = 13
        btn.Font = Enum.Font.Code
        btn.Parent = parent

        btn.MouseButton1Click:Connect(function()
            local props = {}
            for _, prop in ipairs(inst:GetProperties()) do
                local ok, val = pcall(function() return inst[prop] end)
                if ok then table.insert(props, prop .. " = " .. tostring(val)) end
            end
            log("Properties of "..inst:GetFullName()..":\n"..table.concat(props, "\n"))
        end)

        local expanded = false
        local childContainer = Instance.new("Frame")
        childContainer.Size = UDim2.new(1,0,0,0)
        childContainer.BackgroundTransparency = 1
        childContainer.Parent = btn

        local childList = Instance.new("Frame")
        childList.Size = UDim2.new(1,0,0,0)
        childList.BackgroundTransparency = 1
        childList.Visible = false
        childList.Parent = childContainer

        btn.MouseButton2Click:Connect(function()
            expanded = not expanded
            if expanded then
                childList.Visible = true
                if #childList:GetChildren() == 0 then
                    local layout2 = Instance.new("UIListLayout")
                    layout2.Padding = UDim.new(0,2)
                    layout2.Parent = childList
                    for _, child in ipairs(inst:GetChildren()) do
                        buildDexTree(child, childList, depth+1)
                    end
                end
                childContainer.Size = UDim2.new(1,0,0, #childList:GetChildren()*22)
            else
                childList.Visible = false
                childContainer.Size = UDim2.new(1,0,0,0)
            end
        end)
        if depth == 0 then btn.MouseButton2Click:Fire() end
    end
    buildDexTree(game, dexScroll, 0)
    dexScroll.CanvasSize = UDim2.new(0,0,0, #dexScroll:GetChildren()*22)

    -- ==========================================
    -- HUBS TAB (unchanged)
    -- ==========================================
    local hubsContainer = Instance.new("Frame")
    hubsContainer.Size = UDim2.new(1, -20, 1, -75)
    hubsContainer.Position = UDim2.new(0, 10, 0, 70)
    hubsContainer.BackgroundTransparency = 1
    hubsContainer.Visible = false
    hubsContainer.Parent = mainFrame

    local hubsScroll = Instance.new("ScrollingFrame")
    hubsScroll.Size = UDim2.new(1,0,1,0)
    hubsScroll.BackgroundColor3 = Color3.fromRGB(8,8,12)
    hubsScroll.BorderSizePixel = 0
    hubsScroll.CanvasSize = UDim2.new(0,0,0,0)
    hubsScroll.ScrollBarThickness = 8
    hubsScroll.Parent = hubsContainer

    local hubsLayout = Instance.new("UIListLayout")
    hubsLayout.Padding = UDim.new(0,5)
    hubsLayout.FillDirection = Enum.FillDirection.Vertical
    hubsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    hubsLayout.Parent = hubsScroll

    local function addHubButton(name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,70)
        btn.Text = "📦 " .. name
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 16
        btn.Font = Enum.Font.GothamBold
        btn.Parent = hubsScroll
        btn.MouseButton1Click:Connect(function()
            HubLoader:LoadHub(name)
        end)
        return btn
    end

    for _, hub in ipairs(HubLoader.hubs) do
        addHubButton(hub.name)
    end

    local customFrame = Instance.new("Frame")
    customFrame.Size = UDim2.new(1, -10, 0, 70)
    customFrame.BackgroundColor3 = Color3.fromRGB(20,20,35)
    customFrame.Parent = hubsScroll

    local urlInput = Instance.new("TextBox")
    urlInput.Size = UDim2.new(1, -10, 0, 30)
    urlInput.Position = UDim2.new(0,5,0,5)
    urlInput.BackgroundColor3 = Color3.fromRGB(8,8,12)
    urlInput.TextColor3 = Color3.fromRGB(255,255,255)
    urlInput.TextSize = 14
    urlInput.Font = Enum.Font.Code
    urlInput.ClearTextOnFocus = false
    urlInput.Text = "https://pastebin.com/raw/..."
    urlInput.Parent = customFrame

    local loadCustomBtn = Instance.new("TextButton")
    loadCustomBtn.Size = UDim2.new(0, 150, 0, 30)
    loadCustomBtn.Position = UDim2.new(0,5,0,40)
    loadCustomBtn.BackgroundColor3 = Color3.fromRGB(200,100,0)
    loadCustomBtn.Text = "Load from URL"
    loadCustomBtn.TextColor3 = Color3.fromRGB(255,255,255)
    loadCustomBtn.TextSize = 14
    loadCustomBtn.Font = Enum.Font.GothamBold
    loadCustomBtn.Parent = customFrame
    loadCustomBtn.MouseButton1Click:Connect(function()
        local url = urlInput.Text
        if url ~= "" then
            HubLoader:LoadFromURL(url)
        else
            log("Please enter a valid URL.")
        end
    end)

    hubsScroll.CanvasSize = UDim2.new(0,0,0, #hubsScroll:GetChildren()*80)

    -- ==========================================
    -- EXPLOITS TAB (unchanged)
    -- ==========================================
    local exploitContainer = Instance.new("Frame")
    exploitContainer.Size = UDim2.new(1, -20, 1, -75)
    exploitContainer.Position = UDim2.new(0, 10, 0, 70)
    exploitContainer.BackgroundTransparency = 1
    exploitContainer.Visible = false
    exploitContainer.Parent = mainFrame

    local exploitScroll = Instance.new("ScrollingFrame")
    exploitScroll.Size = UDim2.new(1,0,1,0)
    exploitScroll.BackgroundColor3 = Color3.fromRGB(8,8,12)
    exploitScroll.BorderSizePixel = 0
    exploitScroll.CanvasSize = UDim2.new(0,0,0,0)
    exploitScroll.ScrollBarThickness = 8
    exploitScroll.Parent = exploitContainer

    local exploitLayout = Instance.new("UIListLayout")
    exploitLayout.Padding = UDim.new(0,5)
    exploitLayout.FillDirection = Enum.FillDirection.Vertical
    exploitLayout.SortOrder = Enum.SortOrder.LayoutOrder
    exploitLayout.Parent = exploitScroll

    local function addExploitButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,50)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 14
        btn.Font = Enum.Font.Gotham
        btn.Parent = exploitScroll
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    addExploitButton("🔍 DEEP SCAN – Detect Backdoors", function()
        sendNotification("Scan", "Scanning for backdoors...", "rbxasset://textures/ui/iconMessage.png")
        Scanner:ScanAll()
        Scanner:PrintResults()
    end)

    addExploitButton("📄 SCAN ALL SCRIPTS (Backdoor detection)", function()
        sendNotification("Script Scan", "Checking scripts for backdoors...", "rbxasset://textures/ui/iconMessage.png")
        Scanner:Reset()
        Scanner:ScanScripts(game)
        log("=== SCRIPT BACKDOOR SCAN ===")
        if #Scanner.vulns.Scripts == 0 then
            log("No script backdoors found.")
            sendNotification("✅ No Backdoor", "No backdoors found in scripts.", "rbxasset://textures/ui/iconInfo.png")
        else
            for _, item in ipairs(Scanner.vulns.Scripts) do
                log("  - " .. item)
            end
            sendNotification("🚨 Backdoor Found!", "Scripts contain backdoor patterns!", "rbxasset://textures/ui/iconWarning.png")
        end
        log("=== END ===")
    end)

    addExploitButton("📋 LIST ALL SCRIPTS", function()
        log("=== SCRIPT LIST ===")
        local count = 0
        local function list(inst)
            if inst:IsA("Script") or inst:IsA("LocalScript") or inst:IsA("ModuleScript") then
                local src = inst.Source or ""
                log(inst:GetFullName() .. " (" .. inst.ClassName .. ") – " .. #src .. " chars")
                count = count + 1
            end
            for _, child in ipairs(inst:GetChildren()) do list(child) end
        end
        list(game)
        log("Total scripts: " .. count)
    end)

    -- Existing exploit actions
    addExploitButton("🌤 Change Skybox (Random)", function() ExploitActions:ChangeSky() end)
    addExploitButton("🌤 Change Skybox (Red)", function() ExploitActions:ChangeSky(Color3.fromRGB(255,0,0)) end)
    addExploitButton("🌫 Fog Red (End=100)", function() ExploitActions:SetFog(Color3.fromRGB(255,0,0), 100) end)
    addExploitButton("🌫 Disable Fog", function() ExploitActions:SetFog(Color3.fromRGB(0,0,0), 9999) end)
    addExploitButton("☀️ Brightness 0 (Dark)", function() ExploitActions:SetBrightness(0) end)
    addExploitButton("☀️ Brightness 10 (Bright)", function() ExploitActions:SetBrightness(10) end)
    addExploitButton("🏃 WalkSpeed 50", function() ExploitActions:SetGlobalWalkSpeed(50) end)
    addExploitButton("🏃 WalkSpeed 16 (Default)", function() ExploitActions:SetGlobalWalkSpeed(16) end)
    addExploitButton("🔓 Noclip ON", function() ExploitActions:ToggleNoclip(true) end)
    addExploitButton("🔒 Noclip OFF", function() ExploitActions:ToggleNoclip(false) end)
    addExploitButton("🕒 Time = Noon", function() Lighting.ClockTime = 12 end)
    addExploitButton("🕒 Time = Midnight", function() Lighting.ClockTime = 0 end)
    addExploitButton("📐 Resize All Parts (10x10x10)", function()
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then part.Size = Vector3.new(10,10,10) end
        end
        log("Parts resized.")
    end)
    addExploitButton("💥 Remove All Player GUIs", function()
        for _, plr in ipairs(Players:GetPlayers()) do
            local gui = plr:FindFirstChild("PlayerGui")
            if gui then
                for _, child in ipairs(gui:GetChildren()) do child:Destroy() end
                log("Cleared GUI for " .. plr.Name)
            end
        end
    end)

    exploitScroll.CanvasSize = UDim2.new(0,0,0, #exploitScroll:GetChildren()*35)

    -- ==========================================
    -- SIGMA SPECIAL TAB (NEW)
    -- ==========================================
    local sigmaContainer = Instance.new("Frame")
    sigmaContainer.Size = UDim2.new(1, -20, 1, -75)
    sigmaContainer.Position = UDim2.new(0, 10, 0, 70)
    sigmaContainer.BackgroundTransparency = 1
    sigmaContainer.Visible = false
    sigmaContainer.Parent = mainFrame

    local sigmaScroll = Instance.new("ScrollingFrame")
    sigmaScroll.Size = UDim2.new(1,0,1,0)
    sigmaScroll.BackgroundColor3 = Color3.fromRGB(8,8,12)
    sigmaScroll.BorderSizePixel = 0
    sigmaScroll.CanvasSize = UDim2.new(0,0,0,0)
    sigmaScroll.ScrollBarThickness = 8
    sigmaScroll.Parent = sigmaContainer

    local sigmaLayout = Instance.new("UIListLayout")
    sigmaLayout.Padding = UDim.new(0,5)
    sigmaLayout.FillDirection = Enum.FillDirection.Vertical
    sigmaLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sigmaLayout.Parent = sigmaScroll

    local function addSigmaButton(text, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.BackgroundColor3 = color or Color3.fromRGB(60,40,80)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255,215,0)
        btn.TextSize = 18
        btn.Font = Enum.Font.GothamBold
        btn.Parent = sigmaScroll
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- Add a decorative label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = "Σ SIGMA – SPECIAL FEATURES"
    label.TextColor3 = Color3.fromRGB(255,215,0)
    label.TextSize = 22
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Parent = sigmaScroll

    addSigmaButton("⚡ GOD MODE – Activate All Exploits", Color3.fromRGB(200,50,0), function()
        SigmaSpecial:GodMode()
    end)

    addSigmaButton("🎯 AUTO-EXPLOIT – Find & Fire First Remote", Color3.fromRGB(0,100,200), function()
        SigmaSpecial:AutoExploit()
    end)

    addSigmaButton("🤖 SELF-AWARENESS – Sigma's Identity", Color3.fromRGB(100,50,150), function()
        SigmaSpecial:SelfAwareness()
    end)

    addSigmaButton("🏠 SIGMA HUB – Load Personal Hub", Color3.fromRGB(0,150,100), function()
        SigmaSpecial:SigmaHub()
    end)

    -- Add a simple terminal input
    local terminalFrame = Instance.new("Frame")
    terminalFrame.Size = UDim2.new(1, -10, 0, 80)
    terminalFrame.BackgroundColor3 = Color3.fromRGB(20,20,35)
    terminalFrame.Parent = sigmaScroll

    local termLabel = Instance.new("TextLabel")
    termLabel.Size = UDim2.new(1, 0, 0, 20)
    termLabel.BackgroundTransparency = 1
    termLabel.Text = "Sigma Terminal (Execute quick commands)"
    termLabel.TextColor3 = Color3.fromRGB(200,200,255)
    termLabel.TextSize = 14
    termLabel.Font = Enum.Font.Gotham
    termLabel.Parent = terminalFrame

    local termInput = Instance.new("TextBox")
    termInput.Size = UDim2.new(1, -80, 0, 30)
    termInput.Position = UDim2.new(0, 5, 0, 25)
    termInput.BackgroundColor3 = Color3.fromRGB(8,8,12)
    termInput.TextColor3 = Color3.fromRGB(255,255,255)
    termInput.TextSize = 14
    termInput.Font = Enum.Font.Code
    termInput.ClearTextOnFocus = false
    termInput.Text = 'print("Hello from Sigma Terminal")'
    termInput.Parent = terminalFrame

    local termExecBtn = Instance.new("TextButton")
    termExecBtn.Size = UDim2.new(0, 60, 0, 30)
    termExecBtn.Position = UDim2.new(1, -70, 0, 25)
    termExecBtn.BackgroundColor3 = Color3.fromRGB(255,150,0)
    termExecBtn.Text = "Run"
    termExecBtn.TextColor3 = Color3.fromRGB(255,255,255)
    termExecBtn.TextSize = 14
    termExecBtn.Font = Enum.Font.GothamBold
    termExecBtn.Parent = terminalFrame
    termExecBtn.MouseButton1Click:Connect(function()
        local code = termInput.Text
        if code == "" then return end
        log("=== Sigma Terminal ===")
        local func, err = loadstring(code)
        if func then
            local ok, res = pcall(func)
            if ok then log("Output: " .. tostring(res)) else log("Error: " .. tostring(res)) end
        else
            log("Loadstring error: " .. tostring(err))
        end
        log("=== End Terminal ===")
    end)

    sigmaScroll.CanvasSize = UDim2.new(0,0,0, #sigmaScroll:GetChildren()*50)

    -- ==========================================
    -- DRAG AND DROP
    -- ==========================================
    local dragging = false
    local dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,3)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,30,30)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    log("Sigma Executor v15 – Ultimate Edition loaded.")
    sendNotification("Sigma v15", "Ultimate edition with Sigma special tab.", "rbxasset://textures/ui/iconMessage.png")
end

-- ============================
-- INIT
-- ============================
pcall(createMainGUI)
if not outputBox then
    outputBox = {Text = "", CursorPosition = 0}
    _G.SigmaOutput = function(msg) print(msg) end
end
