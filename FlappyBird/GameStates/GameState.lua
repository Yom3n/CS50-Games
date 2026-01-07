-- Time between spawned pipes in seconds
local TIME_BETWEEN_PIPES = 2.5

GameState = Class { __includes = BaseState }

-- Transition to game over state whan player dies
local function onPlayerDeath(score)
    StateMachine:change("GameOver", { score = score })
end

function GameState:enter()
    self.pipesSpawnTimer = 0
    -- generate first pipe at game start
    self.bird = Bird()
    self.pipePairs = {}
    self.score = 0
    table.insert(self.pipePairs, PipePair())
end

function GameState:render()
    love.graphics.setFont(SmallFont)
    love.graphics.printf('Score: ' .. self.score, 2, 2, VIRTUAL_WIDTH, "left")
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
        onPlayerDeath(self.score)
        return
    end
    for k, pipePair in pairs(self.pipePairs) do
        if (self.bird:Collides(pipePair.pipes.lower) or self.bird:Collides(pipePair.pipes.upper)) then
            onPlayerDeath(self.score)
            return
        end
        if (self.bird.x > pipePair.x + pipePair.width and not pipePair.scored) then
            pipePair.scored = true
            self.score = self.score + 1
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
