-- Requirements
local composer = require "composer"

-- Variables local to scene
local scene = composer.newScene()

local background
local centerX, centerY = display.contentCenterX, display.contentCenterY

-- Init group
local backGroup = display.newGroup()
local uiGroup = display.newGroup()

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group
  background = display.newImageRect( backGroup, "Assets/Images/menu.png", 448, 6080)
  background.alpha = .1
  background.x = display.contentCenterX
  background.y = -2200
end

local function enterFrame(event)
  local elapsed = event.time

end

function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    Runtime:addEventListener("enterFrame", enterFrame)
    transition.to( background, { alpha = 1, time = 2000 } )
  elseif ( phase == "did" ) then

  end
end

function scene:hide( event )
  local phase = event.phase
  if ( phase == "will" ) then

  elseif ( phase == "did" ) then
    Runtime:removeEventListener("enterFrame", enterFrame)
  end
end

function scene:destroy( event )
  --collectgarbage()
end

scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

return scene
