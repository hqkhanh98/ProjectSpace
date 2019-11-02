local M = {}
local enemy = require "Scripts.Objects.enemy"
function display.newGroup2( insertInto )
	local group = display.newGroup()
	if( insertInto ) then insertInto:insert( group ) end
	return group
end
  function M.newLure(options)
    local options = options or {}
    local amount = options.amount or 3
    local x = options.x or 50
    local y = options.y or 50
    local speed = options.speed or 5000
    local enemies = display.newGroup()
    enemies.lure = {}

    local directX, directY = 0, 0

    function move()
      if enemies.direct == "left" then
        x = 360
        directX = 0
        directY = 480
      elseif enemies.direct == "right" then
        x = 0
        directX = 360
        directY = 480
      end
      enemies.enemy = enemy.create({ x = x, y = y }).display
      enemies:insert(enemies.enemy)
      transition.to(enemies.enemy, {time = speed , x = directX, y = directY } )
    end

    enemies.loop = timer.performWithDelay( speed, move, amount)

    return enemies
  end
return M
