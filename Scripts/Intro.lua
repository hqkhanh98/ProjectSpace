-- Requirements
local composer = require "composer"

-- Variables local to scene
local scene = composer.newScene()

-- biến playText
local playText
--hàm gọi đến cảnh menu
local function goToMenu()
    composer.gotoScene("Scripts.menu")
end

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group

  --backgroudIntro
  local backgroudIntro = display.newImage(sceneGroup,"Assets/Images/backIntro.png", 320, 480)
  backgroudIntro.x = display.contentCenterX
  backgroudIntro.y = display.contentCenterY
  backgroudIntro:toBack()

  --playButton
  playText = display.newText(sceneGroup, "CHẠM ĐỂ BẮT ĐẦU", display.contentCenterX, 400, native.systemFontBold, 20)
	playText:setFillColor( 255, 255, 255 )

end

local function enterFrame(event)
  local elapsed = event.time
end

function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    Runtime:addEventListener("enterFrame", enterFrame)
  elseif ( phase == "did" ) then
      --sự kiện tap
      playText:addEventListener("tap", goToMenu )
  end
end

function scene:hide( event )
  local phase = event.phase
  if ( phase == "will" ) then

  elseif ( phase == "did" ) then
    Runtime:removeEventListener("enterFrame", enterFrame)
    playText:removeSelf()
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
