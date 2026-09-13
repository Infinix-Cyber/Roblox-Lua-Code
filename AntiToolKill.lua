local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local WHITELIST = {
	["TheLocalMaze"] = true,
	["TheLocalMazeV2"] = true,
}

if not WHITELIST[player.Name] then return end

local char, hum, root, lastPos, lock
local threatTimer = 0
local GUARD_TIME = 0.4
local MIN_HP = 100

local function bind(c)
	char = c
	hum = c:WaitForChild("Humanoid", 3)
	root = c:WaitForChild("HumanoidRootPart", 3)
	lastPos = root and root.CFrame
end

player.CharacterAdded:Connect(function(c)
	task.wait(0.05)
	bind(c)
end)

if player.Character then bind(player.Character) end

local function scanThreat()
	if not root or not root.Parent then return false end
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {char}
	local parts = Workspace:GetPartBoundsInRadius(root.Position, 35, params)
	for _, p in ipairs(parts) do
		if p.Name == "Handle" or p.Name == "ClickTarget" then return true end
		local par = p.Parent
		if par and par:IsA("Tool") then return true end
	end
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= player then
			if pl.Character then
				for _, d in ipairs(pl.Character:GetDescendants()) do
					if d:IsA("Tool") then return true end
				end
			end
			if pl.Backpack then
				for _, d in ipairs(pl.Backpack:GetChildren()) do
					if d:IsA("Tool") then return true end
				end
			end
		end
	end
	return false
end

local function neutralize()
	if not char or not char.Parent then return end
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {char}
	local parts = Workspace:GetPartBoundsInRadius(root.Position, 35, params)
	for _, p in ipairs(parts) do
		pcall(function()
			if p.Name == "Handle" or p.Name == "ClickTarget" then p:Destroy() end
			local par = p.Parent
			if par and par:IsA("Tool") then par:Destroy() end
		end)
	end
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= player then
			if pl.Character then
				for _, d in ipairs(pl.Character:GetDescendants()) do
					if d:IsA("Tool") then pcall(function() d:Destroy() end) end
				end
			end
			if pl.Backpack then
				for _, d in ipairs(pl.Backpack:GetChildren()) do
					if d:IsA("Tool") then pcall(function() d:Destroy() end) end
				end
			end
		end
	end
	for _, d in ipairs(char:GetDescendants()) do
		if d:IsA("Tool") then pcall(function() d:Destroy() end) end
	end
end

RunService.Heartbeat:Connect(function(dt)
	if not char or not char.Parent then return end
	if not hum or not hum.Parent then
		local h = char:FindFirstChildOfClass("Humanoid")
		if h then hum = h else return end
	end
	if not root or not root.Parent then
		local r = char:FindFirstChild("HumanoidRootPart")
		if r then root = r else return end
	end
	if lock then return end
	lock = true

	pcall(function()
		local threat = scanThreat()
		local danger = threat
			or (hum.Health < 90)
			or (hum.Health <= 20)
			or root.Anchored
			or root.AssemblyLinearVelocity.Magnitude > 150
			or (lastPos and (root.CFrame.Position - lastPos.Position).Magnitude > 40)

		if danger then
			threatTimer = GUARD_TIME
		else
			threatTimer = math.max(0, threatTimer - dt)
		end

		if threatTimer > 0 then
			if hum.Health < MIN_HP then hum.Health = MIN_HP end
			if hum.MaxHealth < MIN_HP then hum.MaxHealth = MIN_HP end
			if root.Anchored then root.Anchored = false end
			if root.AssemblyLinearVelocity.Magnitude > 50 then
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
			end
			if lastPos and (root.CFrame.Position - lastPos.Position).Magnitude > 20 then
				root.CFrame = lastPos
			end
			if player.Character ~= char then player.Character = char end
			neutralize()
		end

		lastPos = root.CFrame
	end)

	lock = false
end)

local function watchHumanoid(h)
	h.Died:Connect(function()
		task.wait(0.03)
		if h.Parent then
			h.Health = MIN_HP
			h.MaxHealth = MIN_HP
		end
		if player.Character ~= char then
			player.Character = char
		end
	end)
end

if hum then watchHumanoid(hum) end
player.CharacterAdded:Connect(function(c)
	local h = c:WaitForChild("Humanoid", 3)
	if h then watchHumanoid(h) end
end)
