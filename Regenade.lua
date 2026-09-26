--//Options
local Global=(getgenv and getgenv()) or shared
local CAMERAFOCUS="BestFittingBlack"  -- Actual Accessory name
local INTROANIM=false -- set it to true if want an intro animation
local LEGACY=false -- set this to true if you the old anims on some modes






















function notify(text,dur)
local Notify=game:GetService("StarterGui")
Notify:SetCore("SendNotification",{
Title="Renegades";
Text=text})
Duration=.5 or dur
end

local CollectionService = game:GetService("CollectionService");
local RENEGADES ={};
local plrgui=game.CoreGui
local gui=plrgui:FindFirstChild("Renegade Glitcher")
if gui then
gui:Destroy()
end
RENEGADES["Renegade Glitcher_1"]= Instance.new("ScreenGui",plrgui);
RENEGADES["Renegade Glitcher_1"]["Name"]=[[Renegade Glitcher]];
RENEGADES["Renegade Glitcher_1"]["ZIndexBehavior"]= Enum.ZIndexBehavior.Sibling;

CollectionService:AddTag(RENEGADES["Renegade Glitcher_1"],[[main]]);

RENEGADES["MainFrame_2"]= Instance.new("Frame", RENEGADES["Renegade Glitcher_1"]);
RENEGADES["MainFrame_2"]["BorderSizePixel"]= 0;
RENEGADES["MainFrame_2"]["BackgroundColor3"]= Color3.fromRGB(50, 50, 50);
RENEGADES["MainFrame_2"]["Size"]= UDim2.new(0, 340, 0, 216);
RENEGADES["MainFrame_2"]["Position"]= UDim2.new(0, 230, 0, 14);
RENEGADES["MainFrame_2"]["Name"]=[[MainFrame]];
RENEGADES["MainFrame_2"]["Draggable"]=true;
RENEGADES["MainFrame_2"]["Active"]=true;
RENEGADES["MainFrame_2"]["BackgroundTransparency"]= 0.5;


RENEGADES["Extras_3"]= Instance.new("UICorner", RENEGADES["MainFrame_2"]);
RENEGADES["Extras_3"]["Name"]=[[Extras]];


RENEGADES["Extras_4"]= Instance.new("UIStroke", RENEGADES["MainFrame_2"]);
RENEGADES["Extras_4"]["Transparency"]= 0.5;
RENEGADES["Extras_4"]["Name"]=[[Extras]];
RENEGADES["Extras_4"]["Thickness"]= 5;


RENEGADES["Reanimate/Run_5"]= Instance.new("TextButton", RENEGADES["MainFrame_2"]);
RENEGADES["Reanimate/Run_5"]["BorderSizePixel"]= 0;
RENEGADES["Reanimate/Run_5"]["TextXAlignment"]= Enum.TextXAlignment.Left;
RENEGADES["Reanimate/Run_5"]["TextSize"]= 18;
RENEGADES["Reanimate/Run_5"]["TextColor3"]= Color3.fromRGB(255, 255, 255);
RENEGADES["Reanimate/Run_5"]["BackgroundColor3"]= Color3.fromRGB(25, 25, 25);
RENEGADES["Reanimate/Run_5"]["FontFace"]= Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
RENEGADES["Reanimate/Run_5"]["BackgroundTransparency"]= 0.5;
RENEGADES["Reanimate/Run_5"]["Size"]= UDim2.new(0, 92, 0, 34);
RENEGADES["Reanimate/Run_5"]["Text"]=[[Reanim/Run]];
RENEGADES["Reanimate/Run_5"]["Name"]=[[Reanimate/Run]];
RENEGADES["Reanimate/Run_5"]["Position"]= UDim2.new(0, 8, 0, 110);


RENEGADES["Extras_6"]= Instance.new("UICorner", RENEGADES["Reanimate/Run_5"]);
RENEGADES["Extras_6"]["Name"]=[[Extras]];


RENEGADES["Stop_7"]= Instance.new("TextButton", RENEGADES["MainFrame_2"]);
RENEGADES["Stop_7"]["BorderSizePixel"]= 0;
RENEGADES["Stop_7"]["TextXAlignment"]= Enum.TextXAlignment.Left;
RENEGADES["Stop_7"]["TextSize"]= 18;
RENEGADES["Stop_7"]["TextColor3"]= Color3.fromRGB(255, 255, 255);
RENEGADES["Stop_7"]["BackgroundColor3"]= Color3.fromRGB(25, 25, 25);
RENEGADES["Stop_7"]["FontFace"]= Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
RENEGADES["Stop_7"]["BackgroundTransparency"]= 0.5;
RENEGADES["Stop_7"]["Size"]= UDim2.new(0, 42, 0, 34);
RENEGADES["Stop_7"]["Text"]=[[Stop]];
RENEGADES["Stop_7"]["Name"]=[[Stop]];
RENEGADES["Stop_7"]["Position"]= UDim2.new(0, 8, 0, 150);


RENEGADES["Extras_8"]= Instance.new("UICorner", RENEGADES["Stop_7"]);
RENEGADES["Extras_8"]["Name"]=[[Extras]];


RENEGADES["About_9"]= Instance.new("TextLabel", RENEGADES["MainFrame_2"]);
RENEGADES["About_9"]["TextWrapped"]= true;
RENEGADES["About_9"]["BorderSizePixel"]= 0;
RENEGADES["About_9"]["TextSize"]= 15;
RENEGADES["About_9"]["TextXAlignment"]= Enum.TextXAlignment.Left;
RENEGADES["About_9"]["TextYAlignment"]= Enum.TextYAlignment.Top;
RENEGADES["About_9"]["BackgroundColor3"]= Color3.fromRGB(25, 25, 25);
RENEGADES["About_9"]["FontFace"]= Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
RENEGADES["About_9"]["TextColor3"]= Color3.fromRGB(255, 255, 255);
RENEGADES["About_9"]["BackgroundTransparency"]= 0.5;
RENEGADES["About_9"]["Size"]= UDim2.new(0, 214, 0, 100);
RENEGADES["About_9"]["BorderColor3"]= Color3.fromRGB(13, 20, 25);
RENEGADES["About_9"]["Text"]=[[Update: Censored Coloring fix]];
RENEGADES["About_9"]["Name"]=[[About]];
RENEGADES["About_9"]["Position"]= UDim2.new(0, 118, 0, 4);


RENEGADES["Extras_a"]= Instance.new("UICorner", RENEGADES["About_9"]);
RENEGADES["Extras_a"]["Name"]=[[Extras]];


RENEGADES["Title_b"]= Instance.new("TextLabel", RENEGADES["MainFrame_2"]);
RENEGADES["Title_b"]["TextWrapped"]= true;
RENEGADES["Title_b"]["BorderSizePixel"]= 0;
RENEGADES["Title_b"]["TextSize"]= 24;
RENEGADES["Title_b"]["BackgroundColor3"]= Color3.fromRGB(25, 25, 25);
RENEGADES["Title_b"]["FontFace"]= Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
RENEGADES["Title_b"]["TextColor3"]= Color3.fromRGB(255, 255, 255);
RENEGADES["Title_b"]["BackgroundTransparency"]= 0.5;
RENEGADES["Title_b"]["Size"]= UDim2.new(0, 212, 0, 44);
RENEGADES["Title_b"]["BorderColor3"]= Color3.fromRGB(13, 20, 25);
RENEGADES["Title_b"]["Text"]=[[Renegade Glitcher ]];
RENEGADES["Title_b"]["Name"]=[[Title]];
RENEGADES["Title_b"]["Position"]= UDim2.new(0, 120, 0, 108);


RENEGADES["Extras_c"]= Instance.new("UICorner", RENEGADES["Title_b"]);
RENEGADES["Extras_c"]["Name"]=[[Extras]];


RENEGADES["OpenGui_d"]= Instance.new("TextButton", RENEGADES["Renegade Glitcher_1"]);
RENEGADES["OpenGui_d"]["BorderSizePixel"]= 0;
RENEGADES["OpenGui_d"]["BackgroundColor3"]= Color3.fromRGB(50, 50, 50);
RENEGADES["OpenGui_d"]["BackgroundTransparency"]= 0.65;
RENEGADES["OpenGui_d"]["Size"]= UDim2.new(0, 25, 0, 25);
RENEGADES["OpenGui_d"]["Text"]=[[]];
RENEGADES["OpenGui_d"]["Name"]=[[OpenGui]];
RENEGADES["OpenGui_d"]["Position"]= UDim2.new(0, 0, 0, 150);


RENEGADES["Extras_e"]= Instance.new("UICorner", RENEGADES["OpenGui_d"]);
RENEGADES["Extras_e"]["Name"]=[[Extras]];
RENEGADES["Extras_e"]["CornerRadius"]= UDim.new(0, 50);


local RunScript=RENEGADES["Reanimate/Run_5"]
local StopRunningScript=RENEGADES["Stop_7"]
local opengui=RENEGADES["OpenGui_d"]
local mainframe=RENEGADES["MainFrame_2"]
local uis=game.UserInputService
mainframe.Draggable=true
Global.RigHead=CAMERAFOCUS

if isfolder and not isfolder("Renegade Assets") then 
makefolder("Renegade Assets")
end


--// Variables
local osclock=os.clock
local char=game.Players.LocalPlayer.Character
local tspawn=task.spawn
local twait=task.wait
local schar=string.char
local ssub=string.sub
local sfind=string.find
local supper=string.upper
local mrandom=math.random
local sin=math.sin
local cos=math.cos
local abs=math.abs
local rad=math.rad
local min=math.min
local clamp=math.clamp
local tinsert=table.insert
local tclear=table.clear
local tclone=table.clone
local tfind=table.find
local tunpack=table.unpack
local next=next
local pcall=pcall
local xpcall=xpcall
local type=type
local typeof=typeof
local game=game
local i=Instance.new 
local v2=Vector2.new 
local v3=Vector3.new
local c3=Color3.new 
local cf=CFrame.new
local cfl=CFrame.lookAt
local angles=CFrame.Angles
local u2=UDim2.new 
local e=Enum 
local rp=RaycastParams.new 
local cs=ColorSequence.new 
local csk=ColorSequenceKeypoint.new 
local sine=osclock()
local v3_0=v3(0,0,0)
local v3_101=v3(1,0,1)
local v3_010=v3(0,1,0)
local v3_001=v3(0,0,1)
local cf_0=cf(0,0,0)
local v3_xz=v3_101*10
local v3_xzL=v3_101*250.1
local v3_net=v3_010*25.01
local function rs(l)
l=l or mrandom(8,15)
local s=""
for i=1,l do 
if mrandom(1,2)==1 then 
s=s..schar(mrandom(65,90))
else 
s=s..schar(mrandom(97,122))
end 
end 
return s 
end
local function getMetamethodFromErrorStack(userdata,f,test)
local ret=nil
xpcall(f,function()
ret=debug.info(2,"f")
end,userdata,nil,0)
if (type(ret)~="function") or not test(ret) then
return f
end
return ret
end
local insSet=getMetamethodFromErrorStack(game,function(a,b,c) a[b]=c end,function(f) local a=i("Folder") local b=rs() f(a,"Name",b) return a.Name==b end)
local insGet=getMetamethodFromErrorStack(game,function(a,b) return a[b] end,function(f) local a=i("Folder") local b=rs() a.Name=b return f(a,"Name")==b end)
local cfGet=getMetamethodFromErrorStack(cf_0,function(a,b) return a[b] end,function(f) return f(cf(1,2,3),"Position")==v3(1,2,3) end)
local cfMul=getMetamethodFromErrorStack(cf_0,function(a,b) return a*b end,function(f) return angles(1,2,3)*angles(1,2,3)==f(angles(1,2,3),angles(1,2,3)) end)
local cfAdd=getMetamethodFromErrorStack(cf_0,function(a,b) return a+b end,function(f) return cf(1,2,3)+v3(1,2,3)==f(cf(1,2,3),v3(1,2,3)) end)
local v3Get=getMetamethodFromErrorStack(v3_0,function(a,b) return a[b] end,function(f) return v3(1,2,3).Unit==f(v3(1,2,3),"Unit") end)
local Clone=insGet(game,"Clone")
local ClearAllChildren=insGet(game,"ClearAllChildren")
local IsA=insGet(game,"IsA")
local FindFirstChildOfClass=insGet(game,"FindFirstChildOfClass")
local FindFirstChildWhichIsA=insGet(game,"FindFirstChildWhichIsA")
local GetChildren=insGet(game,"GetChildren")
local GetDescendants=insGet(game,"GetDescendants")
local IsDescendantOf=insGet(game,"IsDescendantOf")
local GetPropertyChangedSignal=insGet(game,"GetPropertyChangedSignal")
local plrs=FindFirstChildOfClass(game,"Players")
local rus=FindFirstChildOfClass(game,"RunService")
local ws=FindFirstChildOfClass(game,"Workspace")
local uis=FindFirstChildOfClass(game,"UserInputService")
local gs=FindFirstChildOfClass(game,"GuiService")
local lp=insGet(plrs,"LocalPlayer")
local pg=FindFirstChildOfClass(lp,"PlayerGui")
local mouse=insGet(lp,"GetMouse")(lp)
local stepped=insGet(rus,"Stepped")
local heartbeat=insGet(rus,"Heartbeat")
local renderstepped=insGet(rus,"RenderStepped")
local GetPlayers=insGet(plrs,"GetPlayers")
local Raycast=insGet(ws,"Raycast")
local Connect=heartbeat.Connect
local Disconnect=Connect(GetPropertyChangedSignal(game,"CreatorId"),type).Disconnect
local Wait=heartbeat.Wait
local GetMouseLocation=insGet(uis,"GetMouseLocation")
local GetFocusedTextBox=insGet(uis,"GetFocusedTextBox")
local GetMouseDelta=insGet(uis,"GetMouseDelta")
local IsMouseButtonPressed=insGet(uis,"IsMouseButtonPressed")
local IsKeyDown=insGet(uis,"IsKeyDown")
local Inverse=cfGet(cf_0,"Inverse")
local Lerp=cfGet(cf_0,"Lerp")
local function Chat(Message)
game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(Message)
end

--// Reanimate
local FOLDER="Patchma Reanimate"
if isfolder and not isfolder(FOLDER) then
makefolder(FOLDER)
end
local FILE="Reanimate.lua"
local PatchmaRenimUrl ="https://raw.githubusercontent.com/ilikeices/animated/refs/heads/main/PatchmaRenim.lua"
if isfile and not isfile(FOLDER.."/"..FILE) then
writefile(FOLDER.."/"..FILE,game:HttpGet(PatchmaRenimUrl))
end
local PatchmaSuccess, Patchma = pcall(function()
 return loadstring(readfile(FOLDER.."/"..FILE))()
end)

if not PatchmaSuccess then
 Patchma ={
 Reanim = function()
 return {
 cframes ={},
 joints ={},
 fling = function() end,
 predictionfling = function() end,
 refreshjoints = function() end,
 raycastlegs = function() return 0, 0 end,
 velbycfrvec = function() return 0, 0 end,
 velchgbycfrvec = function() return 0, 0 end,
 velYchg = function() return 0 end,
 addmode = function() end,
 getPart = function() return nil end,
 getPartFromMesh = function() return nil end,
 getAccWeldFromMesh = function() return nil end,
 getJoint = function() return {C0 = CFrame.new(), C1 = CFrame.new()} end,
 getPartJoint = function() return {C0 = CFrame.new()} end,
 rotToMouse = function() end,
 glitchJoint = function() return 0 end,
 setWalkSpeed = function() end,
 setJumpPower = function() end,
 setGravity = function() end,
 setCfr = function() end,
 getVel = function() return Vector3.new() end,
 getCamCF = function() return CFrame.new() end,
 isFirstPerson = function() return false end,
 IsWalking = function() return false end
}
 end,
 stopreanimate = function() end
}
end

--// Misc
local reanimate = Patchma.Reanim
local stopreanimate = Patchma.stopreanimate
local Running=false
local IsRendering=nil
local IsRendering1=nil
local IsKeys=nil
local deltaTime=.25
local GuiOpened=true
local Mode="None"
local ClockTicky=0
local Constant=1
local Boost=1
local BBGVisibilty=true
Weld = nil
Animate1 = nil
Weld1=nil

MainWeld=nil
MainWeld1=nil
 plr=game.Players.LocalPlayer
 PanoramaWeldUpdater = nil
if game.SoundService:FindFirstChild("GlitcherAudioPlayer") then
game.SoundService.GlitcherAudioPlayer:Destroy()
end

--// Main Script
function MainScript()
if Running then print("Already Running.") return end 
Running=true
local t=reanimate()
if type(t)~="table" then  
print("Script Already Running")
return 
end
--// Necessary Variables
local getPart=t.getPart
local idle=true 
local velYchg=t.velYchg 
local raycastlegs=t.raycastlegs
local velbycfrvec=t.velbycfrvec
local setWalkSpeed=t.setWalkSpeed
local walking=false
local rgb=Color3.fromRGB
local Player=game.Players.LocalPlayer
local getVel = t.getVel
local IsWalking=t.IsWalking
local getJoint=t.getJoint
local setCfr=t.setCfr
local getPart=t.getPart
local onnewcamera=t.onnewcamera
local SoundService=game.SoundService
if game.SoundService:FindFirstChild("GlitcherAudioPlayer") then
game.SoundService.GlitcherAudioPlayer:Destroy()
end


--// Spinny thing and interface
local basgui = Instance.new("GuiMain",plrgui)
basgui.Name = "VISgui"
local FSCREEN = Instance.new("Frame")
FSCREEN.Parent = basgui
FSCREEN.BackgroundColor3 = Color3.new(255, 255, 255)
FSCREEN.BackgroundTransparency = 1
FSCREEN.BorderColor3 = Color3.new(17, 17, 17)
FSCREEN.Size = UDim2.new(1, 0, 1, 0)
FSCREEN.Position = UDim2.new(0, 0, 0, 0)
local imag1 = Instance.new("ImageLabel",FSCREEN)
imag1.BackgroundTransparency = 1
imag1.BorderSizePixel = 0
imag1.ImageTransparency = 0.5
imag1.ImageColor3 = Color3.new(1,1,1)
imag1.Position = UDim2.new(.75,25,.55,25)
imag1.Size = UDim2.new(0,550,0,550)
imag1.Image = "rbxassetid://2076519836"
local imag2 = imag1:Clone()
imag2.Parent = FSCREEN
imag2.ImageTransparency = 0
imag2.Size = UDim2.new(0,800,0,800)
imag2.Position = UDim2.new(0.75,-100,0.55,-100)
imag2.ImageColor3 = Color3.new(1,1,1)
imag2.Image = "rbxassetid://2076458450"
local imag3 = imag2:Clone()
imag3.Parent = FSCREEN
imag3.ImageTransparency = 0
imag3.Size = UDim2.new(0,900,0,900)
imag3.Position = UDim2.new(0.75,-150,0.55,-155)
imag3.ImageColor3 = Color3.new(0,0,0)
imag3.Image = "rbxassetid://2092248396"
local imag4 = imag2:Clone()
imag4.Parent = FSCREEN
imag4.ImageTransparency = 0
imag4.Size = UDim2.new(0,700,0,700)
imag4.Position = UDim2.new(0.75,-50,0.55,-50)
imag4.ImageColor3 = Color3.new(1,1,1)
imag4.Image = "rbxassetid://2076519836"



--// Interface 
local GLITCHERAUDIO = {};
GLITCHERAUDIO["MainGui_1"] = Instance.new("ScreenGui", FSCREEN);

GLITCHERAUDIO["MainGui_1"]["Name"] = [[MainGui]];
GLITCHERAUDIO["MainGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
GLITCHERAUDIO["MainGui_1"]["ResetOnSpawn"] = false;

CollectionService:AddTag(GLITCHERAUDIO["MainGui_1"], [[main]]);

GLITCHERAUDIO["TopFrame_2"] = Instance.new("Frame", GLITCHERAUDIO["MainGui_1"]);
GLITCHERAUDIO["TopFrame_2"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["TopFrame_2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["TopFrame_2"]["Size"] = UDim2.new(0, 212, 0, 98);
GLITCHERAUDIO["TopFrame_2"]["Position"] = UDim2.new(0, 650, 0, -70);
GLITCHERAUDIO["TopFrame_2"]["Name"] = [[TopFrameBars]];
GLITCHERAUDIO["TopFrame_2"]["Rotation"] = 45;


GLITCHERAUDIO["TopFrame_3"] = Instance.new("UIStroke", GLITCHERAUDIO["TopFrame_2"]);
GLITCHERAUDIO["TopFrame_3"]["Transparency"] = 0.5;
GLITCHERAUDIO["TopFrame_3"]["Name"] = [[TopFrameBars]];
GLITCHERAUDIO["TopFrame_3"]["Thickness"] = 5;


GLITCHERAUDIO["MusicFrame_4"] = Instance.new("Frame", GLITCHERAUDIO["MainGui_1"]);
GLITCHERAUDIO["MusicFrame_4"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["MusicFrame_4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["MusicFrame_4"]["Size"] = UDim2.new(0, 330, 0, 16);
GLITCHERAUDIO["MusicFrame_4"]["Position"] = UDim2.new(0, 2, 0, 258);
GLITCHERAUDIO["MusicFrame_4"]["Name"] = [[MusicFrame]];
GLITCHERAUDIO["MusicFrame_4"]["BackgroundTransparency"] = 0.25;


GLITCHERAUDIO["AudioDur_5"] = Instance.new("UIStroke", GLITCHERAUDIO["MusicFrame_4"]);
GLITCHERAUDIO["AudioDur_5"]["Transparency"] = 0.5;
GLITCHERAUDIO["AudioDur_5"]["Name"] = [[AudioDur]];
GLITCHERAUDIO["AudioDur_5"]["Thickness"] = 2.5;


GLITCHERAUDIO["MusicName_6"] = Instance.new("TextLabel", GLITCHERAUDIO["MusicFrame_4"]);
GLITCHERAUDIO["MusicName_6"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["MusicName_6"]["TextSize"] = 24;
GLITCHERAUDIO["MusicName_6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
GLITCHERAUDIO["MusicName_6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["MusicName_6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
GLITCHERAUDIO["MusicName_6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["MusicName_6"]["BackgroundTransparency"] = 1;
GLITCHERAUDIO["MusicName_6"]["Size"] = UDim2.new(0, 68, 0, 22);
GLITCHERAUDIO["MusicName_6"]["Text"] = [[N/A]];
GLITCHERAUDIO["MusicName_6"]["AutomaticSize"] = Enum.AutomaticSize.X;
GLITCHERAUDIO["MusicName_6"]["Name"] = [[MusicName]];
GLITCHERAUDIO["MusicName_6"]["Position"] = UDim2.new(0,0,0,-90);


GLITCHERAUDIO["MusicDuration_7"] = Instance.new("TextLabel", GLITCHERAUDIO["MusicFrame_4"]);
GLITCHERAUDIO["MusicDuration_7"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["MusicDuration_7"]["TextSize"] = 24;
GLITCHERAUDIO["MusicDuration_7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
GLITCHERAUDIO["MusicDuration_7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["MusicDuration_7"]["FontFace"] = Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
GLITCHERAUDIO["MusicDuration_7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["MusicDuration_7"]["BackgroundTransparency"] = 1;
GLITCHERAUDIO["MusicDuration_7"]["Size"] = UDim2.new(0, 80, 0, 22);
GLITCHERAUDIO["MusicDuration_7"]["Text"] = [[0 / ----]];
GLITCHERAUDIO["MusicDuration_7"]["AutomaticSize"] = Enum.AutomaticSize.X;
GLITCHERAUDIO["MusicDuration_7"]["Name"] = [[MusicDuration]];
GLITCHERAUDIO["MusicDuration_7"]["Position"] = UDim2.new(0, 2, 0, -26);


GLITCHERAUDIO["Lol_8"] = Instance.new("ImageLabel", GLITCHERAUDIO["MusicFrame_4"]);
GLITCHERAUDIO["Lol_8"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["Lol_8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
-- GLITCHERAUDIO["Lol_8"]["ImageContent"] = ;
GLITCHERAUDIO["Lol_8"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
GLITCHERAUDIO["Lol_8"]["Image"] = [[rbxassetid://2076519836]];
GLITCHERAUDIO["Lol_8"]["Size"] = UDim2.new(0, 15, 0, 15);
GLITCHERAUDIO["Lol_8"]["BackgroundTransparency"] = 1;
GLITCHERAUDIO["Lol_8"]["Name"] = [[Lol]];


GLITCHERAUDIO["Lol1_9"] = Instance.new("ImageLabel", GLITCHERAUDIO["MusicFrame_4"]);
GLITCHERAUDIO["Lol1_9"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["Lol1_9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
-- GLITCHERAUDIO["Lol1_9"]["ImageContent"] = ;
GLITCHERAUDIO["Lol1_9"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
GLITCHERAUDIO["Lol1_9"]["Image"] = [[rbxassetid://2076458450]];
GLITCHERAUDIO["Lol1_9"]["Size"] = UDim2.new(0, 20, 0, 20);
GLITCHERAUDIO["Lol1_9"]["BackgroundTransparency"] = 1;
GLITCHERAUDIO["Lol1_9"]["Name"] = [[Lol1]];
GLITCHERAUDIO["Lol1_9"]["Position"] = UDim2.new(0, -2, 0, -2);


GLITCHERAUDIO["MusicDur_a"] = Instance.new("Frame", GLITCHERAUDIO["MusicFrame_4"]);
GLITCHERAUDIO["MusicDur_a"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["MusicDur_a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
GLITCHERAUDIO["MusicDur_a"]["Size"] = UDim2.new(0, 5, 0, 5);
GLITCHERAUDIO["MusicDur_a"]["Position"] = UDim2.new(0, 5, 0, 5);
GLITCHERAUDIO["MusicDur_a"]["Name"] = [[MusicDur]];
GLITCHERAUDIO["MusicDur_a"]["BackgroundTransparency"] = 0.25;


GLITCHERAUDIO["UICorner_b"] = Instance.new("UICorner", GLITCHERAUDIO["MusicDur_a"]);
GLITCHERAUDIO["UICorner_b"]["CornerRadius"] = UDim.new(0, 50);


GLITCHERAUDIO["ModeInfoFrame_c"] = Instance.new("Frame", GLITCHERAUDIO["MainGui_1"]);
GLITCHERAUDIO["ModeInfoFrame_c"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["ModeInfoFrame_c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["ModeInfoFrame_c"]["Size"] = UDim2.new(0, 216, 0, 30);
GLITCHERAUDIO["ModeInfoFrame_c"]["Position"] = UDim2.new(0, 2, 0, 194);
GLITCHERAUDIO["ModeInfoFrame_c"]["Name"] = [[ModeInfoFrame]];
GLITCHERAUDIO["ModeInfoFrame_c"]["BackgroundTransparency"] = 0.25;


GLITCHERAUDIO["UIGradient_d"] = Instance.new("UIGradient", GLITCHERAUDIO["ModeInfoFrame_c"]);
GLITCHERAUDIO["UIGradient_d"]["Rotation"] = 180;
GLITCHERAUDIO["UIGradient_d"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 2.35713),NumberSequenceKeypoint.new(1.000, 0)};
GLITCHERAUDIO["UIGradient_d"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.698, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};


GLITCHERAUDIO["UIStroke_e"] = Instance.new("UIStroke", GLITCHERAUDIO["ModeInfoFrame_c"]);
GLITCHERAUDIO["UIStroke_e"]["Transparency"] = 0.75;
GLITCHERAUDIO["UIStroke_e"]["Thickness"] = 1.5;


GLITCHERAUDIO["TextLabel_f"] = Instance.new("TextLabel", GLITCHERAUDIO["ModeInfoFrame_c"]);
GLITCHERAUDIO["TextLabel_f"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["TextLabel_f"]["TextSize"] = 24;
GLITCHERAUDIO["TextLabel_f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
GLITCHERAUDIO["TextLabel_f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["TextLabel_f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
GLITCHERAUDIO["TextLabel_f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["TextLabel_f"]["BackgroundTransparency"] = 1;
GLITCHERAUDIO["TextLabel_f"]["Size"] = UDim2.new(0, 200, 0, 30);
GLITCHERAUDIO["TextLabel_f"]["Text"] = [[N/A]];


GLITCHERAUDIO["Glitcher Title_10"] = Instance.new("Frame", GLITCHERAUDIO["MainGui_1"]);
GLITCHERAUDIO["Glitcher Title_10"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["Glitcher Title_10"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["Glitcher Title_10"]["Size"] = UDim2.new(0, 230, 0, 30);
GLITCHERAUDIO["Glitcher Title_10"]["Position"] = UDim2.new(0, 2, 0, 282);
GLITCHERAUDIO["Glitcher Title_10"]["Name"] = [[Glitcher Title]];
GLITCHERAUDIO["Glitcher Title_10"]["BackgroundTransparency"] = 0.25;


GLITCHERAUDIO["UIGradient_11"] = Instance.new("UIGradient", GLITCHERAUDIO["Glitcher Title_10"]);
GLITCHERAUDIO["UIGradient_11"]["Rotation"] = 180;
GLITCHERAUDIO["UIGradient_11"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 2.35713),NumberSequenceKeypoint.new(1.000, 0)};
GLITCHERAUDIO["UIGradient_11"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.698, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};


GLITCHERAUDIO["UIStroke_12"] = Instance.new("UIStroke", GLITCHERAUDIO["Glitcher Title_10"]);
GLITCHERAUDIO["UIStroke_12"]["Transparency"] = 0.75;
GLITCHERAUDIO["UIStroke_12"]["Thickness"] = 1.5;


GLITCHERAUDIO["TextLabel_13"] = Instance.new("TextLabel", GLITCHERAUDIO["Glitcher Title_10"]);
GLITCHERAUDIO["TextLabel_13"]["BorderSizePixel"] = 0;
GLITCHERAUDIO["TextLabel_13"]["TextSize"] = 24;
GLITCHERAUDIO["TextLabel_13"]["TextXAlignment"] = Enum.TextXAlignment.Left;
GLITCHERAUDIO["TextLabel_13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["TextLabel_13"]["FontFace"] = Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
GLITCHERAUDIO["TextLabel_13"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
GLITCHERAUDIO["TextLabel_13"]["BackgroundTransparency"] = 1;
GLITCHERAUDIO["TextLabel_13"]["Size"] = UDim2.new(0, 216, 0, 30);
GLITCHERAUDIO["TextLabel_13"]["Text"] = [[Renegade Glitcher]];
GLITCHERAUDIO["TextLabel_13"]["Position"] = UDim2.new(0, 2, 0, 0);




--// Make the Audio Visualizer
local frame=Instance.new("Frame",FSCREEN)
frame.Name="Container"
frame.AnchorPoint=Vector2.new(.5,.5)
frame.Position=UDim2.new(0,285,1,2.5)
frame.Size=UDim2.new(.75,0,.15,25)
frame.Transparency=1
frame.Rotation=0
local fr1=Instance.new("Frame",frame)
fr1.Name="Bar"
fr1.Size=UDim2.new(0,5,0,5)
fr1.BackgroundColor3=Color3.fromRGB(255,255,255)
fr1.Transparency=0
local stroke=Instance.new("UIStroke",fr1)
stroke.Thickness=2.5
stroke.Transparency=.75
local grad=Instance.new("UIGradient",fr1)
grad.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 1.5),NumberSequenceKeypoint.new(1.000, 0)}
grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.698, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
grad.Rotation=90

local listlay=Instance.new("UIListLayout",frame)
listlay.Padding=UDim.new(0,1.5)
listlay.FillDirection="Horizontal"
listlay.HorizontalAlignment="Left"
listlay.SortOrder="LayoutOrder"
listlay.VerticalAlignment="Center"

local analyzer=Instance.new("AudioAnalyzer")
analyzer.Name="Analyzer"
analyzer.WindowSize="Large"

local AudioPlayer=Instance.new("AudioPlayer",SoundService)
AudioPlayer.Looping=true
AudioPlayer.Volume=1
AudioPlayer.Name="GlitcherAudioPlayer"
AudioPlayer.TimePosition=0
analyzer.Parent = AudioPlayer

local sound=Instance.new("Sound",AudioPlayer)
sound.Looped=true 
sound.Volume=0 --// Set this to 0 to avoid interference
sound.Name="Sound2"

local output=Instance.new("AudioDeviceOutput",AudioPlayer)
local wire=Instance.new("Wire",AudioPlayer)
wire.SourceInstance=AudioPlayer
wire.TargetInstance=output
wire.Name="Output"

local wire2=Instance.new("Wire",AudioPlayer)
wire2.SourceInstance=AudioPlayer
wire2.TargetInstance=analyzer
wire2.Name="WireAnalyzer"


--// Tween function 
function TweenFunction(obj, speed, whattype, anim)
local Tinfo=TweenInfo.new
local TweenService=game.TweenService
local hii = Tinfo(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
if whattype =="pos" then
return TweenService:Create(obj, hii,{Position = anim})
elseif whattype =="size" then
return TweenService:Create(obj, hii,{Size = anim})
elseif whattype =="bt" then
return TweenService:Create(obj, hii,{BackgroundTransparency = anim})
elseif whattype =="trans" then
return TweenService:Create(obj, hii,{Transparency = anim})
elseif whattype=="rot" then
return TweenService:Create(obj, hii,{Rotation = anim})
elseif whattype=="brightness" then
return TweenService:Create(obj, hii,{Brightness = anim})
end
end



--// Load the Visualizer
local container=FSCREEN:WaitForChild("Container")
local Bar=container.Bar
local MusicPlayer=SoundService:WaitForChild("GlitcherAudioPlayer")
Bar.Parent=nil
local marker=15
local startfreq=25
local endfreq=100
for i = 1, marker do
local bar=Bar:Clone()
local freq = startfreq + (i-1) * (endfreq - startfreq) / (marker - 1) *.1
bar.LayoutOrder=i
bar.Name="Bar_"..i
bar.Parent=container
bar.Transparency=.75
TweenFunction(bar,1.5,"size",UDim2.new(0,50,.25,0)):Play()
wait(.01)
end 
fr1.Size=UDim2.new(0,50,.25,0)




local sin=math.sin
function This1(dt)
if MusicPlayer.TimePosition==0 then return end
local spectrum=MusicPlayer.Analyzer:GetSpectrum()
for i, bar in ipairs(container:GetChildren()) do
if bar:IsA("Frame") then
local spectrumIndex = math.floor((bar.LayoutOrder / marker) * #spectrum) + 1
spectrumIndex = math.clamp(spectrumIndex, 1, #spectrum)
local magnitude = spectrum[spectrumIndex] or 0
local scale = math.min(magnitude / 0.0010 * 2, 550)
local targetSize = UDim2.new(
Bar.Size.X.Scale, 
Bar.Size.X.Offset,
math.min(Bar.Size.Y.Scale * scale, 5.5), 
Bar.Size.Y.Offset
)
bar.Size = bar.Size:Lerp(targetSize, math.min(250, dt * 15))
end
end
end


local function timeFormat(seconds)
seconds = math.floor(seconds or 0)
local minutes = math.floor(seconds / 60)
local secs = seconds % 60
return string.format("%d:%02d", minutes, secs)
end


--[[
local imgl2b = imgl2:Clone()
imgl2b.Parent = FSCREEN
imgl2b.ImageTransparency = 0
imgl2b.Size = UDim2.new(0,800,0,800)
imgl2b.Position = UDim2.new(0.75,-100,0.55,-100)
imgl2b.ImageColor3 = Color3.new(0,0,0)
]]



function Asset(filename)
if isfile("Renegade Assets/"..filename) then
return getcustomasset("Renegade Assets/"..filename)
else
warn("Downloading File "..filename)
writefile("Renegade Assets/"..filename, game:HttpGet("https://github.com/ilikeices/animated/blob/Audios-1/"..filename.."?raw=true"))
 
end
end




--// Body Parts
local RootJoint=getJoint("RootJoint")
local RightShoulder=getJoint("Right Shoulder")
local LeftShoulder=getJoint("Left Shoulder")
local RightHip=getJoint("Right Hip")
local LeftHip=getJoint("Left Hip")
local Neck=getJoint("Neck")
local hed=getPart("Neck")

--// Rename accessories if they have the same name but different texture
local char=game.Players.LocalPlayer.Character
char.Humanoid.Health=math.huge
local count=0
for _,v in ipairs(char:GetChildren()) do
if v.Name=="RainbowGodSword" then
count+=1
v.Name="RainbowGodSword_"..count
end
end

function CreatePart(parent,transparency,reflectance,material,col,size,name)
local p = Instance.new("Part")
p.TopSurface = 0
p.Name=name
p.BottomSurface = 0
p.Parent = parent
p.Size = size
p.Transparency = transparency
p.Reflectance = reflectance
p.CanCollide = false
p.Locked = false 
p.Massless = true 
p.Anchored=true 
p.Color = col 
p.Material = material
return p
end


--CreatePart(ws,1,0,"Neon",rgb(0,0,0),v3(.1,.1,.1),"CamFocus")
coroutine.resume(coroutine.create(function()
local up
local obj=game.Players.LocalPlayer.Character:FindFirstChild(CAMERAFOCUS)
up=game:GetService("RunService").RenderStepped:Connect(function()
if Running==false then  
for _, v in ipairs(ws:GetChildren()) do 
if v.Name=="CamFocus" or v.Name=="BBG" then 
v:Destroy()
end
end
up:Disconnect()
end
if ws:FindFirstChild("CamFocus") then
if game.Players.LocalPlayer.Character:FindFirstChild(CAMERAFOCUS) then
ws:WaitForChild("CamFocus").Position=game.Players.LocalPlayer.Character:FindFirstChild(CAMERAFOCUS):FindFirstChild("Handle").Position
ws.CurrentCamera.CameraSubject=game.Players.LocalPlayer.Character:FindFirstChild(CAMERAFOCUS).Handle 
else 
ws.CurrentCamera.CameraSubject=ws:FindFirstChild("CamFocus")
end 
pcall(function()
for _,v in ipairs(ws:FindFirstChild("CamFocus"):GetChildren()) do 
if v:IsA("Attachment") and v.Name~="TitleAttachment" then 
v:Destroy()
end
end
end)
else
CreatePart(ws,1,0,"Neon",rgb(0,0,0),v3(.1,.1,.1),"CamFocus")
end
end)
end))

function SafePart(Find)
local char = game.Players.LocalPlayer.Character

if char:FindFirstChild(Find) then 
return char:FindFirstChild(Find).Handle
else 
return ws:WaitForChild("CamFocus")
end
end
--// Parts 
local Rarm=SafePart("Accessory (RArm)")
local Larm=SafePart("Accessory (LArm)")
local Torso=SafePart("Accessory (Black)")
local Head=SafePart(CAMERAFOCUS)
print(Head)
local jj=nil
function Hmm(Change)
local char = game.Players.LocalPlayer.Character
local humroot=char:WaitForChild("HumanoidRootPart")
if jj then 
jj:Disconnect()
jj=nil
end
coroutine.resume(coroutine.create(function()
jj=game:GetService("RunService").RenderStepped:Connect(function()
local char = game.Players.LocalPlayer.Character
local humroot=char:WaitForChild("HumanoidRootPart")
if Torso then
game.Players.LocalPlayer.Character.HumanoidRootPart.Position=v3(Torso.Position.X,Torso.Position.Y - Change,Torso.Position.Z)
end
if Running then
humroot.Rotation=v3(0,0,0)
humroot.Anchored=true
humroot.Massless=true
humroot.CanCollide=false
humroot.Transparency=1
pcall(function()
for _,v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do 
if v:IsA("Accessory") then
v.Handle.CanCollide=true
end
end
end)
else
jj:Disconnect()
jj=nil

end
end)
end))

end
local HumanoidRoot=game.Players.LocalPlayer.Character.HumanoidRootPart
Hmm(5)



local righead=ws:FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild(CAMERAFOCUS).Handle
--// Focus The Camera On The Rigs heads
--ws.CurrentCamera.CameraSubject=righead




--// Main Swords
local getPartFromMesh=t.getPartFromMesh
local getPartJoint=t.getPartJoint
local sword = getPartFromMesh(5254583415, 5268538095)
local s1_1 = sword and getPartJoint(sword) or {C0 = cf_0} -- VoidLord Sword
local sword2 = getPartFromMesh(5278721954, 5692006383)
local s1_2 = sword2 and getPartJoint(sword2) or {C0 = cf_0} -- Halloween Sword
local sword3 = getPartFromMesh(5278721954, 5316510551)
local s1_3 = sword3 and getPartJoint(sword3) or {C0 = cf_0} -- Rainbow Sword
local sword4 = getPartFromMesh(5278721954, 5278777022)
local s1_4 = sword4 and getPartJoint(sword4) or {C0 = cf_0} -- Demon God Sword

 --// Other Variables
local WingAnimations={}
local sp=0
local AnimType="Renegades"

function CreateWeld(parent,part0,part1,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za)
local weld = Instance.new("Motor6D")
weld.Parent = parent
weld.Part0 = part0
weld.Part1 = part1
weld.Name="What Weld"
weld.C1 = cf(C1X,C1Y,C1Z)*angles(C1Xa,C1Ya,C1Za)
weld.C0 = cf(C0X,C0Y,C0Z)*angles(C0Xa,C0Ya,C0Za)
return weld
end

function CreateWeld1(parent,part0,part1,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za)
local weld = Instance.new("Weld")
weld.Parent = parent
weld.Part0 = part0
weld.Part1 = part1
weld.Name="What Weld"
weld.C1 = cf(C1X,C1Y,C1Z)*angles(C1Xa,C1Ya,C1Za)
weld.C0 = cf(C0X,C0Y,C0Z)*angles(C0Xa,C0Ya,C0Za)
return weld
end





--// Modes Container
local Modes={
  {Name="Renegades",WingAnim="Renegades",MusicTitle="Team Grimoire - Grimoire of Blue",Music="Grimoire of Blue"},
  {Name="Overseer",WingAnim="Overseer",MusicTitle="Frums - of Ambrosia",Music="Ambrosia"},
  {Name="Mayhem",WingAnim="Mayhem",MusicTitle="D-Mode-D - Shriek",Music="Shriek"},
  {Name="Chaos",WingAnim="Chaos",MusicTitle="Frums - HALL",Music="HALL"},
  {Name="Chromatic",WingAnim="Chromatic",MusicTitle="t+pazolite - Cheatreal",Music="Cheatreal"},
  {Name="Fracture",WingAnim="Fracture",MusicTitle="「Hard NRG」[Yooh] Backwards - cold kiss sound",Music="Hard NRG"},
  {Name="Kronos",WingAnim="Kronos",MusicTitle="Camellia - Body F10ating in the Zero Gravity Space",Music="Zero Grav"},
  {Name="E q u i n o x",WingAnim="Equinox",MusicTitle="Sols rng - Equinox",Music="EQUINOX"},
  {Name="Mayhem - No Hope",WingAnim="Mayhem2",MusicTitle="Team Grimoire - Kathastrophe",Music="Kathastrophe"},
  {Name="Shard Surfer",WingAnim="Shard",MusicTitle="Tidal Wave - Shiawase (VIP Remix)",Music="Shiawase"},
  {Name="Luminosity",WingAnim="Luminosity",MusicTitle="t+pazolite & Getty - Twisted Drop Party - HARDCORE TANOC",Music="TANOC"},
  {Name="Censored",WingAnim="Censored",MusicTitle="t+pazolite - CENSORED!!!",Music="Censored"},
  {Name="Fragmentation",WingAnim="Fragmentation",MusicTitle="Camellia - Dance With Silence",Music="Dance With Silence"},
  {Name="Panorama",WingAnim="Panorama",MusicTitle="Arctcore - Panorama",Music="Panorama"},
}




--// BillboardGui
local BBGAttachment=Instance.new("Attachment")
BBGAttachment.CFrame=cf()
BBGAttachment.Name="TitleAttachment"
local bilguit = Instance.new("BillboardGui", BBGAttachment)
bilguit.Adornee = nil
bilguit.Name = "Overhead"
bilguit.Size = UDim2.new(20, 0, 4,0)
bilguit.StudsOffset = Vector3.new(0, 2, 0)
bilguit.StudsOffsetWorldSpace=v3(0,8,0)
local modet = Instance.new("TextLabel", bilguit)
modet.Size = UDim2.new(2, 0, 1.3, 0)
modet.Position = UDim2.new(-.5, 0, -.15, 0)
modet.TextSize = 25
modet.TextScaled = true
modet.TextTransparency = 0
modet.BackgroundTransparency = 1 
modet.TextTransparency = 0
modet.TextStrokeTransparency = 0
modet.FontFace=Font.new([[rbxasset://fonts/families/PressStart2P.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic)
modet.TextStrokeColor3 = Color3.new(0,1,1)
modet.TextColor3 = Color3.new(1,1,1)
modet.Text = "Test"
modet.Name="Title"
modet.Visible=BBGVisibilty
BBGAttachment.Parent=ws:WaitForChild("CamFocus")


--local modet=ws:FindFirstChild("CamFocus"):FindFirstChild("Overhead"):FindFirstChild("Title")
--// Get the PlaybackLoudness 
local Loudness=sound.PlaybackLoudness


--// Recolor And Rename Function 
function ChangeAndRecolor(txt, usefontface, font, col1, col2, usergb,dontaffecttxtcol)
  
--// Important Things For Changing Colors
local TopFrameBars=GLITCHERAUDIO["TopFrame_2"]
local TopFrameStroke=GLITCHERAUDIO["TopFrame_3"]
local MusicFrame=GLITCHERAUDIO["MusicFrame_4"]
local MusicFrameStroke=GLITCHERAUDIO["AudioDur_5"]
local MusicTimeLabel=GLITCHERAUDIO["MusicDuration_7"]
local MusicNameLabel=GLITCHERAUDIO["MusicName_6"]
local MusicLengthFrame=GLITCHERAUDIO["MusicDur_a"]
local MusicImag1=GLITCHERAUDIO["Lol1_9"]
local MusicImag2=GLITCHERAUDIO["Lol_8"]
local ModeInfoFrame=GLITCHERAUDIO["ModeInfoFrame_c"]
local ModeInfoGrad=GLITCHERAUDIO["UIGradient_d"]
local ModeInfoStroke=GLITCHERAUDIO["UIStroke_e"]
local ModeInfoLabel=GLITCHERAUDIO["TextLabel_f"]
local GlitcherTitleFrame=GLITCHERAUDIO["Glitcher Title_10"]
local GlitcherTitleGrad=GLITCHERAUDIO["UIGradient_11"]
local GlitcherTitleStroke=GLITCHERAUDIO["UIStroke_12"]
local GlitcherTitleLabel=GLITCHERAUDIO["TextLabel_13"]
local spin1=imag1
local spin2=imag2 
local spin3=imag3 
local spin4=imag4

modet.Text = string.upper(txt)
ModeInfoLabel.Text = string.upper(txt)
if dontaffecttxtcol== nil then
dontaffecttxtcol=false
end

if usefontface then
modet.FontFace=font
ModeInfoLabel.FontFace=font
MusicNameLabel.FontFace=font
MusicTimeLabel.FontFace=font
GlitcherTitleLabel.FontFace=font
else
modet.Font=font
ModeInfoLabel.Font=font
MusicNameLabel.Font=font
MusicTimeLabel.Font=font
GlitcherTitleLabel.Font=font
end



--// Disconnect Things
if IsRendering1 then
IsRendering1:Disconnect()
IsRendering1=nil
end

--// RGB 
local r = 255
local g = 0
local b = 0
local stage = 1
if usergb then
IsRendering1=game:GetService("RunService").RenderStepped:Connect(function()

--// RGB 
if stage == 1 then
g = g + 2.5
if g >= 255 then
g = 255
stage = 2
end
elseif stage == 2 then
r = r - 2.5
if r <= 0 then
r = 0
stage = 3
end
elseif stage == 3 then
b = b + 2.5
if b >= 255 then
b = 255
stage = 4
end
elseif stage == 4 then
g = g - 2.5
if g <= 0 then
g = 0
stage = 5
end
elseif stage == 5 then
r = r + 2.5
if r >= 255 then
r = 255
stage = 6
end
elseif stage == 6 then
b = b - 2.5
if b <= 0 then
b = 0
stage = 1
end
end

--// Apply Color
local currentrgb=rgb(r,g,b)
TopFrameBars.BackgroundColor3=col1
TopFrameStroke.Color=currentrgb
MusicFrameStroke.Color=currentrgb
MusicImag2.ImageColor3=currentrgb
MusicImag1.ImageColor3=currentrgb
ModeInfoGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.000, currentrgb),ColorSequenceKeypoint.new(0.698, col2),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
MusicNameLabel.TextColor3=col1
ModeInfoStroke.Color=currentrgb
ModeInfoLabel.TextColor3=currentrgb
GlitcherTitleGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.000, currentrgb),ColorSequenceKeypoint.new(0.698, col1),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
GlitcherTitleStroke.Color=currentrgb
spin1.ImageColor3=col1
MusicFrame.BackgroundColor3=col1
modet.TextColor3=col1
modet.TextStrokeColor3=currentrgb
spin2.ImageColor3=currentrgb
spin3.ImageColor3=col1
spin4.ImageColor3=currentrgb
MusicTimeLabel.TextColor3=col1
MusicLengthFrame.BackgroundColor3=currentrgb
GlitcherTitleLabel.TextColor3=currentrgb

if basgui:FindFirstChild(FSCREEN.Name) then 

for _,v in ipairs(FSCREEN:WaitForChild("Container"):GetDescendants()) do
if v:IsA("UIGradient") and usergb==true then
  
v.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.000, currentrgb),ColorSequenceKeypoint.new(0.698, col2),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
end
end

for _,v in ipairs(FSCREEN:WaitForChild("Container"):GetDescendants()) do
if v:IsA("UIStroke") and usergb==true then
v.Color=currentrgb
end
end 
else 
return
end

end)

else

--// Use Normal Colors if set tot false
if IsRendering1 then
IsRendering1:Disconnect()
IsRendering1=nil
end

MusicNameLabel.TextColor3=col2
modet.TextStrokeColor3 = col2
if dontaffecttxtcol==false then
modet.TextColor3 = col1
else 
modet.TextColor3=rgb(255,255,255)
end
TopFrameBars.BackgroundColor3=col1
TopFrameStroke.Color=col2
MusicFrame.BackgroundColor3=col2
MusicFrameStroke.Color=col1
MusicLengthFrame.BackgroundColor3=col1
MusicImag2.ImageColor3=col1
MusicImag1.ImageColor3=col1
ModeInfoFrame.BackgroundColor3=col1
ModeInfoGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.000, col1),ColorSequenceKeypoint.new(0.698, col2),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
ModeInfoStroke.Color=col2
ModeInfoLabel.TextColor3=col1
GlitcherTitleFrame.BackgroundColor3=col2
GlitcherTitleLabel.TextColor3=col1
GlitcherTitleGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.000, col1),ColorSequenceKeypoint.new(0.698, col2),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
MusicTimeLabel.TextColor3=col1
GlitcherTitleStroke.Color=col1
spin1.ImageColor3=col2
spin2.ImageColor3=col2
spin3.ImageColor3=col1
spin4.ImageColor3=col1

for _,v in ipairs(FSCREEN:FindFirstChild("Container"):GetDescendants()) do
if v:IsA("UIGradient") then
v.Color=ColorSequence.new{ColorSequenceKeypoint.new(0.000, col1),ColorSequenceKeypoint.new(0.698, col2),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))}
end
end

for _,v in ipairs(FSCREEN:FindFirstChild("Container"):GetDescendants()) do
if v:IsA("UIStroke") then
v.Color=col2
end
end

end



end



--// Fetch Modes
function getMode(modeName)
for i,v in next, Modes do
if(v.Name==modeName)then
return v
end
end
return Modes[1]
end 


function changeMode(modeName)
local info = getMode(modeName)
Mode=info.Name;
GLITCHERAUDIO["MusicName_6"]["Text"] = info.MusicTitle
AnimType=info.WingAnim or "Renegades"
MusicPlayer.TimePosition=0 
MusicPlayer.Asset=Asset(info.Music..".mp3")
MusicPlayer:Play()
sound.SoundId=Asset(info.Music..".mp3")
sound.TimePosition=0 
sound:Play()

end

function swait(num)
if num==0 or num==nil then
game:service'RunService'.Stepped:wait(0)
else
for i=0,num do
game:service'RunService'.Stepped:wait(0)
end
end
end


--// Intro Animation 
function Introduction()
local alpha=.250
--// First Anim
for i=0,2,.1 do
swait()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.5),angles(0,0,-0.8726646259971648)),alpha)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1,-0.5),angles(0.3490658503988659,1.5707963267948966,0)),alpha)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,200,0),angles(-1.9198621771937625,0,3.141592653589793)),alpha)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.5,-0.5),angles(0,0,0.8726646259971648)),alpha)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1,-0.5),angles(-0.3490658503988659,-1.5707963267948966,0)),alpha)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295,0,3.141592653589793)),alpha)  
end
wait(1)
--// Second Anim
for i=0,5,.1 do
swait()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),alpha)  
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-2,0.5,-1.25),angles(1.2217304763960306,0,-0.5235987755982988)),alpha)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0,-0.5),angles(1.361356816555577,1.5707963267948966,0)),alpha)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-1,0),angles(-2.6179938779914944,0,3.141592653589793)),alpha)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.25,-0.5),angles(0,0,0.8726646259971648)),alpha)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1.25,-0.5),angles(-0.08726646259971647,-1.5707963267948966,0)),alpha)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295,0,3.141592653589793)),alpha)  
end

--// Third Anim
for i=0,3.125,.1 do 
swait()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.5,-3.25),angles(0,1.5707963267948966,1.5707963267948966)),alpha)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,4.5,-3.75),angles(0,1.5707963267948966,-1.5707963267948966)),alpha)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,2.75,-5.1),angles(0,1.5707963267948966,3.141592653589793)),alpha)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,3.25,-5),angles(0,1.5707963267948966,0)),alpha)  
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.75,-0.15,0),angles(-1.2217304763960306,0,-0.8726646259971648)),alpha)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0,-0.5),angles(1.361356816555577,1.5707963267948966,0)),alpha)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-1,0),angles(-2.6179938779914944,0,3.141592653589793)),alpha)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.75,-0.25,0),angles(-1.2217304763960306,0,0.8726646259971648)),alpha)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1.25,-0.5),angles(-0.08726646259971647,-1.5707963267948966,0)),alpha)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295,0,3.141592653589793)),alpha)  

end

--// Fourth Anim
for i=0,3,.1 do 
swait()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.5,-3.25),angles(0,1.5707963267948966,1.5707963267948966)),alpha)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,4.5,-3.75),angles(0,1.5707963267948966,-1.5707963267948966)),alpha)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,2.75,-5.1),angles(0,1.5707963267948966,3.141592653589793)),alpha)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,3.25,-5),angles(0,1.5707963267948966,0)),alpha)  
end
RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.75,0.5,-1),angles(1.2217304763960306,0,0.3490658503988659)),alpha)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.5),angles(0,0,-0.8726646259971648)),alpha)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0,-0.5),angles(1.361356816555577,1.5707963267948966,0)),alpha)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-1,0),angles(-2.6179938779914944,0,3.141592653589793)),alpha)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1.25,-0.5),angles(-0.08726646259971647,-1.5707963267948966,0)),alpha)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295,0,3.141592653589793)),alpha)  

end

--// Fifth Anim
for i=0,2,.1 do 
swait()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.5,-3.25),angles(0,1.5707963267948966,1.5707963267948966)),alpha)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,4.5,-3.75),angles(0,1.5707963267948966,-1.5707963267948966)),alpha)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,2.75,-5.1),angles(0,1.5707963267948966,3.141592653589793)),alpha)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,3.25,-5),angles(0,1.5707963267948966,0)),alpha)  
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cf(-1.5,0.5,-0.5),alpha)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1,0),angles(0,1.5707963267948966,0)),alpha) RootJoint.C0=Lerp(RootJoint.C0,angles(-1.5707963267948966,0,3.6651914291880923),alpha)  RightShoulder.C0=Lerp(RightShoulder.C0,cf(1.5,0.5,-0.5),alpha)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1,0),angles(0,-1.5707963267948966,0)),alpha)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295,0,2.530727415391778)),alpha) 
end
modet.Text = ""
--// Sixth Anim
for i=0,2.5,.1 do 
swait()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.5,-3.25),angles(0,1.5707963267948966,1.5707963267948966)),alpha)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,4.5,-3.75),angles(0,1.5707963267948966,-1.5707963267948966)),alpha)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,2.75,-5.1),angles(0,1.5707963267948966,3.141592653589793)),alpha)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,3.25,-5),angles(0,1.5707963267948966,0)),alpha)  
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.5),angles(0,0,-0.3490658503988659)),alpha)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1,-0.15),angles(0,1.5707963267948966,-0.2617993877991494)),alpha)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,12,0),angles(-1.5707963267948966,-0.08726646259971647,3.6651914291880923)),alpha)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,1,0.15),angles(2.775073510670984,0,-0.5235987755982988)),alpha)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.75,-0.5),angles(0,-1.5707963267948966,0.3490658503988659)),alpha)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295,0,2.530727415391778)),alpha)  
end
changeMode("Fracture")
ChangeAndRecolor("Fracture",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,69,95),rgb(182,235,255),false,false)
end















--// Special Anims

function SpecialAnim(start,dur,change,ret,current,color1)
if current >=start then
Mode=change 
end
if current >= dur then
Mode=ret
if Mode=="Overseer" then
ChangeAndRecolor("Overseer",true,Font.new([[rbxasset://fonts/families/Michroma.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(39,252,69),rgb(255,255,255),false,false)
elseif Mode=="Censored" then
ChangeAndRecolor("Censored",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,0,0),rgb(rgb(61,255,77)),false,false)
end
end
end

local Debounce=false


local Txts={
  "『H A R M O N I O U S』",
  "『E V E R S T I L L』", 
  "『A B S O L U T E』", 
  "『I M M U T A B L E』", 
  "『U L T I M A T E』", 
  "『E T E R N A L』", 
  "『I N F I N I T E』", 
  "『B A L A N C E D』"
}
function EquinoxTexts()
local TweenService=game.TweenService
local Tinfo=TweenInfo.new
function Tween(obj, speed, whattype, anim,type)
local Tinfo=TweenInfo.new
local TweenService=game.TweenService
local hii = Tinfo(speed, type, Enum.EasingDirection.Out)
if whattype =="pos" then
return TweenService:Create(obj, hii,{Position = anim}):Play()
elseif whattype =="size" then
return TweenService:Create(obj, hii,{Size = anim})
elseif whattype =="bt" then
return TweenService:Create(obj, hii,{BackgroundTransparency = anim}):Play()
elseif whattype =="trans" then
return TweenService:Create(obj, hii,{Transparency = anim}):Play()
elseif whattype=="rot" then
return TweenService:Create(obj, hii,{Rotation = anim}):Play()
end
end
local Deb = game:GetService("Debris")
local mrandom=math.random

 function func(arg1) 
		return Vector3.new(math.random(-arg1 * 10, arg1 * 10) / 10, math.random(-arg1 * 10, arg1 * 10) / 10, math.random(-arg1 * 10, arg1 * 10) / 10)
	end
local clone=ws:WaitForChild("EquinoxAssets"):Clone()
local bbg=clone:WaitForChild("Bill")
local txtclone=bbg:WaitForChild("Splash")
local randomv3=bbg.StudsOffset+v3(mrandom(-20,5),mrandom(5,10),mrandom(-15,-10))
local clonestk=txtclone:WaitForChild("TxtStroke")
bbg.Parent=game.Players.LocalPlayer.Character.HumanoidRootPart
bbg.Adornee=game.Players.LocalPlayer.Character.HumanoidRootPart
bbg.StudsOffset=randomv3
bbg.Brightness=10
local gj
clonestk.Thickness=0
local rancol=math.random(1,2)
local val = Instance.new("NumberValue")
val.Value=1
if rancol==1 then
txtclone.TextColor3=rgb(255,255,255)
clonestk.Color=rgb(0,0,0)
gj=1
elseif rancol==2 then
gj=-1
txtclone.TextColor3=rgb(0,0,0)
clonestk.Color=rgb(255,255,255)
end
txtclone.Rotation=mrandom(-45,45)
txtclone.Position=UDim2.fromScale(-5,10)
txtclone.Text=Txts[math.random(1,#Txts)]
--txtclone.AutomaticSize="X"
local txtran=mrandom(1,8)

coroutine.resume(coroutine.create(function()
TweenService:Create(txtclone, Tinfo(0.5,Enum.EasingStyle.Quart),{
  Position=UDim2.fromScale(math.random(-5.5,-1.5),math.random(-1.75,-1));
  Size=UDim2.fromScale(7.5,1.5);
  Rotation=mrandom(-20,20);
}):Play()
TweenService:Create(val, Tinfo(1.5,Enum.EasingStyle.Quart),{
  Value=0;
}):Play()
local lol
local res=time()

lol=game:GetService("RunService").Heartbeat:Connect(function()
if bbg and bbg.Parent then 
bbg.StudsOffsetWorldSpace=randomv3+v3(sin((time() - res)*6*gj),sin((time()-res)*8*gj),sin((time()-gj)*4*gj))+func(val.Value)
else
lol:Disconnect()
end
end)
wait(1)
Deb:AddItem(bbg,1.5)
TweenService:Create(txtclone, Tinfo(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
  Size=UDim2.fromScale(1,.5);
  Position=UDim2.fromScale(math.random(-1,1),math.random(-1,1));
  Transparency=1
}):Play()
TweenService:Create(bbg, Tinfo(1.5,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
  Brightness=1
}):Play()
TweenService:Create(clonestk, Tinfo(2.5,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
  Thickness=2.5
}):Play()
txtclone.TextScaled=false
TweenService:Create(txtclone, Tinfo(1.25,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
  Transparency=1
}):Play()

end))
end

function EquinoxCloneBars()
local FrameFolders=Instance.new("Folder",ws:FindFirstChild("EquinoxAssets"))
FrameFolders.Name="Frames"
local TopFrameBars=ws:FindFirstChild("EquinoxAssets"):WaitForChild("TopFrame"):FindFirstChild("Frame")
local TopFrame=ws:FindFirstChild("EquinoxAssets"):WaitForChild("TopFrame")
local BottomFrameBars=ws:FindFirstChild("EquinoxAssets"):WaitForChild("BottomFrame"):FindFirstChild("Frame")
local BottomFrame=ws:FindFirstChild("EquinoxAssets"):WaitForChild("BottomFrame")

TopFrame.Position=UDim2.fromScale(-.01,-.3)
BottomFrame.Position=UDim2.fromScale(.07,.8)
BottomFrame.Rotation=180
coroutine.resume(coroutine.create(function()
for i=1,20 do
local Barclone=TopFrameBars:Clone()
Barclone.Size=u2(.05,0,1,0)
Barclone.BackgroundTransparency=1 
Barclone.Parent=TopFrame
Barclone.Name=i
wait(.1)
end
end))
coroutine.resume(coroutine.create(function()
for i=1,20 do 
local Barclone1=BottomFrameBars:Clone()
Barclone1.Size=u2(.05,0,1,0)
Barclone1.BackgroundTransparency=1 
Barclone1.Parent=BottomFrame 
Barclone1.Name=i
wait(.01)
end
BottomFrame.Parent=FrameFolders
TopFrame.Parent=FrameFolders
end))
end

local EquinoxBarsFolder=Instance.new("Folder",game.CoreGui:FindFirstChild("VISgui"))
function EquinoxMainBars()
EquinoxBarsFolder.Name="BarFrames"
local Deb = game:GetService("Debris")
local FrameFolder=ws:FindFirstChild("EquinoxAssets"):FindFirstChild("Frames")
local GUIMain=game.CoreGui:FindFirstChild("VISgui"):WaitForChild("BarFrames")
local FolClone=FrameFolder:Clone()
FolClone.Parent=GUIMain

for _, v in GUIMain:GetDescendants() do
if v:IsA("ImageLabel") then
local variable
variable = UDim2.fromScale(1, math.random(50, 200) / 100)
v.Size = variable

if math.random(1, 2) == 1 then 
variable = Color3.fromRGB(0, 0, 0)
else 
variable = Color3.fromRGB(255, 255, 255)
end
v.ImageColor3 = variable
variable = game:GetService("TweenService")
local _ = {
Size = UDim2.fromScale(1, 0);
ImageTransparency = 1;
}
variable = variable:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart), _)
variable:Play()
end
Deb:AddItem(FolClone,1)
end

end

function EquinoxAssets()
--//Stroke 
wait(.2)
print("Loading Equinox Assets")
local nr=NumberRange.new
local EquinoxFolder=Instance.new("Folder",ws)
EquinoxFolder.Name="EquinoxAssets"
local stk=Instance.new("UIStroke",modet)
stk.Color=rgb(255,255,255)
stk.Thickness=1
local gr1=Instance.new("UIGradient",modet)
gr1.Offset=v2(-.1,0)
gr1.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(.225,rgb(100,100,100)),
  csk(.322,rgb(255,255,255)),
  csk(.403,rgb(0,0,0)),
  csk(.465,rgb(255,255,255)),
  csk(.488,rgb(0,0,0)),
  csk(.501,rgb(0,0,0)),
  csk(.64,rgb(0,0,0)),
  csk(.694,rgb(0,0,0)),
  csk(.747,rgb(0,0,0)),
  csk(.784,rgb(0,0,0)),
  csk(.941,rgb(100,100,100)),
  csk(1,rgb(0,0,0))
})
gr1.Rotation=87
gr1.Name="Grad1"
gr1.Enabled=true
local gr2=Instance.new("UIGradient",stk)
gr2.Offset=v2(.25,0)
gr2.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(.289,rgb(100,100,100)),
  csk(.374,rgb(0,0,0)),
  csk(.431,rgb(150,150,150)),
  csk(.497,rgb(0,0,0)),
  csk(.514,rgb(0,0,0)),
  csk(.668,rgb(100,100,100)),
  csk(.765,rgb(255,255,255)),
  csk(.784,rgb(100,100,100)),
  csk(.941,rgb(0,0,0)),
  csk(1,rgb(255,255,255)),
})
gr2.Rotation=87 
gr2.Name="Grad2"
gr2.Enabled=true

--//Assets 
local bbg2=Instance.new("BillboardGui",EquinoxFolder)
bbg2.Size=u2(20,0,20,0)
bbg2.Adornee=nil
bbg2.Name="Bill"
bbg2.StudsOffsetWorldSpace=v3(0,0,0)
bbg2.StudsOffset = Vector3.new(7.5, -10, 8.5)
bbg2.StudsOffsetWorldSpace = Vector3.new(0, 0, -15)
local lbl=Instance.new("TextLabel",bbg2)
lbl.Name="Splash"
lbl.Text=" "
lbl.TextColor3=rgb(255,255,255)
lbl.Size=u2(7,0,1.5,0)
lbl.Position=u2(0,0,0,0)
lbl.BackgroundTransparency=1
lbl.FontFace=Font.new([[rbxassetid://12187376739]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
lbl.TextSize=15
lbl.TextScaled=false
local stk0=Instance.new("UIStroke",lbl)
stk0.Name="TxtStroke"
stk0.Color=rgb(255,255,255)
stk0.Thickness=1

Asset("star.png")


--// Effects 
local nums=NumberSequence.new 
local numk=NumberSequenceKeypoint.new
local att1=Instance.new("Attachment",EquinoxFolder)
att1.Name="Black Pulse"
att1.CFrame=cf(0,1.2,0)
local sq1=Instance.new("ParticleEmitter",att1)
sq1.Name="Square"
sq1.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0)),
})

sq1.Brightness=8 
sq1.Size=nums({
  numk(0,0),
  numk(0.055,26.763),
  numk(0.120,40),
  numk(0.234,48),
  numk(0.39,52),
  numk(0.612,54),
  numk(1,56),
})
sq1.Texture="rbxassetid://108130357346045"
sq1.Orientation="VelocityPerpendicular"
sq1.Transparency=nums({
  numk(0,0),
  numk(.2,0),
  numk(.59,.238),
  numk(1,1),
})
sq1.Enabled=false
sq1.Lifetime=nr(.44,.44)
sq1.Rate=7
sq1.Rotation=nr(45,45)
sq1.Speed=nr(.001,.001)
sq1.SpreadAngle=Vector2.new(0,0)
sq1.EmissionDirection="Top"
sq1.FlipbookFramerate=nr(1,1)
sq1.FlipbookLayout="Grid4x4"
sq1.FlipbookMode="OneShot"
sq1:SetAttribute("EmitCount",1)
local att2=Instance.new("Attachment",EquinoxFolder)
att2.Name="White Pulse"
att2.CFrame=cf(0,4,0)
local sq2=Instance.new("ParticleEmitter",att2)
sq2.Name="Square"
sq2.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255)),
})

sq2.Brightness=8 
sq2.Size=nums({
  numk(0,0),
  numk(0.055,26.763),
  numk(0.120,40),
  numk(0.234,48),
  numk(0.39,52),
  numk(0.612,54),
  numk(1,56),
})
sq2.Texture="rbxassetid://108130357346045"
sq2.Orientation="FacingCamera"
sq2.Transparency=nums({
  numk(0,0),
  numk(.2,0),
  numk(.59,.238),
  numk(1,1),
})
sq2.Enabled=false
sq2.Lifetime=nr(.44,.44)
sq2.Rate=7
sq2.Rotation=nr(45,45)
sq2.Speed=nr(.001,.001)
sq2.SpreadAngle=Vector2.new(0,0)
sq2.EmissionDirection="Top"
sq2.FlipbookFramerate=nr(1,1)
sq2.FlipbookLayout="Grid4x4"
sq2.FlipbookMode="OneShot"
sq2:SetAttribute("EmitCount",1)

local charge1att=Instance.new("Attachment",EquinoxFolder)
charge1att.Name="ParticleAttachmets"
charge1att.CFrame=cf()
local e0=Instance.new("ParticleEmitter",charge1att)
e0.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e0.Orientation="VelocityPerpendicular"
e0.Size=nums({
  numk(0,0),
  numk(.226,24),
  numk(.5,33),
  numk(1,42),
})
e0.Transparency=nums({
  numk(0,1),
  numk(1,.7),
  numk(1,1),
})
e0.Texture="rbxassetid://130341645640774"
e0.Name="Shock1"
e0.EmissionDirection="Top"
e0.Enabled=false
e0.Lifetime=nr(.25,.25)
e0.Rate=7
e0.Rotation=nr(0,0)
e0.RotSpeed=nr(0,0)
e0.Speed=nr(.002,.002)
e0.SpreadAngle=v2(360,360)
e0.VelocitySpread=360
e0.FlipbookFramerate=nr(1,1)
e0.FlipbookMode="OneShot"
e0.FlipbookLayout="Grid4x4"
e0:SetAttribute("EmitCount",1)

local e1=Instance.new("ParticleEmitter",charge1att)
e1.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e1.Orientation="VelocityPerpendicular"
e1.Size=nums({
  numk(0,0),
  numk(.226,24),
  numk(.5,33),
  numk(1,42),
})
e1.Transparency=nums({
  numk(0,1),
  numk(1,.7),
  numk(1,1),
})
e1.Texture="rbxassetid://130341645640774"
e1.Name="Shock2"
e1.EmissionDirection="Top"
e1.Enabled=false
e1.Lifetime=nr(.25,.25)
e1.Rate=7
e1.Rotation=nr(0,0)
e1.RotSpeed=nr(0,0)
e1.Speed=nr(.002,.002)
e1.SpreadAngle=v2(360,360)
e1.VelocitySpread=360
e1.FlipbookFramerate=nr(1,1)
e1.FlipbookMode="OneShot"
e1.FlipbookLayout="Grid4x4"
e1:SetAttribute("EmitCount",1)

local e2=Instance.new("ParticleEmitter",charge1att)
e2.Name="Impact1"
e2.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e2.Brightness=20
e2.Orientation="VelocityPerpendicular"
e2.Size=nums({
  numk(0,0),
  numk(.14,11.5),
  numk(.42,18),
  numk(1,21,.01),
})
e2.Texture="rbxassetid://18140248952"
e2.Transparency=nums({
  numk(0,0),
  numk(1,0),
})
e2.ZOffset=-.1
e2.Enabled=false 
e2.EmissionDirection="Top"
e2.Lifetime=nr(.4,.4)
e2.Rate=7
e2.Rotation=nr(0,0)
e2.RotSpeed=nr(0,0)
e2.Speed=nr(.002,.002)
e2.SpreadAngle=v2(360,360)
e2.VelocitySpread=360 
e2.FlipbookFramerate=nr(1,1)
e2.FlipbookLayout="Grid4x4"
e2.FlipbookMode="OneShot"
e2:SetAttribute("EmitCount",1)

local e3=Instance.new("ParticleEmitter",charge1att)
e3.Name="Impact2"
e3.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e3.Brightness=20
e3.Orientation="VelocityPerpendicular"
e3.Size=nums({
  numk(0,0),
  numk(.14,11.5),
  numk(.42,18),
  numk(1,21,.01),
})
e3.Texture="rbxassetid://18140248952"
e3.Transparency=nums({
  numk(0,0),
  numk(1,0),
})
e3.ZOffset=-.1
e3.Enabled=false 
e3.EmissionDirection="Top"
e3.Lifetime=nr(.4,.4)
e3.Rate=7
e3.Rotation=nr(0,0)
e3.RotSpeed=nr(0,0)
e3.Speed=nr(.002,.002)
e3.SpreadAngle=v2(360,360)
e3.VelocitySpread=360 
e3.FlipbookFramerate=nr(1,1)
e3.FlipbookLayout="Grid4x4"
e3.FlipbookMode="OneShot"
e3:SetAttribute("EmitCount",1)

local e4=Instance.new("ParticleEmitter",charge1att)
e4.Name="Impact3"
e4.Brightness=20
e4.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e4.Orientation="VelocityPerpendicular"
e4.Size=nums({
  numk(0,0),
  numk(.4,18),
  numk(1,21,.1),
})
e4.Texture="rbxassetid://13800461961"
e4.Transparency=nums({
  numk(0,.8),
  numk(1,1),
})
e4.ZOffset=-.1 
e4.Enabled=false 
e4.Rate=7
e4.Lifetime=nr(.3,.3)
e4.EmissionDirection="Top"
e4.Rotation=nr(0,0)
e4.RotSpeed=nr(0,0)
e4.Speed=nr(.002,.002)
e4.SpreadAngle=v2(360,360)
e4.VelocitySpread=360 
e4.FlipbookFramerate=nr(1,1)
e4.FlipbookLayout="Grid4x4"
e4.FlipbookMode="OneShot"
e4:SetAttribute("EmitCount",1)

local e5=Instance.new("ParticleEmitter",charge1att)
e5.Name="Impact4"
e5.Brightness=20
e5.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e5.Orientation="VelocityPerpendicular"

e5.Size=nums({
  numk(0,0),
  numk(.4,18),
  numk(1,21,.1),
})
e5.Texture="rbxassetid://13800461961"
e5.Transparency=nums({
  numk(0,.8),
  numk(1,1),
})
e5.ZOffset=-.1 
e5.Rate=7
e5.Enabled=false 
e5.Lifetime=nr(.3,.3)
e5.EmissionDirection="Top"
e5.Rotation=nr(0,0)
e5.RotSpeed=nr(0,0)
e5.Speed=nr(.002,.002)
e5.SpreadAngle=v2(360,360)
e5.VelocitySpread=360 
e5.FlipbookFramerate=nr(1,1)
e5.FlipbookLayout="Grid4x4"
e5.FlipbookMode="OneShot"
e5:SetAttribute("EmitCount",1)

local e6=Instance.new("ParticleEmitter",charge1att)
e6.Name="Pulse1"
e6.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e6.Brightness=15 
e6.Orientation="FacingCamera"
e6.Size=nums({
  numk(0,0),
  numk(.15,7),
  numk(.3,11),
  numk(.6,13),
  numk(1,14),
})
e6.Texture="rbxassetid://119057920510209"
e6.Transparency=nums({
  numk(0,0),
  numk(1,1),
})
e6.EmissionDirection="Top"
e6.Enabled=false 
e6.Rate=7
e6.Lifetime=nr(.6,.6)
e6.Rotation=nr(0,360)
e6.RotSpeed=nr(0,0)
e6.SpreadAngle=v2(0,0)
e6.VelocitySpread=0 
e6.FlipbookFramerate=nr(1,1)
e6.FlipbookLayout="Grid4x4"
e6.FlipbookMode="OneShot"
e6:SetAttribute("EmitCount",1)

local e7=Instance.new("ParticleEmitter",charge1att)
e7.Name="Pulse2"
e7.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e7.Brightness=15 
e7.Orientation="FacingCamera"
e7.Size=nums({
  numk(0,0),
  numk(.15,7),
  numk(.3,11),
  numk(.6,13),
  numk(1,14),
})
e7.Texture="rbxassetid://119057920510209"
e7.Transparency=nums({
  numk(0,0),
  numk(1,1),
})
e7.EmissionDirection="Top"
e7.Enabled=false 
e7.Rate=7
e7.Lifetime=nr(.6,.6)
e7.Rotation=nr(0,360)
e7.RotSpeed=nr(0,0)
e7.SpreadAngle=v2(0,0)
e7.VelocitySpread=0 
e7.FlipbookFramerate=nr(1,1)
e7.FlipbookLayout="Grid4x4"
e7.FlipbookMode="OneShot"
e7:SetAttribute("EmitCount",1)

local e8=Instance.new("ParticleEmitter",charge1att)
e8.Name="Pulse3"
e8.Brightness=15
e8.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e8.Orientation="VelocityPerpendicular"
--0 0 0 0.156376 9.1546 0 0.394376 15.4639 0 0.606376 17.4659 0 1 18.2 0 
e8.Size=nums({
  numk(0,0),
  numk(.15,9),
  numk(.39,15),
  numk(1,18.2),
})
e8.Texture="rbxassetid://98161445784635"
e8.Transparency=nums({
  numk(0,.5),
  numk(1,1),
})
e8.EmissionDirection="Top"
e8.Enabled=false
e8.Rate=7
e8.Lifetime=nr(.3,.3)
e8.Speed=nr(.001,.001)
e8.SpreadAngle=v2(180,180)
e8.VelocitySpread=180 
e8.FlipbookFramerate=nr(1,2)
e8.FlipbookLayout="Grid4x4"
e8.FlipbookMode="OneShot"
e8:SetAttribute("EmitCount",1)

local e9=Instance.new("ParticleEmitter",charge1att)
e9.Name="Pulse4"
e9.Brightness=15
e9.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e9.Orientation="VelocityPerpendicular"
--0 0 0 0.156376 9.1546 0 0.394376 15.4639 0 0.606376 17.4659 0 1 18.2 0 
e9.Size=nums({
  numk(0,0),
  numk(.15,9),
  numk(.39,15),
  numk(1,18.2),
})
e9.Texture="rbxassetid://98161445784635"
e9.Transparency=nums({
  numk(0,.5),
  numk(1,1),
})
e9.EmissionDirection="Top"
e9.Enabled=false
e9.Rate=7
e9.Lifetime=nr(.3,.3)
e9.Speed=nr(.001,.001)
e9.SpreadAngle=v2(180,180)
e9.VelocitySpread=180 
e9.FlipbookFramerate=nr(1,2)
e9.FlipbookLayout="Grid4x4"
e9.FlipbookMode="OneShot"
e9:SetAttribute("EmitCount",1)

local e10=Instance.new("ParticleEmitter",charge1att)
e10.Name="WhiteStarPulse"
e10.Orientation="FacingCamera"
e10.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
--0 0 0 0.156376 7.042 0 0.394376 11.8953 0 0.606376 13.4353 0 1 14 0 
e10.Size=nums({
  numk(0,0),
  numk(.15,7),
  numk(.39,11),
  numk(.6,13),
  numk(1,14),
})
e10.Transparency=nums({
  numk(0,0),
  numk(1,1),
})
e10.ZOffset=3
e10.Texture=Asset("star.png")
e10.EmissionDirection="Top"
e10.Enabled=false 
e10.Lifetime=nr(.6,.6)
e10.Rate=3.5
e10.Rotation=nr(0,360)
e10.RotSpeed=nr(0,0)
e10.Speed=nr(0,0)
e10.SpreadAngle=v2(0,0)
e10.VelocitySpread=0 
e10.FlipbookFramerate=nr(1,1)
e10.FlipbookLayout="None"
e10.FlipbookMode="OneShot"
e10:SetAttribute("EmitCount",1)

local e11=Instance.new("ParticleEmitter",charge1att)
e11.Name="BlackStarPulse"
e11.Texture=Asset("star.png")
e11.Orientation="FacingCamera"
e11.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0)),
})
--0 0 0 0.156376 7.042 0 0.394376 11.8953 0 0.606376 13.4353 0 1 14 0 
e11.Size=nums({
  numk(0,0),
  numk(.15,7),
  numk(.39,11),
  numk(.6,13),
  numk(1,14),
})
e11.Transparency=nums({
  numk(0,0),
  numk(1,1),
})
e11.ZOffset=4
e11.EmissionDirection="Top"
e11.Enabled=false 
e11.Lifetime=nr(.6,.6)
e11.Rate=3.5
e11.Rotation=nr(0,360)
e11.RotSpeed=nr(0,0)
e11.Speed=nr(0,0)
e11.SpreadAngle=v2(0,0)
e11.VelocitySpread=0 
e11.FlipbookFramerate=nr(1,1)
e11.FlipbookLayout="None"
e11.FlipbookMode="OneShot"
e11:SetAttribute("EmitCount",1)

local e12=Instance.new("ParticleEmitter",charge1att)
e12.Name="Star1"
e12.Brightness=15 
e12.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
--0 0 0 0.1 17.5 0 1 0 0 
e12.Orientation="FacingCamera"
e12.Size=nums({
  numk(0,0),
  numk(.1,17),
  numk(1,0),
})
e12.Texture=Asset("star.png")
e12.Transparency=nums({
  numk(0,0),
  numk(1,0),
})
e12.ZOffset=5
e12.EmissionDirection="Top"
e12.Enabled=false 
e12.Lifetime=nr(.3,.3)
e12.Rate=7
e12.Rotation=nr(0,360)
e12.RotSpeed=nr(0,0)
e12.Speed=nr(0,0)
e12.SpreadAngle=v2(0,0)
e12.VelocitySpread=0
e12.FlipbookFramerate=nr(1,1)
e12.FlipbookLayout="None"
e12.FlipbookMode="OneShot"
e12:SetAttribute("EmitCount",1)

local e13=Instance.new("ParticleEmitter",charge1att)
e13.Name="Star2"
e13.Brightness=15 
e13.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
--0 0 0 0.1 17.5 0 1 0 0 
e13.Orientation="FacingCamera"
e13.Size=nums({
  numk(0,0),
  numk(.1,17),
  numk(1,0),
})
e13.Texture=Asset("star.png")
e13.Transparency=nums({
  numk(0,0),
  numk(1,0),
})
e13.ZOffset=4
e13.EmissionDirection="Top"
e13.Enabled=false 
e13.Lifetime=nr(.3,.3)
e13.Rate=7
e13.Rotation=nr(0,360)
e13.RotSpeed=nr(0,0)
e13.Speed=nr(0,0)
e13.SpreadAngle=v2(0,0)
e13.VelocitySpread=0
e13.FlipbookFramerate=nr(1,1)
e13.FlipbookLayout="None"
e13.FlipbookMode="OneShot"
e13:SetAttribute("EmitCount",1)

local e14=Instance.new("ParticleEmitter",charge1att)
e14.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0)),
})
e14.Name="Stardark1"
e14.Orientation="FacingCamera"
--0 0 0 0.1 22.75 0 1 0 0 
e14.Size=nums({
  numk(0,0),
  numk(.1,22.75),
  numk(1,0),
})
e14.Texture=Asset("star.png")
e14.Transparency=nums({
  numk(0,0),
  numk(1,0)
})
e14.ZOffset=4 
e14.EmissionDirection="Top"
e14.Enabled=false 
e14.Lifetime=nr(.3,.3)
e14.Rate=7
e14.Rotation=nr(0,360)
e14.RotSpeed=nr(0,0)
e14.Speed=nr(0,0)
e14.SpreadAngle=v2(0,0)
e14.VelocitySpread=0 
e14.FlipbookFramerate=nr(1,1)
e14.FlipbookLayout="None"
e14.FlipbookMode="OneShot"
e14:SetAttribute("EmitCount",1)

local e15=Instance.new("ParticleEmitter",charge1att)
e15.Name="Stardark2"
e15.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0)),
})
e15.Orientation="FacingCamera"
--0 0 0 0.1 22.75 0 1 0 0 
e15.Size=nums({
  numk(0,0),
  numk(.1,22.75),
  numk(1,0),
})
e15.Texture=Asset("star.png")
e15.Transparency=nums({
  numk(0,0),
  numk(1,0)
})
e15.ZOffset=224 
e15.EmissionDirection="Top"
e15.Enabled=false 
e15.Lifetime=nr(.3,.3)
e15.Rate=7
e15.Rotation=nr(0,360)
e15.RotSpeed=nr(0,0)
e15.Speed=nr(0,0)
e15.SpreadAngle=v2(0,0)
e15.VelocitySpread=0 
e15.FlipbookFramerate=nr(1,1)
e15.FlipbookLayout="None"
e15.FlipbookMode="OneShot"
e15:SetAttribute("EmitCount",1)

local e16=Instance.new("ParticleEmitter",charge1att)
e16.Name="Wind1"
e16.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e16.Orientation="VelocityPerpendicular"
--0 0 0 0.10339 14.7875 0 0.342373 28.4375 0 0.535593 32.76 0 1 36.4 0 
e16.Size=nums({
  numk(0,0),
  numk(.1,14.8),
  numk(.3,28.8),
  numk(.5,32.7),
  numk(1,36.4),
})
e16.Texture="rbxassetid://14850595833"
e16.Transparency=nums({
  numk(0,.2),
  numk(1,1),
})
e16.EmissionDirection="Top"
e16.Enabled=false 
e16.Lifetime=nr(.3,.3)
e16.Rate=14 
e16.Rotation=nr(0,0)
e16.RotSpeed=nr(0,0)
e16.Speed=nr(.002,.002)
e16.SpreadAngle=v2(15,15)
e16.VelocitySpread=15 
e16.FlipbookFramerate=nr(1,1)
e16.FlipbookLayout="None"
e16.FlipbookMode="OneShot"
e16:SetAttribute("EmitCount",1)

local e17=Instance.new("ParticleEmitter",charge1att)
e17.Name="Wind2"
e17.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e17.Orientation="VelocityPerpendicular"
--0 0 0 0.10339 14.7875 0 0.342373 28.4375 0 0.535593 32.76 0 1 36.4 0 
e17.Size=nums({
  numk(0,0),
  numk(.1,14.8),
  numk(.3,28.8),
  numk(.5,32.7),
  numk(1,36.4),
})
e17.Texture="rbxassetid://16434901408"
e17.Transparency=nums({
  numk(0,.5),
  numk(1,1),
})
e17.EmissionDirection="Top"
e17.Enabled=false 
e17.Lifetime=nr(.3,.3)
e17.Rate=14
e17.Rotation=nr(0,0)
e17.RotSpeed=nr(0,0)
e17.Speed=nr(.002,.002)
e17.SpreadAngle=v2(15,15)
e17.VelocitySpread=15 
e17.FlipbookFramerate=nr(1,1)
e17.FlipbookLayout="None"
e17.FlipbookMode="OneShot"
e17:SetAttribute("EmitCount",1)

local e18=Instance.new("ParticleEmitter",charge1att)
e18.Name="Lightning"
e18.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e18.Orientation="VelocityParallel"
e18.Size=nums({
  numk(0,12.6),
  numk(1,12.6),
})
e18.Squash=nums({
  numk(0,0),
  numk(1,.213,.1),
})
e18.Texture="rbxassetid://132060681192414"
e18.Transparency=nums({
  numk(0,0),
  numk(1,.18),
})
e18.ZOffset=3.3 
e18.EmissionDirection="Top"
e18.Enabled=false 
e18.Lifetime=nr(.11,.13)
e18.Rate=7 
e18.Rotation=nr(-996,1004)
e18.RotSpeed=nr(0,0)
e18.Speed=nr(0,0)
e18.SpreadAngle=v2(-1000,1000)
e18.VelocitySpread=-1000 
e18.FlipbookFramerate=nr(2.34,2.34)
e18.FlipbookLayout="Grid4x4"
e18.FlipbookMode="OneShot"
e18:SetAttribute("EmitCount",1)

local e19=Instance.new("ParticleEmitter",charge1att)
e19.Name="EyeShine"
e19.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e19.Brightness=15 
--0 -0.5 0 1 -0.5 0 
e19.Orientation="FacingCamera"
e19.Squash=nums({
  numk(0,-.5),
  numk(1,-.5)
})
e19.Size=nums({
  numk(0,0),
  numk(.1,21),
  numk(1,0),
})
e19.Transparency=nums({
  numk(0,1),
  numk(.5,.3),
  numk(1,1),
})
e19.ZOffset=20
e19.Texture="rbxassetid://82921243876307"
e19.EmissionDirection="Top"
e19.Enabled=false 
e19.Lifetime=nr(.3,.3)
e19.Rate=7 
e19.Rotation=nr(0,0)
e19.Rotation=nr(0,0)
e19.RotSpeed=nr(0,0)
e19.Speed=nr(0,0)
e19.SpreadAngle=v2(0,0)
e19.VelocitySpread=0 
e19.FlipbookFramerate=nr(1,1)
e19.FlipbookLayout="None"
e19.FlipbookMode="OneShot"
e19:SetAttribute("EmitCount",1)

local e20=Instance.new("ParticleEmitter",charge1att)
e20.Name="WhiteStarBurst"
e20.Brightness=20 
e20.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
})
e20.Orientation="FacingCamera"
--0 0 0 0.1 36 0 0.230376 14.988 0 0.428376 4.788 0 1 0 0 
e20.Size=nums({
  numk(0,0),
  numk(.1,36),
  numk(.23,15),
  numk(.4,4),
  numk(1,0),
})
e20.ZOffset=13
e20.Texture="rbxassetid://8905832887"
e20.EmissionDirection="Top"
e20.Enabled=false 
e20.Lifetime=nr(.2,.2)
e20.Rate=7 
e20.Rotation=nr(0,360)
e20.RotSpeed=nr(0,0)
e20.Speed=nr(300,500)
e20.SpreadAngle=v2(180,180)
e20.VelocitySpread=180 
e20.FlipbookFramerate=nr(1,1)
e20.FlipbookLayout="None"
e20.FlipbookMode="OneShot"
e20:SetAttribute("EmitCount",1)

local e21=Instance.new("ParticleEmitter",charge1att)
e21.Name="DarkStarBurst"
e21.Brightness=0 
e21.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0))
})
e21.Orientation="FacingCamera"
--0 0 0 0.1 36 0 0.230376 14.988 0 0.428376 4.788 0 1 0 0 
e21.Size=nums({
  numk(0,0),
  numk(.1,36),
  numk(.23,15),
  numk(.4,4),
  numk(1,0),
})
e21.ZOffset=13
e21.Texture="rbxassetid://8905832887"
e21.EmissionDirection="Top"
e21.Enabled=false 
e21.Lifetime=nr(.2,.2)
e21.Rate=7 
e21.Rotation=nr(0,360)
e21.RotSpeed=nr(0,0)
e21.Speed=nr(300,500)
e21.SpreadAngle=v2(180,180)
e21.VelocitySpread=180 
e21.FlipbookFramerate=nr(1,1)
e21.FlipbookLayout="None"
e21.FlipbookMode="OneShot"
e21:SetAttribute("EmitCount",1)

local e22=Instance.new("ParticleEmitter",charge1att)
e22.Name="Lightning1"
e22.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e22.Orientation="VelocityParallel"
e22.Size=nums({
  numk(0,12.6),
  numk(1,12.6),
})
e22.Squash=nums({
  numk(0,0),
  numk(1,.213,.1),
})
e22.Texture="rbxassetid://132060681192414"
e22.Transparency=nums({
  numk(0,0),
  numk(1,.18),
})
e22.ZOffset=3.3 
e22.EmissionDirection="Top"
e22.Enabled=false 
e22.Lifetime=nr(.11,.13)
e22.Rate=7 
e22.Rotation=nr(-996,1004)
e22.RotSpeed=nr(0,0)
e22.Speed=nr(0,0)
e22.SpreadAngle=v2(-1000,1000)
e22.VelocitySpread=-1000 
e22.FlipbookFramerate=nr(2.34,2.34)
e22.FlipbookLayout="Grid4x4"
e22.FlipbookMode="OneShot"
e22:SetAttribute("EmitCount",1)

local e23=Instance.new("ParticleEmitter",charge1att)
e23.Name="Lightning2"
e23.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e23.Orientation="VelocityParallel"
e23.Size=nums({
  numk(0,12.6),
  numk(1,12.6),
})
e23.Squash=nums({
  numk(0,0),
  numk(1,.213,.1),
})
e23.Texture="rbxassetid://132060681192414"
e23.Transparency=nums({
  numk(0,0),
  numk(1,.18),
})
e23.ZOffset=3.3 
e23.EmissionDirection="Top"
e23.Enabled=false 
e23.Lifetime=nr(.11,.13)
e23.Rate=7 
e23.Rotation=nr(-996,1004)
e23.RotSpeed=nr(0,0)
e23.Speed=nr(0,0)
e23.SpreadAngle=v2(-1000,1000)
e23.VelocitySpread=-1000 
e23.FlipbookFramerate=nr(2.34,2.34)
e23.FlipbookLayout="Grid4x4"
e23.FlipbookMode="OneShot"
e23:SetAttribute("EmitCount",1)

local e24=Instance.new("ParticleEmitter",charge1att)
e24.Name="GlareWhite"
e24.Brightness=10
e24.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e24.Orientation="FacingCamera"
--0 5 0 0.1 65.5894 0 0.2 96.0972 0 0.3 110.692 0 0.4 117.975 0 0.5 121.705 0 0.6 123.593 0 0.7 124.494 0 0.8 124.87 0 0.9 124.986 0 1 125 0 1 125 0 
e24.Size=nums({
  numk(0,5),
  numk(.1,65),
  numk(.2,96),
  numk(.3,110),
  numk(.4,117),
  numk(.5,212),
  numk(.6,123),
  numk(.7,124),
  numk(.8,124),
  numk(.9,125),
  numk(1,125),
})
e24.Texture="rbxassetid://74633209088223"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e24.Transparency=nums({
  numk(0,2),
  numk(.1,.21),
  numk(.5,.38),
  numk(.8,.56),
  numk(1,1),
})
e24.ZOffset=0
e24.EmissionDirection="Top"
e24.Enabled=false 
e24.Lifetime=nr(.1,.3)
e24.Rate=7 
e24.Rotation=nr(0,360)
e24.RotSpeed=nr(0,0)
e24.Speed=nr(.001,.001)
e24.SpreadAngle=v2(180,180)
e24.VelocitySpread=180 
e24.FlipbookFramerate=nr(1,1)
e24.FlipbookLayout="None"
e24.FlipbookMode="OneShot"
e24:SetAttribute("EmitCount",1)

local e25=Instance.new("ParticleEmitter",charge1att)
e25.Name="Impact"
e25.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e25.Orientation="VelocityPerpendicular"
--0 12 0 0.0762712 35.625 0 0.225424 50.625 0 0.5 57.375 0 1 60 0 
e25.Size=nums({
  numk(0,12),
  numk(.07,35),
  numk(.22,50),
  numk(.5,57.37),
  numk(1,70),
})
e25.Texture="rbxassetid://18453327840"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e25.Transparency=nums({
  numk(0,1),
  numk(.1,0),
  numk(.21,.512),
  numk(.38,.79),
  numk(.56,.925),
  numk(1,1),
})
e25.ZOffset=0
e25.EmissionDirection="Top"
e25.Enabled=false 
e25.Lifetime=nr(.2,.5)
e25.Rate=7 
e25.Rotation=nr(0,360)
e25.RotSpeed=nr(0,0)
e25.Speed=nr(.001,.001)
e25.SpreadAngle=v2(180,180)
e25.VelocitySpread=180 
e25.FlipbookFramerate=nr(1,1)
e25.FlipbookLayout="None"
e25.FlipbookMode="OneShot"
e25:SetAttribute("EmitCount",1)

local e26=Instance.new("ParticleEmitter",charge1att)
e26.Name="Impact1"
e26.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e26.Orientation="VelocityPerpendicular"
--0 12 0 0.0762712 35.625 0 0.225424 50.625 0 0.5 57.375 0 1 60 0 
e26.Size=nums({
  numk(0,12),
  numk(.07,35),
  numk(.22,50),
  numk(.5,57.37),
  numk(1,70),
})
e26.Texture="rbxassetid://15536021290"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e26.Transparency=nums({
  numk(0,1),
  numk(.1,0),
  numk(.21,.512),
  numk(.38,.79),
  numk(.56,.925),
  numk(1,1),
})
e26.ZOffset=0
e26.EmissionDirection="Top"
e26.Enabled=false 
e26.Lifetime=nr(.2,.5)
e26.Rate=7 
e26.Rotation=nr(0,360)
e26.RotSpeed=nr(0,0)
e26.Speed=nr(.001,.001)
e26.SpreadAngle=v2(180,180)
e26.VelocitySpread=180 
e26.FlipbookFramerate=nr(1,1)
e26.FlipbookLayout="Grid4x4"
e26.FlipbookMode="OneShot"
e26:SetAttribute("EmitCount",1)

local e27=Instance.new("ParticleEmitter",charge1att)
e27.Name="Impacts2"
e25.Brightness=45
e27.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0))
}) 
e27.Orientation="VelocityPerpendicular"
--0 40 0 1 40 0 
e27.Size=nums({
  numk(0,40),
  numk(1,40),
})
e27.Texture="rbxassetid://18140248952"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e27.Transparency=nums({
  numk(0,1),
  numk(.1,0),
  numk(1,1),
})
e27.ZOffset=0
e27.EmissionDirection="Top"
e27.Enabled=false 
e27.Lifetime=nr(.3,.3)
e27.Rate=7 
e27.Rotation=nr(0,360)
e27.RotSpeed=nr(0,0)
e27.Speed=nr(.001,.001)
e27.SpreadAngle=v2(35,35)
e27.VelocitySpread=35 
e27.FlipbookFramerate=nr(1,1)
e27.FlipbookLayout="Grid4x4"
e27.FlipbookMode="OneShot"
e27:SetAttribute("EmitCount",1)

local e28=Instance.new("ParticleEmitter",charge1att)
e28.Name="Impacts3"
e25.Brightness=45
e28.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e28.Orientation="VelocityPerpendicular"
--0 40 0 0.0830508 52.5 0 0.211864 59 0 0.472881 60.5 0 1 64 0 
e28.Size=nums({
  numk(0,40),
  numk(.08,52.5),
  numk(.21,59),
  numk(.47,60.5),
  numk(1,64),
})
e28.Texture="rbxassetid://13280251453"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e28.Transparency=nums({
  numk(0,1),
  numk(.1,.8),
  numk(1,1),
})
e28.ZOffset=0
e28.EmissionDirection="Top"
e28.Enabled=false 
e28.Lifetime=nr(.3,.5)
e28.Rate=7 
e28.Rotation=nr(0,360)
e28.RotSpeed=nr(0,0)
e28.Speed=nr(.001,.001)
e28.SpreadAngle=v2(3,3)
e28.VelocitySpread=3
e28.FlipbookFramerate=nr(1,1)
e28.FlipbookLayout="None"
e28.FlipbookMode="OneShot"
e28:SetAttribute("EmitCount",1)

local e29=Instance.new("ParticleEmitter",charge1att)
e29.Name="Impacts4"
e25.Brightness=45
e29.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e29.Orientation="VelocityPerpendicular"
--0 40 0 0.0830508 52.5 0 0.211864 59 0 0.472881 60.5 0 1 64 0 
e29.Size=nums({
  numk(0,40),
  numk(.08,52.5),
  numk(.21,59),
  numk(.47,60.5),
  numk(1,64),
})
e29.Texture="rbxassetid://10529371971"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e29.Transparency=nums({
  numk(0,1),
  numk(.1,.9),
  numk(1,1),
})
e29.ZOffset=0
e29.EmissionDirection="Top"
e29.Enabled=false 
e29.Lifetime=nr(.3,.5)
e29.Rate=7 
e29.Rotation=nr(0,360)
e29.RotSpeed=nr(0,0)
e29.Speed=nr(.001,.001)
e29.SpreadAngle=v2(3,3)
e29.VelocitySpread=3
e29.FlipbookFramerate=nr(1,1)
e29.FlipbookLayout="None"
e29.FlipbookMode="OneShot"
e29:SetAttribute("EmitCount",1)

local e30=Instance.new("ParticleEmitter",charge1att)
e30.Name="Impacts5"
e25.Brightness=45
e30.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e30.Orientation="VelocityPerpendicular"
--0 40 0 0.0830508 52.5 0 0.211864 59 0 0.472881 60.5 0 1 64 0 
e30.Size=nums({
  numk(0,40),
  numk(.08,52.5),
  numk(.21,59),
  numk(.47,60.5),
  numk(1,64),
})
e30.Texture="rbxassetid://18356099314"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e30.Transparency=nums({
  numk(0,1),
  numk(.1,.9),
  numk(1,1),
})
e30.ZOffset=0
e30.EmissionDirection="Top"
e30.Enabled=false 
e30.Lifetime=nr(.3,.5)
e30.Rate=7 
e30.Rotation=nr(0,360)
e30.RotSpeed=nr(0,0)
e30.Speed=nr(.001,.001)
e30.SpreadAngle=v2(3,3)
e30.VelocitySpread=3
e30.FlipbookFramerate=nr(1,1)
e30.FlipbookLayout="None"
e30.FlipbookMode="OneShot"
e30:SetAttribute("EmitCount",1)

local e31=Instance.new("ParticleEmitter",charge1att)
e31.Name="HorizonImpact"
e25.Brightness=15
e31.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e31.Orientation="VelocityPerpendicular"
--0 12 0 0.0762712 35.625 0 0.225424 50.625 0 0.5 57.375 0 1 60 0 
e31.Size=nums({
  numk(0,12),
  numk(.07,35.625),
  numk(.22,50.625),
  numk(.5,57.5),
  numk(1,60),
})
e31.Texture="rbxassetid://16924410706"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e31.Transparency=nums({
  numk(0,1),
  numk(.1,0),
  numk(.21,.51),
  numk(.38,.79),
  numk(.56,.925),
  numk(1,1),
})
e31.ZOffset=0
e31.EmissionDirection="Top"
e31.Enabled=false 
e31.Lifetime=nr(.2,.5)
e31.Rate=14
e31.Rotation=nr(0,360)
e31.RotSpeed=nr(0,0)
e31.Speed=nr(.001,.001)
e31.SpreadAngle=v2(6,6)
e31.VelocitySpread=6
e31.FlipbookFramerate=nr(1,1)
e31.FlipbookLayout="Grid4x4"
e31.FlipbookMode="OneShot"
e31:SetAttribute("EmitCount",1)

local e32=Instance.new("ParticleEmitter",charge1att)
e32.Name="Wind3"
e32.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e32.Orientation="VelocityPerpendicular"
--0 0 0 0.10339 14.7875 0 0.342373 28.4375 0 0.535593 32.76 0 1 36.4 0 
e32.Size=nums({
  numk(0,0),
  numk(.1,14.8),
  numk(.3,28.8),
  numk(.5,32.7),
  numk(1,36.4),
})
e32.Texture="rbxassetid://16434901408"
e32.Transparency=nums({
  numk(0,.5),
  numk(1,1),
})
e32.EmissionDirection="Top"
e32.Enabled=false 
e32.Lifetime=nr(.3,.3)
e32.Rate=14
e32.Rotation=nr(0,0)
e32.RotSpeed=nr(0,0)
e32.Speed=nr(.002,.002)
e32.SpreadAngle=v2(15,15)
e32.VelocitySpread=15 
e32.FlipbookFramerate=nr(1,1)
e32.FlipbookLayout="None"
e32.FlipbookMode="OneShot"
e32:SetAttribute("EmitCount",1)

local e33=Instance.new("ParticleEmitter",charge1att)
e33.Name="Wind4"
e33.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e33.Orientation="VelocityPerpendicular"
--0 0 0 0.10339 14.7875 0 0.342373 28.4375 0 0.535593 32.76 0 1 36.4 0 
e33.Size=nums({
  numk(0,0),
  numk(.1,14.8),
  numk(.3,28.8),
  numk(.5,32.7),
  numk(1,36.4),
})
e33.Texture="rbxassetid://16434901408"
e33.Transparency=nums({
  numk(0,.5),
  numk(1,1),
})
e33.EmissionDirection="Top"
e33.Enabled=false 
e33.Lifetime=nr(.3,.3)
e33.Rate=14
e33.Rotation=nr(0,0)
e33.RotSpeed=nr(0,0)
e33.Speed=nr(.002,.002)
e33.SpreadAngle=v2(15,15)
e33.VelocitySpread=15 
e33.FlipbookFramerate=nr(1,1)
e33.FlipbookLayout="None"
e33.FlipbookMode="OneShot"
e33:SetAttribute("EmitCount",1)

local e34=Instance.new("ParticleEmitter",charge1att)
e34.Name="Wind5"
e34.Color=cs({
  csk(0,rgb(255,255,255)),
  csk(1,rgb(255,255,255))
}) 
e34.Orientation="VelocityPerpendicular"
--0 0 0 0.10339 14.7875 0 0.342373 28.4375 0 0.535593 32.76 0 1 36.4 0 
e34.Size=nums({
  numk(0,0),
  numk(.1,14.8),
  numk(.3,28.8),
  numk(.5,32.7),
  numk(1,36.4),
})
e34.Texture="rbxassetid://16434901408"
e34.Transparency=nums({
  numk(0,.5),
  numk(1,1),
})
e34.EmissionDirection="Top"
e34.Enabled=false 
e34.Lifetime=nr(.3,.3)
e34.Rate=14
e34.Rotation=nr(0,0)
e34.RotSpeed=nr(0,0)
e34.Speed=nr(.002,.002)
e34.SpreadAngle=v2(15,15)
e34.VelocitySpread=15 
e34.FlipbookFramerate=nr(1,1)
e34.FlipbookLayout="None"
e34.FlipbookMode="OneShot"
e34:SetAttribute("EmitCount",1)

local e35=Instance.new("ParticleEmitter",charge1att)
e35.Name="GlareDark"
e35.Brightness=50
e35.Color=cs({
  csk(0,rgb(0,0,0)),
  csk(1,rgb(0,0,0))
}) 
e35.Orientation="FacingCamera"
--0 5 0 0.1 65.5894 0 0.2 96.0972 0 0.3 110.692 0 0.4 117.975 0 0.5 121.705 0 0.6 123.593 0 0.7 124.494 0 0.8 124.87 0 0.9 124.986 0 1 125 0 1 125 0 
e35.Size=nums({
  numk(0,5),
  numk(.1,65),
  numk(.2,96),
  numk(.3,110),
  numk(.4,117),
  numk(.5,212),
  numk(.6,123),
  numk(.7,124),
  numk(.8,124),
  numk(.9,125),
  numk(1,125),
})
e35.Texture="rbxassetid://74633209088223"
--0 1 0 0.1 0 0 0.211864 0.5125 0 0.383051 0.79375 0 0.566102 0.925 0 1 1 0 
e35.Transparency=nums({
  numk(0,2),
  numk(.1,.21),
  numk(.5,.38),
  numk(.8,.56),
  numk(1,1),
})
e35.ZOffset=0
e35.EmissionDirection="Top"
e35.Enabled=false 
e35.Lifetime=nr(.1,.3)
e35.Rate=7 
e35.Rotation=nr(0,360)
e35.RotSpeed=nr(0,0)
e35.Speed=nr(.001,.001)
e35.SpreadAngle=v2(180,180)
e35.VelocitySpread=180 
e35.FlipbookFramerate=nr(1,1)
e35.FlipbookLayout="None"
e35.FlipbookMode="OneShot"
e35:SetAttribute("EmitCount",1)




local TopFrameBars=Instance.new("Frame",EquinoxFolder)
TopFrameBars.Size=u2(1,0,.3,0)
TopFrameBars.BackgroundTransparency=1 
TopFrameBars.Name="TopFrame"
TopFrameBars.Position=UDim2.fromScale(.05,-.5)

local TopframeBar=Instance.new("Frame",TopFrameBars)
TopframeBar.Size=u2(.05,0,1,0)
TopframeBar.BackgroundTransparency=1 


local TopframeBarImage=Instance.new("ImageLabel",TopframeBar)
TopframeBarImage.Image="rbxassetid://13271935089"
TopframeBarImage.ImageColor3=rgb(255,255,255)
TopframeBarImage.ScaleType="Stretch"
TopframeBarImage.Position=u2(.5,0,0,0)
TopframeBarImage.Size=u2(1,0,2,0)
TopframeBarImage.BackgroundTransparency=1

local topbarlayout=Instance.new("UIListLayout",TopFrameBars)
topbarlayout.FillDirection="Horizontal"
topbarlayout.SortOrder="Name"





local BottomFrame=Instance.new("Frame",EquinoxFolder)
BottomFrame.Size=u2(1,0,.3,0)
BottomFrame.Position=u2(0,0,.7,0)
BottomFrame.BackgroundTransparency=1 
BottomFrame.Name="BottomFrame"

local BottomFrameBar=Instance.new("Frame",BottomFrame)
BottomFrameBar.Size=u2(.05,0,1,0)
BottomFrameBar.BackgroundTransparency=1 


local BottomFrameBarImage=Instance.new("ImageLabel",BottomFrameBar)
BottomFrameBarImage.Image="rbxassetid://13271935089"
BottomFrameBarImage.ImageColor3=rgb(255,255,255)
BottomFrameBarImage.ScaleType="Stretch"
BottomFrameBarImage.Position=u2(.5,0,0,0)
BottomFrameBarImage.Size=u2(1,0,2,0)
BottomFrameBarImage.BackgroundTransparency=1

local BottomFrameLayout=Instance.new("UIListLayout",BottomFrame)
BottomFrameLayout.FillDirection="Horizontal"
BottomFrameLayout.SortOrder="Name"
wait(1)



local particlefolderclone=ws:FindFirstChild("EquinoxAssets"):Clone()
EquinoxCloneBars()
print("Loaded.")
particlefolderclone.Parent=HumanoidRoot
Hmm(10)
coroutine.resume(coroutine.create(function()
local ff 
ff=game:GetService("RunService").RenderStepped:Connect(function()
if Mode~="E q u i n o x" then
gr1:Destroy()
gr2:Destroy()
stk:Destroy()
att1:Destroy()
att2:Destroy()
bbg2:Destroy()
charge1att:Destroy()
if ws:FindFirstChild("EquinoxAssets") then
ws.EquinoxAssets:Destroy()
end
particlefolderclone:Destroy()

ff:Disconnect()
Hmm(0)
end

if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("EquinoxAssets") then 
local Effects=game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("EquinoxAssets"):FindFirstChild("ParticleAttachmets")
if Effects then 
if Torso:FindFirstChild("ParticleAttachmets") then 
Effects:Destroy() 
else
Effects.Parent=Torso
print("Parented")
end
end
else
ws:FindFirstChild("EquinoxAssets"):Clone().Parent=game.Players.LocalPlayer.Character.HumanoidRootPart
end
local Torso=SafePart("Accessory (Black)")
if not Torso:FindFirstChild("ParticleAttachmets") then 
ws:FindFirstChild("EquinoxAssets"):FindFirstChild("ParticleAttachmets"):Clone().Parent=Torso
end
end)
end))

end

function EquinoxBeats(start,dur,current)
if current >= start and current <= dur and Mode=="E q u i n o x" then
if not Debounce then
Debounce= true
coroutine.resume(coroutine.create(function() 
local Count = 0
local BeatInterval = 0.3
while current <= dur and Mode=="E q u i n o x" do

pcall(function()
local Particles=game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("EquinoxAssets")
local Particle1=Particles:FindFirstChild("ParticleAttachmets")
local Torso=SafePart("Accessory (Black)")
if Particle1 and Particle1.Parent ~=Torso then 
Particle1.Parent=Torso
end
for _,v in ipairs(Particles:GetDescendants()) do
if v:IsA("ParticleEmitter") then
v:Emit(v:GetAttribute("EmitCount"))
end
end
for _,v in ipairs(Torso:GetChildren()) do
if v.Name=="ParticleAttachmets" and v.Parent~="CamFocus" then
for _,c in ipairs(v:GetChildren()) do
if c:IsA("ParticleEmitter") then 
c:Emit(c:GetAttribute("EmitCount"))
end
end
end
end
end)

--print("Beat at " .. current .. " seconds")
pcall(function()
EquinoxTexts()
EquinoxMainBars()
end)
Count = Count + 1
local waitTime = math.min(BeatInterval, dur - current)
if waitTime > 0 then
wait(waitTime)
pcall(function()
for _,v in ipairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetDescendants()) do
if v:IsA("ParticleEmitter") then
v.Enabled=false
end
end
for _,v in ipairs(Torso:GetDescendants()) do
if v:IsA("ParticleEmitter") then
v.Enabled=false
end
end
end)
Hmm(10)
current = MusicPlayer.TimePosition
else
break
end
end
Debounce = false
end))
coroutine.resume(coroutine.create(function() 
while current >=start and Mode=="E q u i n o x" do
if current>=dur and Mode=="E q u i n o x" then 
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("Frame") or v:IsA("ImageLabel") then
v.Visible=true
end
swait(.01)
end
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("ScreenGui") then
v.Enabled=true
end
swait(.01)
end
break
end
if Mode~="E q u i n o x" then 
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("Frame") or v:IsA("ImageLabel") then
v.Visible=true
end
swait(.01)
end
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("ScreenGui") then
v.Enabled=true
end
swait(.01)
end
break
end 
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("Frame") or v:IsA("ImageLabel") then
v.Visible=false
end
swait(.01)
end
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("ScreenGui") then
v.Enabled=false
end
swait(.01)
end
end
end))
end
end
end

local Debounce1=false
local ColorFlick=false
function EquinoxBobbing()
if not Debounce1 then
if Mode=="E q u i n o x" then
coroutine.resume(coroutine.create(function()
while wait() do
bilguit.StudsOffset=v3(0,2,0)
bilguit.StudsOffsetWorldSpace=v3(0,5,0)
if Debounce1 then return end
Debounce1=true
bilguit.Size=u2(20.5,0,4.5,0)
bilguit.Brightness=100
ColorFlick=not ColorFlick 
coroutine.resume(coroutine.create(function()
if ColorFlick then
for _,v in modet:GetChildren() do 
if v:IsA("UIGradient") and Mode=="E q u i n o x" then 
for i=1,255,25.5 do
if Mode~="E q u i n o x" then 
break 
end
v.Color=cs({
  csk(0,rgb(i,i,i)),
  csk(.45,rgb(i,i,i)),
  csk(.55,rgb(255-i,255-i,255-i)),
  csk(1,rgb(255-i,255-i,255-i))
})
ChangeAndRecolor("E q u i n o x",true,Font.new([[rbxassetid://12187376739]], Enum.FontWeight.Bold, Enum.FontStyle.Normal),rgb(255-i,255-i,255-i),rgb(i,i,i),false,true)
swait()
end
end
end 
else
for _,v in modet:GetChildren() do 
if v:IsA("UIGradient") and Mode=="E q u i n o x" then 
for i=1,255,25.5 do
if Mode~="E q u i n o x" then 
break 
end
v.Color=cs({
  csk(0,rgb(255-i,255-i,255-i)),
  csk(.45,rgb(255-i,255-i,255-i)),
  csk(.55,rgb(i,i,i)),
  csk(1,rgb(i,i,i))
})
ChangeAndRecolor("E q u i n o x",true,Font.new([[rbxassetid://12187376739]], Enum.FontWeight.Bold, Enum.FontStyle.Normal),rgb(i,i,i),rgb(255-i,255-i,255-i),false,true)
swait()
end
end
end
end
end))
if Debounce1 then
if Debounce then
local Tween=TweenFunction(bilguit,.275,"size",u2(20,0,4,0))
local Tween1=TweenFunction(bilguit,.275,"brightness",5)
Tween:Play()
Tween1:Play()
Tween.Completed:Connect(function()
Debounce1=false
end)
else
local Tween=TweenFunction(bilguit,.5,"size",u2(20,0,4,0))
local Tween1=TweenFunction(bilguit,.5,"brightness",5)
Tween:Play()
Tween1:Play()
Tween.Completed:Connect(function()
Debounce1=false
end)
end
break
end
end
end))
end
end
end


function Chromatic(UHH)
wait(1)
function Tween(obj, speed, whattype, anim)
local Tinfo=TweenInfo.new
local TweenService=game.TweenService
local hii = Tinfo(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
if whattype =="pos" then
return TweenService:Create(obj, hii,{Position = anim})
elseif whattype =="size" then
return TweenService:Create(obj, hii,{Size = anim})
elseif whattype =="bt" then
return TweenService:Create(obj, hii,{BackgroundTransparency = anim})
elseif whattype =="trans" then
return TweenService:Create(obj, hii,{Transparency = anim})
elseif whattype=="rot" then
return TweenService:Create(obj, hii,{Rotation = anim})
end
end
local fx = Instance.new("Folder", ws)
fx.Name = "Effects"
local folder=Instance.new("Folder",fx)
folder.Name="Idk"
local mpart=Instance.new("MeshPart",folder)
mpart.Size=Vector3.new(1,1,1)
mpart.MeshId="rbxassetid://2570899763"
mpart.CanCollide=true 
mpart.Position=v3(0,-10,0)
mpart.Transparency=1
mpart.Massless=true 
mpart.Name="Mpart"
wait(.1)
local DDD=Instance.new("Part",fx)
DDD.CanCollide=false
DDD.Massless=true
DDD.CanQuery=false
DDD.Material="Neon"
DDD.Transparency=1
DDD.Anchored=true 
DDD.Size=v3(1,1,1) 
DDD.Position=v3(HumanoidRoot.Position.X,1000,HumanoidRoot.Position.Z)
local v10 = folder:WaitForChild("Mpart")
local marker = 77
local startfreq = 0
local endfreq = 770

local RingParts = {}
local Table1 = {}
local initialCFrames = {}
count=1
-- Pre-calculate positions to avoid repeated calculations
for i = 1, marker do
local v = v10:Clone()
local freq = startfreq + (i-1) * (endfreq - startfreq) / (marker - 1) *.1
count+=1
v.Name = freq
v.Size = Vector3.new(1, 1, 1)
v.Material = Enum.Material.Neon
v.Color = Color3.new(0, 0, 0)
v.CanCollide = false 
v.Massless = true
v.CanQuery = false
v.Anchored = false
v.CastShadow = false
v.Reflectance = 0.5
v.Transparency = 0
v.Parent=fx
local light=Instance.new("PointLight",v)
light.Range=5
light.Name=v.Name

local wel = Instance.new("Weld", v)
wel.Part0 = DDD
wel.Part1 = v

local angle = 4.8 * count 
local initialCF = CFrame.Angles(0, math.rad(angle), 0) * CFrame.new(0, -3.1, 15)
wel.C0 = initialCF

initialCFrames[i] = initialCF
table.insert(RingParts, v)
table.insert(Table1, wel)
end
wait(1)
--[[
for _,v in ipairs(fx:GetChildren()) do
if v:IsA("MeshPart") then 
v.CanCollide=true
end
end]]
local wel1 = Instance.new("Weld", DDD)
wel1.Part0=DDD 
wel1.Part1=HumanoidRoot
function This11(dt, Theme)
local spectrum = MusicPlayer.Analyzer:GetSpectrum()
local spectrumCount = #spectrum
local SafeTreshold = 0.001
local currentTime = tick()
for i, v in ipairs(fx:GetChildren()) do
if v:IsA("MeshPart")  then
local spectrumIndex = math.floor((tonumber(v.Name) / marker) * spectrumCount) + 1
spectrumIndex = math.clamp(spectrumIndex, 1, spectrumCount)
local magnitude = spectrum[spectrumIndex] or 0
local scale = math.min(magnitude / 0.0010 * 2, 550)
local i_pos = tonumber(v.Name) / marker
if magnitude <= SafeTreshold then
v.Color = Color3.new(1, 1, 1)
else
if Theme == "Monochrome" then
v.Color = Color3.fromHSV(1, 0, ( -currentTime * 0.15 + i_pos ) % 1)
elseif Theme == "Rainbow" then
v.Color = Color3.fromHSV(( -currentTime * 0.15 + i_pos ) % 1, 1, 1)
elseif Theme == "Ice" then
v.Color = Color3.fromHSV(.55, ( -currentTime * 0.15 + i_pos ) % 1, 1)
elseif Theme == "Crimson" then
v.Color = Color3.fromHSV(1, 1, ( -currentTime * 0.15 + i_pos ) % 1)
elseif Theme == "Spooky" then
v.Color = Color3.fromHSV(.1, 1, ( -currentTime * 0.15 + i_pos ) % 1)
elseif Theme == "Rainbow2" then
v.Color = Color3.fromHSV((currentTime * .55) % 1, 1, 1)
end
end
if magnitude > SafeTreshold then
local targetSize = Vector3.new(1, 1, math.min(10 * scale, 10.5))
v.Size = v.Size:Lerp(targetSize, 0.25)
else
v.Size = v.Size:Lerp(Vector3.new(1, 1, 1), 0.25)
end
Tween(DDD,1.5,"pos",
Vector3.new(Torso.Position.X, Torso.Position.Y+2, Torso.Position.Z)
):Play()

Tween(DDD,.001,"rot",Vector3.new(0,0,0)):Play()
local wel = Table1[i]
if wel and initialCFrames[i] then
wel.C0 = initialCFrames[i] *
CFrame.Angles(0, 0, math.rad(scale * 0.1))
end
end
end
end
function Light(Theme) 
local spectrum = MusicPlayer.Analyzer:GetSpectrum()
local spectrumCount = #spectrum
local SafeTreshold = 0.001 
local currentTime = tick()
for _,v in fx:GetDescendants() do 
if v:IsA("PointLight")  then
local spectrumIndex = math.floor((tonumber(v.Name) / marker) * spectrumCount) + 1
spectrumIndex = math.clamp(spectrumIndex, 1, spectrumCount)
local magnitude = spectrum[spectrumIndex] or 0
local scale = math.min(magnitude / 0.0010 * 2, 550)
local i_pos = tonumber(v.Name) / marker
if magnitude <= SafeTreshold then
v.Color = Color3.new(1, 1, 1)
else
if Theme == "Monochrome" then
v.Color = Color3.fromHSV(1, 0, ( -currentTime * 0.15 + i_pos ) % 1)
elseif Theme == "Rainbow" then
v.Color = Color3.fromHSV(( -currentTime * 0.15 + i_pos ) % 1, 1, 1)
elseif Theme == "Ice" then
v.Color = Color3.fromHSV(.55, ( -currentTime * 0.15 + i_pos ) % 1, 1)
elseif Theme == "Crimson" then
v.Color = Color3.fromHSV(1, 1, ( -currentTime * 0.15 + i_pos ) % 1)
elseif Theme == "Spooky" then
v.Color = Color3.fromHSV(.1, 1, ( -currentTime * 0.15 + i_pos ) % 1)
elseif Theme == "Rainbow2" then
v.Color = Color3.fromHSV((currentTime * .55) % 1, 1, 1)
if magnitude > SafeTreshold then
v.Brightness=math.min(1*scale,4)
v.Range=math.min(1*scale,5)
else 
v.Brightness=1
v.Range=5
end
end
end
end
end
end
coroutine.resume(coroutine.create(function()
while game:GetService("RunService").Heartbeat:Wait(.00001) do
if Mode ~= "Chromatic" then 
fx:Destroy()
return 
end
This11(0.033, "Rainbow2")
Light("Rainbow2")
end
end))
coroutine.resume(coroutine.create(function()
while wait(5) do
if Mode~="Chromatic" then 
--[[for _,v in ipairs(ws:GetChildren()) do 
if v.Name=="Effects" then 
v:Destroy()
end
end]]
Hmm(0)
break
end
--TweenFunction(HumanoidRoot,.005,"pos",Vector3.new(Torso.Position.X,Torso.Position.Y,Torso.Position.Z)):Play()
end
end))
end




if INTROANIM then
wait(1) -- Wait for the reanimation to load properly
Introduction()
else
wait(.075) -- Wait for the reanimation to load properly
changeMode("E q u i n o x")
ChangeAndRecolor("E q u i n o x",true,Font.new([[rbxassetid://12187376739]], Enum.FontWeight.Bold, Enum.FontStyle.Normal),rgb(255,255,255),rgb(0,0,0),false,true)
EquinoxAssets()
end

















--// Keybinds and etc...
IsKeys=uis.InputBegan:Connect(function(io,gpe)
if gpe then return end

if io.KeyCode==Enum.KeyCode.One and Mode~="Renegades"then
changeMode("Renegades")
ChangeAndRecolor("Renegades",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(255,255,255),rgb(0,160,200),false,false)

elseif io.KeyCode==Enum.KeyCode.Two and Mode~="Overseer" then
changeMode("Overseer")
ChangeAndRecolor("Overseer",true,Font.new([[rbxasset://fonts/families/Michroma.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(39,252,69),rgb(255,255,255),false,false)

elseif io.KeyCode==Enum.KeyCode.Three and Mode~="Mayhem" then
changeMode("Mayhem")
ChangeAndRecolor("Mayhem",false,"Antique",rgb(0,0,0),rgb(224,0,0),false,false)


elseif io.KeyCode==Enum.KeyCode.Four and Mode~="Chaos" then
changeMode("Chaos")


elseif io.KeyCode==Enum.KeyCode.Five and Mode~="Chromatic" then
changeMode("Chromatic")
ChangeAndRecolor("Chromatic",true,Font.new([[rbxasset://fonts/families/PermanentMarker.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(255,255,255),rgb(0,0,0),true)
Chromatic(Torso.Position.Y)


elseif io.KeyCode==Enum.KeyCode.Six and Mode~="Fracture" then
changeMode("Fracture")
ChangeAndRecolor("Fracture",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,69,95),rgb(182,235,255),false,false)


elseif io.KeyCode==Enum.KeyCode.Seven and Mode~="Kronos" then
changeMode("Kronos")
ChangeAndRecolor("Kronos",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Regular, Enum.FontStyle.Italic),rgb(255,247,138),rgb(254,251,209),false,false)


elseif io.KeyCode==Enum.KeyCode.Eight and Mode~="E q u i n o x" then
changeMode("E q u i n o x")
ChangeAndRecolor("E q u i n o x",true,Font.new([[rbxassetid://12187376739]], Enum.FontWeight.Bold, Enum.FontStyle.Normal),rgb(255,255,255),rgb(0,0,0),false,true)
EquinoxAssets()



elseif io.KeyCode==Enum.KeyCode.Nine and Mode~="Shard Surfer" then
changeMode("Shard Surfer")
ChangeAndRecolor("Shard | Surfer",true,Font.new([[rbxasset://fonts/families/Michroma.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(93,228,255),rgb(255,233,93),false,false)


elseif io.KeyCode==Enum.KeyCode.F then
BBGVisibilty=not BBGVisibilty
if BBGVisibilty then
modet.Visible=BBGVisibilty
else
modet.Visible=BBGVisibilty
end

elseif io.KeyCode==Enum.KeyCode.M and Mode=="Mayhem" then
changeMode("Mayhem - No Hope")
ChangeAndRecolor("Mayhem - No Hope",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(255,0,0),rgb(0,0,0),false,false)

elseif io.KeyCode==Enum.KeyCode.M and Mode=="Overseer" then
changeMode("Luminosity")
ChangeAndRecolor("Luminosity",true,Font.new([[rbxasset://fonts/families/Fondamento.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(213,246,255),rgb(175,238,255),false,false)

elseif io.KeyCode==Enum.KeyCode.M and Mode=="Chromatic" then
changeMode("Censored")
ChangeAndRecolor("Censored",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,0,0),rgb(61,255,77),false,false)

elseif io.KeyCode==Enum.KeyCode.M and Mode=="Renegades" then
changeMode("Fragmentation")
ChangeAndRecolor("Fragmentation",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(71,71,71),rgb(223,90,0),false,false)

elseif io.KeyCode==Enum.KeyCode.M and Mode=="Fracture" then
changeMode("Panorama")
ChangeAndRecolor("Panorama",true,Font.new([[rbxasset://fonts/families/PressStart2P.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,0,0),rgb(255,0,0), true,false)


end
end)

--// Misc Function, either for debugging
game.Players.LocalPlayer.Chatted:Connect(function(m)
if m:sub(1,6)==".mode/"then
changeMode(m:sub(7))
elseif m:sub(1,6)==".skip/" then 
MusicPlayer.TimePosition=m:sub(7)
sound.TimePosition=m:sub(7)
end
end)





--// Wing Animation Container
WingAnimations.Renegades=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
if LEGACY then 
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(0,7.5,5.5),angles(0,1.5707963267948966,-1.5707963267948966+0.3490658503988659*sin((sine+0.35)*3.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(0,12.5-1.5*sin((sine+1.5)*3.5),2.5),angles(0,1.5707963267948966,-2.007128639793479+0.3490658503988659*sin((sine+.25)*3.5))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(0,-3.5,-12.5+1.5*sin((sine+1.5)*3.5)),angles(0,1.5707963267948966,0.4363323129985824-0.3490658503988659*sin((sine+.25)*3.5))),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(0,-6,-7.5),angles(0,1.5707963267948966,-0.3490658503988659*sin((sine+0.35)*3.5))),deltaTime)
else 
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,9-2.25*sin((sine+0.15)*1.5),0.6+2*sin((sine+0.75)*1.5)),angles(-1.1344640137963142+0.3490658503988659*sin((sine+0.95)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,5-2.5*sin((sine+0.5)*1.5),2.1-1*sin((sine+0.35)*1.5)),angles(-0.5235987755982988+0.4363323129985824*sin((sine+0.95)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,-2.5+1.25*sin((sine+0.35)*1.5),-4+2.5*sin((sine+0.5)*1.5)),angles(0.5235987755982988-0.4363323129985824*sin((sine+0.9)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,-2.5-2*sin((sine+0.75)*1.5),-8+2.25*sin((sine+0.15)*1.5)),angles(1.1344640137963142-0.3490658503988659*sin((sine+0.95)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
end
end
end


WingAnimations.Overseer=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,-2+10.5*sin(sine*.15),2+10.5*sin(sine*.15)),angles(0+sp/15+Boost/45,1.5707963267948966,2.2689280275926285)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,-2+10.5*sin(sine*.15),2+10.5*sin(sine*.15)),angles(0+sp/15+Boost/45,1.5707963267948966,3.839724354387525)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,-1.35+10.5*sin(sine*.15),2+10.5*sin(sine*.15)),angles(0+sp/15+Boost/45,1.5707963267948966,0.6981317007977318)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,-1.35+10.5*sin(sine*.15),2+10.5*sin(sine*.15)),angles(0+sp/15+Boost/45,1.5707963267948966,-0.8726646259971648)),deltaTime)  
end
end


WingAnimations.Mayhem=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1.5,1.5,1.5),angles(0,1.5707963267948966,-0.8726646259971648-0.17453292519943295*sin((sine+1)*2.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1.5,1.5,8),angles(0,1.5707963267948966,-0.8726646259971648-0.4363323129985824*sin((sine+1)*2.5))),deltaTime) 
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1.5,-0.15 * sin((sine+0.75)*3.5),0.15 * sin((sine+0.75)*3.5)),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1.5,2,4.5),angles(0,1.5707963267948966,-0.8726646259971648-0.2617993877991494*sin((sine+1)*2.5))),deltaTime) 
end
end


WingAnimations.Chaos=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,-2+sound.PlaybackLoudness/50,2+sound.PlaybackLoudness/100),angles(0,1.5707963267948966,2.2689280275926285+sp/15+Boost/20)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,-2+sound.PlaybackLoudness/50,2+sound.PlaybackLoudness/100),angles(0,1.5707963267948966,3.839724354387525+sp/15+Boost/20)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,-1.35+sound.PlaybackLoudness/50,2+sound.PlaybackLoudness/100),angles(0,1.5707963267948966,0.6981317007977318+sp/15+Boost/20)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,-1.35+sound.PlaybackLoudness/50,2+sound.PlaybackLoudness/100),angles(0,1.5707963267948966,-0.8726646259971648+sp/15+Boost/20)),deltaTime)  
end
end



WingAnimations.Chromatic=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,3,1),angles(0+Boost/10,1.5707963267948966,-1.5707963267948966)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-2.75-0.15*sin((sine+0.2)*2),3+sound.PlaybackLoudness/100,-3.35-sound.PlaybackLoudness/100),angles(-2.443460952792061+Boost/20,0.12217304763960307,1.5882496193148399)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(1,3,1),angles(0+Boost/10,-1.5707963267948966,1.5707963267948966)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-2.75-0.15*sin((sine+0.2)*2),1+sound.PlaybackLoudness/50,-1.45-sound.PlaybackLoudness/50),angles(0.6981317007977318+Boost/20,0.12217304763960307,1.5882496193148399)),deltaTime)  
end
end


WingAnimations.Fracture=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.25-2.5*sin((sine+0.45)*1.5),-8+2.5*sin((sine+0.65)*1.5)),angles(0,1.5707963267948966,3.141592653589793-0.2617993877991494*sin((sine+0.25)*1.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,8-2.5*sin((sine+0.65)*1.5),-4.5+2.5*sin((sine+0.45)*1.5)),angles(0,1.5707963267948966,1.3562634015954636+0.3490658503988659*sin((sine+0.25)*1.5))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,7.55-2.5*sin((sine+0.65)*1.5),-4.55+2.5*sin((sine+0.5)*1.5)),angles(0,1.5707963267948966,-1.9198621771937625+0.3490658503988659*sin((sine+0.25)*1.5))),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,3.75-2.5*sin((sine+0.45)*1.5),-8.5+2.5*sin((sine+0.65)*1.5)),angles(0,1.5707963267948966,-0.3490658503988659*sin((sine+0.25)*1.5))),deltaTime)  
end
end


WingAnimations.Kronos=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
--[[
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.5+0.1*sin((sine+0.15)*1.5),-7.515-2.5*sin((sine+0.5)*1.5)),angles(0,1.5707963267948966,-0.2617993877991494*sin((sine+1)*1.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,7+2.5*sin((sine+0.5)*1.5),-3.55+0.15*sin((sine+0.25)*1.5)),angles(0,1.5707963267948966,1.4835298641951802+0.2617993877991494*sin((sine+1)*1.5))),deltaTime)  
]]
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,4.25-2.5*sin((sine+0.45)*1.5),-8+2.5*sin((sine+0.65)*1.5)),angles(0,1.5707963267948966,3.141592653589793-0.2617993877991494*sin((sine+0.25)*1.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,8-2.5*sin((sine+0.65)*1.5),-4.5+2.5*sin((sine+0.45)*1.5)),angles(0,1.5707963267948966,1.3562634015954636+0.3490658503988659*sin((sine+0.25)*1.5))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-.5,3.1,-3.55),angles(0,1.5707963267948966,-0.8726646259971648+ClockTicky/5.25)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-.5,2.85,-3.55),angles(0,1.5707963267948966,2.2689280275926285+ClockTicky/3.25)),deltaTime)  
end
end


WingAnimations.Equinox=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-2.5-sound.PlaybackLoudness/100,0,0),angles(4.014257279586958,0+Boost/25,0+Boost/75)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(2.5+sound.PlaybackLoudness/100,0,0),angles(0.8726646259971648,0+Boost/25,0+Boost/75)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-10-sound.PlaybackLoudness/75,0,0),angles(4.014257279586958+sp/10,0+sp/15+Boost/75,0)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(10+sound.PlaybackLoudness/75,0,0),angles(0.8726646259971648+sp/10,0+sp/15+Boost/75,0)),deltaTime)  
end
end


WingAnimations.Mayhem2=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,3,-3.45),angles(0,1.5707963267948966+0.3490658503988659*sin((sine+0.5)*2.5),0.17453292519943295*sin((sine+0.5)*2.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,3,-3.45),angles(0,1.5707963267948966-0.3490658503988659*sin((sine+1)*2.5),1.2217304763960306-0.3490658503988659*sin((sine+1)*2.5))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(1,3,-3.45),angles(0,4.71238898038469-0.3490658503988659*sin((sine+0.5)*2.5),-0.3490658503988659*sin((sine+0.5)*2.5))),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(1,3,-3.45),angles(0,4.71238898038469+0.3490658503988659*sin((sine+1)*2.5),-1.2217304763960306+0.17453292519943295*sin((sine+1)*2.5))),deltaTime)  
end
end


WingAnimations.Shard=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-2.8,3,-4),angles(1.0471975511965976+sp/5,-0.2617993877991494,1.5707963267948966)),deltaTime) 
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-2.8,2.55,-3.55),angles(-0.5235987755982988+sp/5,-0.2617993877991494,1.5707963267948966)),deltaTime) 
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-2.8,3.4,-3.6),angles(2.6179938779914944+sp/5,-0.2617993877991494,1.5707963267948966)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-2.8,2.9,-3.1),angles(-2.0943951023931953+sp/5,-0.2617993877991494,1.5707963267948966)),deltaTime) 
end
end


WingAnimations.Luminosity=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
--[[
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,-10 * sin(sine*0.5),10 * sin(sine*0.5)),angles(0,1.5707963267948966,0.6981317007977318+sp/15+Boost/25)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,10 * sin(sine*0.5),-10 * sin(sine*0.5)),angles(0,1.5707963267948966,-0.8726646259971648+sp/15+Boost/25)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,-10 * sin(sine*0.5),10 * sin(sine*0.5)),angles(0,1.5707963267948966,3.839724354387525+sp/15+Boost/25)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,10 * sin(sine*0.5),-10 * sin(sine*0.5)),angles(0,1.5707963267948966,2.2689280275926285+sp/15+Boost/25)),deltaTime)  
]]
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,-0 -sound.PlaybackLoudness/50),angles(0,1.5707963267948966,0.6981317007977318-sp/15-Boost/35)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,-10 +sound.PlaybackLoudness/50,10 -sound.PlaybackLoudness/50),angles(0,1.5707963267948966,-0.8726646259971648+sp/15+Boost/35)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,-0 -sound.PlaybackLoudness/50),angles(0,1.5707963267948966,3.839724354387525-sp/15-Boost/35)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,-10 +sound.PlaybackLoudness/50,10 -sound.PlaybackLoudness/50),angles(0,1.5707963267948966,2.2689280275926285+sp/15+Boost/35)),deltaTime)  
end
end


WingAnimations.Censored=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,5.5 * sin(sine*1),-5.5 * sin(sine*1)),angles(0,1.5707963267948966,2.2689280275926285+sp/45+Boost/15)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,5.5 * sin(sine*1),-5.5 * sin(sine*1)),angles(0,1.5707963267948966,-0.8726646259971648+sp/45+Boost/15)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,0 +sound.PlaybackLoudness/50),angles(0-sp/45-Boost/15,1.5707963267948966,0.6981317007977318)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,0 +sound.PlaybackLoudness/50),angles(0-sp/45-Boost/15,1.5707963267948966,-2.443460952792061)),deltaTime)  
end
end


WingAnimations.Fragmentation=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,-2+1.5*sin((sine+0.5)*1.5),-8+1.5*sin((sine+0.95)*1.5)),angles(0.8726646259971648+0.4363323129985824*sin((sine+0.1)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,-3+1.5*sin((sine+0.45)*1.5),-4+1.25*sin((sine+0.75)*1.5)),angles(0.2617993877991494+0.4363323129985824*sin((sine+0.1)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,8-1.5*sin((sine+0.95)*1.5),0.75-1.5*sin((sine+0.5)*1.5)),angles(-0.8726646259971648-0.4363323129985824*sin((sine+0.1)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,4.15-1.25*sin((sine+0.75)*1.5),2.45-1.5*sin((sine+0.45)*1.5)),angles(-0.2617993877991494-0.4363323129985824*sin((sine+0.1)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
end
end


WingAnimations.Panorama=function()
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(1 * sin((sine+0.85)*2),3+1*sin((sine+0.45)*2),-5.55-1*sin((sine+0.5)*2)),angles(0,1.5707963267948966+0.5235987755982988*sin((sine+0.45)*2),0.7853981633974483+0.17453292519943295*sin((sine+0.55)*2))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1 * sin((sine+0.75)*2),3+1*sin((sine+0.65)*2),-6.55-1*sin((sine+0.5)*2)),angles(0,-1.5707963267948966-0.5235987755982988*sin((sine+0.15)*2),-0.08726646259971647-0.3490658503988659*sin((sine+0.35)*2))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1 * sin((sine+0.75)*2),3+1*sin((sine+0.45)*2),-5.55-1*sin((sine+0.5)*2)),angles(0,-1.5707963267948966-0.5235987755982988*sin((sine+0.45)*2),-0.7853981633974483-0.17453292519943295*sin((sine+0.55)*2))),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(1 * sin((sine+0.75)*2),3+1*sin((sine+0.65)*2),-6.55-1*sin((sine+0.5)*2)),angles(0,1.5707963267948966+0.5235987755982988*sin((sine+0.15)*2),0.08726646259971647+0.3490658503988659*sin((sine+0.35)*2))),deltaTime)  
end
end





--//Main Animations Function 
function MainAnimations()
if not Running then return end
if MusicPlayer.Volume==0 then return end
--[[pcall(function()
local char=game.Players.LocalPlayer.Character 
for _,v in ipairs(char:GetChildren()) do 
if v:IsA("Accessory") then 
v.Handle.CanCollide=true
end 
end
end)]]
if Mode=="Chaos"then
ChangeAndRecolor("Chaos",true,Font.new([[rbxasset://fonts/families/PressStart2P.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,0,0),BrickColor.random().Color)
end
sp=sp+1
if Mode=="Kronos" or Mode=="Panorama" then
Constant+=1 
if Constant >=60 then
Constant=1 
ClockTicky+=6.25
end
end
if Mode~="E q u i n o x" then 
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("Frame") or v:IsA("ImageLabel") then
v.Visible=true
end
swait(.01)
end
for _,v in ipairs(game.CoreGui:FindFirstChild("VISgui").Frame:GetChildren()) do
if v:IsA("ScreenGui") then
v.Enabled=true
end
swait(.01)
end
end 
Boost+=1*sound.PlaybackLoudness/50
--onnewcamera()
--ws.CurrentCamera.CameraSubject=righead
--sound.TimePosition=MusicPlayer.TimePosition
--// Music Length Visualizer 
local current = MusicPlayer.TimePosition
local total = MusicPlayer.TimeLength
GLITCHERAUDIO["MusicDuration_7"].Text = string.format("%s / %s", timeFormat(current), total > 0 and timeFormat(total) or "----")

--// Special Anims
if Mode=="Overseer" or Mode=="Overseer1" then
SpecialAnim(98,155,"Overseer1","Overseer",current)
end

if Mode=="Censored" or Mode=="Censored1" then 
SpecialAnim(49,69,"Censored1","Censored",current)
SpecialAnim(128,148,"Censored1","Censored",current)
end
if Mode=="Censored" or Mode=="Censored2" then
SpecialAnim(187,212,"Censored2","Censored",current)
end
--59
--78
--101.5 
--111 --121 --132

EquinoxBeats(58.75,78,current)
EquinoxBeats(101.35,110.5,current)
EquinoxBeats(112,121.150,current)
EquinoxBeats(122.5,132,current)
EquinoxBeats(133.5,142.5,current)




if total > 0 then
local progress = math.clamp(current / total, 0, 1)
local maxWidth = 320
GLITCHERAUDIO["MusicDur_a"].Size = UDim2.new(0, progress * maxWidth, 0, 5)
GLITCHERAUDIO["Lol1_9"].Position=UDim2.new(-.015, progress * maxWidth, 0, -2)
GLITCHERAUDIO["Lol_8"].Position=UDim2.new(-.01, progress * maxWidth, 0, 0)
GLITCHERAUDIO["Lol_8"].Rotation =sp
GLITCHERAUDIO["Lol1_9"].Rotation =sp
else
GLITCHERAUDIO["MusicDur_a"].Size = UDim2.new(0, 5, 0, 5)
end



if Mode=="Chaos" then
BBGAttachment.CFrame=cf(0,0,0) 
bilguit.StudsOffsetWorldSpace=v3(0,0,0)
bilguit.StudsOffset=v3(-9.5,4,-1)
GLITCHERAUDIO["TextLabel_f"].Position=UDim2.new(0,math.random(-1,1),0,math.random(-1,1))
modet.Position = UDim2.new(0,math.random(-1,1),0,math.random(-1,1))
modet.Rotation = -2 * math.cos(sp / 1) + math.random(-3,3)
imag1.Rotation+=-1 + math.random(-5,5)
imag2.Rotation+=1+sound.PlaybackLoudness/50 + math.random(-5,5)
imag3.Rotation+=1+sound.PlaybackLoudness/25 + math.random(-5,5)
imag4.Rotation+=-1-sound.PlaybackLoudness/10 + math.random(-5,5)
elseif Mode=="E q u i n o x" then
EquinoxBobbing()
BBGAttachment.CFrame=cf(0 + 2 * math.cos(sp / 30.5),0 - 1.5 * math.cos(sp / 30.5),0 + 1.5 * math.cos(sp / 30.5))
modet.Position = UDim2.new(-.5,0 + 4 * math.cos(sp / 17.5),-.15,0 - 2.5 * math.cos(sp / 22.5))
modet.Rotation = 0 - 5.5 * math.cos(sp / 20)
imag1.Rotation+=-1
imag2.Rotation+=1+sound.PlaybackLoudness/75
imag3.Rotation+=1+sound.PlaybackLoudness/50
imag4.Rotation+=-1-sound.PlaybackLoudness/25
GLITCHERAUDIO["TextLabel_f"].Position=UDim2.new(0,0,0,0)
else
BBGAttachment.CFrame=cf(0,0,0) 
bilguit.StudsOffsetWorldSpace=v3(0,0,0)
bilguit.StudsOffset=v3(-9.5,4,-1)
bilguit.Brightness=1
modet.Position = UDim2.new(0,0,0,0)
modet.Rotation = -5 * math.cos(sp / 32)
GLITCHERAUDIO["TextLabel_f"].Position=UDim2.new(0,0,0,0)
imag1.Rotation+=-1
imag2.Rotation+=1+sound.PlaybackLoudness/75
imag3.Rotation+=1+sound.PlaybackLoudness/50
imag4.Rotation+=-1-sound.PlaybackLoudness/25
end

if Mode~="Chromatic" then
if ws:FindFirstChild("Effects") then 
ws.Effects:Destroy()
end
end


game.Players.LocalPlayer.PlayerGui.TouchGui.TouchControlFrame.DynamicThumbstickFrame.Active=false
--ws.CurrentCamera.CameraSubject=game.Players.LocalPlayer.Character:WaitForChild("CamFocus")
--TweenFunction(game.Players.LocalPlayer.Character:WaitForChild("CamFocus"),1.5,"pos",game.Players.LocalPlayer.Character:WaitForChild(CAMERAFOCUS).Handle.Position)





sine=osclock()
local walking = IsWalking()
idle = not walking
local getVel= getVel()
local ray,ray2=raycastlegs()
local velY=velYchg()
local velXZ=velbycfrvec(v3_xz)
local velXZ2=velbycfrvec(v3_xzL)
local velNet=velbycfrvec(v3_net)
local IsOnGround=(ray==0)
local Fall=velY>5
local Jump=velY<-20




--// Every Animations
--[[if IsOnGround then
end]]
if Fall then
if Mode=="Renegades" or Mode=="Mayhem" or Mode=="Chaos" or Mode=="Mayhem - No Hope" or Mode=="Chromatic" then
Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.6580627893946132,0,3.141592653589793)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.5),angles(0,0,-0.6108652381980153)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.75,-0.55),angles(0,-1.5707963267948966,0)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1,-0.5),angles(0,1.5707963267948966,-0.4363323129985824)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,angles(-1.7453292519943295,0,3.141592653589793),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.5,-0.5),angles(0,0,0.6108652381980153)),deltaTime)
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
end
end


elseif Jump then
if (velY==0 or velY>0)then return end
if Mode=="Renegades" or Mode=="Mayhem" or Mode=="Chaos" or Mode=="Mayhem - No Hope" or Mode=="Chromatic" then
Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.4835298641951802,0,3.141592653589793)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.5),angles(0,0,-0.4363323129985824)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.75,-0.75),angles(0,-1.5707963267948966,0.5235987755982988)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1,-0.5),angles(0,1.5707963267948966,-0.4363323129985824)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,angles(-1.4835298641951802,0,3.141592653589793),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.5,-0.5),angles(0,0,0.4363323129985824)),deltaTime)  
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
end
end


elseif walking then 
if Mode=="Renegades" or Mode=="Mayhem" or Mode=="Chaos" or Mode=="Mayhem - No Hope" or Mode=="Chromatic" then
setWalkSpeed(12)
RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.5,0),angles(-0.8726646259971648*sin(sine*5.5),1.5707963267948966,0)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5,0),angles(0.8726646259971648*sin(sine*5.5),-1.5707963267948966,0)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.15*sin((sine+1.5)*5.5),-0.25+0.75*sin((sine+0.75)*5.5)),angles(0,1.5707963267948966,-0.2617993877991494-0.6981317007977318*sin((sine+0.5)*5.5))),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,angles(-1.8325957145940461,0,3.141592653589793),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.3962634015954636,-0.04363323129985824*sin(sine*5.5),3.141592653589793-0.09599310885968812*sin(sine*5.5))),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1-0.15*sin((sine+1.5)*5.5),-0.25-0.75*sin((sine+0.75)*5.5)),angles(0,-1.5707963267948966,0.2617993877991494-0.6981317007977318*sin((sine+0.5)*5.5))),deltaTime) 
if Mode=="Renegades" then
if s1_1 and s1_2 and s1_3 and s1_4 then 
if LEGACY then 
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(0,7.5,5.5),angles(0,1.5707963267948966,-1.5707963267948966+0.3490658503988659*sin((sine+0.35)*3.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(0,12.5-1.5*sin((sine+1.5)*3.5),2.5),angles(0,1.5707963267948966,-2.007128639793479+0.3490658503988659*sin((sine+.25)*3.5))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(0,-3.5,-12.5+1.5*sin((sine+1.5)*3.5)),angles(0,1.5707963267948966,0.4363323129985824-0.3490658503988659*sin((sine+.25)*3.5))),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(0,-6,-7.5),angles(0,1.5707963267948966,-0.3490658503988659*sin((sine+0.35)*3.5))),deltaTime)
else 
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,9-2.25*sin((sine+0.15)*1.5),0.6+2*sin((sine+0.75)*1.5)),angles(-1.1344640137963142+0.3490658503988659*sin((sine+0.95)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,5-2.5*sin((sine+0.5)*1.5),2.1-1*sin((sine+0.35)*1.5)),angles(-0.5235987755982988+0.4363323129985824*sin((sine+0.95)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,-2.5+1.25*sin((sine+0.35)*1.5),-4+2.5*sin((sine+0.5)*1.5)),angles(0.5235987755982988-0.4363323129985824*sin((sine+0.9)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,-2.5-2*sin((sine+0.75)*1.5),-8+2.25*sin((sine+0.15)*1.5)),angles(1.1344640137963142-0.3490658503988659*sin((sine+0.95)*1.5),1.5707963267948966,-0.8726646259971648)),deltaTime)  
end
end
elseif Mode=="Mayhem" then
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1.5,1.5,1.5),angles(0,1.5707963267948966,-0.8726646259971648-0.17453292519943295*sin((sine+1)*2.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1.5,1.5,8),angles(0,1.5707963267948966,-0.8726646259971648-0.4363323129985824*sin((sine+1)*2.5))),deltaTime) 
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1.5,-0.15 * sin((sine+0.75)*3.5),0.15 * sin((sine+0.75)*3.5)),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1.5,2,4.5),angles(0,1.5707963267948966,-0.8726646259971648-0.2617993877991494*sin((sine+1)*2.5))),deltaTime) 
end
elseif Mode=="Mayhem - No Hope" then 
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,3,-3.45),angles(0,1.5707963267948966+0.3490658503988659*sin((sine+0.5)*2.5),0.17453292519943295*sin((sine+0.5)*2.5))),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,3,-3.45),angles(0,1.5707963267948966-0.3490658503988659*sin((sine+1)*2.5),1.2217304763960306-0.3490658503988659*sin((sine+1)*2.5))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(1,3,-3.45),angles(0,4.71238898038469-0.3490658503988659*sin((sine+0.5)*2.5),-0.3490658503988659*sin((sine+0.5)*2.5))),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(1,3,-3.45),angles(0,4.71238898038469+0.3490658503988659*sin((sine+1)*2.5),-1.2217304763960306+0.17453292519943295*sin((sine+1)*2.5))),deltaTime)  
end
else
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0,0),angles(0,1.5707963267948966,-0.8726646259971648)),deltaTime) 
end
else
setWalkSpeed(20)
end



else



if WingAnimations[AnimType] then
WingAnimations[AnimType]()
end


--// Body Anima
if Mode=="Renegades" then
if LEGACY then 
RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.75-0.095*sin((sine+0.25)*5),0.95,0.35-0.15*sin((sine+0.25)*5)),angles(1.5707963267948966+0.17453292519943295*sin((sine+0.75)*5),0,2.2689280275926285+0.09599310885968812*sin((sine+0.5)*5))),deltaTime) 
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.25,0.5,-1.35),angles(-0.5235987755982988+0.08726646259971647*sin((sine+1)*5),0,2.0943951023931953+0.09773843811168245*sin((sine+5)*5))),deltaTime) 
LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.25,-1+0.1*sin(sine*5),0.65),angles(-0.2617993877991494-0.17453292519943295*sin(sine*5),0.3490658503988659,-0.01590658503988659-0.04363323129985824*sin((sine+0.5)*5))),deltaTime) 
RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.5,-0.25+0.175*sin(sine*5),-0.5+0.175*sin(sine*5)),angles(0.8726646259971648-0.08726646259971647*sin((sine+0.1)*5),0,-0.2617993877991494-0.04363323129985824*sin((sine+0.5)*5))),deltaTime) 
RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-1.025-0.175*sin(sine*5),0),angles(-2.2689280275926285,-0.3490658503988659+0.08726646259971647*sin((sine+1)*5),3.141592653589793)),deltaTime)
Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.007128639793479+0.09599310885968812*sin((sine+1)*5),0,3.3161255787892263)),deltaTime) 
else 
RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.75-0.095*sin((sine+0.25)*3.5),0.95,0.35-0.15*sin((sine+0.25)*3.5)),angles(1.5707963267948966+0.17453292519943295*sin((sine+0.75)*3.5),0,2.2689280275926285+0.09599310885968812*sin((sine+0.5)*3.5))),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-1.025-0.175*sin(sine*3.5),0),angles(-2.2689280275926285,-0.3490658503988659+0.08726646259971647*sin((sine+1)*3.5),3.141592653589793)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.007128639793479+0.09599310885968812*sin((sine+1)*3.5),0,3.3161255787892263)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.25,-1+0.1*sin(sine*3.5),0.65),angles(-0.2617993877991494-0.17453292519943295*sin(sine*3.5),0.3490658503988659,-0.3490658503988659-0.1308996938995747*sin((sine+0.35)*3.5))),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.5,-0.25+0.175*sin(sine*3.5),-0.5+0.175*sin(sine*3.5)),angles(0.8726646259971648-0.08726646259971647*sin((sine+0.1)*3.5),0,-0.2617993877991494-0.07853981633974483*sin((sine+0.4)*3.5))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.75,0.5+0.25*sin((sine+0.25)*3.5),-1-0.15*sin((sine+0.5)*3.5)),angles(0.8726646259971648+0.08726646259971647*sin((sine+1)*3.5),0,-0.5235987755982988-0.09599310885968812*sin((sine+0.5)*3.5))),deltaTime)  
end

elseif Mode=="Overseer" then
LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.75+0.15*sin((sine+1)*4.5),-1.015),angles(0,-1.5707963267948966,0.5235987755982988+0.2617993877991494*sin((sine+0.5)*4.5))),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.9198621771937625-0.17453292519943295*sin((sine+0.5)*4.5),0,2.443460952792061-0.09599310885968812*sin((sine+0.5)*4.5))),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.75+0.15*sin((sine+1)*4.5),-0.5),angles(0,1.5707963267948966,-0.6981317007977318+0.3490658503988659*sin(sine*4.5))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-0.5,0.25+0.15*sin((sine+1)*4.5),-0.25),angles(2.0943951023931953,0,1.5707963267948966)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,15+0.75*sin(sine*4.5),0),angles(-1.4835298641951802+0.09599310885968812*sin((sine+1)*4.5),0,2.8797932657906435+0.09599310885968812*sin((sine+0.5)*4.5))),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.5,0.65+0.15*sin((sine+1)*4.5),-0.5),angles(2.0943951023931953,-0.17453292519943295,-1.5707963267948966)),deltaTime)

elseif Mode=="Mayhem" then
if LEGACY==true then 
RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.5,-1-0.15*sin(sine*3.5),0.35-0.1*sin(sine*3.5)),angles(-0.4363323129985824+0.09599310885968812*sin(sine*3.5),0,0.17453292519943295)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1+0.045*sin((sine+0.5)*3.5),0),angles(-1.7453292519943295,0,3.7524578917878086)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,0.15 * sin(sine*3.5),0),angles(-1.7453292519943295,0,2.530727415391778)),deltaTime) LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.5,-0.95-0.15*sin(sine*3.5),-0.25+0.15*sin(sine*3.5)),angles(0.17453292519943295,0,-0.17453292519943295)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.25,1.25+0.15*sin(sine*3.5),0.5),angles(2.6179938779914944,-0.3490658503988659,0.5235987755982988)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.35,0.5-0.1*sin((sine+0.75)*3.5),-0.5),angles(0,0.3490658503988659,0.5235987755982988+0.09599310885968812*sin((sine+1)*3.5))),deltaTime) 
else
RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.01*sin((sine+0.2)*2),-0.1),angles(-0.17453292519943295,1.3962634015954636+0.08726646259971647*sin(sine*1),0.19198621771937624-0.08726646259971647*sin(sine*1.4))),deltaTime) LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-0.7,0.35+0.2*sin((sine+0.7)*1.2),-0.6+0.04*sin((sine+0.1)*1.8)),angles(0.4537856055185257+0.024434609527920613*sin((sine+0.1)*90),-2.443460952792061+0.022689280275926284*sin((sine+0.1)*90),-2.6179938779914944-0.05235987755982989*sin((sine+0.4)*2))),deltaTime) RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.4-0.2*sin((sine+0.6)*1.2),0.01),angles(0.3490658503988659,1.2217304763960306+0.08726646259971647*sin((sine+0.1)*1.6),-0.17453292519943295+0.08726646259971647*sin((sine+0.2)*1.2))),deltaTime) Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.8675022996339325+0.17453292519943295*sin(sine*90),-0.08726646259971647*sin(sine*90),3.246312408709453)),deltaTime) LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1-0.05*sin((sine+0.1)*2),-0.16),angles(0,-1.2217304763960306+0.06981317007977318*sin((sine+0.4)*1.4),-0.22689280275926285+0.03490658503988659*sin((sine+0.4)*1.4))),deltaTime) RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-0.04+0.08*sin((sine+0.2)*1.2),0),angles(-1.7802358370342162-0.08726646259971647*sin((sine+0.5)*1.1),0,2.9670597283903604)),deltaTime) 
end

elseif Mode=="Chaos" then
RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.5+0.15*sin((sine+1)*3.5),-1-0.095*sin((sine+0.5)*3.5)),angles(0,0,-2.0943951023931953)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0.25-0.15*sin(sine*3.5),-0.75-0.15*sin(sine*3.5)),angles(0.8726646259971648,1.5707963267948966,0)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-1+0.25*sin(sine*3.5),0),angles(-2.2689280275926285,0,3.141592653589793)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1+0.055*sin((sine+1)*3.5),0),angles(-2.0943951023931953+mrandom(-1.5,1.5),0,3.141592653589793+mrandom(-1.5,1.5))),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1,-0.25-0.15*sin(sine*3.5)),angles(0,-1.5707963267948966,0.4363323129985824)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5+0.15*sin((sine+1)*3.5),-1.5-0.095*sin((sine+0.5)*3.5)),angles(0,0,2.2689280275926285)),deltaTime) 

elseif Mode=="Chromatic" then
LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.5,-0.85-0.15*sin(sine*2),0.1 * sin(sine*2)),angles(-0.17453292519943295,0,-0.17453292519943295)),deltaTime) Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1+0.055*sin((sine+0.15)*2),0),angles(-1.6580627893946132,0,3.6651914291880923)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.5,-0.75-0.15*sin(sine*2),0.5+0.1*sin(sine*2)),angles(-0.3490658503988659-0.03490658503988659*sin((sine+0.2)*2),0,0)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-0.25+0.15*sin((sine+0.25)*2),0),angles(-1.4835298641951802,-0.08726646259971647,2.6179938779914944)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.4+0.15*sin((sine+0.075)*2),-0.45),angles(-0.3490658503988659,0,0.3490658503988659-0.1832595714594046*sin((sine+0.5)*2))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5+0.15*sin((sine+0.075)*2),-0.35-0.1*sin((sine+0.2)*2)),angles(-0.17453292519943295,0,-0.17453292519943295+0.1832595714594046*sin((sine+0.5)*2))),deltaTime)  

elseif Mode=="Fracture" then
LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.75+0.25*sin((sine+0.5)*2.5),-1.015),angles(0,-1.5707963267948966,0.5235987755982988+0.3490658503988659*sin((sine+1)*2.5))),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,1.25+0.25*sin((sine+1)*2.5),0.25),angles(2.530727415391778,0,-0.5235987755982988)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5+0.25*sin((sine+0.5)*2.5),-0.5),angles(0.17453292519943295,0,-0.3490658503988659+0.2617993877991494*sin((sine+0.5)*2.5))),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,12.5+1.5*sin(sine*2.5),0),angles(-1.4835298641951802+0.17453292519943295*sin((sine+0.5)*2.5),0,3.490658503988659)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1+0.055*sin((sine+0.5)*2.5),0),angles(-1.9198621771937625-0.09599310885968812*sin((sine+0.25)*2.5),0,2.6179938779914944)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.15*sin((sine+0.5)*2.5),-0.25),angles(0,1.5707963267948966,-0.3490658503988659-0.17453292519943295*sin((sine+1)*2.5))),deltaTime)  

elseif Mode=="Kronos" then
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.35+0.25*sin((sine+0.45)*2.5),-0.5),angles(0,0,-0.3490658503988659-0.09599310885968812*sin((sine+0.75)*2.5))),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1+0.055*sin((sine+0.15)*2.5),0),angles(-1.9198621771937625-0.09599310885968812*sin((sine+0.5)*2.5),0,2.6179938779914944)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,7.5+1.25*sin(sine*2.5),0),angles(-1.3962634015954636+0.17453292519943295*sin((sine+0.25)*2.5),0,3.141592653589793)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.5-0.15*sin((sine+0.25)*2.5),-1),angles(-0.4363323129985824+0.17453292519943295*sin((sine+0.75)*2.5),-1.5707963267948966,0)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.35+0.25*sin((sine+0.5)*2.5),-1.25),angles(0,0,-2.0943951023931953)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.95+0.25*sin((sine+0.15)*2.5),-0.25),angles(-0.4363323129985824+0.2617993877991494*sin((sine+0.35)*2.5),1.5707963267948966,0)),deltaTime)  

elseif Mode=="E q u i n o x" then
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.3+0.1*sin((sine+0.75)*2.5),-0.5+0.25*sin((sine+0.75)*2.5),-0.25-0.1*sin((sine+0.45)*2.5)),angles(-0.6981317007977318,0,-2.356194490192345-0.17453292519943295*sin((sine+0.35)*2.5))),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1-0.075*sin((sine+0.35)*2.5),0),angles(-2.007128639793479+0.09599310885968812*sin((sine+0.5)*2.5),-0.09599310885968812*sin((sine+0.2)*2.5),4.1887902047863905)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.35,0.15 * sin((sine+0.85)*2.5),-0.25),angles(-0.5235987755982988-0.09599310885968812*sin((sine+0.5)*2.5),0,2.530727415391778-0.1832595714594046*sin((sine+0.25)*2.5))),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.35,-0.15+0.2*sin((sine+0.5)*2.5),-0.5),angles(-0.5235987755982988-0.17453292519943295*sin((sine+0.55)*2.5),0.3490658503988659,0)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.6,-0.75+0.25*sin((sine+0.75)*2.5),0.25-0.1*sin((sine+0.25)*2.5)),angles(-0.3490658503988659+0.1832595714594046*sin((sine+0.25)*2.5),0.3490658503988659,0)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(1.5 * sin((sine+0.15)*2.5),7+0.75*sin((sine+0.75)*2.5),1 * sin((sine+0.85)*2.5)),angles(-1.4835298641951802+0.2617993877991494*sin((sine+0.2)*2.5),-0.17453292519943295,2.443460952792061)),deltaTime)  

elseif Mode=="Mayhem - No Hope" then
RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-0.5+0.15*sin(sine*2.5),0),angles(-2.0943951023931953-0.09599310885968812*sin((sine+0.75)*2.5),0,3.7524578917878086+0.17453292519943295*sin((sine+0.5)*2.5))),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.75+0.15*sin((sine+0.5)*2.5),-0.5),angles(0.3490658503988659+0.3490658503988659*sin((sine+0.5)*2.5),0,0.5235987755982988+0.17453292519943295*sin((sine+0.75)*2.5))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-2-0.15*sin((sine+0.5)*2.5),1+0.15*sin((sine+0.5)*2.5),-0.5-0.25*sin((sine+0.15)*2.5)),angles(1.2217304763960306,0,-0.8726646259971648-0.09599310885968812*sin((sine+0.15)*2.5))),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.65,-1.5-0.1*sin(sine*2.5),0.5-0.25*sin((sine+0.5)*2.5)),angles(-0.4363323129985824+0.17453292519943295*sin((sine+0.75)*2.5),0,-0.3490658503988659+0.17453292519943295*sin((sine+0.75)*2.5))),deltaTime) RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.5,-0.25-0.15*sin((sine+0.25)*2.5),-0.5+0.15*sin((sine+0.5)*2.5)),angles(0,0,0.3490658503988659+0.17453292519943295*sin((sine+0.5)*2.5))),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.2217304763960306-0.1308996938995747*sin((sine+0.25)*2.5),0,2.443460952792061-0.1308996938995747*sin((sine+0.5)*2.5))),deltaTime) 

elseif Mode=="Shard Surfer" then
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.3,0.4,-0.4),angles(-0.17453292519943295-0.17453292519943295*sin(sine*2),-0.3490658503988659+0.08726646259971647*sin(sine*6),-1.5707963267948966-0.17453292519943295*sin(sine*1))),deltaTime) RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(3 * sin(sine*2),6,0),angles(-1.7802358370342162,-0.5585053606381855*sin((sine+0.5)*2),4.363323129985824)),deltaTime) RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.2,0.4,-0.4),angles(-0.17453292519943295-0.17453292519943295*sin(sine*2),0.3490658503988659+0.08726646259971647*sin(sine*6),1.5707963267948966)),deltaTime) RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1.1,-0.5-0.2*sin(sine*1),-0.7),angles(-0.5235987755982988,1.3962634015954636+0.17453292519943295*sin(sine*3),0.47123889803846897+0.3490658503988659*sin(sine*2.3))),deltaTime) Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.5009831567151235+0.3490658503988659*sin(sine*2),0,2.0943951023931953)),deltaTime) LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.9,-0.7+0.2*sin(sine*2),-0.3),angles(-0.6981317007977318+0.03490658503988659*sin(sine*3),-1.0471975511965976,-0.6981317007977318-0.17453292519943295*sin(sine*2.3))),deltaTime) 

elseif Mode=="Luminosity" then
RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,15+1*sin(sine*2.5),0),angles(-1.5707963267948966,0.08726646259971647+0.09599310885968812*sin((sine+0.5)*2.5),2.530727415391778)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.65,-1.075+0.25*sin((sine+0.25)*2.5),0),angles(-0.3490658503988659-0.1832595714594046*sin((sine+0.75)*2.5),0.3490658503988659,0.3490658503988659+0.09599310885968812*sin((sine+0.5)*2.5))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.85,0.85+0.1*sin((sine+0.5)*2.5),-0.16),angles(1.5707963267948966-0.09599310885968812*sin((sine+0.5)*2.5),0.1308996938995747*sin((sine+0.5)*2.5),-1.2217304763960306-0.04363323129985824*sin((sine+0.75)*2.5))),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.25,0.25+0.175*sin((sine+0.45)*2.5),0),angles(2.0943951023931953+0.1832595714594046*sin((sine+0.5)*2.5),0.3490658503988659,0)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.75,-0.25+0.25*sin((sine+0.25)*2.5),-0.5),angles(-0.17453292519943295-0.27052603405912107*sin((sine+0.75)*2.5),0.3490658503988659,0.17453292519943295+0.09599310885968812*sin((sine+0.5)*2.5))),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1-0.055*sin((sine+0.5)*2.5),0),angles(-1.9198621771937625-0.09599310885968812*sin((sine+0.5)*2.5),0,4.1887902047863905)),deltaTime)  

elseif Mode=="Censored" then
local colg=mrandom(1,5)
if colg==1 then
ChangeAndRecolor("C#N##R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,255,6),rgb(0,0,0),false,false)
elseif colg==2 then
ChangeAndRecolor("#E##ORE#",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,10,0),rgb(0,190,0),false,false)
elseif colg==3 then
ChangeAndRecolor("C#N##R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,100,0),rgb(0,50,0),false,false)
elseif colg==4 then
ChangeAndRecolor("###SO#ED",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,125,0),rgb(0,255,0),false,false)
elseif colg==5 then
ChangeAndRecolor("##NS#R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,10,0),rgb(0,50,0),false,false)
end


RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,10+1*sin((sine+0.5)*2.5),0),angles(-1.3962634015954636-0.09599310885968812*sin(sine*2.5),0,3.141592653589793)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1+0.055*sin((sine+0.5)*2.5),0),angles(-1.9198621771937625+0.09599310885968812*sin(sine*2.5),0,3.141592653589793)),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5+0.15*sin((sine+0.5)*2.5),-0.25),angles(0.6108652381980153+0.17453292519943295*sin((sine+0.65)*2.5),0,-0.4363323129985824+0.09599310885968812*sin((sine+0.5)*2.5))),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.5,-0.5+0.15*sin((sine+0.75)*2.5),-0.5),angles(-0.7853981633974483+0.1832595714594046*sin((sine+0.45)*2.5),0,0)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-0.5,-0.25-0.15*sin((sine+0.25)*2.5),-0.5),angles(-0.3490658503988659+0.1832595714594046*sin((sine+0.75)*2.5),0,0)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.5+0.15*sin((sine+0.5)*2.5),-0.15),angles(0.6108652381980153+0.17453292519943295*sin((sine+0.65)*2.5),0,0.4363323129985824-0.09599310885968812*sin((sine+0.5)*2.5))),deltaTime)  

elseif Mode=="Overseer1" then
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1+mrandom(-45,45),0+mrandom(-45,45),0+mrandom(-45,45)),angles(0+mrandom(-45,45),1.5707963267948966+mrandom(-45,45),-0.8726646259971648+mrandom(-45,45))),deltaTime) 
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1+mrandom(-45,45),0+mrandom(-45,45),0+mrandom(-45,45)),angles(0+mrandom(-45,45),1.5707963267948966+mrandom(-45,45),-0.8726646259971648+mrandom(-45,45))),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1+mrandom(-45,45),0+mrandom(-45,45),0+mrandom(-45,45)),angles(0+mrandom(-45,45),1.5707963267948966+mrandom(-45,45),-0.8726646259971648+mrandom(-45,45))),deltaTime) 
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1+mrandom(-45,45),0+mrandom(-45,45),0+mrandom(-45,45)),angles(0+mrandom(-45,45),1.5707963267948966+mrandom(-45,45),-0.8726646259971648+mrandom(-45,45))),deltaTime) 
end
local colg=mrandom(1,3)
if colg==1 then
ChangeAndRecolor("Overseer",true,Font.new([[rbxasset://fonts/families/Michroma.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(4,70,1),rgb(43,255,33),false,false)
elseif colg==2 then
ChangeAndRecolor("Overseer",true,Font.new([[rbxasset://fonts/families/Michroma.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,255,0),rgb(0,0,0),false,false)
elseif colg==3 then
ChangeAndRecolor("Overseer",true,Font.new([[rbxasset://fonts/families/Michroma.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,100,0),rgb(255,255,255),false,false)
end
RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.5,-0.75),angles(0,1.5707963267948966,-0.3490658503988659)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.75,-1),angles(-0.3490658503988659,0,-1.9198621771937625)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0+mrandom(-25,25),15+mrandom(-2.5,2.5),0+mrandom(-2.5,2.5)),angles(-1.2217304763960306+mrandom(-25,25),0+mrandom(-25,25),3.141592653589793+mrandom(-25,25))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5,-1),angles(-0.6981317007977318,0,2.0943951023931953)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.0943951023931953,0,3.141592653589793)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.5,-1.15),angles(0,-1.5707963267948966,0.5235987755982988)),deltaTime)  

elseif Mode=="Censored1" then
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,5.5 * sin(sine*1),-5.5 * sin(sine*1)),angles(0,1.5707963267948966,2.2689280275926285+sp/45+Boost/15)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,5.5 * sin(sine*1),-5.5 * sin(sine*1)),angles(0,1.5707963267948966,-0.8726646259971648+sp/45+Boost/15)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,0 +sound.PlaybackLoudness/50),angles(0-sp/45-Boost/15,1.5707963267948966,0.6981317007977318)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,0 +sound.PlaybackLoudness/50),angles(0-sp/45-Boost/15,1.5707963267948966,-2.443460952792061)),deltaTime)  
end
local colg=mrandom(1,5)
if colg==1 then
ChangeAndRecolor("C#N##R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,255,6),rgb(0,0,0),false,false)
elseif colg==2 then
ChangeAndRecolor("#E##ORE#",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,10,0),rgb(0,190,0),false, false)
elseif colg==3 then
ChangeAndRecolor("C#N##R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,100,0),rgb(0,50,0),false,false)
elseif colg==4 then
ChangeAndRecolor("###SO#ED",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,125,0),rgb(0,255,0),false,false)
elseif colg==5 then
ChangeAndRecolor("##NS#R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(0,10,0),rgb(0,50,0),false,false)
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.25),angles(0.6981317007977318-0.17453292519943295*sin((sine+0.25)*2.5),0,-0.5235987755982988+0.1832595714594046*sin((sine+0.25)*2.5))),.1)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1-0.055*sin((sine+0.75)*2.5),0),angles(-1.3089969389957472+0.09599310885968812*sin((sine+0.5)*2.5),0,3.141592653589793)),.1)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.5,-0.25),angles(0.6981317007977318-0.1832595714594046*sin((sine+0.5)*2.5),0,0.3490658503988659-0.17453292519943295*sin((sine+0.25)*2.5))),.1)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.15*sin((sine+0.5)*2.5),-0.5),angles(0,1.5707963267948966,-0.5235987755982988-0.1832595714594046*sin((sine+0.25)*2.5))),.1)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.75+0.25*sin((sine+0.25)*2.5),-1),angles(0,-1.5707963267948966,0.4363323129985824+0.1832595714594046*sin((sine+0.5)*2.5))),.1)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,10+1*sin(sine*2.5),0),angles(-1.2217304763960306-0.09599310885968812*sin((sine+0.5)*2.5),0,3.141592653589793)),.1) 

elseif Mode=="Censored2" then
if s1_1 and s1_2 and s1_3 and s1_4 then
s1_1.C0=Lerp(s1_1.C0,cfMul(cf(-1,5.5 * sin(sine*1),-5.5 * sin(sine*1)),angles(0,1.5707963267948966,2.2689280275926285+sp/45+Boost/15)),deltaTime)  
s1_2.C0=Lerp(s1_2.C0,cfMul(cf(-1,5.5 * sin(sine*1),-5.5 * sin(sine*1)),angles(0,1.5707963267948966,-0.8726646259971648+sp/45+Boost/15)),deltaTime)  
s1_3.C0=Lerp(s1_3.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,0 +sound.PlaybackLoudness/50),angles(0-sp/45-Boost/15,1.5707963267948966,0.6981317007977318)),deltaTime)  
s1_4.C0=Lerp(s1_4.C0,cfMul(cf(-1,0 -sound.PlaybackLoudness/50,0 +sound.PlaybackLoudness/50),angles(0-sp/45-Boost/15,1.5707963267948966,-2.443460952792061)),deltaTime)  
end
local colg=mrandom(1,5)
if colg==1 then
ChangeAndRecolor("C#N##R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(100,0,0),rgb(10,0,0),false,false)
elseif colg==2 then
ChangeAndRecolor("#E##ORE#",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(100,0,0),rgb(150,0,0),false,false)
elseif colg==3 then
ChangeAndRecolor("C#N##R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(50,0,0),rgb(240,0,0),false)
elseif colg==4 then
ChangeAndRecolor("###SO#ED",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(255,0,0),rgb(190,0,0),false,false)
elseif colg==5 then
ChangeAndRecolor("##NS#R#D",true,Font.new([[rbxasset://fonts/families/Sarpanch.json]], Enum.FontWeight.Bold, Enum.FontStyle.Italic),rgb(100,0,0),rgb(50,0,0),false,false)
end
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.5,0.5,-0.35-0.15*sin((sine+0.35)*2.5)),angles(-0.4363323129985824-0.1832595714594046*sin((sine+0.5)*2.5),0,-0.6108652381980153+0.1832595714594046*sin((sine+0.25)*2.5))),.1)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.5,0.5,-0.35-0.15*sin((sine+0.35)*2.5)),angles(-0.4363323129985824-0.1832595714594046*sin((sine+0.5)*2.5),0,0.6108652381980153-0.1832595714594046*sin((sine+0.25)*2.5))),.1)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,10+0.75*sin(sine*2.5),0),angles(-0.3490658503988659-0.17453292519943295*sin((sine+0.5)*2.5),0,3.141592653589793)),.1)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.3962634015954636+0.09599310885968812*sin((sine+0.25)*2.5),0,3.141592653589793)),.1)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1.16,-0.65+0.35*sin((sine+0.5)*2.5)),angles(0,-1.5707963267948966,0.7853981633974483-0.3490658503988659*sin((sine+0.75)*2.5))),.1)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1-0.25*sin((sine+0.25)*2.5),-0.5+0.25*sin((sine+0.5)*2.5)),angles(0,1.5707963267948966,-0.8726646259971648-0.2617993877991494*sin((sine+0.5)*2.5))),.1)  

elseif Mode=="Fragmentation" then
Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295+0.09599310885968812*sin((sine+0.25)*3.5),0,3.141592653589793)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.85,0.5,-1.15),angles(0,0,-2.356194490192345)),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,5+1*sin((sine+0.5)*3.5),0),angles(-1.3962634015954636+0.09599310885968812*sin((sine+0.75)*3.5),0,3.141592653589793)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.5+0.25*sin((sine+0.5)*3.5),-1.1),angles(0,-1.5707963267948966,0.3490658503988659-0.2181661564992912*sin((sine+0.75)*3.5))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.75,-1.25),angles(0,0,2.0943951023931953)),deltaTime)  RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.85+0.15*sin((sine+0.75)*3.5),-0.7),angles(0,1.5707963267948966,-0.3490658503988659-0.1832595714594046*sin((sine+0.15)*3.5))),deltaTime)  

elseif Mode=="Panorama" then
RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.75-0.35*sin((sine+0.45)*2),-0.5),angles(-0.3490658503988659-0.17453292519943295*sin((sine+0.5)*2),1.5707963267948966,0)),deltaTime)  Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.007128639793479+0.17453292519943295*sin((sine+0.75)*2),0,3.141592653589793)),deltaTime)  RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.25,0.5-0.25*sin((sine+0.75)*2),-0.15),angles(0.3490658503988659,0,0.5235987755982988-0.17453292519943295*sin((sine+0.5)*2))),deltaTime)  LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.25,0.5-0.25*sin((sine+0.75)*2),-0.15),angles(0.3490658503988659,0,-0.5235987755982988+0.17453292519943295*sin((sine+0.5)*2))),deltaTime)  RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,10+0.75*sin(sine*2),0),angles(-1.2217304763960306-0.17453292519943295*sin((sine+0.75)*2),0,3.141592653589793)),deltaTime)  LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.5-0.25*sin((sine+0.75)*2),-1),angles(-0.6108652381980153-0.09599310885968812*sin((sine+0.25)*2),-1.5707963267948966,0)),deltaTime)  


end
end


end

--// Render the animations
IsRendering = rus.Heartbeat:Connect(function(dt)
MainAnimations()
This1(dt)
end)
end






--// Clean Up Everything Before Stopping And Respawning
function StopScript()
local gui=plr.PlayerGui
local visgui=gui:FindFirstChild("VISgui")
if visgui then 
visgui:Destroy()
end
if Running then
Running=false
end
wait(.4)
if Mode~="None" then
Mode="None"
end
if IsRendering then
IsRendering:Disconnect()
IsRendering=nil
end
if IsKeys then
IsKeys=nil
end
if BBGVisibilty==false then 
BBGVisibilty=true
end
game.SoundService:FindFirstChild("GlitcherAudioPlayer").TimePosition=0
game.SoundService:FindFirstChild("GlitcherAudioPlayer"):Stop()
game.SoundService:FindFirstChild("GlitcherAudioPlayer"):FindFirstChild("Sound2").TimePosition=0
game.SoundService:FindFirstChild("GlitcherAudioPlayer"):FindFirstChild("Sound2"):Stop()
if game.SoundService:FindFirstChild("GlitcherAudioPlayer") then
game.SoundService.GlitcherAudioPlayer:Destroy()
end
if IsRendering1 then
IsRendering1:Disconnect()
IsRendering1=nil
end
if MainWeld1 then
MainWeld1:Destroy()
MainWeld1=nil
end
if MainWeld then
MainWeld:Destroy()
MainWeld=nil
end
if plrgui:FindFirstChild("VISgui") then 
plrgui.VISgui:Destroy()
end
if stopreanimate then
stopreanimate()
notify("Stopping script")
wait(3)
Chat("-rs ")
wait(2.5)
Chat("-pd ")
end
end





--// Gui Visibility
function GuiVisible()
GuiOpened=not GuiOpened
if GuiOpened then
mainframe.Active=GuiOpened
mainframe.Visible=GuiOpened
for _,v in ipairs(mainframe:GetChildren()) do
if v:IsA("TextLabel") or v:IsA("TextButton") then
v.Active=true
end 
end
else
mainframe.Active=GuiOpened
mainframe.Visible=GuiOpened
for _,v in ipairs(mainframe:GetChildren()) do
if v:IsA("TextLabel") or v:IsA("TextButton") then
v.Active=false
end 
end
end
end 


--// Connect all three Functions
RunScript.MouseButton1Click:Connect(MainScript)
StopRunningScript.MouseButton1Click:Connect(StopScript)
opengui.MouseButton1Click:Connect(GuiVisible)
