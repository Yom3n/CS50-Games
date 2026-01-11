GameOverState = Class { __includes = BaseState }

function GameOverState:enter(params)
    assert(params["score"], "score paramters is required")
    self.score = params.score
end

function GameOverState:render()
    love.graphics.setFont(MediumFont)
    love.graphics.printf("Score: " .. self.score, 0, VIRTUAL_HEIGHT / 2 - MediumFont:getHeight(), VIRTUAL_WIDTH, "center")
    love.graphics.setFont(SmallFont)
    love.graphics.printf("Press SPACE to start again", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH,
        "center")
end

local function restartGame()
    StateMachine:change("GameState")
end
function GameOverState:keypressed(key)
    if (key == "space") then
        restartGame()
    end
end

function GameOverState:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        -- When primary button presssed
        restartGame()
    end
end
