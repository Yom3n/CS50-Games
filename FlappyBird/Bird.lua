require 'check_collision'
-- @class Bird
-- @field image
-- @field width number
-- @field height number
-- @field x number
-- @field y number
Bird = Class {}

local GRAVITY = 10
local JUMP_HEIGHT = 250
function Bird:init()
    self.image = love.graphics.newImage("/assets/bird2.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2

    self.X_COLLISION_BOX_OFFSET = 4
    self.Y_COLLISION_BOX_OFFSET = 2

    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY

    self.y = self.y + self.dy * dt
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:keypressed(key)
    if (key == 'space') then
        self.dy = -JUMP_HEIGHT
    end
end

function Bird:Collides(pipe)
    return Collides(
        self.x + self.X_COLLISION_BOX_OFFSET, self.y + self.Y_COLLISION_BOX_OFFSET,
        self.width - 2 * self.X_COLLISION_BOX_OFFSET,
        self.height - 2 * self.Y_COLLISION_BOX_OFFSET,
        pipe.x, pipe.y, pipe.width, pipe.height
    )
end
