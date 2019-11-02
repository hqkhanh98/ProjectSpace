local E = {}
local enemyns = require "Scripts.Sheets.ship-blue"
local moduleBullet = require "Scripts.Objects.bullet"
function E.create( enemy, options )
    local options = options or {}
    local x = options.x or 100
    local y = options.y or -10
    local w = options.w or 50
    local h = options.h or 80
    local sl = options.sl or 2
    local hp = options.hp or 1
    local name = options.name or "giant"

    enemyTable = {}

    local physics = require "physics"
    physics.start()

    local path = options.path or "Assets/Images/ship-blue.png"
    local sheet = graphics.newImageSheet( path, enemyns:getSheet() )

    function createEnemy1()
      enemy = display.newSprite( sheet , { frames={4} } )
      enemy.x = x
      enemy.y = y
      enemy.hp = hp
      enemy.name = "enemy"
      physics.addBody( enemy, "dynamic")
      enemy:scale(0.7, 0.7)

      enemy1 = display.newSprite( sheet , { frames={  4 } } )
      enemy1.x = 230
      enemy1.y = -10
      enemy1.hp = 1
      enemy1.name = "enemy"
      physics.addBody( enemy1, "dynamic")
      enemy1:scale(0.7, 0.7)
      table.insert( enemyTable, enemy )
      table.insert( enemyTable, enemy1 )
      transition.to( enemy,  { tag = "enemy" ,time = 600,  y = 150, onComplete = turnLeftEnemy })
      transition.to( enemy1, { tag = "enemy" ,time = 600, y = 150 , onComplete = turnRightEnemy1 })
    end
    enemyLoop = timer.performWithDelay( 500, createEnemy1, 0)
    Runtime:addEventListener( "collision", onCollision )
return enemy
end




function turnLeftEnemy(obj)

  transition.to( obj,  { tag = "enemy" ,time = 400, x = 0, onComplete = clear} )
end

function turnRightEnemy1(obj)

  transition.to( obj,  { tag = "enemy" ,time = 400, x = 300, onComplete = clear } )
end

function clear(obj)
  if obj == nil then
  else
    print("xoa")
    display.remove( obj )
    obj = nil
  end
end

function onCollision(event)
  if ( event.phase == "began" ) then

      local obj1 = event.object1
      local obj2 = event.object2
    --  print("Bat dau")
       -- laser và tiểu hành tinh
      if ( ( obj1.name == "enemy" and obj2.name == "bullet" ) or
      ( obj1.name == "bullet" and obj2.name == "enemy" ) )
      then
          print("Va cham")
          --xóa bỏ
          for i = #enemyTable, 1, -1 do
              if ( enemyTable[i] == obj1 or enemyTable[i] == obj2 ) then
                  print(enemyTable[i].hp )
                  if enemyTable[i].hp > 0  then
                    enemyTable[i].hp = enemyTable[i].hp - 1
                    display.remove( obj2 )
                    obj2 = nil
                    print("tru mau")
                  elseif enemyTable[i].hp == 0 then
                    table.remove( enemyTable, i )
                    transition.cancel( obj1 )

                    display.remove( obj1 )
                    display.remove( obj2 )
                    obj1 = nil
                    obj2 = nil
                    print("Xoa bo")
                  end
              end
          end

      end
    --  print("ket thuc")
  end
end


return E
