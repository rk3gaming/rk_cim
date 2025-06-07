if Shared.versionCheck then lib.versionCheck('rk3gaming/rk_cim') end

if GetCurrentResourceName() ~= 'rk_cim' then
    while true do
        print('^1[ERROR] This resource must be named rk_cim!^7')
        Wait(10000)
    end
end
