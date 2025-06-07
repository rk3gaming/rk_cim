lib.addCommand(Shared.Commands.infomarker, {
    help = 'Create an information marker'
}, function(source)
    TriggerClientEvent('rk_cim:open', source)
end)

lib.addCommand(Shared.Commands.delete, {
    help = 'List all information markers',
    restricted = function(source)
        return IsStaff(source)
    end
}, function(source)
    if not IsStaff(source) then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Information Markers',
            description = 'You do not have permission to use this command',
            type = 'error'
        })
        return
    end

    local markers = MySQL.query.await('SELECT *, DATE_FORMAT(created_at, "%Y-%m-%d") as formatted_date FROM cim_markers WHERE expires_at > NOW()')
    if not markers or #markers == 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Information Markers',
            description = 'No active markers found',
            type = 'error'
        })
        return
    end

    local options = {}
    for _, marker in ipairs(markers) do
        table.insert(options, {
            title = string.format('Marker #%d - %s', marker.id, marker.description),
            description = string.format('Created by: %s\nCreated: %s\nExpires: %s', 
                marker.created_by, 
                marker.formatted_date,
                os.date('%Y-%m-%d', os.time() + (marker.days * 86400))
            ),
            markerId = marker.id
        })
    end

    TriggerClientEvent('rk_cim:showMarkersMenu', source, options)
end)

