-- Requirements

local composer = require "composer"
local widget = require "widget"
local physics = require "physics"
local moduleShip = require "Scripts.Objects.ship"
local moduleBullet = require "Scripts.Objects.bullet"
physics.start()
physics.setGravity( 0, 0 )
physics.setDrawMode("normal")
-- Variables local to scene
local scene = composer.newScene()

local background, background2, background3, ship, bulletLoop, bullet
local bulletTables = {}

local centerX, centerY = display.contentCenterX, display.contentCenterY
local contentW, contentH = display.contentWidth, display.contentHeight
local scrollSpeed = .8
-- Init group
local backGroup = display.newGroup()
local uiGroup = display.newGroup()

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group
  physics.pause()
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

local function onCollision( event )
  if ( event.phase == "began" ) then
    local obj_1 = event.object1

    local obj_2 = event.object2
    if (( obj_1.name == "bullet" and obj_2.name == "destroy" ) or
       ( obj_1.name == "destroy" and obj_2.name == "bullet" ))then
          if ( obj_1.name == "bullet" ) then --or thisBullet.name == obj_2.name ) then
            obj_1:removeSelf()
          elseif obj_2.name == "bullet" then
            obj_2:removeSelf()
          end
    end
  end
end

local function createBullet( bullet, x, y, w, h )
  local thisBullet = bullet

  thisBullet = display.newImageRect( "Assets/Images/test.png", w, h)

  thisBullet.x = x
  thisBullet.y = y

  --thisBullet:setFillColor(0, 233, 233)

  thisBullet:toBack()

  uiGroup:insert( thisBullet )

  physics.addBody( thisBullet, "dynamic", {isSensor = true, bounce = 0,
                  box = { halfWidth=2, halfHeight=5 }} )

  thisBullet.name = "bullet"

  thisBullet.isFixedRotation = true

  table.insert( bulletTables, thisBullet )

  thisBullet:applyForce( 0, -0.222, x, y)

  return thisBullet
end

local function loopBullet()
  bullet = createBullet( bullet, ship.x, ship.y - 30, 30, 30 )
  bullet2 = createBullet( bullet2, ship.x + 20, ship.y, 2, 30 )
  bullet3 = createBullet( bullet3, ship.x - 20, ship.y, 2, 30 )
end

function destroyBullets()
  local destroyBar = display.newRect(130, 5, 700, .5)
  destroyBar.name = "destroy"
  physics.addBody( destroyBar, "static", {bounce = 0} )
end

function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    local json = require( "json" )
    local filePath = system.pathForFile( "Scripts/Sheets/my_galaxy.json" )
    local f = io.open( filePath, "r" )
    local emitterData = f:read( "*a" )
    f:close()

    local emitterParams = json.decode( emitterData)

    local emitter = display.newEmitter( emitterParams )
    emitter.x = centerX
    emitter.y = centerY
    --transition.to( background, { y = 1000, time = 5000 , onComplete = moveCoverBackground } )
  elseif ( phase == "did" ) then
    physics.start()
    ship = moduleShip.create( ship, { x = centerX, y = centerY ,type = "normal" } )
    bulletLoop = timer.performWithDelay( 300, loopBullet, 0 )

    destroyBullets()
    Runtime:addEventListener("enterFrame", enterFrame)
    Runtime:addEventListener( "collision", onCollision )
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
