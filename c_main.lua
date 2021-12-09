local racing = false
local game_mode = nil
local tracker = 2
local last_cp = false
local ready = false
local race_started = false
RegisterNetEvent("race:build_game")
AddEventHandler("race:build_game", function (data)
    game_mode = data[1].game_mode
    racing = true
end)

RegisterNetEvent("race:startRace")
AddEventHandler("race:startRace", function ()
    racing = true
end)

RegisterNetEvent("race:startRaceGUI")
AddEventHandler("race:startRaceGUI", function ()
    race_started = true
end)

CreateThread(function()
    while true do 
        Wait(1000)

        while not racing do 
            Wait(1000) 
        end 

        check_if_in_position(game_mode)


        while racing do 
            if not race_started then
                start_animation()
            end
            Wait(0)
            local point = cfg.default_race_tracks[game_mode][tracker] -- change the next cp based on tracker
            local ped_coords = GetEntityCoords(PlayerPedId()) 
            local d = Vdist(point, ped_coords) -- distance in meters between player and next checkpoint
            if tracker == #cfg.default_race_tracks[game_mode] then last_cp = true end -- if last cp then special behavoir
            generate_race_visual_checkpoint(point, RecolorSmooth(d), last_cp) -- visual only

            setRoute(point)
            if d < 10 then
                tracker = tracker + 1
            end

            if tracker > #cfg.default_race_tracks[game_mode] then -- if last cp
                RemoveBlip(cfg.mission_blip)
                TriggerEvent("toasty:Notify", {type = 'success', title='Race', message = 'Ai terminat cursa'}) 
                if cfg.stop_veh_at_finish then  --mai puteti frana ca va fac sa spuneti piua
                    SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 80)
                end
                --reset vars
                racing = false
                tracker = 1
                last_cp = false
                return
            end
        end
    end
end)


function check_if_in_position(gamemode)
    if not gamemode then print("no gm") return end
    location = cfg.default_race_tracks[gamemode][1]
    ped_coords = GetEntityCoords(PlayerPedId())
    setRoute(location)
    while Vdist(location, ped_coords) > 10 and not ready do
        Wait(0)
        drawHudText(0.5,0.01, 0.0,0.0,0.65,"Race",107, 107, 219,255,1,6,1)
        drawHudText(0.5,0.04, 0.0,0.0,0.65,"Du-te la start!",255, 255, 255,255,1,6,1)
        drawHudText(0.5,0.07, 0.0,0.0,0.65,"#1/3",43, 181, 112,255,1,6,1)
        ped_coords = GetEntityCoords(PlayerPedId())
        generate_race_visual_checkpoint(location, RecolorSmooth(Vdist(location, ped_coords)), false) -- visual only
        ready = false
    end
    ready = true
    RemoveBlip(cfg.mission_blip)
    TriggerServerEvent("race:PlayerState", {ready = true})
end


function start_animation()
    local seconds = GetClockSeconds()
    local passed = 0
    while true do
        Wait(0)
        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0)

        if GetClockSeconds() ~= seconds then
            seconds = GetClockSeconds()
            passed = passed + 1
        end

        if passed >= 0 then -- something weird
        end
        if passed >= 1 then -- happens here
        end
        if passed >= 3 then
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Ready",173, 17, 17, 255,1,6,1)
        end
        if passed >= 4 then
            drawHudText(0.5,0.04, 0.0,0.0,0.65,"Set", 184, 166, 11, 255,1,6,1)     
        end
        if passed >= 5 then
            drawHudText(0.5,0.07, 0.0,0.0,0.65,"GO GO GO!", 20, 184, 11, 255,1,6,1)
        end
        if passed >= 6 then
            return
        end
    end
    race_started = true
        
end

