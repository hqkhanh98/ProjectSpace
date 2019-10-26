-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
local incShip = require "Scripts.Sheets.ship-blue"

local M = {}

function M.create( ship, options )

  local options = options or {}
  local x = options.x or 160
  local y = options.y or 200
  local w = options.w or 20
  local h = options.h or 30
  local type = options.type or "normal"
  local name = options.name or "Dranger"

  local path = options.path or "Assets/Images/ship-blue.png"
  local sheet = graphics.newImageSheet( path, incShip:getSheet() )

  ship = display.newSprite( sheet , { frames={ 4 } } )
  ship.x, ship.y = x, y

  function onDrag( event )

  	local check = event.phase

  	if ( "began" == check ) then
  		--display.currentStage:setFocus( ship ) -- Set touch focus on the ship
  		ship.touchOffsetX = event.x - ship.x -- Store initial offset position
      ship.touchOffsetY = event.y - ship.y
  	elseif ( "moved" == check ) then
  		-- Move the ship to the new touch position
  		ship.x = event.x - ship.touchOffsetX
  	  ship.y = event.y - ship.touchOffsetY
  	elseif ( "ended" == check or "cancelled" == check ) then
  		-- Release touch focus on the ship
  		--display.currentStage:setFocus( nil )
  	end -- End if check
  	return true
  end
  if type == "normal" then
      Runtime:addEventListener( "touch", onDrag )
  elseif type == "figure" then

  end

  return ship
end

return M
