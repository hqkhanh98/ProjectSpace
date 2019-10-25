local M = {}
local incShip = require "Scripts.Sheets.ship-blue"
function M.create( instance, options )

  local options = options or {}
  local x = options.x or 160
  local y = options.y or 200
  local w = options.w or 15
  local h = options.h or 25
  local type = options.type or "normal"

  local path = options.path or "Assets/Images/ship-blue.png"
  local sheet = graphics.newImageSheet( path, incShip:getSheet() )

  instance = display.newSprite( sheet , { frames={ 11 } } )
  instance:scale(0.8, 0.8)
  instance.x, instance.y = x, y - 50

  return instance
end

return M
