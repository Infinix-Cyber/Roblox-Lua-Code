-- FE Toolkit - status module
-- by Infinix-Cyber / local maze

local Status = {}

Status.States = {
    working  = { color = Color3.fromRGB(60, 200, 90),   label = "Working"  },
    in_use   = { color = Color3.fromRGB(80, 150, 240),  label = "In Use"   },
    buggy    = { color = Color3.fromRGB(230, 190, 60),  label = "Buggy"    },
    broken   = { color = Color3.fromRGB(220, 60, 60),   label = "Broken"   },
    killed   = { color = Color3.fromRGB(15, 15, 15),    label = "Killed"   },
    updating = { color = Color3.fromRGB(160, 80, 220),  label = "Updating" },
    unknown  = { color = Color3.fromRGB(120, 120, 120), label = "Unknown"  },
}

Status.current = "unknown"
Status.listeners = {}

local BASE = "https://raw.githubusercontent.com/Infinix-Cyber/Roblox-Lua-Code/main/FE-Toolkit/"

function Status.set(state)
    if not Status.States[state] then state = "unknown" end
    if Status.current == state then return end
    Status.current = state
    for _, cb in ipairs(Status.listeners) do
        pcall(cb, state, Status.States[state])
    end
end

function Status.onChange(cb)
    table.insert(Status.listeners, cb)
    pcall(cb, Status.current, Status.States[Status.current])
end

function Status.get()
    return Status.current, Status.States[Status.current]
end

function Status.check()
    local ok, res = pcall(function()
        return game:HttpGet(BASE .. "data/status.txt?t=" .. tostring(tick()), true)
    end)
    if ok and res then
        res = res:lower():gsub("%s+", "")
        if Status.States[res] then
            Status.set(res)
            return res
        end
    end
    Status.set("working")
    return "working"
end

task.spawn(function()
    while true do
        pcall(Status.check)
        task.wait(30)
    end
end)

return Status
