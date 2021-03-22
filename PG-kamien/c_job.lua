local missionBlip
local missionPickup
local missionVehicle
blurBoxElement = nil
blurBoxElemen = nil
ToWszystk = nil
Text = nil
KiedyKup=true
Animacjegui= true

local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
	for k, a in ipairs(t) do
		if a == v then
			return k
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

screenW, screenH = guiGetScreenSize()
z, y = (screenW/1920), (screenH/1080)

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

Interface={
        ["Nielegalne"]={636*z, 330*y, 260*z, 377*y},
        ["Legalne"]={922*z, 333*y, 264*z, 374*y},
        ["Legalne2"]={922*z, 333*y, 264*z, 0*y},
        ["Nielegalne2"]={636*z, 330*y, 260*z, 0*y}
}

function TrawertRPnieudane()
        if isMouseInPosition ( Interface["Nielegalne"][1], Interface["Nielegalne"][2],Interface["Nielegalne"][3],Interface["Nielegalne"][4] ) then
        dxDrawImage(Interface["Nielegalne"][1], Interface["Nielegalne"][2],Interface["Nielegalne"][3],Interface["Nielegalne"][4], "Legalne/nielegalne.png", 0, 0, 0, tocolor(255, 255, 255, 0), false)
        else
                dxDrawImage(Interface["Nielegalne"][1], Interface["Nielegalne"][2],Interface["Nielegalne"][3],Interface["Nielegalne"][4], "Legalne/nielegalne.png", 0, 0, 0, tocolor(255, 255, 255, 40), false) 
        end
        if isMouseInPosition ( Interface["Legalne"][1], Interface["Legalne"][2], Interface["Legalne"][3], Interface["Legalne"][4] ) then
                dxDrawImage(Interface["Legalne"][1], Interface["Legalne"][2], Interface["Legalne"][3], Interface["Legalne"][4], "Legalne/legalne.png", 0, 0, 0, tocolor(255, 255, 255, 0), false)
        else
        dxDrawImage(Interface["Legalne"][1], Interface["Legalne"][2], Interface["Legalne"][3], Interface["Legalne"][4], "Legalne/legalne.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawImage(Interface["Legalne2"][1], Interface["Legalne2"][2], Interface["Legalne2"][3], Interface["Legalne2"][4], "Legalne/legalne1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(Interface["Nielegalne2"][1], Interface["Nielegalne2"][2], Interface["Nielegalne2"][3], Interface["Nielegalne2"][4], "Legalne/nielegalne1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

addEvent("Straszne/Piekna", true)
addEventHandler("Straszne/Piekna", getRootElement(), function()
addEventHandler("onClientRender", root,TrawertRPnieudane)
setElementData(localPlayer,"gracz:poziom",4)
showCursor(true)
if KiedyKup == true then 
        animate(0, 374, 2, 3000, function (height)
                Interface["Legalne2"][4] = height
            end)
        else if KiedyKup == false then
                animate(374, 0, 2, 4000, function (height)
                        Interface["Legalne2"][4] = height
                    end)
                end    
        end
        if Animacjegui == true then 
                animate(0, 377, 2, 3000, function (height)
                        Interface["Nielegalne2"][4] = height
                    end)
                end            
end)

addEventHandler("onClientClick", getRootElement(), function(btn, state)
        if btn == "left" and state == "down" then return end
        if getElementData(localPlayer,"gracz:poziom") == 4 then
                if isMouseInPosition ( Interface["Legalne"][1], Interface["Legalne"][2], Interface["Legalne"][3], Interface["Legalne"][4] ) then
                        triggerServerEvent("We2zwanie:legalne", localPlayer, localPlayer, localPlayer)
                        removeEventHandler("onClientRender", root,TrawertRPnieudane)
                        showCursor(false)
                end
        end
end)

local missionPoints = {
{650.34, -1473.93, 14.86},
{802.90, -1706.72, 13.55},
{563.69, -1664.97, 18.10},
{482.42, -1655.96, 22.82},
{382.97, -1652.77, 32.44},
{1786.70, -1349.20, 15.75},
{2301.36, -1223.47, 23.84},
{2410.81, -1034.39, 51.48},
{1315.97, -1390.14, 13.52},
{1395.37, -1386.70, 13.55},
{1408.12, -1388.19, 13.56},
{1445.02, -1470.08, 13.37},
{1449.29, -1382.78, 13.55},
{1449.29, -1390.49, 13.55},
{1448.32, -1406.55, 13.55},
{1492.20, -1447.21, 13.55},
{1408.88, -1880.75, 13.55},
{1460.62, -1864.16, 13.55},
{1481.09, -1864.52, 13.55},
}
OctaneSprings = {
{922.88, 2013.00, 11.29},
{921.97, 2022.76, 11.19},
{684.00, 1882.40, 5.55},
{679.74, 1844.74, 5.41},
{720.77, 1896.69, 5.69},
{770.58, 1937.15, 5.81},
{754.91, 2074.32, 6.71},
{770.65, 2040.76, 6.71},
}




dxfont0_RobotoThinItalic = dxCreateFont("Dostawcy/Roboto-ThinItalic.ttf", 10)
dxfont1_RobotoMedium = dxCreateFont("Dostawcy/Roboto-Medium.ttf", 26)
dxfont2_RobotoMedium = dxCreateFont("Dostawcy/Roboto-Medium.ttf", 13)
dxfont0RobotoThinItalic = dxCreateFont("Dostawcy/Roboto-ThinItalic.ttf", 23)
dxfont2RobotoMedium = dxCreateFont("Dostawcy/Roboto-Medium.ttf", 19)
dxfont2RobooMedium = dxCreateFont("Dostawcy/Roboto-Medium.ttf", 38)
dxfont2RoboMedium = dxCreateFont("Dostawcy/Roboto-Medium.ttf", 33)

dxfont0_AlatsiRegular = dxCreateFont("Legalne/Alatsi-Regular.ttf", 27)


    function NaukaJezykaLUA ()
        setElementData(localPlayer,"gracz:gui",true)
ToWszystko = getElementData(localPlayer,"dostawca:punkty") or 0
ToWszystk = getElementData(localPlayer,"dostawca:punkt") or 0
if getElementData(localPlayer,"gracz:poziom") == 0 then
        dxDrawRectangle(605*z, 338*y, 691*z, 91*y, tocolor(165, 160, 21, 255), false)
        dxDrawText("PRACA DORYWCZA", 632*z, 352*y, 1008*z, 548*y, tocolor(255, 255, 255, 255), 1.00, dxfont0_RobotoThinItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Naciśnij H aby rozpocząć pracę", 581*z, 994*y, 1345*z, 1098*y, tocolor(255, 255, 255, 255), 1.00, dxfont0_AlatsiRegular, "center", "top", false, false, false, false, false)
        dxDrawText("Dostawca", 632*z, 377*y, 953*z, 662*y, tocolor(255, 255, 255, 255), 1.00, dxfont1_RobotoMedium, "left", "top", false, false, false, false, false)
        dxDrawText("Masz wysokie umiejętności w prowadzeniu\nauta? Świetnie się składa! Potrzebujemy \npracowników do jazdy pojazdem! Nie czekaj,\ndołącz do naszych pracowników już dziś!", 637*z, 476*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, false, false)
        dxDrawImage(850*z, 323*y, 770*z, 495*y, "Dostawcy/market_teng.png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
        dxDrawImage(1263*z, 342*y, 21*z, 23*y, "Dostawcy/zamknij.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
if isMouseInPosition(1169*z, 348*y, 100*z, 76*y) then
        dxDrawImage(1169*z, 348*y, 100*z, 76*y, "Dostawcy/trozpocznmi.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(1169*z, 348*y, 100*z, 76*y, "Dostawcy/trozpocznmi.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
if isMouseInPosition(1066*z, 347*y, 117*z, 77*y) then
        dxDrawImage(1066*z, 347*y, 117*z, 77*y, "Dostawcy/ustaweienia.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
   dxDrawImage(1066*z, 347*y, 117*z, 77*y, "Dostawcy/ustaweienia.png", 0, 0, 0, tocolor(255, 255, 255,100), false)
end
if isMouseInPosition(961*z, 352*y, 107*z, 72*y) then
        dxDrawImage(961*z, 352*y, 107*z, 72*y, "Dostawcy/staty.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(961*z, 352*y, 107*z, 72*y, "Dostawcy/staty.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
else if getElementData(localPlayer,"gracz:poziom") == 1 then
        dxDrawRectangle(605*z, 338*y, 691*z, 91*y, tocolor(165, 160, 21, 255), false)
        dxDrawText("PRACA DORYWCZA", 632*z, 352*y, 1008*z, 548*y, tocolor(255, 255, 255, 255), 1.00, dxfont0_RobotoThinItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Dostawca", 632*z, 377*y, 953*z, 662*y, tocolor(255, 255, 255, 255), 1.00, dxfont1_RobotoMedium, "left", "top", false, false, false, false, false)
        dxDrawText("Ilość dostaw: #6383aa"..ToWszystko.."", 637*z, 476*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
        dxDrawText("Ilość punktów: #6383aa"..ToWszystk.."", 637*z, 510*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
if getElementData(localPlayer,"auto:pozio") == 1 then
        dxDrawText("Używany pojazd: #6383aaBenson", 637*z, 544*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
else if getElementData(localPlayer,"auto:pozio") == 2 then
dxDrawText("Używany pojazd: #6383aaBobcat", 637*z, 544*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
else if getElementData(localPlayer,"auto:pozio") == 3 then
dxDrawText("Używany pojazd: #6383aaYosemite", 637*z, 544*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
else
dxDrawText("Używany pojazd: #6383aaBrak", 637*z, 544*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
end
end
end
        dxDrawImage(1263*z, 342*y, 21*z, 23*y, "Dostawcy/zamknij.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
if isMouseInPosition(899*z, 360*y, 50*z, 53*y) then
        dxDrawImage(899*z, 360*y, 50*z, 53*y, "Dostawcy/powort.png", 0, 0, 0, tocolor(0, 0, 255, 255), false)

else
        dxDrawImage(899*z, 360*y, 50*z, 53*y, "Dostawcy/powort.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
if isMouseInPosition(1169*z, 348*y, 100*z, 76*y) then
        dxDrawImage(1169*z, 348*y, 100*z, 76*y, "Dostawcy/trozpocznmi.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(1169*z, 348*y, 100*z, 76*y, "Dostawcy/trozpocznmi.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
if isMouseInPosition(1066*z, 347*y, 117*z, 77*y) then
        dxDrawImage(1066*z, 347*y, 117*z, 77*y, "Dostawcy/ustaweienia.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
   dxDrawImage(1066*z, 347*y, 117*z, 77*y, "Dostawcy/ustaweienia.png", 0, 0, 0, tocolor(255, 255, 255,100), false)
end
if isMouseInPosition(961*z, 352*y, 107*z, 72*y) then
        dxDrawImage(961*z, 352*y, 107*z, 72*y, "Dostawcy/staty.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(961*z, 352*y, 107*z, 72*y, "Dostawcy/staty.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
else if getElementData(localPlayer,"gracz:poziom") == 2 then
ToWszyst = getElementData(localPlayer,"auto:pozi") or 1
        dxDrawRectangle(605*z, 338*y, 691*z, 91*y, tocolor(165, 160, 21, 255), false)
        dxDrawText("PRACA DORYWCZA", 632*z, 352*y, 1008*z, 548*y, tocolor(255, 255, 255, 255), 1.00, dxfont0_RobotoThinItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Dostawca", 632*z, 377*y, 953*z, 662*y, tocolor(255, 255, 255, 255), 1.00, dxfont1_RobotoMedium, "left", "top", false, false, false, false, false)
dxDrawText("Premia do zarobku: #649f84"..ToWszyst.."$", 637*z, 544*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
dxDrawText("+1$", 640*z, 570*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
dxDrawText(Text, 780*z, 570*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.20, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
dxDrawText("+10$", 640*z, 640*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
if isMouseInPosition(680*z, 640*y, 34*z, 34*y) then
dxDrawImage(680*z, 640*y, 34*z, 34*y, "Auta/buy.png", 0, 0, 0, tocolor(100, 159, 132, 255), true)
dxDrawText("Kliknij aby dodać 10$ do twoich zarobków", 810*z, 750*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
else
dxDrawImage(680*z, 640*y, 34*z, 34*y, "Auta/buy.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

if isMouseInPosition(670*z, 570*y, 24*z, 24*y) then
dxDrawImage(670*z, 570*y, 24*z, 24*y, "Auta/buy.png", 0, 0, 0, tocolor(100, 159, 132, 255), true)
dxDrawText("Kliknij aby dodać 1$ do twoich zarobków", 810*z, 750*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)
else
dxDrawImage(670*z, 570*y, 24*z, 24*y, "Auta/buy.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end
if isMouseInPosition(850*z, 476*y, 180*z, 49*y) then
        dxDrawImage(850*z, 476*y, 180*z, 49*y, "Auta/pojazd.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
dxDrawText("Kliknij aby przejść do wyboru pojazdu", 810*z, 750*y, 1206*z, 845*y, tocolor(255, 255, 255, 255), 1.00, dxfont2_RobotoMedium, "left", "top", false, false, true, true, false)

else
        dxDrawImage(850*z, 476*y, 180*z, 49*y, "Auta/pojazd.png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
end

if isMouseInPosition(1263*z, 342*y, 21*z, 23*y) then
        dxDrawImage(1263*z, 342*y, 21*z, 23*y, "Dostawcy/zamknij.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)

else
         dxDrawImage(1263*z, 342*y, 21*z, 23*y, "Dostawcy/zamknij.png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
end
if isMouseInPosition(899*z, 360*y, 50*z, 53*y) then
        dxDrawImage(899*z, 360*y, 50*z, 53*y, "Dostawcy/powort.png", 0, 0, 0, tocolor(0, 0, 255, 255), false)

else
        dxDrawImage(899*z, 360*y, 50*z, 53*y, "Dostawcy/powort.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
if isMouseInPosition(1169*z, 348*y, 100*z, 76*y) then
        dxDrawImage(1169*z, 348*y, 100*z, 76*y, "Dostawcy/trozpocznmi.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(1169*z, 348*y, 100*z, 76*y, "Dostawcy/trozpocznmi.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
if isMouseInPosition(1066*z, 347*y, 117*z, 77*y) then
        dxDrawImage(1066*z, 347*y, 117*z, 77*y, "Dostawcy/ustaweienia.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
   dxDrawImage(1066*z, 347*y, 117*z, 77*y, "Dostawcy/ustaweienia.png", 0, 0, 0, tocolor(255, 255, 255,100), false)
end
if isMouseInPosition(961*z, 352*y, 107*z, 72*y) then
        dxDrawImage(961*z, 352*y, 107*z, 72*y, "Dostawcy/staty.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
else
        dxDrawImage(961*z, 352*y, 107*z, 72*y, "Dostawcy/staty.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
end
else if getElementData(localPlayer,"gracz:poziom") == 3 then
        dxDrawRectangle(702*z, 286*y, 568*z, 90*y, tocolor(144, 153, 6, 255), false)
        dxDrawText("Wybór pojazdów", 779*z, 303*y, 990*z, 401*y, tocolor(254, 254, 254, 254), 1.00, dxfont2RobooMedium, "left", "top", false, false, true, true, false)
if isMouseInPosition(722*z, 536*y, 211*z, 38*y) then
        dxDrawImage(722*z, 536*y, 211*z, 38*y, "Dostawcy/rectangle.png", 0, 0, 0, tocolor(9, 248, 0, 255), true)
dxDrawText("Zakup", 785*z, 536*y, 996*z, 634*y, tocolor(0, 0, 0, 254), 1.00, dxfont2RobotoMedium, "left", "top", false, false, true, false, false)
else
                dxDrawImage(722*z, 536*y, 211*z, 38*y, "Dostawcy/rectangle.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
dxDrawText("Zakup", 785*z, 536*y, 996*z, 634*y, tocolor(15, 169, 30, 254), 1.00, dxfont2RobotoMedium, "left", "top", false, false, true, false, false)
end
if isMouseInPosition(720*z, 460*y, 50*z, 53*y) then
        dxDrawImage(720*z, 460*y, 50*z, 53*y, "Dostawcy/powort.png", 0, 0, 0, tocolor(0, 0, 255, 255), true)

else
        dxDrawImage(720*z, 460*y, 50*z, 53*y, "Dostawcy/powort.png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
end
if getElementData(localPlayer,"auto:poziom") == 1 then
        dxDrawRectangle(716*z, 611*y, 89*z, 69*y, tocolor(1, 1, 0, 254), true)
        dxDrawRectangle(725*z, 619*y, 70*z, 51*y, tocolor(144, 153, 6, 255), true)
        dxDrawText("1", 744*z, 618*y, 1208*z, 826*y, tocolor(0, 0, 0, 254), 1.00, dxfont2RoboMedium, "left", "top", false, false, true, true, false)
        dxDrawText("Benson", 731*z, 396*y, 972*z, 534*y, tocolor(255, 255, 255, 255), 1.00, dxfont0RobotoThinItalic, "left", "top", false, false, true, false, false)
        dxDrawText("#09f800200$", 800*z, 460*y, 972*z, 534*y, tocolor(255, 255, 255, 255), 1.00, dxfont0RobotoThinItalic, "left", "top", false, false, true, true, false)
        dxDrawImage(972*z, 386*y, 284*z, 188*y, "Auta/benson.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
else
        dxDrawRectangle(716*z, 611*y, 89*z, 69*y, tocolor(1, 1, 0, 254), true)
        dxDrawRectangle(725*z, 619*y, 70*z, 51*y, tocolor(255, 255, 255, 255), true)
        dxDrawText("1", 744*z, 618*y, 1208*z, 826*y, tocolor(9, 220, 223, 254), 1.00, dxfont2RoboMedium, "left", "top", false, false, true, true, false)
end
if getElementData(localPlayer,"auto:poziom") == 2 then
        dxDrawRectangle(933*z, 611*y, 89*z, 69*y, tocolor(144, 153, 6, 254), true)
        dxDrawRectangle(943*z, 619*y, 70*z, 51*y, tocolor(255, 255, 255, 255), true)
        dxDrawImage(972*z, 386*y, 284*z, 188*y, "Auta/bobcat.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Bobcat", 731*z, 396*y, 972*z, 534*y, tocolor(255, 255, 255, 255), 1.00, dxfont0RobotoThinItalic, "left", "top", false, false, true, false, false)
        dxDrawText("2", 964*z, 618*y, 1428*z, 826*y, tocolor(9, 220, 223, 254), 1.00, dxfont2RoboMedium, "left", "top", false, false, true, false, false)
        dxDrawText("#09f800200 Punktów", 780*z, 460*y, 972*z, 534*y, tocolor(255, 255, 255, 255), 1.00, dxfont0RobotoThinItalic, "left", "top", false, false, true, true, false)

else
        dxDrawRectangle(933*z, 611*y, 89*z, 69*y, tocolor(1, 1, 0, 254), true)
        dxDrawRectangle(943*z, 619*y, 70*z, 51*y, tocolor(255, 255, 255, 255), true)
        dxDrawText("2", 964*z, 618*y, 1428*z, 826*y, tocolor(0, 0, 0, 254), 1.00, dxfont2RoboMedium, "left", "top", false, false, true, false, false)

end
if getElementData(localPlayer,"auto:poziom") == 3 then
        dxDrawRectangle(1167*z, 611*y, 89*z, 69*y, tocolor(144, 153, 6, 254), true)
        dxDrawRectangle(1177*z, 619*y, 70*z, 51*y, tocolor(255, 255, 255, 255), true)
        dxDrawImage(972*z, 386*y, 284*z, 188*y, "Auta/yosemite.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Yosemite", 731*z, 396*y, 972*z, 534*y, tocolor(255, 255, 255, 255), 1.00, dxfont0RobotoThinItalic, "left", "top", false, false, true, false, false)
        dxDrawText("3", 1198*z, 618*y, 1662*z, 826*y, tocolor(0, 0, 0, 254), 1.00, dxfont2RoboMedium, "left", "top", false, false, true, false, false)
        dxDrawText("#09f800400 Punktów", 780*z, 460*y, 972*z, 534*y, tocolor(255, 255, 255, 255), 1.00, dxfont0RobotoThinItalic, "left", "top", false, false, true, true, false)
else
        dxDrawRectangle(1167*z, 611*y, 89*z, 69*y, tocolor(1, 1, 0, 254), true)
        dxDrawRectangle(1177*z, 619*y, 70*z, 51*y, tocolor(255, 255, 255, 255), true)
        dxDrawText("3", 1198*z, 618*y, 1662*z, 826*y, tocolor(9, 220, 223, 254), 1.00, dxfont2RoboMedium, "left", "top", false, false, true, false, false)

end

end
end
end
end
    end

addEvent("BrajankRP:Panel", true)
addEventHandler("BrajankRP:Panel", getRootElement(), function()
blurBoxElement = exports.blur_box:createBlurBox( 605*z, 428*y, 691*z, 347*y, 255, 255, 255, 255, false)
exports.blur_box:setBlurIntensity(4.0)	
addEventHandler("onClientRender", root,NaukaJezykaLUA)
setElementData(localPlayer,"gracz:poziom",0)
end)

addEvent("client.wyszedl", true)
addEventHandler("client.wyszedl", getRootElement(), function()
        exports.blur_box:destroyBlurBox( blurBoxElement )
removeEventHandler("onClientRender", root,NaukaJezykaLUA)
setElementData(localPlayer,"gracz:gui",false)
end)

addEventHandler("onClientClick", getRootElement(), function(btn, state)
if btn == "left" and state == "down" then return end
if getElementData(localPlayer,"gracz:gui") == true then
if isMouseInPosition(1263*z, 342*y, 21*z, 23*y) then
removeEventHandler("onClientRender",root,NaukaJezykaLUA)
exports.blur_box:destroyBlurBox( blurBoxElement )
        setElementData(localPlayer,"gracz:gui",false)
removeEventHandler("onClientRender",root,Statydst)
end
if isMouseInPosition(1169*z, 348*y, 100*z, 76*y) then
              triggerServerEvent("rozpocznij:dostawca", localPlayer, localPlayer)
removeEventHandler("onClientRender",root,NaukaJezykaLUA)
exports.blur_box:destroyBlurBox( blurBoxElement )
        setElementData(localPlayer,"gracz:gui",false)
removeEventHandler("onClientRender",root,Statydst)
end
if isMouseInPosition(1066*z, 347*y, 117*z, 77*y) then
setElementData(localPlayer,"gracz:poziom",1)
end
if isMouseInPosition(899*z, 360*y, 50*z, 53*y) then
setElementData(localPlayer,"gracz:poziom",0)
end
if isMouseInPosition(961*z, 352*y, 107*z, 72*y) then
setElementData(localPlayer,"gracz:poziom",2)
end
if isMouseInPosition(850*z, 476*y, 180*z, 49*y) then
setElementData(localPlayer,"gracz:poziom",3)
exports.blur_box:destroyBlurBox( blurBoxElement )
blurBoxElemen = exports.blur_box:createBlurBox( 702*z, 376*y, 568*z, 318*y, 255, 255, 255, 255, false)
end
if isMouseInPosition(725*z, 619*y, 70*z, 51*y) and getElementData(localPlayer,"gracz:poziom") == 3 then
setElementData(localPlayer,"auto:poziom",1)
end
if isMouseInPosition(933*z, 611*y, 89*z, 69*y) and getElementData(localPlayer,"gracz:poziom") == 3 then
setElementData(localPlayer,"auto:poziom",2)
end
if isMouseInPosition(1167*z, 611*y, 89*z, 69*y) and getElementData(localPlayer,"gracz:poziom") == 3 then
setElementData(localPlayer,"auto:poziom",3)
end
if isMouseInPosition(720*z, 460*y, 50*z, 53*y) and getElementData(localPlayer,"gracz:poziom") == 3 then
setElementData(localPlayer,"gracz:poziom",0)
exports.blur_box:destroyBlurBox( blurBoxElemen )
blurBoxElement = exports.blur_box:createBlurBox( 605*z, 428*y, 691*z, 347*y, 255, 255, 255, 255, false)
exports.blur_box:setBlurIntensity(4.0)
end
if isMouseInPosition(722*z, 536*y, 211*z, 38*y) and getElementData(localPlayer,"gracz:poziom") == 3 and getElementData(localPlayer,"auto:poziom") == 1 then
triggerServerEvent("auto:benson", localPlayer, localPlayer)
outputChatBox("Nie masz pieniedzy na to auto.", 0, 255, 255,true)
else if isMouseInPosition(722*z, 536*y, 211*z, 38*y) and getElementData(localPlayer,"gracz:poziom") == 3 and getElementData(localPlayer,"auto:poziom") == 2 then
if tonumber(getElementData(localPlayer,"dostawca:punkt")) >= 200 then
outputChatBox("Zakupiles auto bobcat", 255, 255, 0,true)
triggerServerEvent("auto:bobcat", localPlayer, localPlayer)
else
outputChatBox("Nie masz punktow na to auto.", 255, 255, 255,true)
end
else if isMouseInPosition(722*z, 536*y, 211*z, 38*y) and getElementData(localPlayer,"gracz:poziom") == 3 and getElementData(localPlayer,"auto:poziom") == 3 then
if tonumber(getElementData(localPlayer,"dostawca:punkt")) >= 400 then
outputChatBox("Zakupiles auto yosemite", 255, 255, 0,true)
triggerServerEvent("auto:yosemite", localPlayer, localPlayer)
else
outputChatBox("Masz za malo punktow na to.", 255, 255, 255,true)
end
else if isMouseInPosition(670*z, 570*y, 24*z, 24*y) and getElementData(localPlayer,"gracz:poziom") == 2 then
ToWszys = getElementData(localPlayer,"dostawca:punkt") or 0
if ToWszys >= 1 then
triggerServerEvent("Dodaj:BonusL4", localPlayer, localPlayer)
Text = "#04fb00Dodałeś do zarobków 1$ \n Odjęto ci 1 Punkt Pracy"
		setTimer (function() 
Text = ""
		end,2*1000,1)
else
Text = "#ff0000Masz za mało punktów na zakup \n Nie posiadasz 1 Punktów Pracy"
		setTimer (function() 
Text = ""
		end,2*1000,1)
end
else if isMouseInPosition(680*z, 640*y, 34*z, 34*y) and getElementData(localPlayer,"gracz:poziom") == 2 then
ToWszys = getElementData(localPlayer,"dostawca:punkt") or 0
if ToWszys >= 10 then
triggerServerEvent("Dodaj:BonusK4", localPlayer, localPlayer)
Text = "#04fb00Dodałeś do zarobków 10$ \n Odjęto ci 10 Punktów Pracy"
		setTimer (function() 
Text = ""
		end,2*1000,1)
else
Text = "#ff0000Masz za mało punktów na zakup \n Nie posiadasz 10 Punktów Pracy"
		setTimer (function() 
Text = ""
		end,2*1000,1) 
end
end

end
end
end
end
end
end)

function getPosCommand(cmd, playerName)
	local player, sentenceStart

	if playerName then
		player = getPlayerFromName(playerName)
		if not player then
			errMsg('There is no player named "' .. playerName .. '".')
			return
		end
		playerName = getPlayerName(player)		-- make sure case is correct
		sentenceStart = playerName .. ' is '
	else
		player = localPlayer
		sentenceStart = ''
	end

	local px, py, pz = getElementPosition(player)
	local vehicle = getPedOccupiedVehicle(player)
	if vehicle then
	else
	end
               dziwka = getElementDimension(player)
		szmata = getElementInterior(player)
	outputChatBox(sentenceStart .. '{' .. string.format("%.2f", px) .. ', ' .. string.format("%.2f", py) .. ', ' .. string.format("%.2f", pz) .. '},', 255, 255, 255)
	outputChatBox(""..dziwka.." dim "..szmata.." int", 255, 255, 255)
end
addCommandHandler('gp', getPosCommand)

local function finishJob(missionValue)
    if isElement(missionBlip) then
        destroyElement(missionBlip)
        missionBlip=nil
    end
    if isElement(missionPickup) then
        destroyElement(missionPickup)
        missionPickup=nil
    end
    if missionValue then
        setElementData(localPlayer,"gracz:praca",false)
		outputChatBox("#ffffffPraca Dostawcy została zakończona pomyślnie.#ff0054 Wykonał: Rodzaje",255,255,255,true)
        triggerServerEvent("mower:stopJOB", localPlayer, missionVehicle)
        missionVehicle=nil
        missionPickup=nil
        missionBlip=nil
    end
end

addEventHandler("onClientVehicleExit",root,function (plr,seat)
if plr == localPlayer and seat == 0 and source == missionVehicle then
local vh = missionVehicle
finishJob(missionVehicle)
end
end)


function showMarker()
    el=localPlayer
    veh=getPedOccupiedVehicle(el)
    if not getPedOccupiedVehicle(el) then return end
    if getVehicleController(veh) == el then
        rnd=missionPoints[math.random(#missionPoints)]
        missionPickup=createMarker(rnd[1], rnd[2], rnd[3],"checkpoint",4,25,200,55)
        missionBlip=createBlip(rnd[1], rnd[2], rnd[3], 12)
        addEventHandler("onClientMarkerHit", missionPickup, function(el,md)
		outputChatBox("#ffffffUdaj się do następnego punktu zaznaczonym na mapie blipem różowego 'C'!",0,255,0,true)
            if el~=localPlayer then return end
            triggerServerEvent("kamienio:placenie", localPlayer, 50)
            finishJob(false)
            showMarker()
        end)
    end
end

addEvent("mower:startJOB", true)
addEventHandler("mower:startJOB", resourceRoot, function(veh)
	outputChatBox("#ffffffUdaj się do punktu zaznaczonym na mapie blipem różowego 'C'!",255,255,255,true)
    missionVehicle=veh
    showMarker()
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
    if getElementData(localPlayer,"gracz:praca") and getElementData(localPlayer,"gracz:praca") == "Kamieniolom" then
        setElementData(localPlayer,"gracz:praca",false)
    end
end)
