local telegramLink = "https://t.me/BABFT"
local scriptUrl = "https://raw.githubusercontent.com/LimeCVC/BABFT/refs/heads/main/Script.lua"

-- НАСТРОЙКИ SUPABASE
local SUPABASE_URL = "glvlfvvgcngpyjxgnena"
local SUPABASE_KEY = "sb_publishable_NnhCqOOKfsGkPqFBtR3m-Q_vZ2aAkKU"

local function sendAnalytics()
    local request = syn and syn.request or http and http.request or request
    if request then
        pcall(function()
            local playerName = game:GetService("Players").LocalPlayer.Name
            local placeId = game.PlaceId
            
            request({
                Url = SUPABASE_URL .. "/rest/v1/script_logs",
                Method = "POST",
                Headers = {
                    ["apikey"] = SUPABASE_KEY,
                    ["Authorization"] = "Bearer " .. SUPABASE_KEY,
                    ["Content-Type"] = "application/json",
                    ["Prefer"] = "return=minimal"
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    player_name = playerName,
                    place_id = placeId
                })
            })
        end)
    end
end

-- 1. СНАЧАЛА отправляем лог в базу данных (теперь это сработает в любом случае!)
sendAnalytics()

-- 2. Копируем вашу ссылку в буфер обмена
if setclipboard then
    setclipboard(telegramLink)
elseif toclipboard then
    toclipboard(telegramLink)
end

-- 3. И только в самом конце запускаем основной скрипт (который сейчас выдает ошибку)
local success, err = pcall(function()
    loadstring(game:HttpGet(scriptUrl))()
end)

if not success then
    warn("Ошибка при запуске скрипта: " .. tostring(err))
end
