Paddle = Class {}

function Paddle:init(x, y)
    self.speed = 200
    self.width = 5
    self.height = 30
    self.x = x
    self.y = y
    self.dy = 0
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:update(dt)
    local newPosition = self.y + self.dy * dt
    if (self.dy < 0) then
        -- Moving up
        self.y = math.max(0, newPosition)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, newPosition)
    end
    self.dy = 0
end

return Paddle
