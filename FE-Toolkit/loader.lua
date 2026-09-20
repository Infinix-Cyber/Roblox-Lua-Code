-- FE Toolkit loader
-- by Infinix-Cyber

local BASE = "https://raw.githubusercontent.com/Infinix-Cyber/Roblox-Lua-Code/main/FE-Toolkit/"
local CACHE = "maze_cache/"
local MODULES = CACHE .. "modules/"
local DATA = CACHE .. "data/"

if not isfolder(CACHE) then makefolder(CACHE) end
if not isfolder(MODULES) then makefolder(MODULES) end
if not isfolder(DATA) then makefolder(DATA) end

local function fetch(url)
    local ok, res = pcall(function() return game:HttpGet(url, true) end)
    if ok and res and #res > 0 then return res end
    return nil
end

local function write(path, content)
    pcall(function() writefile(path, content) end)
end

local function read(path)
    if not isfile(path) then return nil end
    local ok, res = pcall(function() return readfile(path) end)
    if ok then return res end
    return nil
end

local function downloadIfMissing(relPath, localPath)
    if isfile(localPath) then return true end
    local content = fetch(BASE .. relPath)
    if not content then return false end
    write(localPath, content)
    return true
end

local versionRemote = fetch(BASE .. "version.txt")
local versionLocal = read(DATA .. "version.txt")
local needRefresh = versionRemote and versionRemote ~= versionLocal

local listContent = fetch(BASE .. "files.txt")
if not listContent then
    warn("[FE-Toolkit] failed to fetch files.txt")
    return
end

local files = {}
for line in listContent:gmatch("[^\r\n]+") do
    line = line:gsub("^%s+", ""):gsub("%s+$", "")
    if line ~= "" and not line:match("^#") then
        table.insert(files, line)
    end
end

if needRefresh then
    for _, f in ipairs(files) do
        pcall(function()
            local p = MODULES .. f
            if isfile(p) then delfile(p) end
        end)
    end
end

for _, f in ipairs(files) do
    downloadIfMissing("modules/" .. f, MODULES .. f)
end

if versionRemote then
    write(DATA .. "version.txt", versionRemote)
end

local keyPath = MODULES .. "key.lua"
if not isfile(keyPath) then
    warn("[FE-Toolkit] key module missing")
    return
end

local keySrc = read(keyPath)
local keyFn = keySrc and loadstring(keySrc)
if keyFn then
    keyFn()
else
    warn("[FE-Toolkit] key module failed to load")
end
