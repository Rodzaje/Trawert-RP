
local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
	for k, a in ipairs(t) do
		if a == v then
			return k
		end
	end
	return false
end

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

function animate(f, t, easing, duration, onChange, onEnd)
	assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
	assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
	assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'animate' [Invalid easing at argument 3]")
	assert(type(duration) == "number", "Bad argument @ 'animate' [expected function at argument 4, got "..type(duration).."]")
	assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
	table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
	return #anims
end

function destroyAnimation(a)
	if anims[a] then
		table.remove(anims, a)
	end
end

addEventHandler("onClientRender", root, function( )
	local now = getTickCount( )
	for k,v in ipairs(anims) do
		v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
		if now >= v.start+v.duration then
			if type(v.onEnd) == "function" then
				v.onEnd( )
			end
			table.remove(anims, k)
		end
	end
end)

local sm = {}
sm.moov = 0

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end

local start
local animTime
local tempPos = {{},{}}
local tempPos2 = {{},{}}

local function camRender()
	local now = getTickCount()
	if (sm.moov == 1) then
		local x1, y1, z1 = interpolateBetween(tempPos[1][1], tempPos[1][2], tempPos[1][3], tempPos2[1][1], tempPos2[1][2], tempPos2[1][3], (now-start)/animTime, "InOutQuad")
		local x2,y2,z2 = interpolateBetween(tempPos[2][1], tempPos[2][2], tempPos[2][3], tempPos2[2][1], tempPos2[2][2], tempPos2[2][3], (now-start)/animTime, "InOutQuad")
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientRender",root,camRender)
		fadeCamera(true)
	end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
    if(sm.moov == 1) then
        killTimer(timer1)
        killTimer(timer2)
        removeEventHandler("onClientRender",root,camRender)
    end
    sm.moov = 1
    timer1 = setTimer(removeCamHandler,time,1)
    timer2 = setTimer(fadeCamera, time-1000, 1, false)
    start = getTickCount()
    animTime = time
    tempPos[1] = {x1,y1,z1}
    tempPos[2] = {x1t,y1t,z1t}
    tempPos2[1] = {x2,y2,z2}
    tempPos2[2] = {x2t,y2t,z2t}
    addEventHandler("onClientRender",root,camRender)
    return true
end


local sx, sy = guiGetScreenSize()
function sw(value)
    return sx*value/1920    
end
            
function sh(value)    
    return sy*value/1080
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


Klasy={
    ["1"]={sw(38), sh(264), sw(284), sh(468),"rozrywkowa"},
    ["2"]={sw(349), sh(264), sw(284), sh(468),"przestępcza"},
    ["3"]={sw(663), sh(264), sw(284), sh(468),"biznesowa"},
    ["4"]={sw(974), sh(264), sw(284), sh(468),"polityczna"},
    ["5"]={"porządkowa"},
    ["6"]={"cywilna"}
}

dxfont0_AndikaNewBasicBoldItalic = dxCreateFont("KlasyPostaci/AndikaNewBasic-BoldItalic.ttf", 65)



    function Sickgirl ()
        tick = getTickCount() 

        local animate = interpolateBetween(10,  0 , 0 , 0, 0, 0, (getTickCount()-tick) /300,  "OutQuad") 
        dxDrawImage(1283, 264, 284, 468, "KlasyPostaci/POLITYCZNA.png", 0, 0, 0, tocolor(255, 255, 255, 0), false)
        dxDrawImage(1603, 264, 284, 468, "KlasyPostaci/POLITYCZNA.png", 0, 0, 0, tocolor(255, 255, 255, 0), false)
        dxDrawText("Kliknij aby wybrać typ postaci", sw(429), sh(72), sw(1258), sh(205), tocolor(255, 255, 255, 255), 1.00, dxfont0_AndikaNewBasicBoldItalic, "left", "top", false, false, false, false, false)
        if isMouseInPosition ( Klasy["3"][1], Klasy["3"][2], Klasy["3"][3], Klasy["3"][4] ) then
            dxDrawImage(Klasy["3"][1], Klasy["3"][2], Klasy["3"][3]+animate, Klasy["3"][4]+animate, "KlasyPostaci/BIZNESOWA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(Klasy["3"][1], Klasy["3"][2], Klasy["3"][3]-animate, Klasy["3"][4]-animate, "KlasyPostaci/BIZNESOWA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
            smoothMoveCamera( 1976.21704, -1218.08472, 49.41188, 1939.14429, -1191.31763, 53.35598, 1707.11963, -1163.77136, 170.83409, 1730.57788, -1149.95667, 38.95619, 2000)    
            end   
            if isMouseInPosition ( Klasy["1"][1], Klasy["1"][2], Klasy["1"][3], Klasy["1"][4] ) then
                dxDrawImage(Klasy["1"][1], Klasy["1"][2], Klasy["1"][3]+animate, Klasy["1"][4]+animate, "KlasyPostaci/ROZRYWKOWA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(Klasy["1"][1], Klasy["1"][2], Klasy["1"][3]-animate, Klasy["1"][4]-animate, "KlasyPostaci/ROZRYWKOWA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) 
                smoothMoveCamera(487.58801, -1253.42932, 109.89849, 508.42621, -1269.14380, 68.56197, 441.90829, -1307.22876, 56.39494, 404.67395, -1289.87585, 50.04852, 5000)         
                end  
                if isMouseInPosition ( Klasy["2"][1], Klasy["2"][2], Klasy["2"][3], Klasy["2"][4] ) then
                    dxDrawImage(Klasy["2"][1], Klasy["2"][2], Klasy["2"][3]+animate, Klasy["2"][4]+animate, "KlasyPostaci/PRZESTEPCZA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                else
                    dxDrawImage(Klasy["2"][1], Klasy["2"][2], Klasy["2"][3]-animate, Klasy["2"][4]-animate, "KlasyPostaci/PRZESTEPCZA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)      
                    smoothMoveCamera(2591.57983, -1259.11279, 67.88829, 2553.87280, -1258.95898, 64.65460, 2549.79956, -1257.58777, 53.01241, 2550.91016, -1236.42334, 48.83723, 5000)  
                    end  
                    if isMouseInPosition ( Klasy["4"][1], Klasy["4"][2], Klasy["4"][3], Klasy["4"][4] ) then
                        dxDrawImage(Klasy["4"][1], Klasy["4"][2], Klasy["4"][3]+animate, Klasy["4"][4]+animate, "KlasyPostaci/POLITYCZNA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                    else
                        dxDrawImage(Klasy["4"][1], Klasy["4"][2], Klasy["4"][3]-animate, Klasy["4"][4]-animate, "KlasyPostaci/POLITYCZNA.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)  
                        smoothMoveCamera( 2737.07837, -1193.00500, 104.54697, 2672.83569, -1263.82080, 65.85080, 2631.43091, -1271.11438, 81.51028, 2605.07959, -1254.78955, 78.44994, 2000)      
                        end  
    end


    function NogiBola(index_klasy)
        triggerServerEvent("KlasyZapis", localPlayer, tonumber(index_klasy))
        removeEventHandler("onClientRender",root,Sickgirl)
        setCameraTarget (localPlayer)
        showCursor(false)
end

    marker = createMarker ( 2678.31274, -1260.84265, 54.05523-1, "cylinder", 1.5, 255, 255, 0, 170 )
    function MarkerHit ()
        addEventHandler("onClientRender", root,Sickgirl)
        showCursor(true)
    end
    addEventHandler ( "onClientMarkerHit", marker, MarkerHit )

    addEventHandler("onClientClick", getRootElement(), function(btn, state)
        if not isEventHandlerAdded("onClientRender", root,Sickgirl) then return end
        if btn == "left" and state == "down" then return end
        if isMouseInPosition ( Klasy["1"][1], Klasy["1"][2], Klasy["1"][3], Klasy["1"][4] ) then
            NogiBola(1)
        end
        if isMouseInPosition ( Klasy["2"][1], Klasy["2"][2], Klasy["2"][3], Klasy["2"][4] ) then
            NogiBola(2)
        end
        if isMouseInPosition ( Klasy["3"][1], Klasy["3"][2], Klasy["3"][3], Klasy["3"][4] ) then
            NogiBola(3)
        end
        if isMouseInPosition ( Klasy["4"][1], Klasy["4"][2], Klasy["4"][3], Klasy["4"][4] ) then
            NogiBola(4)
        end
    end)
            