Shared = {
    versionCheck = true,
    
    Price = 250, -- How much it cost to create a information marker, set to false if you want it to be free.

    Distance = 30.0, -- How close you should be to a marker for it to render

    MarkerSize = {x = 0.5, y = 0.5, z = 0.5}, -- why would you change this?
     
    MarkerColor = {r = 255, g = 255, b = 0, a = 100},  -- Use this website for colors https://rgbacolorpicker.com/ 

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
