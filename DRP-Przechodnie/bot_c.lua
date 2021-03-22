function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end



mojeW,mojeH = 1920, 1080
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)

Interfejs={
    ["Dalej"]={1328*w, 991*h, 292*w, 53*h},
    ["Rzeznia"]={616*w, 812*h, 587*w, 55*h},
}

dxfont0_RobotoBoldItalic = dxCreateFont("pedy/Roboto-BoldItalic.ttf", 13)
dxfont1_AndikaNewBasicRegular = dxCreateFont("pedy/AndikaNewBasic-Regular.ttf", 10)

pozycja_zdjecia = {561, 344}
pozycja_myszki = {604, 381}
pozycja_cursora = {575, 409}

function Gui()
    if isEventHandlerAdded("onClientRender", root,poszczuszek) then return end
    dxDrawImage(pozycja_zdjecia[1], pozycja_zdjecia[2], 154*w, 147*h, "pedy/circle.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Interakcja", pozycja_myszki[1], pozycja_myszki[2], 992*w, 756*h, tocolor(22, 124, 203, 255), 1.00, dxfont0_RobotoBoldItalic, "left", "top", false, false, false, false, false)
    dxDrawText("Kliknij aby porozmawiać", pozycja_cursora[1], pozycja_cursora[2], 865*w, 672*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicRegular, "left", "top", false, false, false, false, false)
end


bindKey("M", "down", function()
    showCursor(not isCursorShowing())
end)


addEventHandler( "onClientCursorMove", getRootElement( ),
    function ( kursorx, kursory,_, _,wX,Wy,Wz )
        local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
        local px, py, pz = getCameraMatrix()
        local hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, worldx, worldy, worldz )
        if getElementType(elementHit) == "ped" then
    if getElementData( elementHit, "npc") == true then
    pozycja_zdjecia[1] = kursorx*1500
pozycja_zdjecia[2] = kursory*1000
pozycja_myszki[1] = kursorx*1500+43
pozycja_myszki[2] = kursory*1000+37
pozycja_cursora[1] = kursorx*1500+14
pozycja_cursora[2] = kursory*1000+65
    addEventHandler("onClientRender", root, Gui)
    end
else 
    if isEventHandlerAdded("onClientRender", root,Gui) then
    removeEventHandler("onClientRender", root, Gui)
    end
end
    end)

    local dxfont0_AndikaNewBasicBold = dxCreateFont("rozmowa/AndikaNewBasic-Bold.ttf", 25)
    local dxfont1_AndikaNewBasicBold = dxCreateFont("rozmowa/AndikaNewBasic-Bold.ttf", 15)
    local dxfont2_AndikaNewBasicBold = dxCreateFont("rozmowa/AndikaNewBasic-Bold.ttf", 28)

    addEvent("czemutotrobie", true)
addEventHandler("czemutotrobie", getRootElement(), function()
    addEventHandler("onClientRender", root, poszczuszek)
    setElementData( localPlayer, "przejscia",0)
end)

czczionka1 = dxCreateFont("rozmowa/AndikaNewBasic-Bold.ttf", 29)
czczionka2 = dxCreateFont("rozmowa/AndikaNewBasic-Bold.ttf", 25)
czczionka3 = dxCreateFont("rozmowa/AndikaNewBasic-Bold.ttf", 21)

        function poszczuszek()
            if getElementData( localPlayer, "przejscia") == 0 then
            dxDrawRectangle(0*w, 706*h, 1920*w, 374*h, tocolor(1, 0, 0, 101), false)
            dxDrawRectangle(316*w, 706*h, 1314*w, 374*h, tocolor(1, 0, 0, 206), false)
            dxDrawRectangle(316*w, 706*h, 1314*w, 44*h, tocolor(224, 232, 6, 207), false)
            dxDrawText("Rozmowa z NPC", 858*w, 701*h, 1429*w, 972*h, tocolor(255, 255, 255, 255), 1.00, dxfont0_AndikaNewBasicBold, "left", "top", false, false, false, false, false)
            dxDrawText("*Przechodzac obok słyszałeś krzyki, wkrotce jeden z nich zaczepia cie*", 326*w, 756*h, 689*w, 952*h, tocolor(238, 86, 243, 207), 1.00, dxfont1_AndikaNewBasicBold, "left", "top", false, false, false, false, false)
            if isMouseInPosition ( Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4] ) then
            dxDrawRectangle(Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4], tocolor(125, 125, 125, 207), false)
            dxDrawText("Dalej", 1341*w, 991*h, 1620*w, 1121*h, tocolor(255, 255, 255, 255), 1.00, dxfont2_AndikaNewBasicBold, "left", "top", false, false, false, false, false)
            dxDrawImage(1542*w, 991*h, 62*w, 55*h, "rozmowa/right.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawRectangle(Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4], tocolor(255, 255, 255, 207), false)
                dxDrawText("Dalej", 1341*w, 991*h, 1620*w, 1121*h, tocolor(255, 255, 0, 255), 1.00, dxfont2_AndikaNewBasicBold, "left", "top", false, false, false, false, false)
                dxDrawImage(1542*w, 991*h, 62*w, 55*h, "rozmowa/right.png", 0, 0, 0, tocolor(255, 255, 0, 255), false)  
            end
        elseif getElementData( localPlayer, "przejscia") == 1 then
            dxDrawRectangle(0*w, 706*h, 1920*w, 374*h, tocolor(1, 0, 0, 101), false)
            dxDrawRectangle(316*w, 706*h, 1314*w, 374*h, tocolor(1, 0, 0, 206), false)
        dxDrawImage(345*w, 609*h, 247*w, 461*h, "rozmowa/Sarina.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Sarina Tsumakura mówi: Co robisz tutaj?", 615*w, 713*h, 1076*w, 891*h, tocolor(255, 255, 255, 255), 1.00, czczionka1, "left", "top", false, false, false, false, false)
        dxDrawText("*Martin Clinton wtraca sie do rozmowy*", 615*w, 762*h, 1076*w, 940*h, tocolor(217, 40, 224, 193), 1.00, czczionka1, "left", "top", false, false, false, false, false)
            if isMouseInPosition ( Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4] ) then
                dxDrawRectangle(Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4], tocolor(125, 125, 125, 207), false)
                dxDrawText("Dalej", 1341*w, 991*h, 1620*w, 1121*h, tocolor(255, 255, 255, 255), 1.00, dxfont2_AndikaNewBasicBold, "left", "top", false, false, false, false, false)
                dxDrawImage(1542*w, 991*h, 62*w, 55*h, "rozmowa/right.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawRectangle(Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4], tocolor(255, 255, 255, 207), false)
                    dxDrawText("Dalej", 1341*w, 991*h, 1620*w, 1121*h, tocolor(255, 255, 0, 255), 1.00, dxfont2_AndikaNewBasicBold, "left", "top", false, false, false, false, false)
                    dxDrawImage(1542*w, 991*h, 62*w, 55*h, "rozmowa/right.png", 0, 0, 0, tocolor(255, 255, 0, 255), false)  
                end
            elseif getElementData( localPlayer, "przejscia") == 2 then
                dxDrawRectangle(0*w, 706*h, 1920*w, 374*h, tocolor(1, 0, 0, 101), false)
                dxDrawRectangle(316*w, 706*h, 1314*w, 374*h, tocolor(1, 0, 0, 206), false)
                dxDrawText("Martin Clinton mówi: Odpowiadaj jak kobieta zadaje pytania", 615*w, 713*h, 1076*w, 891*h, tocolor(255, 255, 255, 255), 1.00, czczionka2, "left", "top", false, false, false, false, false)
                dxDrawText("*Wtedy Samuel White odpowiada*", 615*w, 762*h, 1076*w, 940*h, tocolor(217, 40, 224, 193), 1.00, czczionka3, "left", "top", false, false, false, false, false)
                dxDrawImage(332*w, 698*h, 232*w, 175*h, "rozmowa/info.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawRectangle(615, 875, 587, 55, tocolor(0, 0, 0, 125), false)
                dxDrawRectangle(615, 940, 897, 55, tocolor(0, 0, 0, 125), false)
                dxDrawText("Oddawaj portfel! #ff6e00(Kradziez)", 615, 885, 1076, 1063, tocolor(254, 254, 254, 255), 1.00, czczionka3, "left", "top", false, false, false, true, false)
                dxDrawText("Salut Home! Co dobrego? #ff6e00(Wymagane #ffff0010%#ff6e00 przyjaźni z gangiem niesmiertelnych)", 615, 950, 1076, 1128, tocolor(254, 254, 254, 255), 1.00, czczionka3, "left", "top", false, false, false, true, false)
                dxDrawRectangle(615, 1000, 587, 55, tocolor(0, 0, 0, 125), false)
                dxDrawText("Spierdalam #ff6e00(Uciekaj)", 615, 1010, 1076, 1188, tocolor(254, 254, 254, 255), 1.00, czczionka3, "left", "top", false, false, false, true, false)
                if isMouseInPosition ( Interfejs["Rzeznia"][1], Interfejs["Rzeznia"][2], Interfejs["Rzeznia"][3], Interfejs["Rzeznia"][4] ) then
                    dxDrawRectangle(616*w, 812*h, 587*w, 55*h, tocolor(0, 255, 255, 125), false)
                    dxDrawText("Brzmisz jakby cie gwalcil goryl #ff6e00(Rzeznia)", 615*w, 822*h, 1076*w, 1000*h, tocolor(0, 0, 0, 255), 1.00, czczionka3, "left", "top", false, false, false, true, false)
                else
                    dxDrawRectangle(616*w, 812*h, 587*w, 55*h, tocolor(0, 0, 0, 125), false)
                    dxDrawText("Brzmisz jakby cie gwalcil goryl #ff6e00(Rzeznia)", 615*w, 822*h, 1076*w, 1000*h, tocolor(254, 254, 254, 255), 1.00, czczionka3, "left", "top", false, false, false, true, false)
                end
            end
        end

        addEventHandler("onClientClick", getRootElement(), function(btn, state)
            if btn == "left" and state == "down" then return end
            if isEventHandlerAdded("onClientRender", root,poszczuszek) then
                    if isMouseInPosition ( Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4] ) and getElementData( localPlayer, "przejscia") == 0 then
                        setElementData( localPlayer, "przejscia",getElementData( localPlayer, "przejscia")+1)
                    end
                    if isMouseInPosition ( Interfejs["Dalej"][1], Interfejs["Dalej"][2], Interfejs["Dalej"][3], Interfejs["Dalej"][4] ) and getElementData( localPlayer, "przejscia") == 1 then
                        setElementData( localPlayer, "przejscia",getElementData( localPlayer, "przejscia")+1)
                    end
                 if isMouseInPosition ( Interfejs["Rzeznia"][1], Interfejs["Rzeznia"][2], Interfejs["Rzeznia"][3], Interfejs["Rzeznia"][4] ) and getElementData( localPlayer, "przejscia") == 2 then
                        setElementData( localPlayer, "przejscia",0)
                        removeEventHandler("onClientRender", root, poszczuszek)
                        triggerServerEvent("gang:niesmiertelnych", localPlayer, localPlayer)
                    end
            end
    end)