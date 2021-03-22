bot = nil
botSarina = nil

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function createbot( )
    bot = createPed ( 102, 1589.31616, -1551.45642, 13.58679,90)
    setElementData( bot, "npc", true )
    setElementData(bot,"dane","Martin Clinton")
    botSarina = createPed ( 193, 1588.61072, -1551.53955, 13.58558 ,270)
    setElementData(botSarina,"dane","Sarina Tsumakura")
end


addEventHandler( "onResourceStart", resourceRoot, function () 
    createbot( )
end)

praca = createMarker(1589.31616, -1551.45642, 13.58679-1, "cylinder", 2.0, 0,102,255,0)
rozmowa = createMarker(1589.31616, -1551.45642, 13.58679-1, "cylinder", 5.0, 0,102,255,0)

addEventHandler("onMarkerHit", rozmowa, function(gracz)
    outputChatBox("#6E6E6EMartin Clinton mówi: Zerżnąłem trupa w lesie.",gracz,255,255,255,true)
    outputChatBox("#8C8C8CSarina Tsumakura mówi: A ja dałam ci się odprowadzić gdy byłam pijana...",gracz,255,255,255,true)
    outputChatBox("#AAAAAAMartin Clinton mówi: Już nie pierdol, podobało ci się.",gracz,255,255,255,true)
    outputChatBox("#C8C8C8Sarina Tsumakura mówi: Jesteś pierdolonym psycholem Martin.",gracz,255,255,255,true)
end)

addEventHandler("onMarkerHit", praca, function(gracz)
    zdenerowanie = math.random(1,3)
    local x,y,z 	= getElementPosition(gracz); --get your position
	local tx,ty,tz 	= getElementPosition(bot);
    tsx,tsy,tsz 	= getElementPosition(botSarina);
	setPedRotation(bot, findRotation(tx,ty,x,y) )
    setPedRotation(botSarina, findRotation(tsx,tsy,x,y) )
    if zdenerowanie == 1 then
    outputChatBox("#C8C8C8Sarina Tsumakura mówi: Nie za blisko koleś?",gracz,255,255,255,true)
    outputChatBox("#E6E6E6Martin Clinton mówi: Mógbyś trochę się od nas odsunąć...",gracz,255,255,255,true)
    setPedAnimation(bot, "GANGS", "prtial_gngtlkA")
    setPedAnimation(botSarina, "GANGS", "prtial_gngtlkB")
    end
    if zdenerowanie == 2 then
        outputChatBox("#E6E6E6Martin Clinton mówi: Ey, on chyba podsłuchuje..",gracz,255,255,255,true)
        outputChatBox("#C8C8C8Sarina Tsumakura mówi: Każ mu spadać.",gracz,255,255,255,true)
        setPedAnimation(botSarina, "DEALER", "DEALER_IDLE")
        setPedAnimation(bot, "GANGS", "prtial_gngtlkA")
    end
    if zdenerowanie == 3 then
        outputChatBox("#C6A2EE*Sarina Tsumakura spogląda na zbliżającego się "..getPlayerName(gracz),gracz,255,255,255,true)
        outputChatBox("#C8C8C8Sarina Tsumakura mówi: Co jest facet? #C6A2EE*uśmiecha się do "..getPlayerName(gracz).."*",gracz,255,255,255,true)
            outputChatBox("#E6E6E6Martin Clinton mówi: Odejdź to dzielnica w której rządzi mój gang.",gracz,255,255,255,true)
            outputChatBox("#C6A2EE*Martin Clinton wyjmuje nóż sprężynkowy z kieszeni.",gracz,255,255,255,true)
    end
end)

function repairClickedVehicle( button, state, player )
    if button == "left" and state == "down" then
        if getElementType( source ) == "ped" then
            local x, y, z = getElementPosition( player )
            local x1, y1, z1 = getElementPosition( source ) 
            local distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1 ) -- Some distance calculations
            if distance < 8 then 
                if getElementData(source,"dane") == "Martin Clinton" then
                    triggerClientEvent(player, "czemutotrobie",player)
                end
            end
        end
    end
end
addEventHandler( "onElementClicked", root, repairClickedVehicle )

-- syntax x,y,z, rotacja, id skina, int, dim,bron, lvl
AttackerGrind = {
    {1581.13123, -1549.64539, 13.57280, 0, 230, 0, 0, 4,1},
}

addEvent("gang:niesmiertelnych", true)
addEventHandler("gang:niesmiertelnych", getRootElement(), function()
    local peds = getElementsByType ( "ped" )
    for i,v in ipairs(peds) do 
    exports["slothbot"]:spawnBot(AttackerGrind[1], AttackerGrind[2], AttackerGrind[3], AttackerGrind[4], AttackerGrind[5], AttackerGrind[6], AttackerGrind[7], nil, AttackerGrind[8], "guarding")
    end
end)
