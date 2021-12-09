function generate_race_visual_checkpoint(vector, rgba, finished)
    
    --create race checkpoint
    local direction = vector3(0.0,0.0,0.0)
    local rotation = vector3(0.0, 0, 0)
    local scale = vector3(3.0, 3.0, 3.0)
    local type = 0 
    if finished then type = 4 scale = vector3(20.0, 20.0, 20.0) end
    DrawMarker(type, 
                vector.x, vector.y, vector.z+5.0, 
                direction.x, direction.y, direction.z, 
                rotation.x, rotation.y, rotation.z, 
                scale.x, scale.y, scale.z, 
                rgba.r, rgba.g, rgba.b, 
                80, true, true, 2, false, false, false, false
    )
    
end

function RecolorSmooth(d)
    local r,g,b 
    --keep d in range of 0 to 100
    if d > 100 then
        d = 100
    elseif d < 0 then
        d = 0
    end

    r = math.floor((255 * d) / 255)
    g = math.floor((255 * (150 - d)) / 255)
    b = math.floor((255 * (255 - d)) / 255)
    return {r = r , g = g , b = b}
end


function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    
    SetTextCentre(center)
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


function k_draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*4
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end



function setRoute(waypoint)
    RemoveBlip(cfg.mission_blip)
    cfg.mission_blip = AddBlipForCoord(waypoint)
    SetBlipRoute(cfg.mission_blip, true)
    SetBlipSprite(cfg.mission_blip,1)
	SetBlipColour(cfg.mission_blip,5)
	SetBlipAsShortRange(cfg.mission_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Race")
	EndTextCommandSetBlipName(cfg.mission_blip)
	SetBlipRoute(cfg.mission_blip,true)
end