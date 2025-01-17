--LEARNING SOME LUA CODE FROM SQUIDGOD 
--SETTING UP PLAYDATE SDK TUTORIAL

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "sprites"
import "assets"

--Constants
local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite
local timer <const> = playdate.timer

--Variables
local playerSprite=nil
local playerSpriteL=nil

local playerSpeed =4

local playTimer=nil
local playTime= 30*1000 --30 seconds

local coinSprite=nil
local score=0
local highScore=0

--Set Timer
local function resetTimer()
    playTimer = timer.new(playTime,playTime,0,playdate.easingFunctions.linear)
end

--Randomize Coin Position
local function moveCoin()
    local randX=math.random(40,360)
    local randY=math.random(40,200)
    coinSprite:moveTo(randX,randY)
end

--Save High Score 
local function saveScore()

    
end

local function setup ()
    math.randomseed(playdate.getSecondsSinceEpoch())
--Import player avatar 
    local playerImage=gfx.image.new(assets.player)
    local playerInstance = Player(200,120,playerImage)
    playerInstance:setCollideRect(0,0,25,40)--
    playerInstance:add()

--Import background
    local backgroundImage=gfx.image.new("images/background")
    assert(backgroundImage)
    
    --setBackgroundDrawingCallback() does the following:
    --Creates Screen-Sized sprite(400x240)
    --Adds to draw list 
    gfx.sprite.setBackgroundDrawingCallback(
        function(x,y,width,height)
            gfx.setClipRect(x,y,width,height)
            backgroundImage:draw(0,0)
            gfx.clearClipRect()
     end
    )


   --Import Coin Sprite
   local coinImage = gfx.image.new(assets.coin)
   coinSprite = gfx.sprite.new(coinImage)
   coinSprite:setCollideRect(0,0,10,10)
   moveCoin()
   coinSprite:add()

--TEST add enemy to game
--    local enemy=Enemy()
--    local enemyStartX = 200
--    local enemyStartY = 120
--    enemy:moveTo(enemyStartX,enemyStartY)
--    enemy:add()

   --Reset Timer
   resetTimer()
end


setup()

function playdate.update()
        --Stop Player movement if timer = 0
        if playTimer.value == 0
        then
            if playdate.buttonJustPressed(playdate.kButtonA)
            then
                resetTimer()
                moveCoin()
                score=0
            end
        

    --set coin collection
        local collisions = playerInstance:overlappingSprites()
        if #collisions >= 1
        then
            moveCoin()
            score+=1
        end
    end
    
    --update Sprite
    gfx.sprite.update()

    --update timers
    playdate.timer.updateTimers()

    --Reset Timer when Finished
    gfx.drawText("Time: ".. math.ceil(playTimer.value/1000),5,5)

    --Display score
    gfx.drawText("Score: "..score,320,5)

    --Instructions for Player
    if playTimer.value==0
    then
        gfx.drawText("Press A to restart",15,200)
    end
end