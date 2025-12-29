PipePair = Class {}

PIPES_GAP = 90
function PipePair:init()
    self.x = VIRTUAL_WIDTH
    self.y = VIRTUAL_HEIGHT - PIPE_HEIGHT - 200
    topPipe = Pipe(self.y, "top")
    self.pipes = {
        ["upper"] = topPipe,
        ["lower"] = Pipe(self.y + topPipe.height + PIPES_GAP, "bottom")
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
