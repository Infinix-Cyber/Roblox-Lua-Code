-- Anti kill script by Local Maze
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local TARGET_USER = "TheLocalMaze"

local player = Players.LocalPlayer
local isFreezed = false

-- ФИКС 2026: Функция отправки сообщения в реальный чат сервера через SendAsync
local function sendAntiCheatToChat()
	task.spawn(function()
		-- Ждем полной загрузки каналов TextChatService в 2026 году
		local textChannels = TextChatService:WaitForChild("TextChannels", 5)
		if textChannels then
			local rbxGeneral = textChannels:WaitForChild("RBXGeneral", 5)
			if rbxGeneral and rbxGeneral:IsA("TextChannel") then
				-- Отправляем официальное сообщение, которое увидят ВСЕ игроки на сервере
				pcall(function()
					rbxGeneral:SendAsync("Anti kill script by Local Maze")
				end)
			end
		end
	end)
end

local function timedFreezeShield(character)
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	
	humanoid.TouchToEquip = false

	local loop
	loop = RunService.Heartbeat:Connect(function()
		if not character.Parent then 
			loop:Disconnect() 
			return 
		end
		
		-- Радар угроз (Радиус 15 студов)
		local params = OverlapParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {character}
		
		local parts = workspace:GetPartBoundsInRadius(rootPart.Position, 15, params)
		local threatFound = false
		
		for _, hit in ipairs(parts) do
			if hit.Name == "Handle" or hit.Name == "ClickTarget" or hit:IsA("Tool") or (hit.Parent and hit.Parent:IsA("Tool")) then
				threatFound = true
				
				-- Моментально аннигилируем колу из памяти телефона
				pcall(function()
					hit.CanCollide = false
					hit.CanTouch = false
					hit:Destroy()
				end)
			end
		end
		
		-- Логика умного экстренного Freeze на 0.2 секунды под задержку чита
		if threatFound and not isFreezed then
			isFreezed = true
			
			rootPart.Anchored = true
			rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			
			task.delay(0.2, function()
				if rootPart and rootPart.Parent then
					rootPart.Anchored = false
					isFreezed = false
				end
			end)
		end
		
		-- Режим призрака во время бега
		if not isFreezed then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
					part.CanTouch = false
				end
			end
		end
	end)
end

-- Авторизация под ником TheLocalMaze
if player.Name == TARGET_USER then
	if player.Character then timedFreezeShield(player.Character) end
	player.CharacterAdded:Connect(timedFreezeShield)
	
	-- Запуск отправки сообщения в чат 2026 года
	sendAntiCheatToChat()
	print("[SUCCESS] Loaded: Anti kill script by Local Maze")
end
