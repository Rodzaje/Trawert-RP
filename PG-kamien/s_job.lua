m=createMarker(780.26, -1020.73, 26.36-1, "cylinder", 1.2, 100,255,200,25)
mRodxa=createMarker(695.60, 1779.01, 7.34-1, "cylinder", 1.2, 100,255,200,25)




function ZagladaszDoMoich(trest)
losuj = math.random(1,2)
exports.global:giveMoney(source, trest + (getElementData(source, "auto:pozi") or 1))
setElementData(source, "dostawca:punkty", (getElementData(source, "dostawca:punkty") or 0)+1)
setElementData(source, "dostawca:punkt", (getElementData(source, "dostawca:punkt") or 0)+losuj)
exports.mysql:query_free("UPDATE characters SET celebryta='"..getElementData(source, "dostawca:punkty").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
exports.mysql:query_free("UPDATE characters SET dostawcaP='"..getElementData(source, "dostawca:punkt").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
end
addEvent("kamienio:placenie",true)
addEventHandler("kamienio:placenie",getRootElement(),ZagladaszDoMoich)

addEvent("mower:stopJOB", true)
addEventHandler("mower:stopJOB", root, function(veh)
	if not veh then return end
	destroyElement(veh)
end)

addEvent("Dodaj:BonusL4", true)
addEventHandler("Dodaj:BonusL4", getRootElement(), function()
setElementData(source, "auto:pozi", (getElementData(source, "auto:pozi") or 1)+1)
setElementData(source, "dostawca:punkt", (getElementData(source, "dostawca:punkt") or 0)-1)
exports.mysql:query_free("UPDATE characters SET dostawcaP='"..getElementData(source, "dostawca:punkt").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
exports.mysql:query_free("UPDATE characters SET dosMNOZNIK='"..getElementData(source, "auto:pozi").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
end)

addEvent("Dodaj:BonusK4", true)
addEventHandler("Dodaj:BonusK4", getRootElement(), function()
setElementData(source, "auto:pozi", (getElementData(source, "auto:pozi") or 1)+10)
setElementData(source, "dostawca:punkt", (getElementData(source, "dostawca:punkt") or 0)-10)
exports.mysql:query_free("UPDATE characters SET dostawcaP='"..getElementData(source, "dostawca:punkt").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
exports.mysql:query_free("UPDATE characters SET dosMNOZNIK='"..getElementData(source, "auto:pozi").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
end)



addEvent("auto:benson", true)
addEventHandler("auto:benson", getRootElement(), function()
if exports.players:takeMoney(source, 200) then
outputChatBox("Kupiłeś auto Benson",source,255,255,255,true)
setElementData(source,"auto:pozio", 1)
exports.mysql:query_free("UPDATE characters SET dostawcaA='"..getElementData(source, "auto:pozio").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
else
outputChatBox("Nie posiadasz wystarczającej ilości pieniedzy",source,255,255,0,true)
end
end)

addEvent("auto:bobcat", true)
addEventHandler("auto:bobcat", getRootElement(), function()
setElementData(source, "dostawca:punkt", (getElementData(source, "dostawca:punkt") or 0)-200)
setElementData(source,"auto:pozio", 2)
exports.mysql:query_free("UPDATE characters SET dostawcaA='"..getElementData(source, "auto:pozio").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
exports.mysql:query_free("UPDATE characters SET dostawcaP='"..getElementData(source, "dostawca:punkt").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
end)

addEvent("auto:yosemite", true)
addEventHandler("auto:yosemite", getRootElement(), function()
setElementData(source, "dostawca:punkt", (getElementData(source, "dostawca:punkt") or 0)-400)
setElementData(source,"auto:pozio", 3)
exports.mysql:query_free("UPDATE characters SET dostawcaA='"..getElementData(source, "auto:pozio").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
exports.mysql:query_free("UPDATE characters SET dostawcaP='"..getElementData(source, "dostawca:punkt").."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
end)

function opuscilmarker(gracz)
	if getElementType(gracz) == "player" then
		triggerClientEvent(gracz, "client.wyszedl",gracz)
		unbindKey ( gracz, "h", "down", TworzyszZAczynasz)
	end
end
addEventHandler("onMarkerLeave", m, opuscilmarker)
function sex(el)
if getElementType(el) == "player" then
		triggerClientEvent(el, "BrajankRP:Panel",el)
		bindKey(el,"h", "down", TworzyszZAczynasz)
end
end
addEventHandler("onMarkerHit", m, sex)
addEventHandler("onMarkerHit", mRodxa, sex)

function ZdolnosciWyzsze()
currentGC = exports.mysql:query_fetch_assoc("SELECT `celebryta` FROM `characters` WHERE `charactername`='"..getPlayerName(source).."'  LIMIT 1")["celebryta"]
currentG = exports.mysql:query_fetch_assoc("SELECT `dostawcaP` FROM `characters` WHERE `charactername`='"..getPlayerName(source).."'  LIMIT 1")["dostawcaP"]
current = exports.mysql:query_fetch_assoc("SELECT `dostawcaA` FROM `characters` WHERE `charactername`='"..getPlayerName(source).."'  LIMIT 1")["dostawcaA"]
curren = exports.mysql:query_fetch_assoc("SELECT `dosMNOZNIK` FROM `characters` WHERE `charactername`='"..getPlayerName(source).."'  LIMIT 1")["dosMNOZNIK"]
curre = exports.mysql:query_fetch_assoc("SELECT `sila` FROM `characters` WHERE `charactername`='"..getPlayerName(source).."'  LIMIT 1")["sila"]

  		setElementData(source,"sila", curre)
  		setElementData(source,"dostawca:punkty", currentGC)
setElementData(source,"dostawca:punkt", currentG)
setElementData(source,"auto:pozio", current)
setElementData(source,"auto:pozi", curren)
end
addEventHandler("accounts:characters:spawn", getRootElement(), ZdolnosciWyzsze)

blip2T = {}
marker2T = {}

addEvent("We2zwanie:legalne", true)
addEventHandler("We2zwanie:legalne", getRootElement(), function(el)
	zapotrzebowanie = false
	local vehicle = getPedOccupiedVehicle(el)
	local x, y, z = getElementPosition(el)
				local sql = exports.sql:query_assoc("SELECT * FROM interiors ORDER BY productos ASC")
		for k, v in ipairs(sql) do
			if v and v.interiorID and exports.interiors:isTienda(v.interiorID) == true and zapotrzebowanie == false and v.productos <= 6000 and (v.interiorType == 0 or (v.interiorType == 2 and v.characterID > 0)) then
				zapotrzebowanie = true
				setElementData(el, "int.reparto", tonumber(v.interiorID))
				outputChatBox("Sklep '"..tostring(v.interiorName).."' potrzebuje produktów.", el, 255, 255, 0,true)
				blip2T[el] = createBlip(v.dropoffX, v.dropoffY, v.dropoffZ, 34, 2, 0, 0, 255, 255, 0, 99, el)
				marker2T[el] = createMarker(v.dropoffX, v.dropoffY, v.dropoffZ-1, "cylinder", 8, 255, 255, 255, 127, el)
				addEventHandler("onMarkerHit", marker2T[el], repartoListo2)
				setElementParent(blip2T[el], marker2T[el])
				local idveh = getElementData(vehicle, "idveh")
				setElementData(el, "idtransporte", tonumber(idveh))
				setElementData(vehicle, "driverTransport", getPlayerName(el))
			end	
		end
		if zapotrzebowanie == false then
			outputChatBox("(( Obecnie nie ma sklepów, które wymagają produktów))", el, 255, 0, 0,true) 
		end
end)

function TworzyszZAczynasz (el)
	if getElementType(el) == "player" then
		if getElementData(el,"auto:pozio") == 1 then
		veh=createVehicle(499,767.45, -1044.68, 23.95,355.3,358.2,180)
		warpPedIntoVehicle(el,veh)
		triggerClientEvent(el, "Straszne/Piekna", el)
setVehicleColor(veh,96, 254, 0)
else if getElementData(el,"auto:pozio") == 2 then
veh=createVehicle(422, 763.90, -1016.37, 24.10,355.3,358.2,180)
  		setElementData(veh,"temporary", true)
  		setElementData(veh,"spawnedBy", el)
		setVehicleColor(veh,5,20,225)
		setElementData(veh,"vehicle:mileage",0)
		setElementData(veh,"vehicle:fuel",50)
		warpPedIntoVehicle(el,veh)
		setElementData(el,"gracz:praca","Kamieniolom")
		triggerClientEvent(el, "mower:startJOB", resourceRoot, veh)
else if getElementData(el,"auto:pozio") == 3 then
veh=createVehicle(554, 763.90, -1016.37, 24.10,355.3,358.2,180)
		warpPedIntoVehicle(el,veh)
		triggerClientEvent(el, "mower:startJOB", resourceRoot, veh)
else
outputChatBox("Nie masz żadnego zakupionego auta",el,255,0,0,true)
end
end
end
	end
end
addEvent("rozpocznij:dostawca",true)
addEventHandler("rozpocznij:dostawca",getRootElement(),TworzyszZAczynasz)

function repartoListo2 (vehicle)
	if getElementType(vehicle) == "vehicle" then
		el = getVehicleController(vehicle)
		if source == marker2T[el] then
			if getElementData(el, "int.reparto") and getElementData(el, "int.reparto") > 0 then
				exports.interiors:giveProductos(getElementData(el, "int.reparto"), 50)
				removeElementData(el, "int.reparto")
				removeEventHandler("onMarkerHit", marker2T[el], repartoListo2)
				local idveh = getElementData(vehicle, "idveh")
				local idveh2 = getElementData(el, "idtransporte")
				if tonumber(idveh) ~= tonumber(idveh2) then
					outputChatBox("Ten pojazd nie jest tym, w którym przewozisz towar. Nieprawidłowa obsada.", el, 255, 0, 0)
					return
				end 
					outputChatBox("Dotarłeś na miejsce i zarobiłeś $"..tostring(math.floor(0.200*getElementHealth(vehicle)))..".", el, 0, 255, 0)
				    exports.players:giveMoney(el, math.floor(0.200*getElementHealth(vehicle)))
					exports.factions:giveFactionPresupuesto(7, 50)
					removeElementData(vehicle, "driverTransport")
				destroyElement(marker2T[el])
	zapotrzebowanie = false
	local vehicle = getPedOccupiedVehicle(el)
	local x, y, z = getElementPosition(el)
				local sql = exports.sql:query_assoc("SELECT * FROM interiors ORDER BY productos ASC")
		for k, v in ipairs(sql) do
			if v and v.interiorID and exports.interiors:isTienda(v.interiorID) == true and zapotrzebowanie == false and v.productos <= 6000 and (v.interiorType == 0 or (v.interiorType == 2 and v.characterID > 0)) then
				zapotrzebowanie = true
				setElementData(el, "int.reparto", tonumber(v.interiorID))
				outputChatBox("Sklep '"..tostring(v.interiorName).."' potrzebuje produktów.", el, 255, 255, 0,true)
				blip2T[el] = createBlip(v.dropoffX, v.dropoffY, v.dropoffZ, 34, 2, 0, 0, 255, 255, 0, 99, el)
				marker2T[el] = createMarker(v.dropoffX, v.dropoffY, v.dropoffZ-1, "cylinder", 8, 255, 255, 255, 127, el)
				addEventHandler("onMarkerHit", marker2T[el], repartoListo2)
				setElementParent(blip2T[el], marker2T[el])
				local idveh = getElementData(vehicle, "idveh")
				setElementData(el, "idtransporte", tonumber(idveh))
				setElementData(vehicle, "driverTransport", getPlayerName(el))
			end	
		end	
			end
		end
	end 
end

local function respawn()
  for i,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
    if not getVehicleController(v) then
    	destroyElement(v)
    end
  end
end
setTimer(respawn, 60000, 0)