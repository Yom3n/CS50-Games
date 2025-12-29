local push = require "/libs/push"
Class = require 'libs/class'
require 'Bird'
require 'Pipe'
require 'PipePair'

local ground = love.graphics.newImage("/assets/ground.png")
local bg = love.graphics.newImage("/assets/background.png")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- @type number
VIRTUAL_WIDTH = 512
-- @type number
VIRTUAL_HEIGHT = 288

local groundOffset = 0
local bgOffset = 0

-- Points that when offset reaches,
-- must reset images position to simulate scrolling
local BG_MID_POINT = 413
local BG_SCROLLING_SPEED = 40
GROUND_SCROLLOING_SPEED = 80

local bird = Bird()

math.randomseed(os.time())

local pipesSpawnTimer = 0
-- Time between spawned pipes in seconds
local TIME_BETWEEN_PIPES = 2.5

local pipePairs = {}

local scrolling = true

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Crappy bird")
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
    })

    -- generate first pipe at game start
    table.insert(pipePairs, PipePair())
end

function love.draw()
    push:start()

    love.graphics.draw(bg, -bgOffset, 0)
    for k, pipePair in pairs(pipePairs) do
        pipePair:render()
    end
    love.graphics.draw(ground, -groundOffset, VIRTUAL_HEIGHT - ground:getHeight())

    bird:render()

    push:finish()
end

function love.update(dt)
    if not scrolling then
        return
    end
    groundOffset = (groundOffset + GROUND_SCROLLOING_SPEED * dt) % VIRTUAL_WIDTH
    bgOffset = (bgOffset + BG_SCROLLING_SPEED * dt) % BG_MID_POINT

    bird:update(dt)
    for k, pipePair in pairs(pipePairs) do
        if (bird:Collides(pipePair.pipes.lower) or bird:Collides(pipePair.pipes.upper)) then
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
        table.insert(pipePairs, PipePair())
        pipesSpawnTimer = 0
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if (key == "escape") then
        love.event.quit()
    end
    bird:keypressed(key)
end
