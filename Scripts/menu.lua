-- Requirements
local json = require "json"
local composer = require "composer"
local physics = require "physics"
local moduleMap = require "Scripts.map"

physics.start()
physics.setGravity( 0, 0 )
physics.setDrawMode("normal")
-- Variables local to scene
local scene = composer.newScene()

local panel, btnUpgrade, btnShop, map

local centerX, centerY = display.contentCenterX, display.contentCenterY
local contentW, contentH = display.contentWidth, display.contentHeight
local scrollSpeed = .8

-- Init group
local backGroup = display.newGroup()
local uiGroup = display.newGroup()
local mapGroup = display.newGroup()

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group
  physics.pause()

  panel = display.newImageRect( backGroup, "Assets/Images/mapPanel.png", 360, 480 )
  panel.x = centerX
  panel.y = centerY --- 50
  panel.alpha = 1

  btnUpgrade = display.newImageRect( uiGroup, "Assets/Images/GUI/Button.png", 100, 30 )
  btnUpgrade.x = centerX
  btnUpgrade.y = centerY + 150

  btnUpgrade.text = display.newText( uiGroup, "UPGRADE", centerX, centerY, "Assets/Fonts/kenvector_future.ttf", 12 )
  btnUpgrade.text.x = btnUpgrade.x
  btnUpgrade.text.y = btnUpgrade.y
  btnUpgrade.color = 0
  btnShop = display.newImageRect( uiGroup, "Assets/Images/GUI/Button.png", 100, 30 )
  btnShop.x = centerX
  btnShop.y = centerY + 200

  btnShop.text = display.newText( uiGroup, "SHOP", centerX, centerY, "Assets/Fonts/kenvector_future.ttf", 12 )
  btnShop.text.x = btnShop.x
  btnShop.text.y = btnShop.y
  btnShop.color = 0


  map = moduleMap.create( {x = centerX, y = centerY - 30} )

  --mapGroup:insert( map )
  sceneGroup:insert( backGroup )
  sceneGroup:insert( map )
end

local function enterFrame(event)
  local elapsed = event.time
end

function transitionBtnUpgrade()
   transition.from( btnUpgrade.text, {tag = "button", time = 1000, xScale = 0.888, yScale = 0.888, onComplete = transitionBtnUpgrade} )
   btnUpgrade.text:setFillColor( btnUpgrade.color, btnUpgrade.color, btnUpgrade.color )

   if btnUpgrade.color == 0 then btnUpgrade.color = 255
   else
      btnUpgrade.color = 0
   end
end

function transitionBtnShop()

  transition.from( btnShop.text, {tag = "button", time = 1000, xScale = 0.888, yScale = 0.888, onComplete = transitionBtnShop} )

  btnShop.text:setFillColor( btnShop.color, btnShop.color, btnShop.color )

   if btnShop.color == 0 then btnShop.color = 255
   else
      btnShop.color = 0
   end
end


function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then

    transition.from( panel, { tag = "button", alpha = 0, time = 1000 } )
    transition.from( panel.title, { tag = "button",alpha = 0, time = 1000 } )
    transitionBtnUpgrade()
    transitionBtnShop()
  elseif ( phase == "did" ) then
    physics.start()

    --ship.level = 100
    Runtime:addEventListener("enterFrame", enterFrame)
  end
end

function scene:hide( event )
  local phase = event.phase
  if ( phase == "will" ) then
    transition.cancel("button")
    map.clearAll()
    display.remove(panel)
    display.remove(btnShop.text)
    display.remove(btnShop)
    display.remove(btnUpgrade)
    display.remove(btnUpgrade.text)

    btnShop.text = nil
    btnUpgrade.text = nil
    panel = nil
    btnShop = nil
    btnUpgrade = nil
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
