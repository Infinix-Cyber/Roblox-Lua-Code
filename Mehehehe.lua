-- =====================================================
-- GOON TRANSLATOR V2.4 (NO TTS, NO NIL)
-- by Extra & cheat96354961 | 2026
-- =====================================================

local player = game.Players.LocalPlayer
local http = game:GetService("HttpService")
local soundService = game:GetService("SoundService")

-- ===== УНИВЕРСАЛЬНЫЙ ЧАТ (БЕЗ ОШИБОК) =====
local function sendToChat(msg)
    if not msg or msg == "" then return end
    
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local chatEvent = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent then
        local sayRequest = chatEvent:FindFirstChild("SayMessageRequest")
        if sayRequest then
            pcall(function()
                sayRequest:FireServer(msg, "All")
            end)
            return
        end
    end
    
    local chatService = game:GetService("Chat")
    if chatService and chatService:FindFirstChild("Chat") then
        pcall(function()
            chatService.Chat:FireServer(msg, "All")
        end)
        return
    end
end

-- ===== ФУНКЦИЯ ДЛЯ РУССКИХ НАЗВАНИЙ =====
local function getRussianName(code)
    local names = {
        ru="Русский", en="Английский", es="Испанский", fr="Французский",
        de="Немецкий", it="Итальянский", pt="Португальский", zh="Китайский",
        ja="Японский", ko="Корейский", ar="Арабский", hi="Хинди",
        bn="Бенгальский", pa="Панджаби", jv="Яванский", ms="Малайский",
        tl="Тагальский", vi="Вьетнамский", th="Тайский", my="Бирманский",
        km="Кхмерский", lo="Лаосский", ne="Непальский", si="Сингальский",
        ur="Урду", fa="Фарси", he="Иврит", el="Греческий",
        pl="Польский", cs="Чешский", sk="Словацкий", hu="Венгерский",
        ro="Румынский", bg="Болгарский", sr="Сербский", hr="Хорватский",
        sl="Словенский", lt="Литовский", lv="Латышский", et="Эстонский",
        fi="Финский", sv="Шведский", no="Норвежский", da="Датский",
        is="Исландский", ga="Ирландский", cy="Валлийский", eu="Баскский",
        ca="Каталанский", gl="Галисийский", sq="Албанский", mk="Македонский",
        bs="Боснийский", uk="Украинский", be="Белорусский", kk="Казахский",
        uz="Узбекский", az="Азербайджанский", hy="Армянский", ka="Грузинский",
        mn="Монгольский", am="Амхарский", sw="Суахили", ha="Хауса",
        ig="Игбо", yo="Йоруба", zu="Зулу", af="Африкаанс",
        ny="Чичева", st="Сесото", tn="Тсвана", ts="Тсонга",
        ve="Венда", xh="Коса", rw="Киньяруанда", rn="Кирунди",
        mg="Малагасийский", id="Индонезийский", su="Сунданский",
        min="Минангкабау", bug="Бугийский", ace="Ачехский", ban="Балийский",
        mad="Мадурский", mak="Макассарский", ceb="Себуанский", ilo="Илоканский",
        hil="Хилигайнон", pam="Капампанган", chv="Чувашский", sah="Якутский",
        tyv="Тувинский", alt="Алтайский", ab="Абхазский", os="Осетинский",
        ce="Чеченский", inh="Ингушский", lez="Лезгинский", ava="Аварский",
        dar="Даргинский", lbe="Лакский", tab="Табасаранский", udi="Удинский"
    }
    return names[code] or code
end

-- ===== ПРИВЕТСТВИЕ =====
sendToChat("Translator By Extra & cheat96354961")
task.wait(2)
sendToChat("I'm so tired dude.")
task.wait(2)
sendToChat("GOON TRANSLATOR V2.4 — now with English support!")
task.wait(1.5)

-- ===== ВСЕ ЯЗЫКИ =====
local languages = {
    {code="ru", name="Russian", flag="🇷🇺"},
    {code="en", name="English", flag="🇬🇧"},
    {code="es", name="Spanish", flag="🇪🇸"},
    {code="fr", name="French", flag="🇫🇷"},
    {code="de", name="German", flag="🇩🇪"},
    {code="it", name="Italian", flag="🇮🇹"},
    {code="pt", name="Portuguese", flag="🇵🇹"},
    {code="zh", name="Chinese", flag="🇨🇳"},
    {code="ja", name="Japanese", flag="🇯🇵"},
    {code="ko", name="Korean", flag="🇰🇷"},
    {code="ar", name="Arabic", flag="🇸🇦"},
    {code="hi", name="Hindi", flag="🇮🇳"},
    {code="bn", name="Bengali", flag="🇧🇩"},
    {code="pa", name="Punjabi", flag="🇮🇳"},
    {code="jv", name="Javanese", flag="🇮🇩"},
    {code="ms", name="Malay", flag="🇲🇾"},
    {code="tl", name="Tagalog", flag="🇵🇭"},
    {code="vi", name="Vietnamese", flag="🇻🇳"},
    {code="th", name="Thai", flag="🇹🇭"},
    {code="my", name="Burmese", flag="🇲🇲"},
    {code="km", name="Khmer", flag="🇰🇭"},
    {code="lo", name="Lao", flag="🇱🇦"},
    {code="ne", name="Nepali", flag="🇳🇵"},
    {code="si", name="Sinhala", flag="🇱🇰"},
    {code="ur", name="Urdu", flag="🇵🇰"},
    {code="fa", name="Persian", flag="🇮🇷"},
    {code="he", name="Hebrew", flag="🇮🇱"},
    {code="el", name="Greek", flag="🇬🇷"},
    {code="pl", name="Polish", flag="🇵🇱"},
    {code="cs", name="Czech", flag="🇨🇿"},
    {code="sk", name="Slovak", flag="🇸🇰"},
    {code="hu", name="Hungarian", flag="🇭🇺"},
    {code="ro", name="Romanian", flag="🇷🇴"},
    {code="bg", name="Bulgarian", flag="🇧🇬"},
    {code="sr", name="Serbian", flag="🇷🇸"},
    {code="hr", name="Croatian", flag="🇭🇷"},
    {code="sl", name="Slovenian", flag="🇸🇮"},
    {code="lt", name="Lithuanian", flag="🇱🇹"},
    {code="lv", name="Latvian", flag="🇱🇻"},
    {code="et", name="Estonian", flag="🇪🇪"},
    {code="fi", name="Finnish", flag="🇫🇮"},
    {code="sv", name="Swedish", flag="🇸🇪"},
    {code="no", name="Norwegian", flag="🇳🇴"},
    {code="da", name="Danish", flag="🇩🇰"},
    {code="is", name="Icelandic", flag="🇮🇸"},
    {code="ga", name="Irish", flag="🇮🇪"},
    {code="cy", name="Welsh", flag="🏴"},
    {code="eu", name="Basque", flag="🇪🇸"},
    {code="ca", name="Catalan", flag="🇪🇸"},
    {code="gl", name="Galician", flag="🇪🇸"},
    {code="sq", name="Albanian", flag="🇦🇱"},
    {code="mk", name="Macedonian", flag="🇲🇰"},
    {code="bs", name="Bosnian", flag="🇧🇦"},
    {code="uk", name="Ukrainian", flag="🇺🇦"},
    {code="be", name="Belarusian", flag="🇧🇾"},
    {code="kk", name="Kazakh", flag="🇰🇿"},
    {code="uz", name="Uzbek", flag="🇺🇿"},
    {code="az", name="Azerbaijani", flag="🇦🇿"},
    {code="hy", name="Armenian", flag="🇦🇲"},
    {code="ka", name="Georgian", flag="🇬🇪"},
    {code="mn", name="Mongolian", flag="🇲🇳"},
    {code="am", name="Amharic", flag="🇪🇹"},
    {code="sw", name="Swahili", flag="🇹🇿"},
    {code="ha", name="Hausa", flag="🇳🇬"},
    {code="ig", name="Igbo", flag="🇳🇬"},
    {code="yo", name="Yoruba", flag="🇳🇬"},
    {code="zu", name="Zulu", flag="🇿🇦"},
    {code="af", name="Afrikaans", flag="🇿🇦"},
    {code="ny", name="Chichewa", flag="🇲🇼"},
    {code="st", name="Sesotho", flag="🇱🇸"},
    {code="tn", name="Tswana", flag="🇧🇼"},
    {code="ts", name="Tsonga", flag="🇲🇿"},
    {code="ve", name="Venda", flag="🇿🇦"},
    {code="xh", name="Xhosa", flag="🇿🇦"},
    {code="rw", name="Kinyarwanda", flag="🇷🇼"},
    {code="rn", name="Kirundi", flag="🇧🇮"},
    {code="mg", name="Malagasy", flag="🇲🇬"},
    {code="id", name="Indonesian", flag="🇮🇩"},
    {code="su", name="Sundanese", flag="🇮🇩"},
    {code="min", name="Minangkabau", flag="🇮🇩"},
    {code="bug", name="Buginese", flag="🇮🇩"},
    {code="ace", name="Achinese", flag="🇮🇩"},
    {code="ban", name="Balinese", flag="🇮🇩"},
    {code="mad", name="Madurese", flag="🇮🇩"},
    {code="mak", name="Makassar", flag="🇮🇩"},
    {code="ceb", name="Cebuano", flag="🇵🇭"},
    {code="ilo", name="Ilocano", flag="🇵🇭"},
    {code="hil", name="Hiligaynon", flag="🇵🇭"},
    {code="pam", name="Kapampangan", flag="🇵🇭"},
    {code="chv", name="Chuvash", flag="🇷🇺"},
    {code="sah", name="Yakut", flag="🇷🇺"},
    {code="tyv", name="Tuvan", flag="🇷🇺"},
    {code="alt", name="Altai", flag="🇷🇺"},
    {code="ab", name="Abkhaz", flag="🇬🇪"},
    {code="os", name="Ossetian", flag="🇬🇪"},
    {code="ce", name="Chechen", flag="🇷🇺"},
    {code="inh", name="Ingush", flag="🇷🇺"},
    {code="lez", name="Lezghian", flag="🇷🇺"},
    {code="ava", name="Avar", flag="🇷🇺"},
    {code="dar", name="Dargwa", flag="🇷🇺"},
    {code="lbe", name="Lak", flag="🇷🇺"},
    {code="tab", name="Tabasaran", flag="🇷🇺"},
    {code="udi", name="Udi", flag="🇦🇿"},
}
table.sort(languages, function(a,b) return a.name < b.name end)

-- ===== ТЕКУЩИЕ ЯЗЫКИ =====
local srcLang = languages[1]
local tgtLang = languages[2]
local lastTranslated = ""
local history = {}
local canSend = true

-- ===== ГУИ =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GoonTranslator"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 440, 0, 420)
frame.Position = UDim2.new(0.5, -220, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(18, 20, 38)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 40, 62)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 23, 42))
})
grad.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 150, 255)
stroke.Thickness = 1.5
stroke.Transparency = 0.4
stroke.Parent = frame

-- ЗАГОЛОВОК
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 32)
title.Position = UDim2.new(0, 12, 0, 2)
title.BackgroundTransparency = 1
title.Text = "🏆 GOON TRANSLATOR V2.4"
title.TextColor3 = Color3.fromRGB(255, 220, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- ПОДЗАГОЛОВОК
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -60, 0, 16)
subTitle.Position = UDim2.new(0, 14, 0, 30)
subTitle.BackgroundTransparency = 1
subTitle.Text = "by Extra & cheat96354961 | 2026"
subTitle.TextColor3 = Color3.fromRGB(160, 180, 220)
subTitle.TextSize = 12
subTitle.Font = Enum.Font.Gotham
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = frame

-- КНОПКА ЗАКРЫТИЯ
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 60)
closeBtn.BackgroundTransparency = 0.15
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = frame
local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 10)
cc.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- ===== ПАНЕЛЬ ЯЗЫКОВ =====
local langPanel = Instance.new("Frame")
langPanel.Size = UDim2.new(0.95, 0, 0, 48)
langPanel.Position = UDim2.new(0.025, 0, 0.11, 0)
langPanel.BackgroundTransparency = 1
langPanel.Parent = frame

local srcBtn = Instance.new("TextButton")
srcBtn.Size = UDim2.new(0.36, 0, 1, 0)
srcBtn.Position = UDim2.new(0, 0, 0, 0)
srcBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 80)
srcBtn.BackgroundTransparency = 0.3
srcBtn.Text = "🇷🇺 Russian / Русский ▼"
srcBtn.TextColor3 = Color3.fromRGB(255,255,255)
srcBtn.TextSize = 14
srcBtn.Font = Enum.Font.GothamBold
srcBtn.BorderSizePixel = 0
srcBtn.Parent = langPanel
local srcCorner = Instance.new("UICorner")
srcCorner.CornerRadius = UDim.new(0, 10)
srcCorner.Parent = srcBtn

local swapBtn = Instance.new("TextButton")
swapBtn.Size = UDim2.new(0.12, 0, 1, 0)
swapBtn.Position = UDim2.new(0.44, 0, 0, 0)
swapBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
swapBtn.BackgroundTransparency = 0.2
swapBtn.Text = "↔"
swapBtn.TextColor3 = Color3.fromRGB(255,255,255)
swapBtn.TextSize = 22
swapBtn.Font = Enum.Font.GothamBold
swapBtn.BorderSizePixel = 0
swapBtn.Parent = langPanel
local swapCorner = Instance.new("UICorner")
swapCorner.CornerRadius = UDim.new(0, 10)
swapCorner.Parent = swapBtn

local tgtBtn = Instance.new("TextButton")
tgtBtn.Size = UDim2.new(0.36, 0, 1, 0)
tgtBtn.Position = UDim2.new(0.62, 0, 0, 0)
tgtBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 80)
tgtBtn.BackgroundTransparency = 0.3
tgtBtn.Text = "🇬🇧 English / Английский ▼"
tgtBtn.TextColor3 = Color3.fromRGB(255,255,255)
tgtBtn.TextSize = 14
tgtBtn.Font = Enum.Font.GothamBold
tgtBtn.BorderSizePixel = 0
tgtBtn.Parent = langPanel
local tgtCorner = Instance.new("UICorner")
tgtCorner.CornerRadius = UDim.new(0, 10)
tgtCorner.Parent = tgtBtn

-- ===== ПОЛЕ ВВОДА =====
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9, 0, 0, 80)
textBox.Position = UDim2.new(0.05, 0, 0.27, 0)
textBox.BackgroundColor3 = Color3.fromRGB(45, 50, 75)
textBox.BackgroundTransparency = 0.2
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.PlaceholderText = "Введите текст / Enter text (auto-detect)"
textBox.PlaceholderColor3 = Color3.fromRGB(160, 170, 200)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 18
textBox.TextWrapped = true
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.TextYAlignment = Enum.TextYAlignment.Top
textBox.ClearTextOnFocus = false
textBox.BorderSizePixel = 0
textBox.Parent = frame
local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 14)
tbCorner.Parent = textBox

-- ===== КНОПКИ ДЕЙСТВИЙ =====
local actionPanel = Instance.new("Frame")
actionPanel.Size = UDim2.new(0.9, 0, 0, 40)
actionPanel.Position = UDim2.new(0.05, 0, 0.53, 0)
actionPanel.BackgroundTransparency = 1
actionPanel.Parent = frame

local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(0.44, 0, 1, 0)
sendBtn.Position = UDim2.new(0, 0, 0, 0)
sendBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
sendBtn.Text = "📤 Send / Отправить"
sendBtn.TextColor3 = Color3.fromRGB(255,255,255)
sendBtn.TextSize = 17
sendBtn.Font = Enum.Font.GothamBold
sendBtn.BorderSizePixel = 0
sendBtn.Parent = actionPanel
local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 12)
sendCorner.Parent = sendBtn

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.26, 0, 1, 0)
copyBtn.Position = UDim2.new(0.48, 0, 0, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 160)
copyBtn.Text = "📋 Copy"
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.TextSize = 16
copyBtn.Font = Enum.Font.GothamBold
copyBtn.BorderSizePixel = 0
copyBtn.Parent = actionPanel
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 12)
copyCorner.Parent = copyBtn

-- ВМЕСТО TTS — КНОПКА ОЧИСТКИ (CLEAR)
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0.20, 0, 1, 0)
clearBtn.Position = UDim2.new(0.78, 0, 0, 0)
clearBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 50)
clearBtn.Text = "🗑️ Clear"
clearBtn.TextColor3 = Color3.fromRGB(255,255,255)
clearBtn.TextSize = 16
clearBtn.Font = Enum.Font.GothamBold
clearBtn.BorderSizePixel = 0
clearBtn.Parent = actionPanel
local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 12)
clearCorner.Parent = clearBtn

-- ===== ИСТОРИЯ =====
local historyFrame = Instance.new("Frame")
historyFrame.Size = UDim2.new(0.9, 0, 0, 72)
historyFrame.Position = UDim2.new(0.05, 0, 0.67, 0)
historyFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
historyFrame.BackgroundTransparency = 0.2
historyFrame.BorderSizePixel = 0
historyFrame.ClipsDescendants = true
historyFrame.Parent = frame
local hfCorner = Instance.new("UICorner")
hfCorner.CornerRadius = UDim.new(0, 10)
hfCorner.Parent = historyFrame

local historyLabel = Instance.new("TextLabel")
historyLabel.Size = UDim2.new(1, 0, 0, 18)
historyLabel.Position = UDim2.new(0, 8, 0, 2)
historyLabel.BackgroundTransparency = 1
historyLabel.Text = "📜 History (5) / История (5)"
historyLabel.TextColor3 = Color3.fromRGB(160, 190, 230)
historyLabel.TextSize = 13
historyLabel.Font = Enum.Font.Gotham
historyLabel.TextXAlignment = Enum.TextXAlignment.Left
historyLabel.Parent = historyFrame

local historyScroll = Instance.new("ScrollingFrame")
historyScroll.Size = UDim2.new(1, 0, 1, -22)
historyScroll.Position = UDim2.new(0, 0, 0, 20)
historyScroll.BackgroundTransparency = 1
historyScroll.BorderSizePixel = 0
historyScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
historyScroll.ScrollBarThickness = 3
historyScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
historyScroll.Parent = historyFrame

local historyItems = {}
local function updateHistory()
    for _, item in ipairs(historyItems) do
        item:Destroy()
    end
    historyItems = {}
    local yOff = 0
    for _, entry in ipairs(history) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 20)
        btn.Position = UDim2.new(0, 5, 0, yOff)
        btn.BackgroundColor3 = Color3.fromRGB(45, 50, 78)
        btn.BackgroundTransparency = 0.6
        btn.Text = entry
        btn.TextColor3 = Color3.fromRGB(220, 230, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.Parent = historyScroll
        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 4)
        bCorner.Parent = btn
        btn.MouseButton1Click:Connect(function()
            textBox.Text = entry:match("(.-) →") or entry
        end)
        table.insert(historyItems, btn)
        yOff = yOff + 22
    end
    historyScroll.CanvasSize = UDim2.new(0, 0, 0, yOff)
end

-- ===== СТАТУС =====
local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.9, 0, 0, 22)
status.Position = UDim2.new(0.05, 0, 0.91, 0)
status.BackgroundTransparency = 1
status.Text = "✅ Ready / Готов"
status.TextColor3 = Color3.fromRGB(140, 180, 230)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Center
status.Parent = frame

-- ===== КНОПКА "ОСТАВИТЬ ОТЗЫВ" =====
local feedbackBtn = Instance.new("TextButton")
feedbackBtn.Size = UDim2.new(0.5, 0, 0, 22)
feedbackBtn.Position = UDim2.new(0.25, 0, 0.96, 0)
feedbackBtn.BackgroundTransparency = 1
feedbackBtn.Text = "💬 Leave feedback / Оставить отзыв"
feedbackBtn.TextColor3 = Color3.fromRGB(140, 180, 230)
feedbackBtn.TextSize = 13
feedbackBtn.Font = Enum.Font.Gotham
feedbackBtn.BorderSizePixel = 0
feedbackBtn.Parent = frame

feedbackBtn.MouseButton1Click:Connect(function()
    local discordTag = "the.local.maze"
    local copied = false
    if setclipboard then
        setclipboard(discordTag)
        copied = true
    elseif game:GetService("GuiService"):SetClipboard then
        game:GetService("GuiService"):SetClipboard(discordTag)
        copied = true
    end
    if copied then
        status.Text = "✅ Copied: " .. discordTag .. " / Скопировано"
        task.wait(2)
        status.Text = "✅ Ready / Готов"
    else
        status.Text = "❌ Copy failed / Ошибка копирования"
        task.wait(1.5)
        status.Text = "✅ Ready / Готов"
    end
end)

-- ===== ВЫПАДАЮЩИЕ СПИСКИ =====
local function createDropdown(anchorBtn, isSource)
    local dropdown = Instance.new("Frame")
    dropdown.Size = UDim2.new(0.8, 0, 0, 180)
    dropdown.Position = UDim2.new(0.1, 0, 0.38, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(28, 32, 52)
    dropdown.BackgroundTransparency = 0.08
    dropdown.BorderSizePixel = 0
    dropdown.ClipsDescendants = true
    dropdown.Visible = false
    dropdown.Parent = frame
    local ddCorner = Instance.new("UICorner")
    ddCorner.CornerRadius = UDim.new(0, 14)
    ddCorner.Parent = dropdown

    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(0.9, 0, 0, 30)
    searchBox.Position = UDim2.new(0.05, 0, 0.03, 0)
    searchBox.BackgroundColor3 = Color3.fromRGB(55, 60, 85)
    searchBox.BackgroundTransparency = 0.3
    searchBox.TextColor3 = Color3.fromRGB(255,255,255)
    searchBox.PlaceholderText = "🔍 Search / Поиск"
    searchBox.PlaceholderColor3 = Color3.fromRGB(160, 170, 200)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 15
    searchBox.ClearTextOnFocus = true
    searchBox.BorderSizePixel = 0
    searchBox.Parent = dropdown
    local scCorner = Instance.new("UICorner")
    scCorner.CornerRadius = UDim.new(0, 10)
    scCorner.Parent = searchBox

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, -38)
    scroll.Position = UDim2.new(0, 0, 0, 36)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    scroll.Parent = dropdown

    local langButtons = {}
    local yOff = 0
    local btnH = 26
    for _, lang in ipairs(languages) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -12, 0, btnH)
        btn.Position = UDim2.new(0, 6, 0, yOff)
        btn.BackgroundColor3 = Color3.fromRGB(45, 50, 78)
        btn.BackgroundTransparency = 0.4
        btn.Text = lang.flag .. " " .. lang.name
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 14
        btn.Font = Enum.Font.Gotham
        btn.BorderSizePixel = 0
        btn.Parent = scroll
        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 6)
        bCorner.Parent = btn
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(70, 80, 120)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(45, 50, 78)
        end)
        btn.MouseButton1Click:Connect(function()
            if isSource then
                srcLang = lang
                srcBtn.Text = lang.flag .. " " .. lang.name .. " / " .. getRussianName(lang.code) .. " ▼"
            else
                tgtLang = lang
                tgtBtn.Text = lang.flag .. " " .. lang.name .. " / " .. getRussianName(lang.code) .. " ▼"
            end
            dropdown.Visible = false
            status.Text = "✅ Selected: " .. lang.name .. " / Выбран"
        end)
        table.insert(langButtons, {btn=btn, name=lang.name, lang=lang})
        yOff = yOff + btnH + 2
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, yOff)

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = searchBox.Text:lower()
        for _, item in ipairs(langButtons) do
            item.btn.Visible = string.find(item.name:lower(), query, 1, true) ~= nil
        end
    end)

    anchorBtn.MouseButton1Click:Connect(function()
        dropdown.Visible = not dropdown.Visible
        if dropdown.Visible then
            searchBox
