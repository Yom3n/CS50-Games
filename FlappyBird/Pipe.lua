Pipe = Class {}

local PIPE_IMAGE = love.graphics.newImage("assets/pipe.png")
PIPE_HEIGHT = 288
-- @params orientation top| bottom
function Pipe:init(y, orientation)
    assert(orientation == "top" or orientation == "bottom")
    self.orientation = orientation
    self.x = VIRTUAL_WIDTH
    self.y = y
    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT
end

function Pipe:update(dt)
    -- Ground scrolling speed is used to match pipe visualy with gorund.
    -- Othwerwise it looks like ground is sliding on the surface
    self.x = self.x - GROUND_SCROLLOING_SPEED * dt
end

function Pipe:render()
    local scaleY = self.orientation == "bottom" and 1 or -1
    love.graphics.draw(PIPE_IMAGE, self.x, (self.orientation == 'top' and self.y + self.height or self.y), 0, 1, scaleY)
end
