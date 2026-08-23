local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local Remote = ReplicatedStorage:WaitForChild("01_server", 5)
if not Remote then return end

local WHITELIST = {
	["TheLocalMazeV2"] = true,
	["TheLocalMaze"] = true,
	["Quur92"] = true,
	["BAcON_KJpast"] = true
}

TextChatService.MessageReceived:Connect(function(message)
	-- Если сообщение системное или нет отправителя — выходим
	if not message.FromUser then return end
	
	-- Находим реального игрока по его UserId из TextSource
	local player = Players:GetPlayerByUserId(message.FromUser.UserId)
	if not player then return end

	-- Проверяем ник игрока в вайтлисте
	if not WHITELIST[player.Name] then return end

	if message.Text == "-# Rigs1" then
		local args1 = {
			"cmd",
			"-gh 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835 86532446465835"
		}
		Remote:FireServer(unpack(args1))

		task.wait(2)

		local args2 = {
			"cmd",
			"-pd"
		}
		Remote:FireServer(unpack(args2))

	elseif message.Text == "-# PlushRigs" then
		local args1 = {
			"cmd",
			"-gh 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628 99134410491628"
		}
		Remote:FireServer(unpack(args1))

		task.wait(2)

		local args2 = {
			"cmd",
			"-pd"
		}
		Remote:FireServer(unpack(args2))

	elseif message.Text == "-# PlushRigs2" then
		local args1 = {
			"cmd",
			"-gh 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669 130209733282669"
		}
		Remote:FireServer(unpack(args1))

		task.wait(2)

		local args2 = {
			"cmd",
			"-pd"
		}
		Remote:FireServer(unpack(args2))

	elseif message.Text == "-# ToryRigs" then
		local args1 = {
			"cmd",
			"-gh 5316479641,5316539421,5268602207,5316549755,132006952641112,102523984905681,77986176057943,89328465080930,111787383238402,126699902233201,138364679836274"
		}
		Remote:FireServer(unpack(args1))

		task.wait(2)

		local args2 = {
			"cmd",
			"-pd"
		}
		Remote:FireServer(unpack(args2))
	end
end)
