local success, err = pcall(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/LimeCVC/BABFT/refs/heads/main/Script.lua'))()
end)

if not success then
    warn("[Main Script Error]: " .. tostring(err))
end
