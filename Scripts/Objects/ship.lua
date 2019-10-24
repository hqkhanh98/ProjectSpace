-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
local incShip = require "Scripts.Sheets.ship-blue"
local physics = require "physics"
physics.start()
local M = {}

function M.create( ship, options )

  local bullet_lv1
  local bullets = {}
  local options = options or {}
  local x = options.x or 160
  local y = options.y or 200
  local w = options.w or 50
  local h = options.h or 80
  local type = options.type or "normal"
  local name = options.name or "Dranger"

  local path = options.path or "Assets/Images/ship-blue.png"
  local sheet = graphics.newImageSheet( path, incShip:getSheet() )

  ship = display.newSprite( sheet , { frames={ 4 } } )
  ship.x, ship.y = x, y

  physics.addBody( bullet_lv1, "dynamic" )
  loop = timer.performWithDelay( 500, shipLoop, 0 )
  function shipLoop()
    bullet_lv1 = display.newSprite( sheet , { frames={ 9 } } )
    bullet_lv1.x, bullet_lv1.y = x,y

    --table.insert( bullets, bullet_lv1 )
    --bullet_lv1:applyForce( 0, 50, bullet_lv1.x, bullet_lv1.y )
  end

  return ship
end



return M
