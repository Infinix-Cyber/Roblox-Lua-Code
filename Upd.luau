-- Anti kill script by Local Maze (2026 Ultra-Safe Version)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local TARGET_USER = "TheLocalMaze"

local player = Players.LocalPlayer
local isFreezed = false

-- Защищенная отправка в чат (ФИКС 2026)
local function sendAntiCheatToChat()
	task.spawn(function()
		pcall(function()
			local textChannels = TextChatService:WaitForChild("TextChannels", 5)
			if textChannels then
				local rbxGeneral = textChannels:WaitForChild("RBXGeneral", 5)
				if rbxGeneral then
					rbxGeneral:SendAsync("Anti kill script by Local Maze")
				end
			end
		end)
	end)
end

local function timedFreezeShield(character)
	-- Безопасное ожидание гуманоида и рутпарта
	local humanoid = character:WaitForChild("Humanoid", 5)
	local rootPart = character:WaitForChild("HumanoidRootPart", 5)
	
	if humanoid then
		pcall(function() humanoid.TouchToEquip = false end)
	end

	local loop
	loop = RunService.Heartbeat:Connect(function()
		-- Если персонаж удален, плавно выключаем цикл без ошибок
		if not character or not character.Parent or not rootPart or not rootPart.Parent then 
			pcall(function() loop:Disconnect() end)
			return 
		end
		
		local threatFound = false
		
		-- Безопасный сканер зоны (Радиус 15 студов)
		pcall(function()
			local params = OverlapParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = {character}
			
			local parts = workspace:GetPartBoundsInRadius(rootPart.Position, 15, params)
			
			for _, hit in ipairs(parts) do
				if hit and hit.Parent then
					local name = hit.Name
					-- Если это хитбокс, кола или инструмент чита
					if name == "Handle" or name == "ClickTarget" or hit:IsA("Tool") or hit.Parent:IsA("Tool") then
						threatFound = true
						
						-- Аннигилируем физику летящего предмета локально
						pcall(function()
							hit.CanCollide = false
							hit.CanTouch = false
							hit:Destroy() -- Удаляем, чтобы не лагало
						end)
					end
				end
			end
		end)
		
		-- Безопасная логика Freeze по вашей идее
		if threatFound and not isFreezed then
			isFreezed = true
			
			pcall(function()
				rootPart.Anchored = true
				rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end)
			
			-- Отключение заморозки строго через 0.2 сек под тайминг чита
			task.delay(0.2, function()
				isFreezed = false
				pcall(function()
					if rootPart and rootPart.Parent then
						rootPart.Anchored = false
					end
				end)
			end)
		end
		
		-- Безопасный режим призрака для ходьбы
		if not isFreezed then
			pcall(function()
				rootPart.AssemblyLinearVelocity = Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0)
				rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
				
				for _, part in ipairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
						part.CanTouch = false
					end
				end
			end)
		end
	end)
end

-- Проверка аккаунта
if player.Name == TARGET_USER then
	if player.Character then timedFreezeShield(player.Character) end
	player.CharacterAdded:Connect(timedFreezeShield)
	
	sendAntiCheatToChat()
	print("[SUCCESS] Loaded: Anti kill script by Local Maze")
else
	warn("[ERROR] Скрипт залочен под ник: " .. TARGET_USER)
end
