-- Time between spawned pipes in seconds
local MIN_TIME_BETWEEN_PIPES = 2.2
local MAX_TIME_BETWEEN_PIPES = 3.5

GameState = Class { __includes = BaseState }

-- Transition to game over state whan player dies
local function onPlayerDeath(score)
    Sounds.hurt:play()
    StateMachine:change("GameOver", { score = score })
end

--- Returns random time between [MIN_TIME_BETWEEN_PIPES] and [MAX_TIME_BETWEEN_PIPES]
local function getRandomPipesSpawnTime()
    return math.random(MIN_TIME_BETWEEN_PIPES, MAX_TIME_BETWEEN_PIPES)
end

function GameState:enter()
    self.pipesSpawnTimer = 0
    -- generate first pipe at game start
    self.bird = Bird()
    self.pipePairs = {}
    self.score = 0
    self.nextPipesSpawnTime = getRandomPipesSpawnTime()
    self.isPaused = false
    table.insert(self.pipePairs, PipePair())
end

function GameState:render()
    love.graphics.setFont(SmallFont)
    love.graphics.printf('Score: ' .. self.score, 2, 2, VIRTUAL_WIDTH, "left")
    if self.isPaused then
        love.graphics.setFont(BigFont)
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - BigFont:getHeight(), VIRTUAL_WIDTH, "center")
        return
    end

    for k, pipePair in pairs(self.pipePairs) do
        pipePair:render()
    end

    self.bird:render()
end

function GameState:update(dt)
    if self.isPaused then
        return
    end
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
            Sounds.score:play()
            self.score = self.score + 1
        end
        pipePair:update(dt)
        if pipePair.x < -pipePair.width then
            -- Remove pipe if its out of screen
            table.remove(pipePair, k)
        end
    end


    self.pipesSpawnTimer = self.pipesSpawnTimer + dt
    if self.pipesSpawnTimer >= self.nextPipesSpawnTime then
        table.insert(self.pipePairs, PipePair(self.pipePairs[#self.pipePairs].y))
        self.nextPipesSpawnTime = getRandomPipesSpawnTime()
        self.pipesSpawnTimer = 0
    end
end

function GameState:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- When primary button presssed
        self.bird:jump()
    end
end

function GameState:keypressed(key)
    if key == 'space' then
        self.bird:jump()
    end
    if key == 'p' then
        if self.isPaused then
            -- On unpaused
            Sounds.bgMusic:play()
            self.isPaused = false
        else
            -- On paused
            Sounds.bgMusic:pause()
            Sounds.pause:play()
            self.isPaused = true
        end
    end
end
