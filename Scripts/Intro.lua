-- Requirements
local composer = require "composer"

-- Variables local to scene
local scene = composer.newScene()

-- biến playText, title
local playText
local title
--x,y
local contentX,contentY = display.contentCenterX, display.contentCenterY
--hàm gọi đến cảnh menu
local function goToMenu()
    composer.gotoScene("Scripts.menu")
end

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group

  --backgroudIntro
  local backgroudIntro = display.newImage(sceneGroup,"Assets/Images/backIntro.png", 320, 480)
  backgroudIntro.x = contentX
  backgroudIntro.y = contentY
  backgroudIntro:toBack()
  --title(nữa kiếm hình)
  title = display.newText(sceneGroup, "SPACESHIP WAR", contentX, -10, native.systemFontBold, 20)
	title:setFillColor(0,255,0)
  --playText
  playText = display.newText(sceneGroup, "CHẠM ĐỂ BẮT ĐẦU", contentX, -10, native.systemFontBold, 20)
	playText:setFillColor( 255, 255, 255 )
  --hiệu ứng playText
  transition.to( title, {time=1500, delay=900, alpha=1, x=contentX, y=250} )
  --hiệu ứng playText
  transition.to( playText, {time=1000, alpha=1, x=contentX, y=400} )
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
