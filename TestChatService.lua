print("🧪 TEST MODE: Listening to ALL chat systems")
print("Every message will appear in the console")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

-- 1. Player.Chatted (самый надёжный)
local function connectPlayer(player)
    if player == LocalPlayer then return end
    pcall(function()
        player.Chatted:Connect(function(msg)
            print("📩 [Player.Chatted] from", player.Name, ":", msg)
        end)
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    connectPlayer(player)
end
Players.PlayerAdded:Connect(connectPlayer)
print("✅ Connected via Player.Chatted")

-- 2. OnMessageDoneFiltering (старая система)
pcall(function()
    local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local onMsg = chatEvents:FindFirstChild("OnMessageDoneFiltering")
        if onMsg and onMsg:IsA("RemoteEvent") then
            onMsg.OnClientEvent:Connect(function(data)
                if data and data.FromSpeaker and data.Message then
                    print("📩 [OnMessageDoneFiltering] from", data.FromSpeaker, ":", data.Message)
                end
            end)
            print("✅ Connected via OnMessageDoneFiltering")
        end
    end
end)

-- 3. TextChatService (новая система)
pcall(function()
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if channel then
            channel.MessageReceived:Connect(function(msg)
                if msg.TextSource then
                    local sender = Players:GetPlayerByUserId(msg.TextSource.UserId)
                    if sender then
                        print("📩 [TextChatService] from", sender.Name, ":", msg.Text)
                    end
                end
            end)
            print("✅ Connected via TextChatService")
        end
    end
end)

print("🧪 TEST MODE ACTIVE — waiting for messages...")
