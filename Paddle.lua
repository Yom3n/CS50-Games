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
    self.y = self.y + self.dy * dt
    self.dy = 0
end

return Paddle