local markers = {}

ShowMarkerInfo = function(markerData)
    TriggerEvent('chat:addMessage', {
        multiline = true,
        args = {'^4[INFO]', string.format('^3[%s] ^7%s', markerData.data.formatted_date, markerData.data.description)}
    })
end

LoadMarkers = function()
    local result = lib.callback.await('rk_cim:getMarkers', false)
    if result then
        for _, markerData in ipairs(result) do
            local coords = json.decode(markerData.coords)
            local marker = lib.marker.new({
                type = 32,
                coords = coords,
                color = Shared.MarkerColor,
                width = Shared.MarkerSize.x,
                height = Shared.MarkerSize.y
            })
            markers[markerData.id] = {
                marker = marker,
                data = markerData
            }
        end
    end
end

CreateMarker = function(coords, description, days)
    local id, markerData = lib.callback.await('rk_cim:createMarker', false, {
        coords = coords,
        description = description,
        days = tonumber(days)
    })

    if id then
        local marker = lib.marker.new({
            type = 32,
            coords = coords,
            color = Shared.MarkerColor,
            width = Shared.MarkerSize.x,
            height = Shared.MarkerSize.y
        })
        markers[id] = {
            marker = marker,
            data = markerData
        }
        return true
    else
        if markerData == 'not_enough_money' then
            lib.notify({
                title = 'Information Marker',
                description = 'You don\'t have enough money',
                type = 'error'
            })
        else
            lib.notify({
                title = 'Information Marker',
                description = 'Failed to create marker',
                type = 'error'
            })
        end
        return false
    end
end

DrawMarkers = function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local hasNearbyMarkers = false

    for id, markerData in pairs(markers) do
        local markerCoords = markerData.marker.coords
        local distance = #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(markerCoords.x, markerCoords.y, markerCoords.z))
        
        if distance <= Shared.Distance then
            hasNearbyMarkers = true
            markerData.marker:draw()
            
            if distance <= 1.5 and not markerData.data.shown then
                ShowMarkerInfo(markerData)
                markerData.data.shown = true
            elseif distance > 1.5 and markerData.data.shown then
                markerData.data.shown = false
            end
        end
    end

    return hasNearbyMarkers
end

RemoveMarker = function(markerId)
    if markers[markerId] then
        markers[markerId] = nil
    end
end

return {
    markers = markers,
    LoadMarkers = LoadMarkers,
    CreateMarker = CreateMarker,
    DrawMarkers = DrawMarkers,
    RemoveMarker = RemoveMarker
}
