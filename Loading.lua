-- КОНФИГУРАЦИЯ (Без токена, так как база в тестовом режиме)
local BASE_URL = "https://limecvc-default-rtdb.firebaseio.com/"
local REAL_SCRIPT_URL = "https://raw.githubusercontent.com/LimeCVC/BABFT/refs/heads/main/Script.lua"

local HttpService = game:GetService("HttpService")

local function getNetworkTime()
    local success, result = pcall(function()
        return game:HttpGet("http://worldtimeapi.org")
    end)
    if success and result then
        local json = HttpService:JSONDecode(result)
        if json and json.datetime then
            return string.sub(json.datetime, 1, 10)
        end
    end
    return os.date("!%Y-%m-%d")
end

local function reportLaunch()
    local currentDate = getNetworkTime() 
    local currentYearMonth = string.sub(currentDate, 1, 7)
    local currentWeek = os.date("!%V") 
    local currentYearWeek = string.sub(currentDate, 1, 4) .. "-W" .. currentWeek 

    local payload = {
        ["total"] = { [".sv"] = "increment", value = 1 },
        ["daily/" .. currentDate] = { [".sv"] = "increment", value = 1 },
        ["weekly/" .. currentYearWeek] = { [".sv"] = "increment", value = 1 },
        ["monthly/" .. currentYearMonth] = { [".sv"] = "increment", value = 1 }
    }

    pcall(function()
        -- Отправляем запрос без ?auth=
        game:HttpPost(BASE_URL .. "stats.json", HttpService:JSONEncode(payload), "application/json", "PATCH")
    end)
end

task.spawn(reportLaunch)

local success, content = pcall(game.HttpGet, game, REAL_SCRIPT_URL)
if success then
    local func = loadstring(content)
    if func then
        task.wait(0.1)
        func()
    end
end
