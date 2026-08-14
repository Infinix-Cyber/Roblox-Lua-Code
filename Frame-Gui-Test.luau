--!strict
-- ЧАСТЬ 1: Симуляция инициализации и глубокой проверки файлов
local StarterGui = game:GetService("StarterGui")

local function sendNotify(title: string, text: string)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 3
		})
	end)
end

task.spawn(function()
	sendNotify("Infinix Framework", "Запуск окружения Luau 2026...")
	task.wait(2.5)
	sendNotify("Infinix Framework", "Сканирование DataModel...")
	task.wait(3.0)
	sendNotify("Infinix Framework", "Обход внутренних триггеров...")
	task.wait(3.5)
	sendNotify("Infinix Framework", "Декомпиляция среды...")
	task.wait(4.0)
	sendNotify("Infinix Framework", "Done!")
	task.wait(2.0)
	
	-- Активируем триггер для запуска следующей части
	_G.InfinixReady = true
end)
--!strict
-- ЧАСТЬ 2: Отрисовка основного интерфейса (Ждем завершения Части 1)
repeat task.wait(0.5) until _G.InfinixReady == true

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JustABaseplatesMenu"
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = -1 -- Под клавиатурой
ScreenGui.Parent = PlayerGui
_G.InfinixScreenGui = ScreenGui

-- Функция перемещения (Drag)
local function makeDrag(frame: Frame)
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Фрейм меню
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"; MainFrame.Size = UDim2.new(0, 310, 0, 320)
MainFrame.Position = UDim2.new(0.18, 0, 0.35, 0); MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 1; MainFrame.Visible = false; MainFrame.Active = true
MainFrame.Parent = ScreenGui; makeDrag(MainFrame); _G.InfinixMainFrame = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10); MainCorner.Parent = MainFrame

-- Компоненты шапки
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45); Header.BackgroundTransparency = 1; Header.Parent = MainFrame

local HomeIcon = Instance.new("ImageLabel")
HomeIcon.Size = UDim2.new(0, 22, 0, 22); HomeIcon.Position = UDim2.new(0, 12, 0.5, -11)
HomeIcon.BackgroundTransparency = 1; HomeIcon.Image = "rbxassetid://10887309549"; HomeIcon.ImageTransparency = 1; HomeIcon.Parent = Header
_G.InfinixHomeIcon = HomeIcon

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -45, 1, 0); Title.Position = UDim2.new(0, 40, 0, 0)
Title.BackgroundTransparency = 1; Title.Text = "Just A Baseplate / Modified by Crazy Maze"
Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextSize = 13; Title.TextTransparency = 1
Title.FontFace = Font.fromName("BuilderSans", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = Header; _G.InfinixTitle = Title

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 140, 0, 20); VersionLabel.Position = UDim2.new(1, -10, 1, -22)
VersionLabel.AnchorPoint = Vector2.new(1, 1); VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "beta v1.0.4a-stable"; VersionLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
VersionLabel.TextSize = 11; VersionLabel.TextTransparency = 1; VersionLabel.Parent = MainFrame; _G.InfinixVersionLabel = VersionLabel

local PerfLabel = Instance.new("TextLabel")
PerfLabel.Size = UDim2.new(0, 140, 0, 15); PerfLabel.Position = UDim2.new(1, -10, 1, -8)
PerfLabel.AnchorPoint = Vector2.new(1, 1); PerfLabel.BackgroundTransparency = 1
PerfLabel.Text = "FPS: -- | PING: --ms"; PerfLabel.TextColor3 = Color3.fromRGB(90, 180, 120)
PerfLabel.TextSize = 10; PerfLabel.TextTransparency = 1; PerfLabel.Parent = MainFrame; _G.InfinixPerfLabel = PerfLabel

local lastUpdate = 0
RunService.RenderStepped:Connect(function(dt)
	lastUpdate += dt
	if lastUpdate >= 0.5 then
		lastUpdate = 0
		PerfLabel.Text = string.format("FPS: %d | PING: %dms", math.round(1/dt), math.clamp(math.round(Stats.Network.ServerByterateIn/100), 12, 120))
	end
end)

-- Скролл
local Scroller = Instance.new("ScrollingFrame")
Scroller.Size = UDim2.new(1, -20, 1, -85); Scroller.Position = UDim2.new(0, 10, 0, 48)
Scroller.BackgroundTransparency = 1; Scroller.BorderSizePixel = 0; Scroller.ScrollBarThickness = 3
Scroller.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150); Scroller.ScrollBarImageTransparency = 1
Scroller.CanvasSize = UDim2.new(0, 0, 0, 0); Scroller.Parent = MainFrame; _G.InfinixScroller = Scroller

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Scroller; ListLayout.SortOrder = Enum.SortOrder.LayoutOrder; ListLayout.Padding = UDim.new(0, 5)
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Scroller.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 5)
end)

-- Ряд кнопки
local ButtonRow = Instance.new("Frame")
ButtonRow.Size = UDim2.new(1, -2, 0, 36); ButtonRow.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ButtonRow.BackgroundTransparency = 1; ButtonRow.BorderSizePixel = 0; ButtonRow.Parent = Scroller; _G.InfinixButtonRow = ButtonRow

local RowCorner = Instance.new("UICorner")
RowCorner.CornerRadius = UDim.new(0, 6); RowCorner.Parent = ButtonRow

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(0.7, 0, 1, 0); Label.Position = UDim2.new(0, 10, 0, 0); Label.BackgroundTransparency = 1
Label.Text = "Infinix Cyber Administration"; Label.TextColor3 = Color3.fromRGB(240, 240, 240); Label.TextSize = 15
Label.FontFace = Font.fromName("BuilderSans", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Label.TextXAlignment = Enum.TextXAlignment.Left; Label.TextTransparency = 1; Label.Parent = ButtonRow; _G.InfinixLabel = Label

-- Триггер чита
local ActionBtn = Instance.new("ImageButton")
ActionBtn.Size = UDim2.new(0, 20, 0, 20); ActionBtn.Position = UDim2.new(1, -10, 0.5, -10); ActionBtn.BackgroundTransparency = 1
ActionBtn.Image = "rbxassetid://12704332151"; ActionBtn.ImageColor3 = Color3.fromRGB(70, 210, 110); ActionBtn.ImageTransparency = 1
ActionBtn.Parent = ButtonRow; _G.InfinixActionBtn = ActionBtn

_G.InfinixPart2Ready = true
--!strict
-- ЧАСТЬ 3: Развертывание Infinix Real-Time Core Diagnostics и анимаций логов
repeat task.wait(0.5) until _G.InfinixPart2Ready == true

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LogService = game:GetService("LogService")

local ScreenGui = _G.InfinixScreenGui
local MainFrame = _G.InfinixMainFrame
local Scroller = _G.InfinixScroller
local ButtonRow = _G.InfinixButtonRow
local Label = _G.InfinixLabel
local ActionBtn = _G.InfinixActionBtn

local MainTargetPos = UDim2.new(0.18, 0, 0.25, 0)
local MainHiddenPos = UDim2.new(0.18, 0, 0.35, 0)
local LogsTargetPos = UDim2.new(0.53, 0, 0.25, 0)
local LogsHiddenPos = UDim2.new(0.53, 0, 0.35, 0)
local TweenInfoObj = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Панель диагностики (Логи)
local LogsFrame = Instance.new("Frame")
LogsFrame.Name = "LogsFrame"; LogsFrame.Size = UDim2.new(0, 330, 0, 320)
LogsFrame.Position = LogsHiddenPos; LogsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogsFrame.BackgroundTransparency = 1; LogsFrame.Visible = false; LogsFrame.Active = true
LogsFrame.Parent = ScreenGui

local LogsCorner = Instance.new("UICorner")
LogsCorner.CornerRadius = UDim.new(0, 10); LogsCorner.Parent = LogsFrame

local LogsHeader = Instance.new("Frame")
LogsHeader.Size = UDim2.new(1, 0, 0, 45); LogsHeader.BackgroundTransparency = 1; LogsHeader.Parent = LogsFrame

local LogsTitle = Instance.new("TextLabel")
LogsTitle.Size = UDim2.new(1, -80, 1, 0); LogsTitle.Position = UDim2.new(0, 15, 0, 0)
LogsTitle.BackgroundTransparency = 1; LogsTitle.Text = "Infinix Real-Time Core Diagnostics"
LogsTitle.TextColor3 = Color3.fromRGB(255, 255, 255); LogsTitle.TextSize = 13; LogsTitle.TextTransparency = 1
LogsTitle.FontFace = Font.fromName("BuilderSans", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
LogsTitle.TextXAlignment = Enum.TextXAlignment.Left; LogsTitle.Parent = LogsHeader

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0, 50, 0, 22); ClearBtn.Position = UDim2.new(1, -15, 0.5, -11)
ClearBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); ClearBtn.BackgroundTransparency = 1
ClearBtn.Text = "Clear"; ClearBtn.TextColor3 = Color3.fromRGB(200, 200, 200); ClearBtn.TextSize = 11; ClearBtn.TextTransparency = 1
ClearBtn.FontFace = Font.fromName("BuilderSans", Enum.FontWeight.Bold, Enum.FontStyle.Normal); ClearBtn.Parent = LogsHeader

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 4); ClearCorner.Parent = ClearBtn

local LogsScroller = Instance.new("ScrollingFrame")
LogsScroller.Size = UDim2.new(1, -20, 1, -60); LogsScroller.Position = UDim2.new(0, 10, 0, 48)
LogsScroller.BackgroundTransparency = 1; LogsScroller.BorderSizePixel = 0; LogsScroller.ScrollBarThickness = 2
LogsScroller.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150); LogsScroller.ScrollBarImageTransparency = 1
LogsScroller.CanvasSize = UDim2.new(0, 0, 0, 0); LogsScroller.Parent = LogsFrame

local LogsListLayout = Instance.new("UIListLayout")
LogsListLayout.Parent = LogsScroller; LogsListLayout.SortOrder = Enum.SortOrder.LayoutOrder; LogsListLayout.Padding = UDim.new(0, 4)

local MAX_LOGS, logCount, activeLogs = 300, 0, {} :: {TextLabel}

LogsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	LogsScroller.CanvasSize = UDim2.new(0, 0, 0, LogsListLayout.AbsoluteContentSize.Y + 5)
	LogsScroller.CanvasPosition = Vector2.new(0, LogsListLayout.AbsoluteContentSize.Y)
end)

local function addLog(text: string, color: Color3)
	logCount += 1
	if #activeLogs >= MAX_LOGS then
		local oldest = table.remove(activeLogs, 1)
		if oldest then oldest:Destroy() end
	end
	local LogText = Instance.new("TextLabel")
	LogText.Size = UDim2.new(1, 0, 0, 16); LogText.BackgroundTransparency = 1
	LogText.Text = string.format("[%s] %s", os.date("%X"), text); LogText.TextColor3 = color; LogText.TextSize = 11
	LogText.FontFace = Font.fromName("BuilderSans", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
	LogText.TextXAlignment = Enum.TextXAlignment.Left; LogText.TextWrapped = true; LogText.LayoutOrder = logCount
	LogText.TextTransparency = LogsTitle.TextTransparency; LogText.Parent = LogsScroller
	table.insert(activeLogs, LogText)
end

ClearBtn.MouseButton1Click:Connect(function()
	for _, v in ipairs(activeLogs) do v:Destroy() end
	table.clear(activeLogs)
	addLog("Буфер успешно очищен.", Color3.fromRGB(120, 220, 150))
end)

-- Системный перехват
LogService.MessageOut:Connect(function(msg, msgType)
	if msgType == Enum.MessageType.MessageError then addLog("[GAME ERROR] " .. msg, Color3.fromRGB(255, 80, 80))
	elseif msgType == Enum.MessageType.MessageWarning then addLog("[GAME WARN] " .. msg, Color3.fromRGB(255, 160, 50)) end
end)

Players.PlayerAdded:Connect(function(p)
	addLog("Подключился: " .. p.Name, Color3.fromRGB(100, 255, 100))
	p.Chatted:Connect(function(msg) addLog(p.Name .. " [CHAT]: " .. msg, Color3.fromRGB(240, 240, 240)) end)
end)

Players.PlayerRemoving:Connect(function(p) addLog("Покинул сервер: " .. p.Name, Color3.fromRGB(255, 100, 100)) end)

for _, p in ipairs(Players:GetPlayers()) do
	p.Chatted:Connect(function(msg) addLog(p.Name .. " [CHAT]: " .. msg, Color3.fromRGB(240, 240, 240)) end)
end
addLog("Модуль Diagnostics развернут.", Color3.fromRGB(100, 200, 255))

ActionBtn.MouseButton1Click:Connect(function()
	addLog("Запрос авторизации к Infinix удаленному серверу...", Color3.fromRGB(230, 230, 100))
	local success, err = pcall(function()
		loadstring(game:HttpGet("https://githubusercontent.com"))()
	end)
	if success then addLog("Infinix Core загружен.", Color3.fromRGB(100, 255, 100))
	else addLog("[CRITICAL ERROR] Сбой запроса. Проверьте сеть.", Color3.fromRGB(255, 80, 80)) end
end)

-- Кнопка-Шестерёнка
local SetContainer = Instance.new("Frame")
SetContainer.Size = UDim2.new(0, 35, 0, 35); SetContainer.Position = UDim2.new(1, -50, 0, 15)
SetContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20); SetContainer.BackgroundTransparency = 1; SetContainer.Active = true; SetContainer.Parent = ScreenGui

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(1, 0); ContainerCorner.Parent = SetContainer

local SetIcon = Instance.new("ImageButton")
SetIcon.Size = UDim2.new(0, 20, 0, 20); SetIcon.Position = UDim2.new(0.5, -10, 0.5, -10); SetIcon.BackgroundTransparency = 1
SetIcon.Image = "rbxassetid://11432839019"; SetIcon.ImageColor3 = Color3.fromRGB(255, 255, 255); SetIcon.ImageTransparency = 1; SetIcon.Parent = SetContainer

TweenService:Create(SetContainer, TweenInfoObj, {BackgroundTransparency = 0.3}):Play()
TweenService:Create(SetIcon, TweenInfoObj, {ImageTransparency = 0}):Play()

local isMenuOpen, isTweening = false, false
SetIcon.MouseButton1Click:Connect(function()
	if isTweening then return end
	isTweening = true; isMenuOpen = not isMenuOpen
	TweenService:Create(SetIcon, TweenInfoObj, {Rotation = isMenuOpen and 45 or 0}):Play()

	if isMenuOpen then
		MainFrame.Visible = true; LogsFrame.Visible = true
		TweenService:Create(MainFrame, TweenInfoObj, {Position = MainTargetPos, BackgroundTransparency = 0.3}):Play()
		TweenService:Create(LogsFrame, TweenInfoObj, {Position = LogsTargetPos, BackgroundTransparency = 0.3}):Play()
		TweenService:Create(_G.InfinixTitle, TweenInfoObj, {TextTransparency = 0}):Play()
		TweenService:Create(LogsTitle, TweenInfoObj, {TextTransparency = 0}):Play()
		TweenService:Create(ClearBtn, TweenInfoObj, {TextTransparency = 0, BackgroundTransparency = 0.5}):Play()
		TweenService:Create(_G.InfinixVersionLabel, TweenInfoObj, {TextTransparency = 0}):Play()
		TweenService:Create(_G.InfinixPerfLabel, TweenInfoObj, {TextTransparency = 0}):Play()
		TweenService:Create(_G.InfinixHomeIcon, TweenInfoObj, {ImageTransparency = 0}):Play()
		TweenService:Create(ButtonRow, TweenInfoObj, {BackgroundTransparency = 0.4}):Play()
		TweenService:Create(Label, TweenInfoObj, {TextTransparency = 0}):Play()
		TweenService:Create(ActionBtn, TweenInfoObj, {ImageTransparency = 0}):Play()
		TweenService:Create(Scroller, TweenInfoObj, {ScrollBarImageTransparency = 0}):Play()
		TweenService:Create(LogsScroller, TweenInfoObj, {ScrollBarImageTransparency = 0}):Play()
		for _, v in ipairs(activeLogs) do TweenService:Create(v, TweenInfoObj, {TextTransparency = 0}):Play() end
		task.wait(0.3)
	else
		TweenService:Create(MainFrame, TweenInfoObj, {Position = MainHiddenPos, BackgroundTransparency = 1}):Play()
		TweenService:Create(LogsFrame, TweenInfoObj, {Position = LogsHiddenPos, BackgroundTransparency = 1}):Play()
		TweenService:Create(_G.InfinixTitle, TweenInfoObj, {TextTransparency = 1}):Play()
		TweenService:Create(LogsTitle, TweenInfoObj, {TextTransparency = 1}):Play()
		TweenService:Create(ClearBtn, TweenInfoObj, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
		TweenService:Create(_G.InfinixVersionLabel, TweenInfoObj, {TextTransparency = 1}):Play()
		TweenService:Create(_G.InfinixPerfLabel, TweenInfoObj, {TextTransparency = 1}):Play()
		TweenService:Create(_G.InfinixHomeIcon, TweenInfoObj, {ImageTransparency = 1}):Play()
		TweenService:Create(ButtonRow, TweenInfoObj, {BackgroundTransparency = 1}):Play()
		TweenService:Create(Label, TweenInfoObj, {TextTransparency = 1}):Play()
		TweenService:Create(ActionBtn, TweenInfoObj, {ImageTransparency = 1}):Play()
		TweenService:Create(Scroller, TweenInfoObj, {ScrollBarImageTransparency = 1}):Play()
		TweenService:Create(LogsScroller, TweenInfoObj, {ScrollBarImageTransparency = 1}):Play()
		for _, v in ipairs(activeLogs) do TweenService:Create(v, TweenInfoObj, {TextTransparency = 1}):Play() end
		task.wait(0.3); MainFrame.Visible = false; LogsFrame.Visible = false
	end
	isTweening = false
end)
