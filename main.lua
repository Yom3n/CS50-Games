local push = require "libs/push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243



function love.load()
    smallFont = love.graphics.newFont("font.ttf", 8)
    love.graphics.setFont(smallFont)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 30
PADDLE_SPACING_TO_EDGE = 5
BALL_SIZE = 4

function love.draw()
    push:start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    love.graphics.printf("Hello pong!", 0, 20, VIRTUAL_WIDTH, "center")
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + BALL_SIZE, BALL_SIZE, BALL_SIZE)
    -- Renders left paddle
    love.graphics.rectangle('fill', PADDLE_SPACING_TO_EDGE, 10, PADDLE_WIDTH, PADDLE_HEIGHT)
    -- Renders right paddle
    love.graphics.rectangle(
        'fill',
        VIRTUAL_WIDTH - PADDLE_WIDTH - PADDLE_SPACING_TO_EDGE,
        VIRTUAL_HEIGHT - PADDLE_HEIGHT - 10,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
