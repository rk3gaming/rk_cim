if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

IsStaff = function(source)
    return IsPlayerAceAllowed(source, 'dim')
end

RemoveMoney = function(source, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false, 'error' end

    if Player.PlayerData.money.cash >= amount then
        Player.Functions.RemoveMoney('cash', amount)
        return true
    elseif Player.PlayerData.money.bank >= amount then
        Player.Functions.RemoveMoney('bank', amount)
        return true
    else
        return false, 'not_enough_money'
    end
end

return {
    IsStaff = IsStaff,
    RemoveMoney = RemoveMoney
}

-- Not fully tested with qb-core. Because I don't care for shitcore.