

Ball = Class {}

function Ball:init(size)
    self.x = VIRTUAL_WIDTH / 2 - size
    self.y = VIRTUAL_HEIGHT / 2 + size
    self.size = size
    self.dx = 0
    self.dy = 0
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - self.size
    self.y = VIRTUAL_HEIGHT / 2 + self.size
    self.dx = math.random(0, 1) == 0 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

return Ball
