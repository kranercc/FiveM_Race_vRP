--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local lobbies = {}

RegisterNetEvent("race:send_data_to_lobby_members")
AddEventHandler("race:send_data_to_lobby_members", function (data)    
    
    
    table.insert(lobbies, data.lobby) 
    --[[
        data.lobby[0] = {
            id = 0,
            ready = false,
            bet = 0
        }
    ]]

    for _, lobby_data in pairs(data.lobby) do
        user_id = tonumber(lobby_data.id)
        local player = vRP.getUserSource({user_id})
        TriggerClientEvent("race:build_game", player, data.lobby) 
    end
end)


RegisterNetEvent("race:PlayerState")
AddEventHandler("race:PlayerState", function(data)
    if data.ready then
        --go thru all lobbies
        for _, lobby in pairs(lobbies) do
            --go thru players in lobby
            for __, player in pairs(lobby) do
                if tonumber(player.id) == user_id then
                    player.ready = true
                end
            end
        end
    end
end)


CreateThread(function()
    while true do
        Wait(1000)
        if #lobbies > 0 then
            for _, lobby in pairs(lobbies) do
                local counter = 0
                for __, player in pairs(lobby) do
                    if player.ready then
                        counter = counter + 1
                    end
                end
                if counter > 0 and counter == #lobby then
                    for __, player in pairs(lobby) do
                        TriggerClientEvent("race:startRaceGUI", vRP.getUserSource({tonumber(player.id)}))
                    end
                end
            end
        end
    end
end)