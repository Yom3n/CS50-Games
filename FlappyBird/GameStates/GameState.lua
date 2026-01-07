-- Time between spawned pipes in seconds
local TIME_BETWEEN_PIPES = 2.5

GameState = Class { __includes = BaseState }

-- Transition to game over state whan player dies
local function onPlayerDeath()
    StateMachine:change("GameOver", { score = 0 })
end

function GameState:enter()
    self.pipesSpawnTimer = 0
    -- generate first pipe at game start
    self.bird = Bird()
    self.pipePairs = {}
    table.insert(self.pipePairs, PipePair())
end

function GameState:render()
    for k, pipePair in pairs(self.pipePairs) do
        pipePair:render()
    end

    self.bird:render()
end

function GameState:update(dt)
    self.bird:update(dt)

    if self.bird.y > VIRTUAL_HEIGHT - GroundHeight - self.bird.height + self.bird.Y_COLLISION_BOX_OFFSET or
        self.bird.y < -self.bird.height then
        -- Bird collides with ground or go out of top edge of the screen
        onPlayerDeath()
        return
    end
    for k, pipePair in pairs(self.pipePairs) do
        if (self.bird:Collides(pipePair.pipes.lower) or self.bird:Collides(pipePair.pipes.upper)) then
            onPlayerDeath()
            return
        end
        pipePair:update(dt)
        if pipePair.x < -pipePair.width then
            -- Remove pipe if its out of screen
            table.remove(pipePair, k)
        end
    end

    self.pipesSpawnTimer = self.pipesSpawnTimer + dt
    if self.pipesSpawnTimer >= TIME_BETWEEN_PIPES then
        table.insert(self.pipePairs, PipePair(self.pipePairs[#self.pipePairs].y))
        self.pipesSpawnTimer = 0
    end
end

function GameState:keypressed(key)
    self.bird:keypressed(key)
end
