local args = {
	"cmd",
	"-gh 132006952641112,102523984905681"
}
game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(args))

wait(2)

local args = {
	"cmd",
	"-pd"
}
game:GetService("ReplicatedStorage"):WaitForChild("01_server"):FireServer(unpack(args))

task.wait(2)

game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Axirian glitcher Stars by Crazy")

task.wait(1)

game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("btw already -pd")

task.wait(1)

game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Sorry for stealing ur script Tory💔")
