
addEvent("KlasyZapis", true)
addEventHandler("KlasyZapis", getRootElement(), function(liczba)
    exports.mysql:query_assoc("UPDATE characters SET Klasa='"..liczba.."' WHERE charactername='" ..getPlayerName(source).. "' LIMIT 1")
outputChatBox(""..liczba.."",source,255,255,0,true)
setCameraTarget (source)
end)

function StatystykiPanel()
b = exports.sql:query_assoc_single("SELECT banco FROM characters WHERE characterID = " .. exports.players:getCharacterID ( source ))
g = exports.sql:query_assoc_single("SELECT horas FROM characters WHERE characterID = " .. exports.players:getCharacterID ( source ))
w = exports.sql:query_assoc_single("SELECT edad FROM characters WHERE characterID = " .. exports.players:getCharacterID ( source ))
p = exports.sql:query_assoc_single("SELECT genero FROM characters WHERE characterID = " .. exports.players:getCharacterID ( source ))
setElementData(source,"godziny",g.horas)
setElementData(source,"bank",b.banco)
setElementData(source,"wiek",w.edad)
setElementData(source,"plec",p.genero)
end
addEvent("StatystykiPanel",true)
addEventHandler("StatystykiPanel",getRootElement(),StatystykiPanel)


function JapierdolewSoboteznowuegazm(mysql)
mysql = exports.interiors:getInteriorsTipo(source, 2)
triggerClientEvent(source, "Biznesy", source, mysql)
end
addEvent("JapierdolewSoboteznowuegazm",true)
addEventHandler("JapierdolewSoboteznowuegazm",getRootElement(),JapierdolewSoboteznowuegazm)


function NowyPoczatr()
sql = exports.sql:query_assoc("SELECT * FROM vehicles WHERE inactivo = 0 AND characterID = "..exports.players:getCharacterID(source))
triggerClientEvent(source, "ToRozpierdalaMozg", source, sql)
end
addEvent("NowyPoczatr",true)
addEventHandler("NowyPoczatr",getRootElement(),NowyPoczatr)


function quitPlayer ( quitType )
    if source and quitType then
        if quitType == "Quit" then
opis=createElement("text")
                        x, y, z = getElementPosition(source)
setElementPosition(opis, x,y,z)
      local time = getRealTime()
      local hours = time.hour
      local minutes = time.minute
formattedTime = string.format("%02d:%02d", hours, minutes)
                        setElementData(opis, "name","" .. getPlayerName(source):gsub("_", " ") .. " wyszedł z gry (Quit)\n "..formattedTime.."")
setTimer ( function()
        destroyElement(opis)
    end, 5*60*1000, 1 )
        elseif quitType == "Kicked" then
setElementData(opis, "name","" .. getPlayerName(source):gsub("_", " ") .. " wyszedł z gry (Kick)\n "..formattedTime.."")
setTimer ( function()
removeElementData(opis, "name")
    end, 2*60*1000, 1 )
        elseif quitType == "Banned" then
setElementData(opis, "name","" .. getPlayerName(source):gsub("_", " ") .. " wyszedł z gry (Ban)\n "..formattedTime.."")
setTimer ( function()
removeElementData(opis, "name")
    end, 1*60*1000, 1 )
        elseif quitType == "Bad Connection" or quitType == "Timed out" then
opis=createElement("text")
                        x, y, z = getElementPosition(source)
setElementPosition(opis, x,y,z)
      local time = getRealTime()
      local hours = time.hour
      local minutes = time.minute
formattedTime = string.format("%02d:%02d", hours, minutes)
                        setElementData(opis, "name","" .. getPlayerName(source):gsub("_", " ") .. " wyszedł z gry (Timed out)\n "..formattedTime.."")
setTimer ( function()
        destroyElement(opis)
    end, 5*60*1000, 1 )
        else
setElementData(opis, "name","" .. getPlayerName(source):gsub("_", " ") .. " wyszedł z gry (Reconnect)\n "..formattedTime.."")
setTimer ( function()
removeElementData(opis, "name")
    end, 3*60*1000, 1 )
        end
    end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

local commandSpam = {}

addEventHandler("onPlayerCommand", root,
    function(cmd)
        if getElementData(source, "Lepkazielona") then
            cancelEvent()
            outputChatBox("Jesteś wyciszony.", source, 255, 0, 0,true)
            return
        end
        if (not commandSpam[source]) then
            commandSpam[source] = 1
        elseif (commandSpam[source] >= 5) and (commandSpam[source] < 7)then
            cancelEvent()
            outputChatBox("Spam komendami.", source, 255, 0, 0)
            commandSpam[source] = commandSpam[source]+1
        elseif (commandSpam[source] >= 8) then
            cancelEvent()
            commandSpam[source] = nil
            setElementData(source, "Lepkazielona", true)
            outputChatBox("Zostałeś wyciszony przez 15 sekund przez spam.", source, 255, 0, 0)
            outputChatBox("Zostaniesz powiadomiony, kiedy będziesz mógł ponownie użyć poleceń.", source, 255, 255, 255)
            setTimer(function(source)
                removeElementData(source, "Lepkazielona")
                outputChatBox("Możesz znowu mówić. Nie spam ponownie!", source, 0, 255, 0)
                end, 15000, 1, source)
        else
            commandSpam[source] = commandSpam[source]+1
        end
    end
)
setTimer(function() commandSpam = {} end, 1000, 0)

function SprawdzPing(player)
    nPing = 0
    nPing2 = 0
    for k, v in ipairs(getElementsByType("player")) do
        nPing = nPing+getPlayerPing(v)
        nPing2 = nPing2+1
    end
    outputChatBox("Twoj ping "..tostring(math.floor(nPing/nPing2))..".", player, 0, 255, 0)
end
addCommandHandler("ping", SprawdzPing)