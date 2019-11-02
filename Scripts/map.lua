local widget = require "widget"
local composer = require "composer"
local M = {}

local map = display.newGroup()
function display.newGroup2( insertInto )
	local group = display.newGroup()
	if( insertInto ) then insertInto:insert( group ) end
	return group
end

pathEmpty = "Assets/Images/Star_01.png"
local pathBlock = "Assets/Images/Star_02.png"
local pathGet = "Assets/Images/Star_03.png"

function M.create( options )

  local options = options or {}
  local x = options.x or 160
  local y = options.y or 240

  map.levelGroup = display.newGroup2( map )
	map.lineLevels = display.newGroup2( map )
  map.display = display.newImageRect( "Assets/Images/panel.png", 230, 250)
  map.levels = {}

  map.display.x, map.display.y = x, y
  map.levels = createLevels( levels, 0, 0, 10 )
  map.levelGroup.x, map.levelGroup.y = display.centerX, display.centerY

  map.levelGroup:toFront()

  -- Create the widget
  local scrollView = widget.newScrollView(
      {
          top = 100 ,
          left = 70,
          width = 180,
          height = 200,
          scrollWidth = map.levelGroup.contentWidth,
          scrollHeight = map.levelGroup.contentHeight -50,
          hideBackground = true,
          hideScrollBar = true,
          horizontalScrollDisabled = true
      }
  )

  -- Create a image and insert it into the scroll view
	-- local line = display.newLine( map.levelGroup, map.levels[1].x, map.levels[1].y, map.levels[2].x, map.levels[2].y )
	-- line:toFront()
	-- print( "x1 : "..levels[1].x.." y1 : "..levels[1].y.." x2 : "..levels[2].x.." y2 : "..levels[2].y )
	for i = 1, #map.levels do
		map.levels[i]:addEventListener("tap", onTap)
	end
  scrollView:insert( map.levelGroup )

  scrollView:scrollTo( "bottom", { time=50 } )

  return map
end

function createLevels( levels, x, y, max )
  local levels = levels or {}
  local length = max + 5
  local title = length
	local size  = 3
      --if x == 50 then x = 150 else x = 50 end
  for i = 1, length do
    if x == 40 then x = 140 else x = 40 end
      levels[i] = display.newImageRect( map.levelGroup, "Assets/Images/level.png", 50, 50 )
      levels[i].x, levels[i].y, levels[i].id = x, y, title
      levels[i].title = display.newText( map.levelGroup, title, levels[i].x, levels[i].y, "Assets/Fonts/kenvector_future.ttf", 16 )
			levels[i].star = {}
      title = title - 1

      y = y + 100
      if length > max then
        levels[i].alpha = 0.5
        length = length -1
				for j = 1, size do
					local x = levels[i].x - 30
					levels[i].star[j] = display.newImageRect( map.levelGroup, "Assets/Images/Star_02.png", 10, 10 )
					levels[i].star[j].x, levels[i].star[j].y = x + (j * 15	), levels[i].y + 20
					levels[i].star[j].id = j
				end
			else
				for j = 1, size do
					local x = levels[i].x - 30
					levels[i].star[j] = display.newImageRect( map.levelGroup, "Assets/Images/Star_03.png", 10, 10 )
					levels[i].star[j].x, levels[i].star[j].y = x + (j * 15	), levels[i].y + 20
					levels[i].star[j].id = j
				end
      end
  end
	function map:clearAll()
		for i = 1, #map.levels do
			for k = 1, 3 do
				display.remove(map.levels[i].star[k])
				map.levels[i].star[k].id = nil
			end
			map.levels[i]:removeEventListener("tap", onTap)
			display.remove( map.levels[i].title )
			map.levels[i].title = nil
			display.remove(map.levels[i])
			map.levels[i] = nil
			display.remove( map.display )
			map.display = nil

		end
	end
  return levels
end

function onTap( event )
	print("Go to scene " .. event.target.id)
	composer.gotoScene( "Scripts.game" )
end



return M
