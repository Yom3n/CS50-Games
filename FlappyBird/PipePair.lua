PipePair = Class {}

PIPES_GAP = 90
function PipePair:init(lastY)
    -- Chagnes to true when bird flights over it
    self.scored = false
    self.x = VIRTUAL_WIDTH
    local minY = -PIPE_HEIGHT + 30
    local maxY = VIRTUAL_HEIGHT - PIPES_GAP - PIPE_HEIGHT - GroundHeight
    if (lastY == nil) then
        lastY = math.random(minY, maxY)
    end
    local randomizedY = lastY + math.random(-50, 50)
    -- y is a upper pipe top part clamped to minY and maxY
    self.y = math.max(minY, math.min(randomizedY, maxY))
    self.pipes = {
        ["upper"] = Pipe(self.y, "top"),
        ["lower"] = Pipe(self.y + PIPE_HEIGHT + PIPES_GAP, "bottom")
    }
    self.width = self.pipes.lower.width
end

function PipePair:render()
    for key, pipe in pairs(self.pipes) do
        pipe:render()
    end
end

function PipePair:update(dt)
    self.x = self.pipes["upper"].x
    for key, pipe in pairs(self.pipes) do
        pipe:update(dt)
    end
end
