-- Requirements
local composer = require "composer"
local widget = require "widget"

-- Variables local to scene
local scene = composer.newScene()

local background, background2, background3
local centerX, centerY = display.contentCenterX, display.contentCenterY
local contentW, contentH = display.contentWidth, display.contentHeight
local scrollSpeed = .5
-- Init group
local backGroup = display.newGroup()
local uiGroup = display.newGroup()

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group
  background = display.newImageRect( backGroup, "Assets/Images/menu.png", 360, 480)
  --background.alpha = .1
  background.x = contentW * 0.5
  background.y = contentH/2

  background2 = display.newImageRect( backGroup, "Assets/Images/menu.png", 360, 480)
  background2.x = contentW * 0.5
  background2.y = background.y + 480

  background3 = display.newImageRect( backGroup, "Assets/Images/menu.png", 360, 480)
  background3.x = contentW * 0.5
  background3.y = background2.y + 480

  -- coverBackground = display.newImageRect( backGroup, "Assets/Images/menu.png", 360, 480)
  -- coverBackground.x = display.contentCenterX
  -- coverBackground.y = background.y - background.height
  -- coverBackground:toBack()
  sceneGroup:insert( backGroup )
end

local function enterFrame(event)
  local elapsed = event.time

  background.y = background.y + scrollSpeed
  background2.y = background2.y + scrollSpeed
  background3.y = background3.y + scrollSpeed

  if ( background.y + background.contentWidth ) > 1040 then
    background:translate( 0, -960 )
  end
  if ( background2.y + background2.contentWidth ) > 1040 then
    background2:translate( 0, -960 )
  end
  if ( background3.y + background3.contentWidth ) > 1040 then
    background3:translate( 0, -960 )
  end
end

function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    Runtime:addEventListener("enterFrame", enterFrame)
    --transition.to( background, { y = 1000, time = 5000 , onComplete = moveCoverBackground } )
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
