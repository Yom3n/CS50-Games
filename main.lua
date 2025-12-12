push = require 'libs/push'
Class = require 'libs/class'
Ball = require 'Ball'
Paddle = require 'Paddle'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

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

    love.window.setTitle("Pong")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    ball = Ball(BALL_SIZE)
    player1 = Paddle(5, 10)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 10 - 30)
end

function love.draw()
    push:start()
    -- Sets bg
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    ball:render()
    player1:render()
    player2:render()

    displayFPS()

    push:finish()
end

function displayFPS()
    love.graphics.setFont(smallFont)
    local fps = love.timer.getFPS()
    love.graphics.print(fps, 0, 0)
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        player1.dy = -PADDLE_SPEED
    end
    if love.keyboard.isDown("s") then
        player1.dy = PADDLE_SPEED
    end

    if ball:collides(player1) then
        -- every collision speeds up the ball
        ball.dx = -ball.dx * 1.03
        ball.x = player1.x + 5
        if (ball.dy < 0) then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end
    end
    if ball:collides(player2) then
        -- every collision speeds up the ball
        ball.dx = -ball.dx * 1.03
        ball.x = player2.x - 4
        if (ball.dy < 0) then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end
    end

    player1:update(dt)
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
