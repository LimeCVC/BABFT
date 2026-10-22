local telegramLink = "https://t.me/BABFT"
local scriptUrl = "https://raw.githubusercontent.com/LimeCVC/BABFT/refs/heads/main/Script.lua"
if setclipboard then
    setclipboard(telegramLink)
elseif toclipboard then
    toclipboard(telegramLink)
end
local success, err = pcall(function()
    loadstring(game:HttpGet(scriptUrl))()
end)
if not success then
    warn("Ошибка при запуске скрипта: " .. tostring(err))
end
