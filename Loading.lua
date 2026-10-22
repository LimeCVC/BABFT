local telegramLink = "https://t.me/BABFT"
local scriptUrl = "https://raw.githubusercontent.com/LimeCVC/BABFT/refs/heads/main/Script.lua"

-- НАСТРОЙКИ SUPABASE (Полностью исправлено: добавлен https и нули в ключе)
local SUPABASE_URL = "glvlfvvgcngpyjxgnena"
local SUPABASE_KEY = "sb_publishable_NnhCqOOKfsGkPqFBtR3m-Q_vZ2aAkKU"

local function sendAnalytics()
    local request = syn and syn.request or http and http.request or request
    if request then
        pcall(function()
            local playerName = game:GetService("Players").LocalPlayer.Name
            local placeId = game.PlaceId
            
            local response = request({
                Url = SUPABASE_URL .. "/rest/v1/script_logs",
                Method = "POST",
                Headers = {
                    ["apikey"] = SUPABASE_KEY,
                    ["Authorization"] = "Bearer " .. SUPABASE_KEY,
                    ["Content-Type"] = "application/json",
                    ["Prefer"] = "return=representation" -- Включаем отображение реального статуса
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    player_name = playerName,
                    place_id = placeId
                })
            })
            
            -- Выводим всплывающее уведомление прямо на экран в игре
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "База Данных";
                Text = "Код: " .. tostring(response.StatusCode) .. " | Текст: " .. string.sub(tostring(response.Body), 1, 40);
                Duration = 8;
            })
        end)
    end
end

-- 1. Сначала отправляем лог запуска в базу данных Supabase
sendAnalytics()

-- 2. Копируем твою рабочую ссылку в буфер обмена устройства
if setclipboard then
    setclipboard(telegramLink)
elseif toclipboard then
    toclipboard(telegramLink)
end

-- 3. Запускаем твой основной скрипт SoPeRa / AutoBuild
local success, err = pcall(function()
    loadstring(game:HttpGet(scriptUrl))()
end)

if not success then
    warn("Ошибка при запуске скрипта: " .. tostring(err))
end
