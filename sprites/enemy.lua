import "sprites"
import "assets"

local gfx <const> =playdate.graphics
local imagetableEnemy <const> = gfx.image.new(assets.enemy)


Enemy={}

class("Enemy").extends(gfx.sprite)

function Enemy:init(x,y)
    Enemy.super.init(self)
    self:setImage(imagetableEnemy)
    self:moveTo(x,y)
    self:setCollideRect(0,0,10,10)
    self:setGroups(1)
end

function Enemy:update()
    self:moveBy(0,1)
end