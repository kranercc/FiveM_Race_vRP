--[[
    DATE: 12.09.2021
    AUTHOR: KRANE IC (krane#2890)
    <!> <!> <!>
    ! ROMANIA !
    <!> <!> <!> 
]]
fx_version "cerulean"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
    "MASTER.lua",
}


server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "MASTER.lua"
}


ui_page "html/index.html"

files {
    "html/index.html",
    "html/style.css",
    "html/main.js",
    "html/details.css",
    "html/maps.js",
    "html/images/avansat.png",
    "html/images/lsairport.jpg",
    "html/images/liniuta.png",
    "html/images/sandy.jpg",
    "html/images/sandyrace.png",
    "html/images/vinewood_hills.png",
    "html/images/vinewood.png",
}