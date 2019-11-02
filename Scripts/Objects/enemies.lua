local M = {}
local enemy = require "Scripts.Objects.enemy"
function display.newGroup2( insertInto )
	local group = display.newGroup()
	if( insertInto ) then insertInto:insert( group ) end
	return group
end
  function M.newLure(options)
    local options = options or {}
    local amount = options.amount or 5
    local x = options.x or 10
    local y = options.y or 10
    local speed = options.speed or 10
    local enemies = display.newGroup()
    enemies.lure = {}
    local x1 = display.contentCenterX
    local y1 = display.contentCenterY
    for i = 1, 3 do

      enemies.enemy = enemy.create({ x = x1, y = y1 })
      enemies.enemy = display.newGroup2(enemies)
      x1 = x1 + 40
      y1 = y1 + 50
    end

    return enemies
  end
return M
