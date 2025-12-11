local push = require "libs/push"

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

BALL_SIZE = 4
local ballDx = 0
local ballDy = 0
local ballX
local ballY

local player1Score = 0
local player2Score = 0


local function resetBallPosition()
    ballX = VIRTUAL_WIDTH / 2 - BALL_SIZE
    ballY = VIRTUAL_HEIGHT / 2 + BALL_SIZE
end

function love.load()
    math.randomseed(os.time())
    resetBallPosition()
    smallFont = love.graphics.newFont("font.ttf", 8)
    scoreFont = love.graphics.newFont("font.ttf", 32)
    love.graphics.setFont(smallFont)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    push:start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    love.graphics.rectangle('fill', ballX, ballY, BALL_SIZE, BALL_SIZE)
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

    push:finish()
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        paddleY = paddleY - PADDLE_SPEED * dt
    end
    if love.keyboard.isDown("s") then
        paddleY = paddleY + PADDLE_SPEED * dt
    end

    -- Update ball movement
    ballX = ballX + ballDx * dt
    ballY = ballY + ballDy * dt
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' then
        resetBallPosition()
        print(math.random(0, 1))
        ballDx = math.random(0, 1) == 0 and 100 or -100
        ballDy = math.random(-50, 50)
    end
end
