-- Requirements
local composer = require "composer"
local playButton
-- Variables local to scene
local scene = composer.newScene()

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group

  --hình nền
  local backgroungIntro = display.newImage("Assets/Images/backIntro.png", 320, 480)
  backgroungIntro.x = display.contentCenterX
  backgroungIntro.y = display.contentCenterY
  backgroungIntro:toBack()
  --playButton
  playButton = display.newText( "Menu", display.contentCenterX, display.contentCenterY, native.systemFont, 44)
	playButton:setFillColor( 255, 255, 255 )

  --sự kiện tap


end

local function enterFrame(event)
  local elapsed = event.time

end

function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    Runtime:addEventListener("enterFrame", enterFrame)
  elseif ( phase == "did" ) then
      local function goToMenu()
          composer.gotoScene("Scripts.menu")
      end

      playButton:addEventListener("tap", goToMenu )
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
