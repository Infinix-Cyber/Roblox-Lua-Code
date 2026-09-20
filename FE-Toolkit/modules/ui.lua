-- FE Toolkit - ui framework
-- by Infinix-Cyber / local maze

local UI = {}

UI.Theme = {
    BG      = Color3.fromRGB(10, 10, 10),
    Panel   = Color3.fromRGB(20, 20, 20),
    Panel2  = Color3.fromRGB(35, 35, 35),
    Input   = Color3.fromRGB(5, 5, 5),
    Accent  = Color3.fromRGB(240, 240, 240),
    Accent2 = Color3.fromRGB(180, 180, 180),
    Text    = Color3.fromRGB(240, 240, 240),
    TextDim = Color3.fromRGB(120, 120, 120),
    Stroke  = Color3.fromRGB(60, 60, 60),
    Green   = Color3.fromRGB(60, 200, 90),
    Blue    = Color3.fromRGB(80, 150, 240),
    Yellow  = Color3.fromRGB(230, 190, 60),
    Red     = Color3.fromRGB(220, 60, 60),
    Black   = Color3.fromRGB(15, 15, 15),
    Purple  = Color3.fromRGB(160, 80, 220),
}

function UI.corner(inst, r)
    local c = Instance.new("UICorner", inst)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end

function UI.stroke(inst, col, th)
    local s = Instance.new("UIStroke", inst)
    s.Color = col or UI.Theme.Stroke
    s.Thickness = th or 1
    return s
end

function UI.dragify(frame, handle)
    handle = handle or frame
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos

    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = frame.Position
        end
    end)

    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)

    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

return UI
