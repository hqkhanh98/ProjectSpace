-- Requirements
local composer = require "composer"

-- Variables local to scene
local scene = composer.newScene()

-- biến playText, title
local playText
local title
--x,y
local contentX,contentY = display.contentCenterX, display.contentCenterY

local font = "Assets/Fonts/kenvector_future.ttf"
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
  title = display.newText(sceneGroup, "SPACESHIP WAR", contentX, -10, font, 20)
	title:setFillColor(0,255,0)

  --playText
  playText = display.newText(sceneGroup, "TOUCH TO START", -50, 400, font, 20)
	playText:setFillColor( 255, 255, 255 )
  playText.alpha = 0.1

  --hiệu ứng bông tuyết
  local json = require( "json" )
  local filePath = system.pathForFile( "Scripts/Sheets/particle_texture1.json" )
  local f = io.open( filePath, "r" )
  local emitterData = f:read( "*a" )
  f:close()

  local emitterParams = json.decode( emitterData)

  local emitter = display.newEmitter( emitterParams )
  emitter.x = display.contentCenterX
  emitter.y = display.contentCenterY


end

local function enterFrame(event)
  local elapsed = event.time
end
function scaleTitle()
   transition.from( playText, { time = 1200, xScale = 0.899, yScale = 0.899, onComplete = scaleTitle} )
end
function blink()
  --nhấp nháy
  transition.blink( playText, { time=1200 } )
  transition.from( playText, { time = 1200, xScale = 0.899, yScale = 0.899,
  onComplete = scaleTitle
  } )
end
function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    Runtime:addEventListener("enterFrame", enterFrame)
  elseif ( phase == "did" ) then
      --sự kiện tap
      playText:addEventListener("tap", goToMenu )
      --hiệu ứng title
      transition.to( title, {time=1000,  alpha=1, x=contentX, y=250} )
      --hiệu ứng playText
      transition.to( playText, {time=1500, delay=900, alpha=1, x=contentX, y=400, onComplete = blink} )

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
