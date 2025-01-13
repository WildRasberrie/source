local gfx <const> =playdate.graphics
local imagetableEnemy <const> = gfx.imagetable.new(assets.enemy)

class("Enemy").extends(gfx.sprite)

function Enemy:init()
    Enemy.super.init(self,imagetableEnemy[1])

end