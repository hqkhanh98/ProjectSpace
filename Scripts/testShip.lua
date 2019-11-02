-- Requirements
local composer = require "composer"
local meter = require "com.meter"
meter.create_fps()
meter.create_mem()
local ship = require "Scripts.Objects.ship"
-- Variables local to scene
local scene = composer.newScene()

function scene:create( event )
  local sceneGroup = self.view -- add display objects to this group
  ship = ship.create()

end

local function enterFrame(event)
  local elapsed = event.time

end

function scene:show( event )
  local phase = event.phase
  if ( phase == "will" ) then
    Runtime:addEventListener("enterFrame", enterFrame)
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
