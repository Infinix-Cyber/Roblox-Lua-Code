local p=game.Players.LocalPlayer
if p.Name~="TheLocalMazeV2" then return end

local s=Instance.new("ScreenGui")
s.Name="ZS"
s.ResetOnSpawn=false
s.Parent=p:WaitForChild("PlayerGui")

local bg=Instance.new("Frame")
bg.Size=UDim2.new(1,0,1,0)
bg.BackgroundColor3=Color3.fromRGB(40,40,45)
bg.BackgroundTransparency=0.4
bg.BorderSizePixel=0
bg.Parent=s

local troll=Instance.new("ImageLabel")
troll.Size=UDim2.new(0.8,0,0.8,0)
troll.Position=UDim2.new(0.1,0,0.1,0)
troll.BackgroundTransparency=1
troll.Image="rbxassetid://16040273943"
troll.ImageTransparency=0.7
troll.ScaleType=Enum.ScaleType.Fit
troll.Parent=s

local m=Instance.new("Frame")
m.Size=UDim2.new(0,340,0,300)
m.Position=UDim2.new(0.5,-170,0.5,-150)
m.BackgroundColor3=Color3.fromRGB(50,50,55)
m.BackgroundTransparency=0.1
m.BorderSizePixel=0
m.ClipsDescendants=true
m.Active=true
m.Draggable=true
m.Parent=s

local c=Instance.new("UICorner")
c.CornerRadius=UDim.new(0,12)
c.Parent=m

local h=Instance.new("Frame")
h.Size=UDim2.new(1,0,0,32)
h.BackgroundColor3=Color3.fromRGB(60,60,65)
h.BackgroundTransparency=0.2
h.BorderSizePixel=0
h.Parent=m

local t=Instance.new("TextLabel")
t.Size=UDim2.new(1,-60,1,0)
t.Position=UDim2.new(0,12,0,0)
t.BackgroundTransparency=1
t.Text="ZS | Troll"
t.TextSize=14
t.TextColor3=Color3.fromRGB(220,220,220)
t.Font=Enum.Font.SourceSansBold
t.TextXAlignment=Enum.TextXAlignment.Left
t.Parent=h

local mn=Instance.new("TextButton")
mn.Size=UDim2.new(0,26,0,26)
mn.Position=UDim2.new(1,-56,0,3)
mn.BackgroundTransparency=1
mn.Text="−"
mn.TextSize=18
mn.TextColor3=Color3.fromRGB(200,200,200)
mn.Font=Enum.Font.SourceSansBold
mn.Parent=h

local cl=Instance.new("TextButton")
cl.Size=UDim2.new(0,26,0,26)
cl.Position=UDim2.new(1,-28,0,3)
cl.BackgroundTransparency=1
cl.Text="✕"
cl.TextSize=15
cl.TextColor3=Color3.fromRGB(200,200,200)
cl.Font=Enum.Font.SourceSansBold
cl.Parent=h

local lf=Instance.new("Frame")
lf.Size=UDim2.new(1,-12,1,-75)
lf.Position=UDim2.new(0,6,0,38)
lf.BackgroundColor3=Color3.fromRGB(30,30,35)
lf.BackgroundTransparency=0.2
lf.ClipsDescendants=true
lf.Parent=m

local lc=Instance.new("UICorner")
lc.CornerRadius=UDim.new(0,6)
lc.Parent=lf

local sc=Instance.new("UIScrollingFrame")
sc.Size=UDim2.new(1,0,1,0)
sc.BackgroundTransparency=1
sc.ScrollBarThickness=3
sc.Parent=lf

local ct=Instance.new("Frame")
ct.Size=UDim2.new(1,0,0,0)
ct.BackgroundTransparency=1
ct.Parent=sc

local logs={}
local function add(txt,col)
    col=col or Color3.fromRGB(200,255,220)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,0,0,18)
    l.BackgroundTransparency=1
    l.Text=txt
    l.TextSize=12
    l.TextColor3=col
    l.Font=Enum.Font.SourceSans
    l.TextXAlignment=Enum.TextXAlignment.Left
    l.Parent=ct
    table.insert(logs,l)
    ct.Size=UDim2.new(1,0,0,#logs*18)
    sc.CanvasSize=UDim2.new(0,0,0,#logs*18)
    task.wait()
    sc.ScrollPosition=Vector2.new(0,#logs*18)
end

local inp=Instance.new("TextBox")
inp.Size=UDim2.new(1,-12,0,24)
inp.Position=UDim2.new(0,6,1,-30)
inp.BackgroundColor3=Color3.fromRGB(40,40,45)
inp.BackgroundTransparency=0.2
inp.TextColor3=Color3.fromRGB(255,255,255)
inp.Text=""
inp.TextSize=12
inp.Font=Enum.Font.SourceSans
inp.PlaceholderText="cmd..."
inp.ClearTextOnFocus=false
inp.Parent=m

local ic=Instance.new("UICorner")
ic.CornerRadius=UDim.new(0,5)
ic.Parent=inp

local mn_state=false
mn.MouseButton1Click:Connect(function()
    mn_state=not mn_state
    m:TweenSize(mn_state and UDim2.new(0,340,0,32)or UDim2.new(0,340,0,300),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
    mn.Text=mn_state and "+"or"−"
    lf.Visible=not mn_state
    inp.Visible=not mn_state
end)

cl.MouseButton1Click:Connect(function() s:Destroy() end)

inp.FocusLost:Connect(function(e)
    if e and inp.Text~=""then
        local cmd=inp.Text
        inp.Text=""
        add("> "..cmd,Color3.fromRGB(150,200,255))
        local ok,res=pcall(function()return loadstring(cmd)()end)
        if not ok then add("! "..tostring(res),Color3.fromRGB(255,100,100))
        elseif res~=nil then add(tostring(res),Color3.fromRGB(200,255,200))end
    end
end)

_G.LOADED_URL=nil
_G.LOADED_CODE=nil

local old=loadstring
loadstring=function(code,name)
    local url=code:match("game:HttpGet%s*%(%s*([\"'])(.-)%1%s*%)")
    if not url then url=code:match("game:HttpGetAsync%s*%(%s*([\"'])(.-)%1%s*%)")end
    if not url then url=code:match("HttpService:GetAsync%s*%(%s*([\"'])(.-)%1%s*%)")end
    if url then
        _G.LOADED_URL=url
        add("> "..url,Color3.fromRGB(255,200,100))
        local ok,res=pcall(function()return game:HttpGet(url)end)
        if ok and res then
            _G.LOADED_CODE=res
            add(#res.." bytes",Color3.fromRGB(150,255,150))
            add(res:sub(1,150).."...",Color3.fromRGB(180,255,180))
        else add("x "..tostring(res),Color3.fromRGB(255,100,100))end
    end
    return old(code,name)
end

local skids={
    "nice skid, did you copy that from youtube?",
    "skid alert! this guy uses pastebin scripts",
    "you're not a hacker, you're a skid with google",
    "skid detected: can't even spell 'exploit'",
    "this skid thinks loadstring makes him pro",
    "skid energy: 100%",
    "you're the reason devs hate skids",
    "skid spotted! hide your scripts",
    "this skid uses 'Infinite Yield' unironically",
    "skid: copy, paste, pray",
    "skid mode: active",
    "you're a skid, not a dev",
    "skid alert! he's using free scripts",
    "this skid can't even write a loop",
    "skid: watch 1 tutorial and thinks he's god"
}

local vibes={
    "ai generated code? nice vibe bro",
    "vibecoder detected: you ask ai to do everything",
    "you're not coding, you're prompting",
    "vibecoder: chatgpt is your only friend",
    "this code smells like ai",
    "vibecoder alert! he can't write a single line",
    "you're a vibe coder, not a hacker",
    "vibe coding: ask ai, copy, paste, repeat",
    "vibecoder: your brain is just a prompt",
    "ai wrote this, not you",
    "vibecoder spotted: he thinks ai is hacking",
    "you're not a developer, you're a prompter",
    "vibecoder: chatgpt does 100% of your work",
    "this is ai code and you know it",
    "vibecoder: you're just a middleman for ai"
}

local wannabes={
    "you're not a hacker, you're a clown with a script",
    "hacker? you can't even open cmd",
    "you think using an executor makes you a hacker?",
    "hacker wannabe: copy, paste, cry",
    "you're the reason real hackers laugh",
    "wannabe detected: he thinks gui = hacking",
    "you're not hacking, you're just annoying",
    "hacker? you're a script kiddie with attitude",
    "wannabe: watches 1 youtube video and goes crazy",
    "you're not a hacker, you're a spectator",
    "hacker wannabe: all gui, no brain",
    "you're the clown of the server",
    "wannabe: thinks loadstring is a spell",
    "you're not a hacker, you're a copypaster",
    "hacker? you're the reason devs laugh"
}

local male_insults={
    "get off me you brainless sack of meat",
    "you're so trash you make baseplate look smart",
    "even byfron doesn't care about you",
    "you're the final boss of stupidity",
    "your iq is lower than my fps",
    "you're not a player, you're a bug",
    "go back to brookhaven you npc",
    "you're so bad even your alt mocks you",
    "you're like a remoteevent without args",
    "your skill is a null value",
    "you're the reason devs add anti-cheat",
    "you're not gaming, you're lagging with ego",
    "even a bot would outplay you",
    "you're a walking syntax error",
    "your brain is a memory leak",
    "you're the clown of the lobby",
    "go touch grass you absolute failure",
    "you're a script without pcall",
    "your existence is a false positive",
    "you're so bad you make me lag",
    "you're the reason people turn off chat",
    "you're not a threat, you're a notification",
    "even a baseplate has more moves than you",
    "you're like a free model — broken and useless",
    "you're the player everyone kicks on sight"
}

local female_names={
    "Emily","Emma","Olivia","Ava","Sophia","Isabella","Mia","Charlotte","Amelia","Harper",
    "Evelyn","Abigail","Ella","Ella","Grace","Victoria","Aria","Lily","Chloe","Eleanor",
    "Hannah","Addison","Nora","Luna","Savannah","Aubrey","Ellie","Stella","Zoe","Leah",
    "Hazel","Violet","Aurora","Lucy","Anna","Maya","Natalie","Lila","Eliza","Rose",
    "Sarah","Alice","Claire","Sophie","Elena","Cora","Lydia","Jade","Ivy","Mila"
}

local function is_female(name)
    for _,n in ipairs(female_names)do
        if name:match(n)then return true end
    end
    return false
end

local function random_from(t)
    return t[math.random(1,#t)]
end

local function get_insult(target)
    local name=target.Name
    if is_female(name) then return nil end
    return random_from(male_insults)
end

task.spawn(function()
    while task.wait(2) do
        local char=p.Character
        if not char then continue end
        local hrp=char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        for _,plr in ipairs(game.Players:GetPlayers())do
            if plr~=p and plr.Character then
                local target=plr.Character:FindFirstChild("HumanoidRootPart")
                if target then
                    local dist=(hrp.Position-target.Position).Magnitude
                    if dist<4 then
                        local msg=get_insult(plr)
                        if msg then
                            add("!"..plr.Name..": "..msg,Color3.fromRGB(255,100,100))
                        end
                    end
                end
            end
        end
    end
end)

local function chat_defender()
    local chat=game:GetService("Chat")
    if not chat then return end

    local triggers={
        "ai","chatgpt","gpt","vibecoder","skid","copypaste","pastebin",
        "тупой","ии","гпт","нейросеть","бот","читер","халявщик","дигинират",
        "diginirat","scriptkiddie","copy","paste","youtube","tutorial",
        "noob","bad","trash","garbage","fake","cheater","hacker","lol","lmao",
        "no skill","ez","rekt","owned","get good","ggez","cry","mad","salt",
        "sad","loser","failure","clown","joke","useless","worthless","npc",
        "bot","auto","script","loadstring","executor","exploit","cheat",
        "modded","hacked","cracked","stolen","leaked","free","cheap","broken"
    }

    local responses={
        "cry about it, skid. your code is worse than my AI.",
        "at least my AI works. your brain doesn't.",
        "you're just mad you can't write a single line without youtube.",
        "imagine calling AI bad when you use pastebin scripts LMAO.",
        "keep coping, copypaster. I own you.",
        "you're the reason devs add anti-cheat. and it still doesn't help.",
        "my AI > your IQ. facts.",
        "you're not a hacker, you're a spectator with opinions.",
        "skid alert! this guy thinks he's relevant.",
        "you're so bad even AI feels sorry for you.",
        "I'd explain it to you, but you wouldn't understand.",
        "you're like a free model — broken and useless.",
        "imagine talking trash when you can't even exploit properly.",
        "you're the final boss of being wrong.",
        "my code is cleaner than your entire existence.",
        "you're not worth a real response, but here you go.",
        "keep talking, I'll keep owning.",
        "you're the clown of this server. literally.",
        "I've seen better code in a 2016 free model.",
        "you're not a threat, you're a notification.",
        "you're so irrelevant even the chat ignores you.",
        "my AI has more skill than you.",
        "you're the reason people mute chat.",
        "imagine being this mad over a script LMAO.",
        "you're not a hacker, you're a spectator with a keyboard.",
        "cope harder, skid. it's free.",
        "you're the type to use 'Infinite Yield' and still lose.",
        "my AI would ban you if it could.",
        "you're like a RemoteEvent — always failing.",
        "keep crying, I'll keep winning.",
        "you're not even worth the bandwidth.",
        "your opinion is as useful as a null value.",
        "I'd say 'stay mad' but you're already there.",
        "you're the reason I have a mute button.",
        "imagine thinking you're relevant in 2026.",
        "you're a bug in real life.",
        "my code > your entire existence.",
        "you're the clown of the lobby. period.",
        "keep talking, I'm collecting L's from you.",
        "you're not a hacker — you're a spectator with a mic.",
        "my AI is smarter than your whole bloodline.",
        "you're so bad even your alts pity you.",
        "imagine being this pressed over a script.",
        "you're the human version of a syntax error.",
        "I'd explain, but you wouldn't get it.",
        "you're not worth the time, but here I am.",
        "keep coping, it's entertaining.",
        "you're the reason devs drink.",
        "my AI has more wins than you.",
        "you're not a threat, you're a feature.",
        "you're the reason I don't play this game seriously.",
        "imagine being mad at a script. couldn't be me.",
        "you're like a null value — useless and ignored.",
        "my AI > your whole existence.",
        "you're not a player, you're a placeholder.",
        "I'd say 'skill issue' but you'd need skill first.",
        "you're the type to blame lag for your failures.",
        "keep talking, I'm taking notes for my next script.",
        "you're not a hacker, you're a spectator with a chat box.",
        "my AI has more personality than you.",
        "you're the reason I use /mute.",
        "imagine being this salty over a game.",
        "you're like a broken script — always crashing.",
        "my code is worth more than your account.",
        "you're the clown of the server, and it's not even close.",
        "keep coping, I'm already winning.",
        "you're not a threat, you're a comic relief.",
        "my AI would roast you harder, but it's not worth it.",
        "you're the reason people use /ignore.",
        "imagine thinking you can outsmart my AI. LMAO.",
        "you're not a hacker, you're a spectator with a dream.",
        "my code > your entire setup.",
        "you're the reason devs add captcha.",
        "keep crying, I'm still here.",
        "you're like a free model — everyone uses you and nobody respects you.",
        "my AI has more braincells than you.",
        "you're not a player, you're a bug report.",
        "imagine being this irrelevant.",
        "you're the reason I don't play with randoms.",
        "my code is cleaner than your chat history.",
        "you're not a hacker, you're a spectator with a mic.",
        "keep talking, I'm farming your L's.",
        "you're the reason I use scripts — to avoid players like you.",
        "my AI > your skill issue.",
        "you're not a threat, you're a joke.",
        "imagine being this mad over a script. couldn't be me.",
        "you're like a RemoteEvent — always failing and everyone knows it.",
        "my code has more value than your opinion.",
        "you're the clown of the lobby, and you don't even know it.",
        "keep coping, I'm already in your head.",
        "you're not a hacker, you're a spectator with a keyboard.",
        "my AI is undefeated. you're not.",
        "you're the reason I don't take this game seriously.",
        "imagine being this pressed over a free script.",
        "you're like a null value — ignored and useless.",
        "my code > your whole existence. period.",
        "you're not a player, you're a placeholder.",
        "keep talking, I'm collecting your L's.",
        "you're the reason I use /mute. and it's not even close.",
        "my AI has more wins than you.",
        "you're not a threat, you're a notification.",
        "imagine being this salty over a game. couldn't be me.",
        "you're like a broken script — always crashing and nobody cares.",
        "my code is worth more than your account.",
        "you're the clown of the server, and it's not even close.",
        "keep coping, I'm already winning.",
        "you're not a hacker, you're a spectator with a dream.",
        "my AI > your entire setup.",
        "you're the reason devs add captcha.",
        "keep crying, I'm still here.",
        "you're like a free model — everyone uses you and nobody respects you.",
        "my AI has more braincells than you.",
        "you're not a player, you're a bug report.",
        "imagine being this irrelevant.",
        "you're the reason I don't play with randoms.",
        "my code is cleaner than your chat history.",
        "you're not a hacker, you're a spectator with a mic.",
        "keep talking, I'm farming your L's.",
        "you're the reason I use scripts — to avoid players like you.",
        "my AI > your skill issue.",
        "you're not a threat, you're a joke."
    }

    local function is_insult(msg)
        msg=msg:lower()
        for _,word in ipairs(triggers)do
            if msg:find(word)then return true end
        end
        return false
    end

    local function get_response()
        return responses[math.random(1,#responses)]
    end

    local say_event=game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest")
    if say_event then
        local old=say_event.OnServerEvent
        say_event.OnServerEvent=function(player,msg,...)
            if player~=p and is_insult(msg)then
                task.wait(0.3)
                say_event:FireServer(get_response(),"All")
                add("⚡ "..player.Name.." → "..get_response(),Color3.fromRGB(255,200,100))
            end
            return old and old(player,msg,...)
        end
    end
end

task.spawn(chat_defender)

for _,b in ipairs(game:GetDescendants())do
    if b:IsA("TextButton")and b.MouseButton1Click then
        local old=b.MouseButton1Click
        b.MouseButton1Click=function(...)
            local msgs={skids,vibes,wannabes}
            add("c "..b.Name,Color3.fromRGB(200,200,255))
            add("! "..random_from(msgs[math.random(1,3)]),Color3.fromRGB(255,150,100))
            return old and old(...)
        end
    end
end

function show()
    add("URL: "..tostring(_G.LOADED_URL),Color3.fromRGB(200,255,200))
    if _G.LOADED_CODE then
        add("CODE: "..#_G.LOADED_CODE.." bytes",Color3.fromRGB(200,255,200))
    else add("CODE: nil",Color3.fromRGB(255,200,200))end
end

function clear()
    for _,l in ipairs(logs)do l:Destroy()end
    logs={}
    ct.Size=UDim2.new(1,0,0,0)
    sc.CanvasSize=UDim2.new(0,0,0,0)
    add("cleared",Color3.fromRGB(150,150,150))
end

add("ZS | Troll Edition",Color3.fromRGB(200,200,200))
add("show() | clear()",Color3.fromRGB(150,200,255))
add("---",Color3.fromRGB(80,80,80))
