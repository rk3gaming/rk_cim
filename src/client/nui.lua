local func = require 'src.client.functions'

RegisterNetEvent('rk_cim:open', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'setVisible',
        data = {
            show = true
        }
    })
end)

RegisterNUICallback('create', function(data, cb)
    local coords = GetEntityCoords(PlayerPedId())
    local success = func.CreateMarker(coords, data.description, data.days)

    if success then
        lib.notify({
            title = 'Information Marker',
            description = 'Marker created successfully',
            type = 'success'
        })
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'setVisible',
            data = {
                show = false
            }
        })
    end
    cb({})
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'setVisible',
        data = {
            show = false
        }
    })
    cb({})
end)