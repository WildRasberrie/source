local gfx <const> =playdate.graphics
local imagetableBullet <const> = gfx.imagetable.new(assets.bullet)

class("Bullet").extends(gfx.sprite)

function Bullet:init()
    Bullet.super.init(self,imagetableBullet[1])
end