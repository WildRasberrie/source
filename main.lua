import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics


local playerSprite = nil

local function initialize ()
    local playerImage=gfx.image.new("images/player")
    playerSprite=gfx.sprite.new(playerImage)
    playerSprite:moveto(200,120)
    playerSprite:add()
end

initialize()

function playdate.update()
	gfx.sprite.update()
    playdate.timer.updateTimers()
end