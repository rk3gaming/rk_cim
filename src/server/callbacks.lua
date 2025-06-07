lib.callback.register('rk_cim:getMarkers', function(source)
    local result = MySQL.query.await('SELECT *, DATE_FORMAT(created_at, "%Y-%m-%d") as formatted_date FROM cim_markers WHERE expires_at > NOW()')
    return result
end)

lib.callback.register('rk_cim:createMarker', function(source, data)
    if Shared.Price then
        local success, response = RemoveMoney(source, Shared.Price)
        if not success then
            return false, response
        end
    end

    local coords = json.encode(data.coords)
    local description = data.description
    local days = data.days
    local created_by = GetPlayerName(source)
    local expires_at = os.date('%Y-%m-%d %H:%M:%S', os.time() + (days * 86400))

    local id = MySQL.insert.await('INSERT INTO cim_markers (coords, description, days, created_by, expires_at) VALUES (?, ?, ?, ?, ?)',
        {coords, description, days, created_by, expires_at}
    )
    
    if id then
        local result = MySQL.query.await('SELECT *, DATE_FORMAT(created_at, "%Y-%m-%d") as formatted_date FROM cim_markers WHERE id = ?', {id})
        if result and result[1] then
            return id, result[1]
        end
    end
    return false, 'error'
end)

lib.callback.register('rk_cim:checkStaff', function(source)
    return IsStaff(source)
end)

lib.callback.register('rk_cim:deleteMarker', function(source, markerId)
    if not IsStaff(source) then
        return false, 'no_permission'
    end

    markerId = tonumber(markerId)
    if not markerId then
        return false, 'invalid_id'
    end

    local success = MySQL.update.await('DELETE FROM cim_markers WHERE id = ?', {markerId})
    if success then
        TriggerClientEvent('rk_cim:markerDeleted', -1, markerId)
        return true
    end
    return false, 'error'
end)