-- ====================================================================
--  ФИНАЛЬНЫЙ АВТОНОМНЫЙ RAYFIELD HUB ДЛЯ BAcON_KJpast (ОБХОД ВАЙТЛИСТА)
-- ====================================================================

-- 1. Подготовка окружения для нового ника
local TARGET_NAME = "BAcON_KJpast"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local mt = getrawmetatable(game) or debug.getmetatable(game)
if mt and setreadonly then
    setreadonly(mt, false)
    local old_index = mt.__index
    mt.__index = newcclosure(function(t, k)
        if t == LocalPlayer and (k == "Name" or k == "DisplayName" or k == "name") then
            return TARGET_NAME
        end
        return old_index(t, k)
    end)
    setreadonly(mt, true)
end

print("[*] Окружение подготовлено для BAcON_KJpast! Запуск обфускатора...")

-- ====================================================================
-- 2. ВНУТРЕННИЙ БЛОК: ВАША ПОЛНАЯ РАСШИФРОВАННАЯ БЕССМЫСЛИЦУ WEAREDEVS
-- ====================================================================
local obfuscated = [[
-- [[ v1.0.0 https://wearedevs.net ]] return(function(...)local C={"\054\081\061\061","\069\083\080","\065\073\077\066\079\084","\083\089\078\065\080\083\069","\073\078\070\073\078\073\084\069","\089\073\069\076\068","\084\069\076\069\080\079\082\084","\082\065\089\070\073\069\076\068","\067\082\069\065\084\069","\065\068\068\084\065\066","\087\072\073\084\069\076\073\083\084"}local function z(n)local r=""for i=1,#n,4 do local b=tonumber(n:sub(i+1,i+3))r=r..string.char(b)end return r end for i,v in ipairs(C) do C[i]=z(v) end return function(...) local Player=game:GetService("Players").LocalPlayer if Player.Name==C or C:find(Player.Name) then loadstring(C..C..C)() else print("Not Whitelisted!") end end end)(...)
]]

-- Запускаем внутреннюю матрешку обфускатора
local func = loadstring(obfuscated)
if func then
    setfenv(func, getfenv())
    pcall(func)
else
    print("[-] Ошибка загрузки тела обфускатора.")
end
