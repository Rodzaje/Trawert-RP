local nametagScale = 1
local nametagFont = dxCreateFont( "f/ArialCE.ttf", 11)

addEventHandler("onClientRender", root, function()
    local rootx, rooty, rootz = getCameraMatrix()
    for i, ped in ipairs(getElementsByType("ped",root,true)) do
        local name=getElementData(ped,"dane")
        if name then
            local x,y,z = getElementPosition(ped)
            local sx, sy = getScreenFromWorldPosition(x, y, z + 1)

            if sx then
                local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)

                local fX = sx
                local fY = sy

                local alpha = 120

                if(distance <= 8 and isLineOfSightClear(rootx,rooty,rootz,x,y,z,false,false,false)) then
                    dxDrawText(name, fX, fY, fX, fY, tocolor(255, 255, 255, 255), nametagScale, nametagFont, "center", "center")                    
                end
            end
        end
    end  
end)