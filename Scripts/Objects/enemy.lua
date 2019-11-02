local E = {}

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



function E.create( options )
  local options = options or {}
  local x = options.x or 150
  local y = options.y or 150
  local height = options.h or 30
  local width = options.w or 30
  local type = options.type or "normal"

  local enemy = display.newGroup()
  enemy.display = display.newCircle( enemy, x, y, 10 )
  enemy.display.name = "enemy"
  enemy.display.hp = 4
  physicsCreate()
  physics.addBody( enemy.display, "dynamic", { isSensor = true } )

  function enemy.display:collision( event )
    if ( event.phase == "began" ) then
      local enemy = event.target
      local other = event.other

      if enemy.name == "enemy" and other.name == "bullet" then
        if enemy.hp > 0 then
          enemy.hp = enemy.hp - 1
        else
          destroy(enemy)
        end
      elseif enemy.name == "enemy" and other.name == "enemy" then
        print("cham")
      end
    end
  end
  enemy.display:addEventListener('collision')

    function destroy( object )
      object:removeEventListener('collision')
      display.remove( object )
      object = nil
    end
  return enemy
end

return E
