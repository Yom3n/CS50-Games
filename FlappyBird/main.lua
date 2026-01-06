local push = require "/libs/push"
Class = require 'libs/class'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'StateMachine'
require 'GameStates.BaseState'
require 'GameStates.TitleScreenState'
require 'GameStates.GameState'

GroundSprite = love.graphics.newImage("/assets/ground.png")
BgSprite = love.graphics.newImage("/assets/background.png")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Explicitly declare as global
_G.VIRTUAL_WIDTH = 512
_G.VIRTUAL_HEIGHT = 288

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

    }
    StateMachine:change("GameState")
end

function love.draw()
    push:start()
    StateMachine:render()

    push:finish()
end

function love.update(dt)
    StateMachine:update(dt)
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
