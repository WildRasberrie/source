local pd <const> = playdate
local gfx <const> = pd.graphics

--DECLARE CLASS

class('Player').extends(gfx.sprite)
Player={}
--CONSTRUCTORS
function Player:init(x,y,image)
    self:moveTo(x,y)
    self:setImage(image)
    self.moveSpeed =1
    self.projectileSpeed =1
end

--METHODS
function Player:update()
    Player.super.update(self)
    --Set Button Controls--
    if playdate.buttonIsPressed(playdate.kButtonUp)
    then
        self:moveBy(0, -self.moveSpeed)
    end
    if playdate.buttonIsPressed(playdate.kButtonDown)
    then
        self:moveBy(0, self.moveSpeed)
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft)
    then
        self:moveBy(-self.moveSpeed, 0)
    --else
        --self:setImageFlip(false)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight)
    then
        self:moveBy(self.moveSpeed, 0)
    end
end
