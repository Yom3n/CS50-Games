push = require 'libs/push'
Class = require 'libs/class'
Ball = require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Distance to horicontal edges
PADDLE_SPACING_TO_EDGE = 5
PADDLE_SPEED = 200
PADDLE_WIDTH = 5
PADDLE_HEIGHT = 30
local paddleY = 5

local BALL_SIZE = 4

local player1Score = 0
local player2Score = 0

-- start / play
local gameState = 'start'


function love.load()
    math.randomseed(os.time())
    smallFont = love.graphics.newFont("font.ttf", 8)
    scoreFont = love.graphics.newFont("font.ttf", 32)
    love.graphics.setFont(smallFont)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    ball = Ball(BALL_SIZE)
end

function love.draw()
    push:start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    -- Renders left paddle
    love.graphics.rectangle('fill', PADDLE_SPACING_TO_EDGE, paddleY, PADDLE_WIDTH, PADDLE_HEIGHT)
    -- Renders right paddle
    love.graphics.rectangle(
        'fill',
        VIRTUAL_WIDTH - PADDLE_WIDTH - PADDLE_SPACING_TO_EDGE,
        VIRTUAL_HEIGHT - PADDLE_HEIGHT - 10,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )

    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
    ball:render()
    push:finish()
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        paddleY = paddleY - PADDLE_SPEED * dt
    end
    if love.keyboard.isDown("s") then
        paddleY = paddleY + PADDLE_SPEED * dt
    end

    if gameState == 'play' then
        -- Update ball movement
        ball:update(dt)
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' and gameState == 'start' then
        ball:reset()
        gameState = 'play'
    end
end
