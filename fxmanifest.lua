fx_version 'adamant'
game 'gta5'

description "FiveM script that allows you to communicate with the DataDog Api"
author "PABLO-1610"
version '1.0'
repository 'https://github.com/PABLO-1610/datadog-fivem'

server_scripts {
    -- Enum
    'src/enum/*.lua',
    -- Types
    'src/type/*.lua',
    -- Core
    'src/datadogapi.lua',
    -- Methods
    'src/api/get/*.lua',
    'src/api/post/*.lua',
    'src/api/put/*.lua',
    -- Library
    'src/lib/datadog.lua'
}

-- Example
-- server_script 'src/example/datadogapi_example.lua'

-- Testing
-- server_script 'test/server.lua'