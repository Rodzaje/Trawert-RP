
dxfont0_AndikaNewBasicItalic = dxCreateFont("staty/AndikaNewBasic-Italic.ttf", 36)
dxfont1_AndikaNewBasicItalic = dxCreateFont("staty/AndikaNewBasic-Italic.ttf", 19)

mojeW,mojeH = 1920, 1080
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)
local sx, sy = guiGetScreenSize ()


function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

skalowanie={
    ["zamykanie"]={1135*w, 287*h, 27*w, 27*h},
    ["LilScarl"]={709*w, 277*h, 477*w, 564*h},
    ["Lepkazielona"]={786*w, 272*h, 876*w, 392*h},
    ["Bronks"]={722*w, 343*h, 876*w, 429*h},
    ["K3NNY"]={722*w, 372*h, 811*w, 456*h},
    ["BronksCzarnalista"]={920*w, 343*h, 1074*w, 429*h},


}

    function HomeGUI()
plec = getElementData(localPlayer,"plec")

	local properties = ""
	local numproperties = 0
	for key, value in ipairs(getElementsByType("interior")) do
		local interiorStatus = getElementData(value, "status")
		
		if interiorStatus[4] and interiorStatus[4] == dbid and getElementData(value, "name") then
			local id = getElementData(value, "dbid")
			properties = properties .. id .. ", "
			numproperties = numproperties + 1
		end
	end

        triggerServerEvent ( "StatystykiPanel", localPlayer)


	if (properties=="") then properties = "Brak.  " end
	if (plec==2) then 
plec = "Kobieta" 
end
	if (plec==1) then 
plec = "Mężczyzna" 
end

	money = getPlayerMoney ( )
        name = getPlayerName( localPlayer ):gsub( "_", " " )
               skin = getElementModel(localPlayer)
              bankmoney = getElementData(localPlayer,"bank") or 0
              hoursplayed = getElementData(localPlayer,"godziny")
              wiek = getElementData(localPlayer,"wiek")


        dxDrawImage(skalowanie["LilScarl"][1], skalowanie["LilScarl"][2], skalowanie["LilScarl"][3], skalowanie["LilScarl"][4], "staty/job_wigget_off.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(""..name.."", skalowanie["Lepkazielona"][1], skalowanie["Lepkazielona"][2], skalowanie["Lepkazielona"][3], skalowanie["Lepkazielona"][4], tocolor(255, 255, 255, 255), 1.00, dxfont0_AndikaNewBasicItalic, "center", "top", false, false, false, false, false)
        dxDrawText("Gotówka:", skalowanie["Bronks"][1], skalowanie["Bronks"][2], skalowanie["Bronks"][3], skalowanie["Bronks"][4], tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Bank:", skalowanie["K3NNY"][1], skalowanie["K3NNY"][2], skalowanie["K3NNY"][3], skalowanie["K3NNY"][4], tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText(""..money.."$", skalowanie["BronksCzarnalista"][1], skalowanie["BronksCzarnalista"][2], skalowanie["BronksCzarnalista"][3], skalowanie["BronksCzarnalista"][4], tocolor(11, 237, 11, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, true, false)
        dxDrawText("Czas gry:", 719*w, 402*h, 861*w, 507*h, tocolor(169, 177, 250, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Ubranie:", 722*w, 433*h, 811*w, 517*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText(""..skin.."", 920*w, 435*h, 1062*w, 540*h, tocolor(253, 212, 146, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Dane podstawowe:", 722*w, 507*h, 811*w, 591*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText(""..plec..", "..wiek.." lat", 920*w, 507*h, 1009*w, 591*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Typ postaci:", 719*w, 550*h, 885*w, 662*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Cywilna", 920*w, 550*h, 1009*w, 634*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("", 722*w, 596*h, 791*w, 642*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("", 920*w, 601*h, 1009*w, 685*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Nieruchomości:", 722*w, 644*h, 791*w, 690*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("" .. string.sub(properties, 1, string.len(properties)-2).."", 920*w, 644*h, 1009*w, 728*h, tocolor(255, 255, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Potrzeby:", 719*w, 672*h, 881*w, 786*h, tocolor(252, 193, 98, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawImage(791*w, 654*h, 75*w, 75*h, "staty/level2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(""..(getElementData(localPlayer,"hambre") or 0).." głodu", 920*w, 672*h, 1009*w, 756*h, tocolor(255, 75, 75, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText(""..(getElementData(localPlayer,"sed") or 0).." pragnienia", 920*w, 702*h, 1009*w, 786*h, tocolor(75, 75, 255, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText(""..(getElementData(localPlayer,"cansancio") or 0).." energii", 920*w, 729*h, 1009*w, 813*h, tocolor(75, 255, 75, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText("Atrybuty:", 719*w, 756*h, 881*w, 870*h, tocolor(252, 193, 98, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawImage(801*w+10, 754*h, 48*w, 49*h, "staty/book_icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(""..getPedStat(localPlayer, 23).." siły", 920*w, 757*h, 1009*w, 841*h, tocolor(198, 216, 2, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
        dxDrawText(""..getPedStat(localPlayer, 21).." staminy", 920*w, 786*h, 1009*w, 870*h, tocolor(216, 155, 2, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
if bankmoney then
        dxDrawText(""..bankmoney.."$", 920*w, 372*h, 1074*w, 458*h, tocolor(11, 237, 11, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, true, false)
end
if hoursplayed then
    dxDrawText(""..hoursplayed.."h", 920*w, 402*h, 1062*w, 507*h, tocolor(169, 177, 250, 255), 1.00, dxfont1_AndikaNewBasicItalic, "left", "top", false, false, false, false, false)
end
if mysz(skalowanie["zamykanie"][1], skalowanie["zamykanie"][2], skalowanie["zamykanie"][3], skalowanie["zamykanie"][4]) then
        dxDrawImage(skalowanie["zamykanie"][1], skalowanie["zamykanie"][2], skalowanie["zamykanie"][3], skalowanie["zamykanie"][4], "staty/x.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
else
        dxDrawImage(skalowanie["zamykanie"][1], skalowanie["zamykanie"][2], skalowanie["zamykanie"][3], skalowanie["zamykanie"][4], "staty/x.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end
if mysz(1150*w, 654*h, 190*w, 190*h) then
        dxDrawImage(1150*w, 654*h, 190*w, 190*h, "staty/level3.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
else
                dxDrawImage(1150*w, 654*h, 190*w, 190*h, "staty/level3.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

if mysz(1150*w, 654*h-150, 190*w, 190*h) then
                dxDrawImage(1150*w, 654*h-150, 190*w, 190*h, "staty/upgrade_engine.png", 0, 0, 0, tocolor(255, 0,0, 255), false)

else
        dxDrawImage(1150*w, 654*h-150, 190*w, 190*h, "staty/upgrade_engine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

    end

function escapeMe()
addEventHandler("onClientRender", root,HomeGUI)
end
addCommandHandler ( "stats", escapeMe )
addCommandHandler ( "staty", escapeMe )

    addEventHandler("onClientClick", getRootElement(), function(btn, state)
        if not isEventHandlerAdded("onClientRender", root,HomeGUI) then return end
        if btn == "left" and state == "down" then return end
if mysz(skalowanie["zamykanie"][1], skalowanie["zamykanie"][2], skalowanie["zamykanie"][3], skalowanie["zamykanie"][4]) then
removeEventHandler("onClientRender", root,HomeGUI)
end
if mysz(1150*w, 654*h, 190*w, 190*h) then
removeEventHandler("onClientRender", root,HomeGUI)
triggerServerEvent ( "NowyPoczatr", localPlayer)
end
if mysz(1150*w, 654*h-150, 190*w, 190*h) then
removeEventHandler("onClientRender", root,HomeGUI)
triggerServerEvent ( "JapierdolewSoboteznowuegazm", localPlayer)
addEventHandler("onClientRender", root,SmutnaMuzylka)
end

end)

    addEventHandler("onClientClick", getRootElement(), function(btn, state)
        if not isEventHandlerAdded("onClientRender", root,SmutnaMuzylka) then return end
        if btn == "left" and state == "down" then return end
if mysz(1150*w, 654*h, 190*w, 190*h) then
removeEventHandler("onClientRender", root,SmutnaMuzylka)
dxGrid:Destroy (gridlist)
destroyElement ( playerList )
destroyElement ( gridlist )
end
end)

playerList = nil
gridlist = nil

function SmutnaMuzylka()
if mysz(1150*w, 654*h, 190*w, 190*h) then
        dxDrawImage(1150*w, 654*h, 190*w, 190*h, "staty/upgrade_engine.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
else
                dxDrawImage(1150*w, 654*h, 190*w, 190*h, "staty/upgrade_engine.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end
end

function ToRozpierdalaMozg(data)
addEventHandler("onClientRender", root,SmutnaMuzylka)
local screen_size = { guiGetScreenSize( ) } 
gridlist = dxGrid:Create ( ( screen_size[1] / 2 ) - 250, ( screen_size[2] / 2 ) - 150, 500, 300 ); 
  gridlist:AddColumn ( "ID", 50 ) 
gridlist:AddColumn ( "Model", 400 ) 
	for k, v in ipairs(data) do
    gridlist:AddItem ( 1, tostring(v.vehicleID) ) 
    gridlist:AddItem ( 2, tostring(getVehicleNameFromModel(v.model)) ) 
end

end
addEvent("ToRozpierdalaMozg",true)
addEventHandler("ToRozpierdalaMozg",getRootElement(),ToRozpierdalaMozg)

DGS = exports.dgs
function Biznesy(data)
playerList = DGS:dgsCreateGridList (346, 163, 433, 403, false )
local column = DGS:dgsGridListAddColumn( playerList, "Nieruchomości", 0.5 )
	for k, v in ipairs(data) do
	row = DGS:dgsGridListAddRow ( playerList )
	DGS:dgsGridListSetItemText ( playerList, row, column, tostring(v.interiorName) )
end
end
addEvent("Biznesy",true)
addEventHandler("Biznesy",getRootElement(),Biznesy)


