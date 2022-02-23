ESX, JEtsitty, wait = nil, {}, 0

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(wait)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

local roskikset = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b'
}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local wait = 1000
        for k,v in pairs(roskikset) do 
            local ped = PlayerPedId()
            local PPed = GetEntityCoords(ped)
            local LObjecti = GetClosestObjectOfType(PPed, 1.0, GetHashKey(v), false, false, false)
            local PObject = GetEntityCoords(LObjecti)
            if DoesEntityExist(LObjecti) then
                wait = 0
                ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ Tutkiaksesi roskista')
                if IsControlJustPressed(0, 38) then
                    if not JEtsitty[LObjecti] then
                        if not IsPedInAnyVehicle(ped) then
                            JEtsitty[LObjecti] = true
                            ESX.ShowNotification('Aloitit tutkimaan roskista')
                            TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_SHOPPING_CART")
                            Citizen.Wait(math.random(1000*10, 1000*15))
                            TriggerServerEvent('esx_dyykkaus:palkkio')
                        else
                            ESX.ShowNotification('Autossako meinasit dyykata?!')
                        end
                    else
                        ESX.ShowNotification('Olet jo tutkinut tämän roskiksen')
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)