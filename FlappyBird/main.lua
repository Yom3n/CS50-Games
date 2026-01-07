local push = require "/libs/push"
Class = require 'libs/class'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'libs.StateMachine'
require 'GameStates.BaseState'
require 'GameStates.TitleScreenState'
require 'GameStates.GameState'
require 'GameStates.GameOverState'

GroundSprite = love.graphics.newImage("/assets/ground.png")
BgSprite = love.graphics.newImage("/assets/background.png")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Explicitly declare as global
_G.VIRTUAL_WIDTH = 512
_G.VIRTUAL_HEIGHT = 288

-- Points that when offset reaches,
-- must reset images position to simulate scrolling
local BG_MID_POINT = 413
local BG_SCROLLING_SPEED = 40
GROUND_SCROLLOING_SPEED = 80
local groundOffset = 0
local bgOffset = 0


math.randomseed(os.time())


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Crappy bird")
    SmallFont = love.graphics.newFont("font.ttf", 8)
    MediumFont = love.graphics.newFont("font.ttf", 16)
    BigFont = love.graphics.newFont("font.ttf", 32)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
    })

    GroundHeight = GroundSprite:getHeight()

    StateMachine = StateMachine {
        ['TitleScreen'] = function() return TitleScreenState() end,
        ['GameState'] = function() return GameState() end,
        ['GameOver'] = function() return GameOverState() end

    }
    StateMachine:change("TitleScreen")
end

function love.draw()
    push:start()

    love.graphics.draw(BgSprite, -bgOffset, 0)
    StateMachine:render()
    love.graphics.draw(GroundSprite, -groundOffset, VIRTUAL_HEIGHT - GroundHeight)

    push:finish()
end

function love.update(dt)
    groundOffset = (groundOffset + GROUND_SCROLLOING_SPEED * dt) % VIRTUAL_WIDTH
    bgOffset = (bgOffset + BG_SCROLLING_SPEED * dt) % BG_MID_POINT
    StateMachine:update(dt)
    love.graphics.draw(GroundSprite, -groundOffset, VIRTUAL_HEIGHT - GroundSprite:getHeight())
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if (key == "escape") then
        love.event.quit()
    end
    StateMachine:keypressed(key)
end
