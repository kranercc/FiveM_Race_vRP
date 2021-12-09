# FiveM Race VRP
## _Race Script Using vRP 2021_

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Race Script optimized 2021.

> Easy to use

> Easy to configure

> ✨Contact: krane#2890✨

## Features

- Simple to use UI, intuitive
- Autopopulated fields => ease of use for client
- In FiveM you have UI for everything leading to pleasent experience
- Optimized CPU consumption (0.01~0.03ms)



## Tech

- [jQuery](https://github.com/jquery/jquery) - javascript
- [vRP](https://github.com/ImagicTheCat/vRP) - Framework for the FiveM server
- [FiveM API](https://github.com/citizenfx/fivem) - Explained here

## Installation

Add your files into ./resources/race and modify your server.cfg with
```
start race
```

## Development

Want to contribute? Great!

You can send code and i will accept all improvements that don't conflict with the main branch :D 😊

## License

MIT

**Free Software!**

## Demo

>Here you can see the default UI when `/race` is executed

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/Screenshot_4.png)


>If you click any map you can select a game mode you want to play from the pre-sets (there are in total _4_ of them)

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/different_game_mods.png)

>If the map ends up being bigger and can't fit or can't be seen in the small window, there is logic written to scale it and "zoom" it for better visuals

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/zoom_on_selection.png)

>Here you can see the arrows pointing to UI elements, they are used to guide the client to use the script correctly even if he is not familiar with it, also setting a waypoint to the destionation so it's easy to follow

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/basic%20ui%20info%20after%20invite%20to%20go%20to%20the%20start%20of%20race.png)

>An indicator is set above the location player needs to be in 

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/indicator.png)

>As soon as all the lobby members get together, the timer will start for the race to begin 

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/readysetgo.png)


>There already is special conditions if it's about to end it will change the visual to a generic "end of race" visual

![img](https://raw.githubusercontent.com/kranercc/FiveM_Race_vRP/main/docs/special_end_cp_visual.png)


# Code Breakdown

When the user hits Escape to exit the UI, an event is triggered to get the information into the server and client side

``` js
var data = {}
data.lobby = {}
function send_data() { $.post('https://race/race_main',JSON.stringify(data)) }


document.onkeyup = function(data) {
        if (data.key == "Escape") {
            display(false)
            send_data()
            /*code*/
```

The lobby is handled by the server like so
```lua

RegisterNetEvent("race:send_data_to_lobby_members")
AddEventHandler("race:send_data_to_lobby_members", function (data)    

    table.insert(lobbies, data.lobby) 
    for _, lobby_data in pairs(data.lobby) do
        user_id = tonumber(lobby_data.id)
        local player = vRP.getUserSource({user_id})
        TriggerClientEvent("race:build_game", player, data.lobby) 
    end
end)

```

It will all go into a `table` and from there the server check every second for changes


```lua

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
```


The server sends data to client using this events registered in the client

```lua
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
```


> Thank you for reading | discord: krane#2890 
