ESX = nil

local aseita = true -- Laita tämä false jos haluat että roskiksista ei voi löytää aseita
local random = 3 -- Montako itemiä haluat roskiksesta löytyvän (randomilla 0 - random) default 0 - 3 [esm random = 1 roskiksesta löytää max 1]


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local palkkiot = {
    '', -- {
    '',
    '',
    '', -- Listaa itemit tähän mitä haluat löytyvän roskiksista
    '',
    '',
    '', -- }
}

RegisterServerEvent('esx_dyykkaus:palkkio')
AddEventHandler('esx_dyykkaus:palkkio', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local palkkio = palkkiot[math.random(#palkkiot)]
    local maara = math.random(random)
    if xPlayer ~= nil then 
        xPlayer.addInventoryItem(palkkio, maara)
        TriggerClientEvent('esx:showNotification', source, 'Löysit roskiksesta ' .. maara .. 'X ' .. palkkio)
        ClearPedTasksImmediately(source)
        if aseita then 
            local chance = math.random(0, 100)
            if chance >= 0 and chance <= 0.5 then -- 0.50%
                xPlayer.addWeapon("WEAPON_KNIFE", 0)
                TriggerClientEvent('esx:showNotification', source, 'Löysit roskiksesta puukon')
            elseif chance >= 0.51 and chance <= 0.76 then -- 0.25%
                TriggerClientEvent('esx:showNotification', source, 'Löysit roskiksesta pistoolin')
                xPlayer.addWeapon("WEAPON_PISTOL", 200)
            end
        end
    end
end)
