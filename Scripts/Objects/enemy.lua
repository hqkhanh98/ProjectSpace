local E = {}
local enemyns = require "Scripts.Sheets.ship-blue"
function E.create( enemy, options )
    local options = options or {}
    local x = options.x or 0
    local y = options.y or 0
    local w = options.w or 50
    local h = options.h or 80
    local name = options.name or "giant"
    local enemy
    local enemyTable= {}

    local physics = require "physics"
    physics.start()

    local path = options.path or "Assets/Images/ship-blue.png"
    local sheet = graphics.newImageSheet( path, enemyns:getSheet() )

    local function createEnemy()
        -- enemy = display.newCircle( x  , y , 20 )
        -- table.insert( enemyTable, enemy )
        -- transition.to( enemy, {time = 1000, x = 300, y = 150 })
        --
        -- enemy = display.newCircle( x + 300  , y , 20 )
        -- transition.to( enemy, {time = 1000, x = 0, y = 150 })

        enemy = display.newSprite( sheet , { frames={  5} } )
        enemy.x = 100
        enemy.y = 50
        table.insert( enemyTable, enemy )

        transition.to( enemy, {time = 1000, x = 300, y = 150 })


      end
      -- createEnemy()
      bulletLoop = timer.performWithDelay( 1000, createEnemy, 0)













return enemy
end
return E
