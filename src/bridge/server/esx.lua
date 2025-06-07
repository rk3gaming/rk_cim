if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

IsStaff = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    for _, group in ipairs(Shared.Staffgroups) do
        if xPlayer.getGroup() == group then
            return true
        end
    end
    return false
end

RemoveMoney = function(source, amount)
    local success, response = exports.ox_inventory:RemoveItem(source, 'money', amount)
    if not success then
        if response == 'not_enough_items' then
            return false, 'not_enough_money'
        end
        return false, 'error'
    end
    return true
end

return {
    IsStaff = IsStaff,
    RemoveMoney = RemoveMoney
}
        