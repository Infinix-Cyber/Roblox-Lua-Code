-- ====================================================================
-- CRAZY HUB | PART 1 (Initialization, Window Setup & Info Tab)
-- ====================================================================

-- 1. Initialize Rayfield Library (fixed URL + error handling)
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Failed to load Rayfield: " .. tostring(err))
    return
end

-- Hub Settings
local HUB_VERSION = "v1.4.2-beta"
local AUTHOR_NAME = "Crazy Maze"

-- Script URLs (replace with real URLs if needed)
local CMDS_URL = "https://githubusercontent.com"
local AI_URL = "https://githubusercontent.com"
local FRAME_URL = "https://githubusercontent.com"
local KDL_URL = "https://githubusercontent.com"

-- 2. Create Window
local Window = Rayfield:CreateWindow({
   Name = "Crazy Hub | " .. HUB_VERSION,
   LoadingTitle = "Loading Crazy Hub...",
   LoadingSubtitle = "by " .. AUTHOR_NAME .. " | Just a Baseplate",
   ConfigurationSaving = { Enabled = false }
})

-- Player Variables
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Safe character reference
local character = player.Character
if not character then
    character = player.CharacterAdded:Wait()
end
local humanoid = character:WaitForChild("Humanoid")

-- Feature Variables
local InfiniteJumpEnabled = false
local FlyEnabled = false
local FlySpeed = 50
local GodModeEnabled = false

-- Auto-refresh character references upon respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    if GodModeEnabled then
        task.wait(1)
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end)

-- ==========================================
-- TAB 1: Support + Description
-- ==========================================
local InfoTab = Window:CreateTab("Support + Description", 4483362458)

local TitleLabel = InfoTab:CreateLabel("Welcome to Crazy Hub!")

local DescParagraph = InfoTab:CreateParagraph({
    Title = "Project Description", 
    Content = "Crazy Hub is an all-in-one multihack tool designed for Just a Baseplate. Created for testing mechanics, having fun, and automating gameplay."
})

local CreditsParagraph = InfoTab:CreateParagraph({
    Title = "Developers / Project Authors", 
    Content = "• Main Developer: " .. AUTHOR_NAME .. "\n• Co-Authors: cheat96354961, TownAndDown, RealBackdoorTester"
})

local SupportButton = InfoTab:CreateButton({
   Name = "📋 Copy Support / Discord Link",
   Callback = function()
      pcall(function()
          setclipboard("https://github.com")
      end)
   end,
})

-- ====================================================================
-- CRAZY HUB | PART 2 (Cheats Tab, External Loaders & Movement Loops)
-- ====================================================================

-- ==========================================
-- TAB 2: Cheats
-- ==========================================
local CheatsTab = Window:CreateTab("Cheats", 4483362458)

-- SECTION: THEME CHANGER
local SectionGui = CheatsTab:CreateSection("GUI Customization")

local ThemeDropdown = CheatsTab:CreateDropdown({
   Name = "Change GUI Color / Theme",
   Options = {"Default", "Light", "Ocean", "Green", "Amber", "Serenity"},
   CurrentOption = "Default",
   Flag = "ThemeDropdown",
   Callback = function(SelectedTheme)
      Rayfield:ModifyTheme(SelectedTheme)
   end,
})

-- SECTION: EXTERNAL LOADERS
local SectionLoaders = CheatsTab:CreateSection("External Scripts (Loaders)")

-- Button 1: Crazy CMDS
local CmdsButton = CheatsTab:CreateButton({
   Name = "🚀 Crazy CMDS",
   Callback = function()
      task.spawn(function()
          task.wait(1)
          pcall(function()
              local scriptCode = game:HttpGet(CMDS_URL)
              if scriptCode and scriptCode ~= "" then
                  loadstring(scriptCode)()
              end
          end)
      end)
   end,
})

-- Button 2: PackGod AI
local AiButton = CheatsTab:CreateButton({
   Name = "🤖 PackGod AI by cheat96354961 & TheLocalMaze",
   Callback = function()
      task.spawn(function()
          task.wait(1)
          pcall(function()
              local scriptCode = game:HttpGet(AI_URL)
              if scriptCode and scriptCode ~= "" then
                  loadstring(scriptCode)()
              end
          end)
      end)
   end,
})

-- Button 3: FrameGui Test
local FrameButton = CheatsTab:CreateButton({
   Name = "🖼️ FrameGui Test",
   Callback = function()
      task.spawn(function()
          task.wait(1)
          pcall(function()
              local scriptCode = game:HttpGet(FRAME_URL)
              if scriptCode and scriptCode ~= "" then
                  loadstring(scriptCode)()
              end
          end)
      end)
   end,
})

-- Button 4: KDL-HUB
local KdlButton = CheatsTab:CreateButton({
   Name = "🌟 KDL-HUB",
   Callback = function()
      task.spawn(function()
          task.wait(1)
          pcall(function()
              local scriptCode = game:HttpGet(KDL_URL)
              if scriptCode and scriptCode ~= "" then
                  loadstring(scriptCode)()
              end
          end)
      end)
   end,
})

-- SECTION: MOVEMENT
local SectionMovement = CheatsTab:CreateSection("Movement Features")

-- WalkSpeed Slider
local SpeedSlider = CheatsTab:CreateSlider({
   Name = "WalkSpeed",
   Increment = 1,
   Max = 250,
   Min = 16,
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      if humanoid then humanoid.WalkSpeed = Value end
   end,
})

-- JumpPower Slider
local JumpSlider = CheatsTab:CreateSlider({
   Name = "JumpPower",
   Increment = 1,
   Max = 300,
   Min = 50,
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      if humanoid then
          humanoid.JumpPower = Value
          humanoid.UseJumpPower = true
      end
   end,
})

-- Infinite Jump Toggle
local InfJumpToggle = CheatsTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump", 
   Callback = function(Value)
      InfiniteJumpEnabled = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled and humanoid then
        humanoid:ChangeState("Jumping")
    end
end)

-- Fly Toggle
local FlyToggle = CheatsTab:CreateToggle({
   Name = "Fly Mode",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      FlyEnabled = Value
      if FlyEnabled then
          local BodyGyro = Instance.new("BodyGyro", character:WaitForChild("HumanoidRootPart"))
          local BodyVelocity = Instance.new("BodyVelocity", character:WaitForChild("HumanoidRootPart"))
          
          BodyGyro.P = 9e4
          BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
          BodyGyro.cframe = character.HumanoidRootPart.CFrame
          
          BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
          BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
          
          task.spawn(function()
              while FlyEnabled and character and character:FindFirstChild("HumanoidRootPart") do
                  local camera = workspace.CurrentCamera
                  local moveDirection = humanoid.MoveDirection
                  BodyVelocity.velocity = camera.CFrame:VectorToWorldSpace(Vector3.new(moveDirection.X, 0, moveDirection.Z)) * FlySpeed
                  BodyGyro.cframe = camera.CFrame
                  task.wait()
              end
              BodyGyro:Destroy()
              BodyVelocity:Destroy()
          end)
      end
   end,
})

-- SECTION: COMBAT & TELEPORT
local SectionPlayers = CheatsTab:CreateSection("Combat & Teleport")

-- God Mode Toggle
local GodToggle = CheatsTab:CreateToggle({
   Name = "God Mode (Infinite HP)",
   CurrentValue = false,
   Flag = "GodMode",
   Callback = function(Value)
      GodModeEnabled = Value
      if GodModeEnabled and humanoid then
          humanoid.MaxHealth = math.huge
          humanoid.Health = math.huge
      else
          if humanoid then
              humanoid.MaxHealth = 100
              humanoid.Health = 100
          end
      end
   end,
})

-- ESP Toggle (fixed)
local EspEnabled = false
local playerAddedConnection = nil

local function addEsp(plr)
    if plr ~= player then
        local function applyHighlight(char)
            if char and not char:FindFirstChild("CrazyESP") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "CrazyESP"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = char
            end
        end
        if plr.Character then applyHighlight(plr.Character) end
        plr.CharacterAdded:Connect(applyHighlight)
    end
end

local function removeEspFromCharacter(char)
    if char and char:FindFirstChild("CrazyESP") then
        char.CrazyESP:Destroy()
    end
end

local EspToggle = CheatsTab:CreateToggle({
   Name = "Player ESP (Wallhack)",
   CurrentValue = false,
   Flag = "EspToggle",
   Callback = function(Value)
      EspEnabled = Value
      if EspEnabled then
          for _, p in pairs(Players:GetPlayers()) do addEsp(p) end
          playerAddedConnection = Players.PlayerAdded:Connect(addEsp)
      else
          if playerAddedConnection then
              playerAddedConnection:Disconnect()
              playerAddedConnection = nil
          end
          for _, p in pairs(Players:GetPlayers()) do
              if p ~= player and p.Character then
                  removeEspFromCharacter(p.Character)
              end
          end
      end
   end,
})

-- Teleport Dropdown
local PlayerDropdown = CheatsTab:CreateDropdown({
   Name = "Teleport to Player",
   Options = {},
   CurrentOption = "",
   Flag = "TpDropdown",
   Callback = function(SelectedPlayerName)
      local targetPlayer = Players:FindFirstChild(SelectedPlayerName)
      if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
          character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
      end
   end,
})

-- Dynamic Player List Update Loop
task.spawn(function()
    while true do
        local currentPlayers = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then table.insert(currentPlayers, p.Name) end
        end
        PlayerDropdown:Refresh(currentPlayers)
        task.wait(3)
    end
end)

-- 4. Successful Execution Notification
Rayfield:Notify({
   Title = "Crazy Hub Activated!",
   Content = "Version " .. HUB_VERSION .. " by " .. AUTHOR_NAME .. " successfully executed.",
   Duration = 5,
   Image = 4483362458,
})
