if not game:GetService("ReplicatedStorage"):FindFirstChild("01_server") then local a=game:GetService("CollectionService")local b={}b["ScreenGui_1"]=Instance.new("ScreenGui",game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))b["ScreenGui_1"].IgnoreGuiInset=true b["ScreenGui_1"].ScreenInsets=Enum.ScreenInsets.DeviceSafeInsets b["ScreenGui_1"].ZIndexBehavior=Enum.ZIndexBehavior.Sibling a:AddTag(b["ScreenGui_1"],"main")b["Frame_2"]=Instance.new("Frame",b["ScreenGui_1"])b["Frame_2"].BorderSizePixel=0 b["Frame_2"].BackgroundColor3=Color3.fromRGB(0,0,0)b["Frame_2"].AnchorPoint=Vector2.new(.5,.5)b["Frame_2"].Size=UDim2.new(.36316,0,.46667,0)b["Frame_2"].Position=UDim2.new(.5,0,.5,0)b["Frame_2"].BackgroundTransparency=.5 b["UICorner_3"]=Instance.new("UICorner",b["Frame_2"])b["UICorner_3"].CornerRadius=UDim.new(.04,0)b["TextLabel_4"]=Instance.new("TextLabel",b["Frame_2"])b["TextLabel_4"].TextWrapped=true b["TextLabel_4"].BorderSizePixel=0 b["TextLabel_4"].TextScaled=true b["TextLabel_4"].BackgroundColor3=Color3.fromRGB(255,255,255)b["TextLabel_4"].TextColor3=Color3.fromRGB(255,255,255)b["TextLabel_4"].BackgroundTransparency=1 b["TextLabel_4"].Size=UDim2.new(.81159,0,.32143,0)b["TextLabel_4"].Text="You are in the wrong game, please copy the link below and enter the game. (game: Just a baseplate., game creator: dreammazestudio/ the local maze)"b["TextLabel_4"].Position=UDim2.new(.0942,0,.13095,0)b["TextBox_5"]=Instance.new("TextBox",b["Frame_2"])b["TextBox_5"].CursorPosition=-1 b["TextBox_5"].BorderSizePixel=0 b["TextBox_5"].BackgroundColor3=Color3.fromRGB(255,255,255)b["TextBox_5"].ClearTextOnFocus=false b["TextBox_5"].Size=UDim2.new(.81159,0,.29762,0)b["TextBox_5"].Position=UDim2.new(.1087,0,.5119,0)b["TextBox_5"].Text="https://www.roblox.com/games/123974602339071/UP-Just-a-baseplate"b["TextBox_5"].TextScaled=true b["UIAspectRatioConstraint_6"]=Instance.new("UIAspectRatioConstraint",b["Frame_2"])b["UIAspectRatioConstraint_6"].AspectRatio=1.64286 game:GetService("TeleportService"):Teleport(123974602339071,game:GetService("Players").LocalPlayer)return b["ScreenGui_1"],require end


local function notify(text, dur)
    local Notify = game:GetService("StarterGui")
    Notify:SetCore(
        "SendNotification",
        {
            Title = "Service",
            Text = text
        }
    )
    Duration = 5 or dur
end
local function Chat(Message)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(Message)
end
local Char = game:GetService("Players").LocalPlayer.Character
local H =
    " ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Place = game.placeId
local Window =
    Rayfield:CreateWindow(
    {
        Name = "Just A Baseplate",
        LoadingTitle = "Just A Baseplate",
        LoadingSubtitle = "By Yuni",
        Theme = "Amethyst",
        ToggleUIKeybind = "N",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "JustABaseplate",
            FileName = "Config"
        },
        KeySystem = false
    }
)

local ReadTab = Window:CreateTab("READ", nil)

local Paragraph =
    ReadTab:CreateParagraph(
    {
        Title = "PLEASE READ BEFORE PROCEEDING BELLOW!:",
        Content = "I DO NOT OWN THE SCRIPTS THAT ARE INSIDE THIS SCRIPT!! I ONLY CONFIGURED THEM!! ALL CREDITS GOES TO THE RESPECTIVE OWNERS OF THE SCRIPTS!!"
    }
)
local Divider = ReadTab:CreateDivider()
local Paragraph1 =
    ReadTab:CreateParagraph(
    {
        Title = "How to use this hubðŸ¤”",
        Content = " If Your gonna use genesis, go to the hats and rigs tab, same as the achromatics, once your done loading the hats and rigs, head to the Main tab and execute the scripts there!!"
    }
)

local HomeTab = Window:CreateTab("Home", nil) -- Title, Image
local HomeSection = HomeTab:CreateSection("Main")

local Paragraph =
    HomeTab:CreateParagraph({Title = "Just A Baseplate Hub By Theo/Paradigm", Content = "Created on 06/13/25!"})
local Paragraph1 =
    HomeTab:CreateParagraph(
    {
        Title = "CHANGELOGS:",
        Content = "The hub returns!, i will give this an annual update because theres not much fe scripts thay i really find lol, Warn!, if your a krnl user, expect some crashes if your using some scripts..."
    }
)

local Button =
    HomeTab:CreateButton(
    {
        Name = "Sit",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-sit")
        end
    }
)

local Button1 =
    HomeTab:CreateButton(
    {
        Name = "Boost Fps",
        Callback = function()
            local ToDisable = {
                VisualEffects = true,
                Parts = true,
                Particles = true,
                Sky = true
            }

            local ToEnable = {
                FullBright = true
            }

            local Stuff = {}

            for _, v in next, game:GetDescendants() do
                if ToDisable.Parts then
                    if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") then
                        v.Material = Enum.Material.SmoothPlastic
                        table.insert(Stuff, 1, v)
                    end
                end

                if ToDisable.Particles then
                    if
                        v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or
                            v:IsA("Fire")
                     then
                        v.Enabled = false
                        table.insert(Stuff, 1, v)
                    end
                end

                if ToDisable.VisualEffects then
                    if
                        v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or
                            v:IsA("SunRaysEffect")
                     then
                        v.Enabled = false
                        table.insert(Stuff, 1, v)
                    end
                end

                if ToDisable.Sky then
                    if v:IsA("Sky") then
                        v.Parent = nil
                        table.insert(Stuff, 1, v)
                    end
                end
            end

            game:GetService("TestService"):Message(
                "Effects Disabler Script: Successfully disabled " .. #Stuff .. " assets/effects. Settings:"
            )

            for i, v in next, ToDisable do
                print(tostring(i) .. ": " .. tostring(v))
            end

            if ToEnable.FullBright then
                local Lighting = game:GetService("Lighting")

                Lighting.FogColor = Color3.fromRGB(255, 255, 255)
                Lighting.FogEnd = math.huge
                Lighting.FogStart = math.huge
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 5
                Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
                Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Lighting.Outlines = true
            end
        end
    }
)
local Button2 =
    HomeTab:CreateButton(
    {
        Name = "Serverhop",
        Callback = function()
            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            local File =
                pcall(
                function()
                    AllIDs = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
                end
            )
            if not File then
                table.insert(AllIDs, actualHour)
                writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
            end
            function TPReturner()
                local Site
                if foundAnything == "" then
                    Site =
                        game.HttpService:JSONDecode(
                        game:HttpGet(
                            "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
                        )
                    )
                else
                    Site =
                        game.HttpService:JSONDecode(
                        game:HttpGet(
                            "https://games.roblox.com/v1/games/" ..
                                PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything
                        )
                    )
                end
                local ID = ""
                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end
                local num = 0
                for i, v in pairs(Site.data) do
                    local Possible = true
                    ID = tostring(v.id)
                    if tonumber(v.maxPlayers) > tonumber(v.playing) then
                        for _, Existing in pairs(AllIDs) do
                            if num ~= 0 then
                                if ID == tostring(Existing) then
                                    Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile =
                                        pcall(
                                        function()
                                            delfile("NotSameServers.json")
                                            AllIDs = {}
                                            table.insert(AllIDs, actualHour)
                                        end
                                    )
                                end
                            end
                            num = num + 1
                        end
                        if Possible == true then
                            table.insert(AllIDs, ID)
                            wait()
                            pcall(
                                function()
                                    writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
                                    wait()
                                    game:GetService("TeleportService"):TeleportToPlaceInstance(
                                        PlaceID,
                                        ID,
                                        game.Players.LocalPlayer
                                    )
                                end
                            )
                            wait(4)
                        end
                    end
                end
            end

            function Teleport()
                while wait() do
                    pcall(
                        function()
                            TPReturner()
                            if foundAnything ~= "" then
                                TPReturner()
                            end
                        end
                    )
                end
            end

            Teleport()
        end
    }
)
local Slider =
    HomeTab:CreateSlider(
    {
        Name = "WalkSpeed Slider",
        Range = {16, 350},
        Increment = 1,
        Suffix = "Walkspeed",
        CurrentValue = 16,
        Flag = "sliderws",
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
        end
    }
)

local Slider =
    HomeTab:CreateSlider(
    {
        Name = "JumpPower Slider",
        Range = {50, 400},
        Increment = 1,
        Suffix = "Jump Power",
        CurrentValue = 50,
        Flag = "sliderjp",
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
        end
    }
)
local Input =
    HomeTab:CreateInput(
    {
        Name = "Walkspeed",
        PlaceholderText = "1-500",
        RemoveTextAfterFocusLost = true,
        Callback = function(Text)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Text)
        end
    }
)
wait(1)
local Toggle =
    HomeTab:CreateToggle(
    {
        Name = "Dark Mode",
        CurrentValue = false,
        Flag = "DM",
        Callback = function(DM)
            if (DM) then
                Window.ModifyTheme {
                    TextColor = Color3.fromRGB(255, 255, 255),
                    Background = Color3.fromRGB(0, 0, 0),
                    Topbar = Color3.fromRGB(0, 0, 0),
                    Shadow = Color3.fromRGB(0, 0, 0),
                    NotificationBackground = Color3.fromRGB(0, 0, 0),
                    NotificationActionsBackground = Color3.fromRGB(0, 0, 0),
                    TabBackground = Color3.fromRGB(0, 0, 0),
                    TabStroke = Color3.fromRGB(255, 255, 255),
                    TabBackgroundSelected = Color3.fromRGB(255, 255, 255),
                    TabTextColor = Color3.fromRGB(255, 255, 255),
                    SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
                    ElementBackground = Color3.fromRGB(15, 15, 15),
                    ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
                    SecondaryElementBackground = Color3.fromRGB(0, 0, 0),
                    ElementStroke = Color3.fromRGB(150, 150, 150),
                    SecondaryElementStroke = Color3.fromRGB(255, 255, 255),
                    SliderBackground = Color3.fromRGB(255, 255, 255),
                    SliderProgress = Color3.fromRGB(0, 0, 0),
                    SliderStroke = Color3.fromRGB(255, 255, 255),
                    ToggleBackground = Color3.fromRGB(0, 0, 0),
                    ToggleEnabled = Color3.fromRGB(255, 255, 255),
                    ToggleDisabled = Color3.fromRGB(255, 255, 255),
                    ToggleEnabledStroke = Color3.fromRGB(0, 0, 0),
                    ToggleDisabledStroke = Color3.fromRGB(0, 0, 0),
                    ToggleEnabledOuterStroke = Color3.fromRGB(0, 0, 0),
                    ToggleDisabledOuterStroke = Color3.fromRGB(0, 0, 0),
                    DropdownSelected = Color3.fromRGB(100, 0, 255),
                    DropdownUnselected = Color3.fromRGB(0, 0, 0),
                    InputBackground = Color3.fromRGB(0, 0, 0),
                    InputStroke = Color3.fromRGB(255, 255, 255),
                    PlaceholderColor = Color3.fromRGB(255, 25, 255)
                }
            elseif true then
                Window.ModifyTheme("Serenity")
            end
        end
    }
)

local ThemesSection = HomeTab:CreateSection("Themes Section")
local Button2 =
    HomeTab:CreateButton(
    {
        Name = "Ocean",
        Callback = function()
            Window.ModifyTheme("Ocean")
        end
    }
)
local Button3 =
    HomeTab:CreateButton(
    {
        Name = "Bloom",
        Callback = function()
            Window.ModifyTheme("Bloom")
        end
    }
)
local Button4 =
    HomeTab:CreateButton(
    {
        Name = "Dark Blue",
        Callback = function()
            Window.ModifyTheme("DarkBlue")
        end
    }
)
local Button5 =
    HomeTab:CreateButton(
    {
        Name = "Amethyst",
        Callback = function()
            Window.ModifyTheme("Amethyst")
        end
    }
)
local Button6 =
    HomeTab:CreateButton(
    {
        Name = "Serenity",
        Callback = function()
            Window.ModifyTheme("Serenity")
        end
    }
)

local CustomThemesSection = HomeTab:CreateSection("Custon Themes Section")
local Button7 =
    HomeTab:CreateButton(
    {
        Name = "Outer Space",
        Callback = function()
            Window.ModifyTheme {
                TextColor = Color3.fromRGB(255, 255, 255),
                Background = Color3.fromRGB(0, 0, 0),
                Topbar = Color3.fromRGB(0, 0, 0),
                Shadow = Color3.fromRGB(0, 0, 0),
                NotificationBackground = Color3.fromRGB(0, 0, 0),
                NotificationActionsBackground = Color3.fromRGB(100, 0, 255),
                TabBackground = Color3.fromRGB(0, 0, 0),
                TabStroke = Color3.fromRGB(100, 0, 255),
                TabBackgroundSelected = Color3.fromRGB(50, 0, 132.5),
                TabTextColor = Color3.fromRGB(255, 255, 255),
                SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
                ElementBackground = Color3.fromRGB(15, 15, 15),
                ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
                SecondaryElementBackground = Color3.fromRGB(0, 0, 0),
                ElementStroke = Color3.fromRGB(150, 150, 150),
                SecondaryElementStroke = Color3.fromRGB(255, 255, 255),
                SliderBackground = Color3.fromRGB(75, 0, 200),
                SliderProgress = Color3.fromRGB(50, 0, 255),
                SliderStroke = Color3.fromRGB(75, 0, 255),
                ToggleBackground = Color3.fromRGB(100, 0, 255),
                ToggleEnabled = Color3.fromRGB(255, 255, 255),
                ToggleDisabled = Color3.fromRGB(255, 255, 255),
                ToggleEnabledStroke = Color3.fromRGB(0, 0, 0),
                ToggleDisabledStroke = Color3.fromRGB(0, 0, 0),
                ToggleEnabledOuterStroke = Color3.fromRGB(0, 0, 0),
                ToggleDisabledOuterStroke = Color3.fromRGB(0, 0, 0),
                DropdownSelected = Color3.fromRGB(100, 0, 255),
                DropdownUnselected = Color3.fromRGB(0, 0, 0),
                InputBackground = Color3.fromRGB(0, 0, 0),
                InputStroke = Color3.fromRGB(100, 0, 255),
                PlaceholderColor = Color3.fromRGB(100, 0, 255)
            }
        end
    }
)
local Button8 =
    HomeTab:CreateButton(
    {
        Name = "Outer Space[Red]",
        Callback = function()
            Window.ModifyTheme {
                TextColor = Color3.fromRGB(255, 255, 255),
                Background = Color3.fromRGB(0, 0, 0),
                Topbar = Color3.fromRGB(0, 0, 0),
                Shadow = Color3.fromRGB(0, 0, 0),
                NotificationBackground = Color3.fromRGB(0, 0, 0),
                NotificationActionsBackground = Color3.fromRGB(100, 0, 255),
                TabBackground = Color3.fromRGB(0, 0, 0),
                TabStroke = Color3.fromRGB(255, 0, 0),
                TabBackgroundSelected = Color3.fromRGB(135.5, 0, 0),
                TabTextColor = Color3.fromRGB(255, 255, 255),
                SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
                ElementBackground = Color3.fromRGB(15, 15, 15),
                ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
                SecondaryElementBackground = Color3.fromRGB(0, 0, 0),
                ElementStroke = Color3.fromRGB(150, 0, 0),
                SecondaryElementStroke = Color3.fromRGB(255, 0, 0),
                SliderBackground = Color3.fromRGB(0, 0, 0),
                SliderProgress = Color3.fromRGB(255, 0, 0),
                SliderStroke = Color3.fromRGB(255, 0, 0),
                ToggleBackground = Color3.fromRGB(130, 0, 0),
                ToggleEnabled = Color3.fromRGB(130, 0, 0),
                ToggleDisabled = Color3.fromRGB(120, 0, 0),
                ToggleEnabledStroke = Color3.fromRGB(140, 0, 0),
                ToggleDisabledStroke = Color3.fromRGB(70, 0, 0),
                ToggleEnabledOuterStroke = Color3.fromRGB(70, 0, 0),
                ToggleDisabledOuterStroke = Color3.fromRGB(40, 0, 0),
                DropdownSelected = Color3.fromRGB(255, 0, 0),
                DropdownUnselected = Color3.fromRGB(0, 0, 0),
                InputBackground = Color3.fromRGB(0, 0, 0),
                InputStroke = Color3.fromRGB(255, 0, 0),
                PlaceholderColor = Color3.fromRGB(255, 0, 0)
            }
        end
    }
)
local Button9 =
    HomeTab:CreateButton(
    {
        Name = "Outer Space[Blue]",
        Callback = function()
            Window.ModifyTheme {
                TextColor = Color3.fromRGB(255, 255, 255),
                Background = Color3.fromRGB(0, 0, 0),
                Topbar = Color3.fromRGB(0, 0, 0),
                Shadow = Color3.fromRGB(0, 0, 0),
                NotificationBackground = Color3.fromRGB(0, 0, 0),
                NotificationActionsBackground = Color3.fromRGB(0, 0, 125),
                TabBackground = Color3.fromRGB(0, 0, 0),
                TabStroke = Color3.fromRGB(0, 0, 255),
                TabBackgroundSelected = Color3.fromRGB(0, 0, 132.5),
                TabTextColor = Color3.fromRGB(255, 255, 255),
                SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
                ElementBackground = Color3.fromRGB(15, 15, 15),
                ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
                SecondaryElementBackground = Color3.fromRGB(0, 0, 0),
                ElementStroke = Color3.fromRGB(0, 0, 150),
                SecondaryElementStroke = Color3.fromRGB(0, 0, 255),
                SliderBackground = Color3.fromRGB(0, 0, 0),
                SliderProgress = Color3.fromRGB(0, 0, 255),
                SliderStroke = Color3.fromRGB(0, 0, 255),
                ToggleBackground = Color3.fromRGB(0, 0, 130),
                ToggleEnabled = Color3.fromRGB(0, 0, 255),
                ToggleDisabled = Color3.fromRGB(0, 0, 120),
                ToggleEnabledStroke = Color3.fromRGB(0, 0, 140),
                ToggleDisabledStroke = Color3.fromRGB(0, 0, 120),
                ToggleEnabledOuterStroke = Color3.fromRGB(0, 0, 120),
                ToggleDisabledOuterStroke = Color3.fromRGB(0, 0, 90),
                DropdownSelected = Color3.fromRGB(0, 0, 255),
                DropdownUnselected = Color3.fromRGB(0, 0, 0),
                InputBackground = Color3.fromRGB(0, 0, 0),
                InputStroke = Color3.fromRGB(0, 0, 255),
                PlaceholderColor = Color3.fromRGB(0, 0, 255)
            }
        end
    }
)
local Button10 =
    HomeTab:CreateButton(
    {
        Name = "Blue And Yellow",
        Callback = function()
            Window.ModifyTheme {
                TextColor = Color3.fromRGB(0, 0, 0),
                Background = Color3.fromRGB(255, 255, 125),
                Topbar = Color3.fromRGB(125, 255, 255),
                Shadow = Color3.fromRGB(200, 200, 200),
                NotificationBackground = Color3.fromRGB(230, 230, 125),
                NotificationActionsBackground = Color3.fromRGB(100, 0, 255),
                TabBackground = Color3.fromRGB(210, 210, 100),
                TabStroke = Color3.fromRGB(0, 255, 255),
                TabBackgroundSelected = Color3.fromRGB(125, 230, 230),
                TabTextColor = Color3.fromRGB(0, 0, 0),
                SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
                ElementBackground = Color3.fromRGB(245, 245, 115),
                ElementBackgroundHover = Color3.fromRGB(125, 255, 255),
                SecondaryElementBackground = Color3.fromRGB(245, 245, 115),
                ElementStroke = Color3.fromRGB(115, 245, 245),
                SecondaryElementStroke = Color3.fromRGB(125, 245, 245),
                SliderBackground = Color3.fromRGB(0, 200, 200),
                SliderProgress = Color3.fromRGB(0, 255, 255),
                SliderStroke = Color3.fromRGB(230, 230, 75),
                ToggleBackground = Color3.fromRGB(220, 220, 65),
                ToggleEnabled = Color3.fromRGB(125, 255, 255),
                ToggleDisabled = Color3.fromRGB(255, 255, 125),
                ToggleEnabledStroke = Color3.fromRGB(255, 255, 125),
                ToggleDisabledStroke = Color3.fromRGB(125, 255, 255),
                ToggleEnabledOuterStroke = Color3.fromRGB(125, 255, 255),
                ToggleDisabledOuterStroke = Color3.fromRGB(255, 255, 125),
                DropdownSelected = Color3.fromRGB(125, 255, 255),
                DropdownUnselected = Color3.fromRGB(255, 255, 125),
                InputBackground = Color3.fromRGB(125, 255, 255),
                InputStroke = Color3.fromRGB(100, 0, 255),
                PlaceholderColor = Color3.fromRGB(100, 0, 255)
            }
        end
    }
)

----========----
local MainTab = Window:CreateTab("Main", nil)

local Krystal = MainTab:CreateSection("Krystal Dance")
local Button2 =
    MainTab:CreateButton(
    {
        Name = "Krystal Dance V3 [>Fixed<] Modified by Local Maze",
        Callback = function(A)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ilikeices/script/refs/heads/main/kdv3mod.luau"))(

            )
        end
    }
)

local GenesisSection = MainTab:CreateSection("Genesis")
local Button2 =
    MainTab:CreateButton(
    {
        Name = "Genesis Neptunian V",
        Callback = function(A)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Neptunian%20V")
            )()
        end
    }
)

local Button3 =
    MainTab:CreateButton(
    {
        Name = "Genesis Sniper",
        Callback = function(A)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            permadeath = true --adds permanent death (no respawning), see #supported-executors channel for executors that work with this
            fling = true --toggle fling
            allowshiftlock = true --adds shiftlock to patchma rig
            ctrltp = false --adds control click tp
            placeholders = false --adds transparent parts showing your hats when you don't have real ones
            clickfling = true --adds click flinging regardless of attacks
            highlightflingtargets = false --highlight fling
            discharscripts = true --disable character scripts
            flingchangestate = false
            --fling with whole body
            hidedeatheffect = true --hides the red damage border when you die (respawn)
            respawntp = 2 --respawn tp mode
            -- 0 - stay at spawn
            -- 1 - randomtp close
            -- 2 - behind fake character
            -- 3 - hide body
            breakjointsmethod = 1 --breakjoints mode
            -- 1 - health+breakjoints (the most support)
            -- 2 - health or breakjoints
            -- 3 - breakjoints
            simrad = true --sets simulation radius

            --==========================================================================================================================--

            loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Sniper"))()

            --==========================================================================================================================--
        end
    }
)
local Button4 =
    MainTab:CreateButton(
    {
        Name = "Genesis Sin Dragon",
        Callback = function(A)
            transparent = true --toggle clientsided parts (dragon head, claws, etc)
            effects = true --toggle clientsided effects (punch effect, laser effect, etc), set this to false if you use an emulator and you are lagging
            permadeath = true --adds permanent death (no respawning), see #supported-executors channel for executors that work with this
            fling = true --toggle fling
            allowshiftlock = true --adds shiftlock to patchma rig
            ctrltp = false --adds control click tp
            placeholders = false --adds transparent parts showing your hats when you don't have real ones
            clickfling = true --adds click flinging regardless of attacks
            highlightflingtargets = true --highlight fling
            discharscripts = true --disable character scripts
            flingchangestate = true --fling with whole body
            hidedeatheffect = true --hides the red damage border when you die (respawn)
            respawntp = 2 --respawn tp mode
            -- 0 - stay at spawn
            -- 1 - randomtp close
            -- 2 - behind fake character
            -- 3 - hide body
            breakjointsmethod = 1 --breakjoints mode
            -- 1 - health+breakjoints (the most support)
            -- 2 - health or breakjoints
            -- 3 - breakjoints
            simrad = true --sets simulation radius

            --==========================================================================================================================--

            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Sin%20Dragon")
            )()

            --==========================================================================================================================--
        end
    }
)
local Button5 =
    MainTab:CreateButton(
    {
        Name = "Genesis Goner",
        Callback = function(A)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            permadeath = true --adds permanent death (no respawning), see #supported-executors channel for executors that work with this
            fling = true --toggle fling
            allowshiftlock = true --adds shiftlock to patchma rig
            ctrltp = true --adds control click tp
            placeholders = false --adds transparent parts showing your hats when you don't have real ones
            clickfling = true --adds click flinging regardless of attacks
            highlightflingtargets = true --highlight fling
            discharscripts = true --disable character scripts
            flingchangestate = true --fling with whole body
            hidedeatheffect = true --hides the red damage border when you die (respawn)
            respawntp = 2 --respawn tp mode
            -- 0 - stay at spawn
            -- 1 - randomtp close
            -- 2 - behind fake character
            -- 3 - hide body
            breakjointsmethod = 1 --breakjoints mode
            -- 1 - health+breakjoints (the most support)
            -- 2 - health or breakjoints
            -- 3 - breakjoints
            simrad = true --sets simulation radius

            --==========================================================================================================================--

            loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Goner"))()

            --==========================================================================================================================--
        end
    }
)
local Button6 =
    MainTab:CreateButton(
    {
        Name = "Genesis Ban Hammer",
        Callback = function(A)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            permadeath = true --adds permanent death (no respawning), see #supported-executors channel for executors that work with this
            fling = true --toggle fling
            allowshiftlock = true --adds shiftlock to patchma rig
            ctrltp = true --adds control click tp
            placeholders = false --adds transparent parts showing your hats when you don't have real ones
            clickfling = true --adds click flinging regardless of attacks
            highlightflingtargets = false --highlight fling
            discharscripts = true --disable character scripts
            flingchangestate = true --fling with whole body
            hidedeatheffect = true --hides the red damage border when you die (respawn)
            respawntp = 2 --respawn tp mode
            -- 0 - stay at spawn
            -- 1 - randomtp close
            -- 2 - behind fake character
            -- 3 - hide body
            breakjointsmethod = 1 --breakjoints mode
            -- 1 - health+breakjoints (the most support)
            -- 2 - health or breakjoints
            -- 3 - breakjoints
            simrad = true --sets simulation radius

            --==========================================================================================================================--

            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Ban%20Hammer")
            )()

            --==========================================================================================================================--
        end
    }
)
local LC =
    MainTab:CreateButton(
    {
        Name = "Genesis Lightning Cannon",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            --===================================--
            --          Script Options           --
            --===================================--

            lightmode = false --overwrite black mode colors with white
            effects = true
            --toggle effects (if you experience performance issues try setting to false)
            timemultiplier = 1 --change animation speed (min=0.1,default=1,max=10)
            walkspeedmultiplier = 1 --change walkspeed (default=1,min/mix=-âˆž-->+âˆž)

            --====================================--
            --          FDless Options           --
            --====================================--

            permadeath = true --adds permanent death (no respawning), see #supported-executors channel for executors that work with this
            fling = true --toggle fling
            allowshiftlock = true --adds shiftlock to patchma rig
            ctrltp = true --adds control click tp
            placeholders = false --adds transparent parts showing your hats when you don't have real ones
            clickfling = true --adds click flinging regardless of attacks
            highlightflingtargets = false --highlight fling
            discharscripts = true --disable character scripts
            flingchangestate = true --fling with whole body
            hidedeatheffect = true --hides the red damage border when you die (respawn)
            respawntp = 2 --respawn tp mode
            --0 -stay at spawn
            --1 -randomtp close
            --2 -behind fake character
            --3 -hide body
            breakjointsmethod = 1 --breakjoints mode
            --1 -health+breakjoints (the most support)
            --2 -health or breakjoints
            --3 -breakjoints
            simrad = true --sets simulation rad,,,,ius

            --==========================================================================================================================--

            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Lightning%20Cannon")
            )()

            --==========================================================================================================================--
        end
    }
)

local MainSection = MainTab:CreateSection("Other")

local Button8 =
    MainTab:CreateButton(
    {
        Name = "Achromoonic",
        Callback = function(A)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/achromoonic edit.luau"
                )
            )()
        end
    }
)

local Button9 =
    MainTab:CreateButton(
    {
        Name = "Achromatix",
        Callback = function(A)
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Achromatix_V6-1.lua")
            )()
        end
    }
)

local Achromaticv5 =
    MainTab:CreateButton(
    {
        Name = "Achromatic V5",
        Callback = function(A)
            --task.wait(2.150)
            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/achromatic%20v5%20edited%20yes.luau"
                )
            )()
        end
    }
)

local Achromaticv2 =
    MainTab:CreateButton(
    {
        Name = "Achromatic V2",
        Callback = function(A)
            --task.wait(2.150)
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Achromatic V2.lua")
            )()
        end
    }
)

local Button10 =
    MainTab:CreateButton(
    {
        Name = "Encription Glitcher",
        Callback = function(A)
            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Encription%20Glitcher.lua"
                )
            )()
        end
    }
)

local Zeon =
    MainTab:CreateButton(
    {
        Name = "Zeon Glitcher",
        Callback = function(A)
            --task.wait(2.150)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Zeon.lua"))()
        end
    }
)

local Renegade =
    MainTab:CreateButton(
    {
        Name = "Renegade Glitcher",
        Callback = function(A)
            --task.wait(2.150)
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Renegade.lua")
            )()
        end
    }
)

local NebulaDivider1 = MainTab:CreateDivider()

local NebulaInput =
    MainTab:CreateInput(
    {
        Name = "Star Glitcher Wings",
        CurrentValue = "97537548465301",
        PlaceholderText = "Insert ID",
        RemoveTextAfterFocusLost = false,
        Callback = function(Nebula)
            local Neb = (Nebula)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-gh " .. tostring(Neb))
        end
    }
)
local NebulaExampleButton =
    MainTab:CreateButton(
    {
        Name = "Reload Example ID",
        Callback = function()
            NebulaInput:Set("97537548465301")
        end
    }
)
local NebulaButton =
    MainTab:CreateButton(
    {
        Name = "Clear",
        Callback = function()
            NebulaInput:Set("")
        end
    }
)

local Button12 =
    MainTab:CreateButton(
    {
        Name = "Nebula Glitcher",
        Callback = function(A)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-net")
            task.wait(3)

            if game:GetService("Players").LocalPlayer.Character.Name ~= "GelatekReanimate" then
                notify("Not Reanimated")
                return
            end
            loadstring(game:HttpGet("https://pastebin.com/raw/j09BnGB3"))()
        end
    }
)

local Spectrum =
    MainTab:CreateButton(
    {
        Name = "Spectrum Glitcher",
        Callback = function(A)
            if game:GetService("Players").LocalPlayer.Character.Name ~= "GelatekReanimate" then
                notify("Not Reanimated")
                return
            end
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Spectrum1.lua")
            )()
        end
    }
)
local MainSection = MainTab:CreateSection("Forsaken")
local Forsaken =
    MainTab:CreateParagraph(
    {
        Title = "Note:",
        Content = "This section automatically loads the rigs so dont worry going to the hats and rigs tab to load the rigs! Also, say -net once u clicked the blue button, Credits to Im Patrick! (not me!)"
    }
)
local Button2 =
    MainTab:CreateButton(
    {
        Name = "Noli",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 83033503825226 98099894849025 74013526892143 131385506535381 85392395166623 129462518582032 106249329428811 138364679836274 12850150835 "
            )
            wait(6)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-sh")
            wait(2.250)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            _G.Config = {
                ["HatCollide"] = false,
                ["ReClaim"] = true, --
                ["Fling"] = true, --
                ["HideCharacter"] = true, --
                ["FlingOption"] = {
                    ["HatFling"] = false, --
                    ["Highlight"] = false, --
                    ["PredictionFling"] = true, --
                    ["ToolFling"] = true --
                }
            }

            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty0.lua")
            )()
        end
    }
)
local Button2 =
    MainTab:CreateButton(
    {
        Name = "c00lkidd",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh  98099894849025  12383790958   131385506535381 85392395166623 129462518582032 106249329428811 138364679836274 12850150835 "
            )
            wait(6)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-sh")
            wait(2.250)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")

            _G.Config = {
                ["HatCollide"] = false, --
                ["ReClaim"] = true, --
                ["Fling"] = true, --
                ["HideCharacter"] = true, --
                ["FlingOption"] = {
                    ["HatFling"] = false, --
                    ["Highlight"] = false, --
                    ["PredictionFling"] = true, --
                    ["ToolFling"] = true --
                }
            }

            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty2.lua")
            )()
        end
    }
)
local Modded = MainTab:CreateSection("Misc")
local Button2 =
    MainTab:CreateButton(
    {
        Name = "Gelatek Modded",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/Main.lua"))()
        end
    }
)

----================----

local HatsTab = Window:CreateTab("Hats And Rigs", nil)
local PDButton =
    HatsTab:CreateButton(
    {
        Name = "Permdeath For Genesis",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-pd")
        end
    }
)

local RemoveHatsButton =
    HatsTab:CreateButton(
    {
        Name = "Remove Hats",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-ch")
        end
    }
)
local Respawn =
    HatsTab:CreateButton(
    {
        Name = "Respawn",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-rs")
        end
    }
)
local save =
    HatsTab:CreateButton(
    {
        Name = "Save Hat",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-sh")
        end
    }
)

local RemoveHatsDivider1 = HatsTab:CreateDivider()
local HatsParagraph =
    HatsTab:CreateParagraph(
    {
        Title = "IMPORTANT!",
        Content = "It is important that you should always load the rigs for genesis so everyone can see you"
    }
)
local Button =
    HatsTab:CreateButton(
    {
        Name = "Genesis Rigs",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 138364679836274 82942681251131 140395948277978 102599402682100 90960046381276 13058406993 "
            )
        end
    }
)

local Button =
    HatsTab:CreateButton(
    {
        Name = "Genesis Rigs[Black]",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 131385506535381 85392395166623 129462518582032  138364679836274 12850150835 106249329428811"
            )
        end
    }
)
local Divider1 = HatsTab:CreateDivider()
local Paragraph1 =
    HatsTab:CreateParagraph(
    {
        Title = "Custom",
        Content = "Here You can load custom Genesis hats or your custom accessories!, if you want custom hats for genesis, consider looking it at the Foundations game."
    }
)

local Input =
    HatsTab:CreateInput(
    {
        Name = "Custom!",
        CurrentValue = "...",
        PlaceholderText = "Input Your ID Here!",
        RemoveTextAfterFocusLost = false,
        Callback = function(ID)
            local Custom = (ID)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-gh " .. tostring(ID))
        end
    }
)
local customButton =
    HatsTab:CreateButton(
    {
        Name = "Clear",
        Callback = function()
            Input:Set("")
        end
    }
)

local Divider2 = HatsTab:CreateDivider()
local Button2 =
    HatsTab:CreateButton(
    {
        Name = "Neptunian V",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-gh 5316479641 ")
        end
    }
)

local Button3 =
    HatsTab:CreateButton(
    {
        Name = "Sniper",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-gh 5168118559 4504231783")
        end
    }
)

local Button4 =
    HatsTab:CreateButton(
    {
        Name = "Sin Dragon",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 117186631495734 99965319383570 132770514241770 3756389957 14864581977  150381051 4504231783"
            )
        end
    }
)

local LightningCannon =
    HatsTab:CreateButton(
    {
        Name = "Lightning Cannon",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 111672581230926 126145101810389 136055191177936 4504231783"
            )
        end
    }
)

local Button5 =
    HatsTab:CreateButton(
    {
        Name = "Goner",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 17770317484 17822722698 17822749561 17772174303 17835236579"
            )
        end
    }
)

local Button6 =
    HatsTab:CreateButton(
    {
        Name = "Ban Hammer",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-gh 15548314241")
        end
    }
)

local OthersSection = HatsTab:CreateSection("Others")

local Button8 =
    HatsTab:CreateButton(
    {
        Name = "Sword Glitchers",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 4820152700 4524991457 4794315940 4506945409 4458601937 4315489767 4623728953 5030789687 4773883146 4773932088 4855847190 4932541287"
            )
        end
    }
)
local OthersSection = HatsTab:CreateSection("Renegade Glitcher Rigs")
Button8 =
    HatsTab:CreateButton(
    {
        Name = "Renegade Glitcher Rigs",
        Callback = function()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                "-gh 5316479641,5316539421,5699795428,5268602207 131385506535381 85392395166623 129462518582032 138364679836274 12850150835 106249329428811"
            )
            if game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name):WaitForChild("Accessory (LLeg)") then
                wait(2)
                Chat("-sh")
            end
        end
    }
)

-----==============-----

local reanim = Window:CreateTab("Reanimate", nil) -- Title, Image

Gelatek =
    reanim:CreateButton(
    {
        Name = "Gelatek Reanimate",
        Callback = function()
            local Global = (getgenv and getgenv()) or shared
            Global.GelatekHubConfig = {
                ["Permanent Death"] = true,
                ["Torso Fling"] = true,
                ["Bullet Enabled"] = false,
                ["Enable Collisions"] = true,
                ["Keep Hats On Head"] = true,
                ["Headless On Perma"] = false,
                ["Anti Void"] = true,
                ["Anti Void Offset"] = 75
            }
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/Gelatekussy/GelatekHub/main/src/lib/Reanimate.lua")
            )()
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-net")
        end
    }
)

local HubsTab = Window:CreateTab("Hubs", nil) -- Title, Image

local Button =
    HubsTab:CreateButton(
    {
        Name = "Gelatek Hub",
        Callback = function()
            -- https://scriptblox.com/script/Universal-Script-Gelatek-hub-26438l9cal

            loadstring(game:HttpGet("https://raw.githubusercontent.com/Gelatekussy/GelatekHub/main/Main.lua"))()
        end
    }
)

local Patchma =
    HubsTab:CreateButton(
    {
        Name = "Patchma Hub",
        Callback = function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Patchma-Hub-36193"))()
        end
    }
)

local FeHub =
    HubsTab:CreateButton(
    {
        Name = "Fe Hub",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/gGB65rMr"))()
        end
    }
)

local Button1 =
    HubsTab:CreateButton(
    {
        Name = "Fire X Hub V2",
        Callback = function()
            loadstring(
                "\105\102\32\110\111\116\32\103\97\109\101\58\71\101\116\83\101\114\118\105\99\101\40\34\82\101\112\108\105\99\97\116\101\100\83\116\111\114\97\103\101\34\41\58\70\105\110\100\70\105\114\115\116\67\104\105\108\100\40\34\48\49\95\115\101\114\118\101\114\34\41\32\116\104\101\110\32\114\101\116\117\114\110\32\103\97\109\101\58\71\101\116\83\101\114\118\105\99\101\40\34\84\101\108\101\112\111\114\116\83\101\114\118\105\99\101\34\41\58\84\101\108\101\112\111\114\116\40\49\55\53\55\52\54\49\56\57\53\57\44\32\103\97\109\101\58\71\101\116\83\101\114\118\105\99\101\40\34\80\108\97\121\101\114\115\34\41\46\76\111\99\97\108\80\108\97\121\101\114\41\32\101\110\100\10\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\116\121\114\101\108\116\114\105\106\111\47\102\105\114\101\47\109\97\105\110\47\102\105\114\101\34\41\41\40\41\10"
            )()
        end
    }
)

-----==============-----
OthersTab = Window:CreateTab("Shaders", nil) -- Title, Image

Button =
    OthersTab:CreateButton(
    {
        Name = "Pshade Ultimate",
        Callback = function()
            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua"
                )
            )()
        end
    }
)
