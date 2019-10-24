-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
local incShip = require "Scripts.Sheets.ship-blue"
local M = {}

function M.create( ship, options )

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

  return ship
end



return M
