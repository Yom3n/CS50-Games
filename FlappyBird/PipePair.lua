PipePair = Class {}

PIPES_GAP = 90
function PipePair:init()
    self.x = VIRTUAL_WIDTH
    self.y = VIRTUAL_HEIGHT - math.random(30, VIRTUAL_HEIGHT * 0.7)
    self.pipes = {
        ["upper"] = Pipe(self.y - PIPES_GAP, "top"),
        ["lower"] = Pipe(self.y, "bottom")
    }
    self.width = self.pipes.lower.width
end

function PipePair:render()
    for key, pipe in pairs(self.pipes) do
        pipe:render()
    end
end

function PipePair:update(dt)
    for key, pipe in pairs(self.pipes) do
        pipe:update(dt)
    end
end
