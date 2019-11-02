-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )


local M = {}
local incShip = require "Scripts.Sheets.ship-blue"
local bullet = require "Scripts.Objects.bullet"
function display.newGroup2( insertInto )
	local group = display.newGroup()
	if( insertInto ) then insertInto:insert( group ) end
	return group
end


function M.create( options )

  local options = options or {}
  local x = options.x or 160
  local y = options.y or 200
  local w = options.w or 20
  local h = options.h or 30
  local type = options.type or "normal"
  local name = options.name or "Dranger"

  local path = options.path or "Assets/Images/ship-blue.png"
  local sheet = graphics.newImageSheet( path, incShip:getSheet() )
  local ship = display.newGroup()
  ship.display = display.newSprite( ship, sheet , { frames={ 4 } } )
  ship.display.x, ship.display.y = x, y
  ship.display.level = 3
  ship.display.speed = 300
  ship.canvas = display.newRect( ship, display.contentCenterX, display.contentCenterY, 360, 480 )
  ship.canvas.alpha = 0.1
  ship.canvas:toBack()
  function ship.canvas:touch( event )

  	local check = event.phase

  	if ( "began" == check ) then
  		--display.currentStage:setFocus( ship ) -- Set touch focus on the ship
  		ship.display.touchOffsetX = event.x - ship.display.x -- Store initial offset position
      ship.display.touchOffsetY = event.y - ship.display.y
  	elseif ( "moved" == check ) then
  		-- Move the ship to the new touch position
  		ship.display.x = event.x - ship.display.touchOffsetX
  	  ship.display.y = event.y - ship.display.touchOffsetY

  	elseif ( "ended" == check or "cancelled" == check ) then
  		-- Release touch focus on the ship
  		--display.currentStage:setFocus( nil )
  	end -- End if check
  	return true
  end
  ship.canvas:addEventListener( 'touch' )

  function ship.display:shoot()
    bullet = bullet.create({x = ship.display.x, y = ship.display.y}).display
    transition.to( bullet, { y = 0, time = 1000 } )
    ship:insert(bullet)
  end

  function destroyShip(object)
    object:removeEventListener('collision')
    display.remove( object )
    object = nil
  end
  return ship
end



return M
