Shared = {
    versionCheck = true,
    
    Price = 250, -- How much it cost to create a information marker, set to false if you want it to be free.

    Distance = 30.0, 

    MarkerSize = {x = 0.5, y = 0.5, z = 0.5},
    
    MarkerColor = {r = 255, g = 255, b = 0, a = 100},  -- dont change the A color.

    Commands = {
        infomarker = {
            'createmarker',
            'cim',
            'infomarker'
        },
        delete = { -- Staff command to open marker menu
            'dim',
            'deletecim'
        }
    },

    -- ESX only, QBCore uses ace perms.
    Staffgroups = {
        'admin',
        'superadmin'
    }
}

-- Runs at 0 resmon, 00.3 near markers.