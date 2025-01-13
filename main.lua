--LEARNING SOME LUA CODE FROM SQUIDGOD 
--SETTING UP PLAYDATE SDK TUTORIAL

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

--Constants
local gfx <const> = playdate.graphics
local timer <const> = playdate.timer

--Variables
local playerSprite=nil

local playerSpeed =4

local playTimer=nil
local playTime= 30*1000 --30 seconds

local coinSprite=nil
local score=0

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

local function initialize ()
    math.randomseed(playdate.getSecondsSinceEpoch())
--Import player avatar 
    local playerImage=gfx.image.new("images/player")
    playerSprite=gfx.sprite.new(playerImage)
    playerSprite:moveTo(200,120)
    playerSprite:setCollideRect(0,0,coinSprite:getSize())
    playerSprite:add()
--Import background
    --local backgroundImage=gfx.image.new("images/background")
    --setBackgroundDrawingCallback does the following:
    --Creates Screen-Sized sprite(400x240)
    --Adds to draw list 
    --gfx.sprite.setBackgroundDrawingCallback{
    --    function(x,y,width,height)
    --        gfx.setClipRect(x,y,width,height)
    --        backgroundImage:draw(0,0)
    --        gfx.clearClipRect()
    -- end
   -- }

   --Import Coin Sprite
   local coinImage = gfx.image.new("images/coin")
   coinSprite = gfx.sprite.new(coinImage)
   moveCoin()
   coinSprite:add()

   --Reset Timer
   resetTimer()
end


initialize()

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
    else
--Set Button Controls

        if playdate.buttonIsPressed(playdate.kButtonUp)
        then
            playerSprite:moveBy(0,-playerSpeed)
        end
        if playdate.buttonIsPressed(playdate.kButtonDown)
        then
            playerSprite:moveBy(0,playerSpeed)
        end
        if playdate.buttonIsPressed(playdate.kButtonLeft)
        then
            playerSprite:moveBy(-playerSpeed,0)
        end
        if playdate.buttonIsPressed(playdate.kButtonRight)
        then
            playerSprite:moveBy(playerSpeed,0)
        end  

    --set coin collection
        local collisions=coinSprite:overlappingSprites()
        if #collisions>=1 
        then
            moveCoin()
            score = score + 1
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
        gfx.drawText("Press A to restart",15,5)
    end
end