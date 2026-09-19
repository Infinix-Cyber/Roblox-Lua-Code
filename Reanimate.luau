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
loadstring(game:HttpGet("https://raw.githubusercontent.com/Gelatekussy/GelatekHub/main/src/lib/Reanimate.lua"))()
game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("-net")
