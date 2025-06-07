fx_version ('cerulean')
game ('gta5')

author ({'rk'})
version ({'1.0.0'})

ui_page ({'web/build/dist/index.html'})

files ({
    'web/build/dist/**',
    'web/build/dist/assets/**',
    'src/**/*.lua'
})

shared_scripts ({
    '@ox_lib/init.lua',
    'shared.lua',
})

server_scripts ({
    'boot.lua',
    '@oxmysql/lib/MySQL.lua',
    'src/bridge/server/**',
    'src/server/**',
})

client_scripts ({
    'src/client/**'
})

dependencies ({
    'ox_lib',
    'oxmysql'
})

lua54 ('yes')