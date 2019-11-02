local M = {}
local incShip = require "Scripts.Sheets.ship-blue"

local physics
local function physicsCreate( sleep, gx, gy )
  local sleep = sleep or 0
  local gx = gx or 0
  local gy = gy or 0
  physics = require "physics"
  physics.start( sleep )
  physics.setGravity( gx, gy )
end

local function physicsPause()
  physics.pause()
end

function M.create( options )

  local options = options or {}
  local x = options.x or 160
  local y = options.y or 200
  local w = options.w or 15
  local h = options.h or 25
  local type = options.type or "normal"

  local path = options.path or "Assets/Images/ship-blue.png"
  local sheet = graphics.newImageSheet( path, incShip:getSheet() )
  local bullet = display.newGroup()

  bullet.display = display.newSprite( sheet , { frames={ 11 } } )
  bullet.display:scale(0.8, 0.8)
  bullet.display.x, bullet.display.y = x, y - 50
  physicsCreate()
  bullet.display.name = "bullet"

  physics.addBody( bullet.display, "dynamic", {isSensor = true} )
  function bullet.display:collision(event)
    if event.phase == "began" then
      local bullet = event.target
      local other = event.other
      if bullet.name == "bullet" then
        destroyBullet(bullet)
      else

      end
    end
  end
  bullet.display:addEventListener('collision')
  function destroyBullet(object)
    object:removeEventListener('collision')
    display.remove( object )
    object = nil
  end
  return bullet
end

return M
