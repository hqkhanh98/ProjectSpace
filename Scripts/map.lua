local widget = require "widget"

local M = {}

local map = display.newGroup()
function display.newGroup2( insertInto )
	local group = display.newGroup()
	if( insertInto ) then insertInto:insert( group ) end
	return group
end

function M.create( options )

  local options = options or {}
  local x = options.x or 160
  local y = options.y or 240


  map.levelGroup = display.newGroup2( map )
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

  scrollView:insert( map.levelGroup )

  scrollView:scrollTo( "bottom", { time=50 } )

  return map
end

function createLevels( levels, x, y, max )
  local levels = levels or {}
  local length = max + 5
  local title = length

      --if x == 50 then x = 150 else x = 50 end
  for i = 1, length do
    if x == 50 then x = 150 else x = 50 end
      levels[i] = display.newImageRect( map.levelGroup, "Assets/Images/level.png", 50, 50 )
      levels[i].x, levels[i].y, levels[i].id = x, y, title
      levels[i].title = display.newText( map.levelGroup, title, levels[i].x, levels[i].y, "Assets/Fonts/kenvector_future.ttf", 16 )
      print(levels[i].id)
      title = title - 1

      y = y + 100
      if length > max then
        levels[i].alpha = 0.5
        length = length -1
      end
  end
  return levels
end

function scrollViewMap( levels )

end

return M
