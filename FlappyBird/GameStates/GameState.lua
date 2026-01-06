local groundOffset = 0
local bgOffset = 0

-- Points that when offset reaches,
-- must reset images position to simulate scrolling
local BG_MID_POINT = 413
local BG_SCROLLING_SPEED = 40
GROUND_SCROLLOING_SPEED = 80


local pipesSpawnTimer = 0
-- Time between spawned pipes in seconds
local TIME_BETWEEN_PIPES = 2.5


local scrolling = true

GameState = Class { __includes = BaseState }

function GameState:init()
    -- generate first pipe at game start
    self.bird = Bird()
    self.pipePairs = {}
    table.insert(self.pipePairs, PipePair())
end

function GameState:render()
    love.graphics.draw(BgSprite, -bgOffset, 0)
    for k, pipePair in pairs(self.pipePairs) do
        pipePair:render()
    end
    love.graphics.draw(GroundSprite, -groundOffset, VIRTUAL_HEIGHT - GroundSprite:getHeight())

    self.bird:render()
end

function GameState:update(dt)
    if not scrolling then
        return
    end
    groundOffset = (groundOffset + GROUND_SCROLLOING_SPEED * dt) % VIRTUAL_WIDTH
    bgOffset = (bgOffset + BG_SCROLLING_SPEED * dt) % BG_MID_POINT

    self.bird:update(dt)
    if self.bird.y > VIRTUAL_HEIGHT - GroundHeight - self.bird.height + self.bird.Y_COLLISION_BOX_OFFSET or
        self.bird.y < -self.bird.height then
        -- Bird collides with ground or go out of top edge of the screen
        scrolling = false
        return
    end
    for k, pipePair in pairs(self.pipePairs) do
        if (self.bird:Collides(pipePair.pipes.lower) or self.bird:Collides(pipePair.pipes.upper)) then
            scrolling = false
            return
        end
        pipePair:update(dt)
        if pipePair.x < -pipePair.width then
            -- Remove pipe if its out of screen
            table.remove(pipePair, k)
        end
    end

    pipesSpawnTimer = pipesSpawnTimer + dt
    if pipesSpawnTimer >= TIME_BETWEEN_PIPES then
        table.insert(self.pipePairs, PipePair(self.pipePairs[#self.pipePairs].y))
        pipesSpawnTimer = 0
    end
end

function GameState:enter() end

function GameState:exit() end

function GameState:keypressed(key)
    self.bird:keypressed(key)
end
