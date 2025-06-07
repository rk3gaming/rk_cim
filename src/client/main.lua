local func = require('src.client.functions')

CreateThread(function()
    func.LoadMarkers()
end)

CreateThread(function()
    while true do
        local hasNearbyMarkers = func.DrawMarkers()
        Wait(hasNearbyMarkers and 0 or 1000)
    end
end)

RegisterNetEvent('rk_cim:showMarkersMenu', function(options)
    local isStaff = lib.callback.await('rk_cim:checkStaff', false)
    if not isStaff then
        lib.notify({
            title = 'Information Marker',
            description = 'You do not have permission to view markers',
            type = 'error'
        })
        return
    end

    local menuOptions = {}
    
    for _, option in ipairs(options) do
        table.insert(menuOptions, {
            title = option.title,
            description = option.description,
            onSelect = function()
                local success = lib.callback.await('rk_cim:deleteMarker', false, option.markerId)
                if success then
                    lib.notify({
                        title = 'Information Marker',
                        description = 'Marker deleted successfully',
                        type = 'success'
                    })
                else
                    lib.notify({
                        title = 'Information Marker',
                        description = 'Failed to delete marker',
                        type = 'error'
                    })
                end
            end
        })
    end

    lib.registerContext({
        id = 'markers_menu',
        title = 'Information Markers',
        options = menuOptions
    })

    lib.showContext('markers_menu')
end)

RegisterNetEvent('rk_cim:markerDeleted', function(markerId)
    func.RemoveMarker(markerId)
    if lib.getOpenMenu() == 'markers_menu' then
        TriggerServerEvent('rk_cim:refreshMarkers')
    end
end)
