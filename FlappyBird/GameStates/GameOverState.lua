GameOverState = Class { __includes = BaseState }

bronzeTrophyImage = love.graphics.newImage("/assets/trophy_bronze.png")
silverTrophyImage = love.graphics.newImage("/assets/trophy_silver.png")
goldTrophyImage = love.graphics.newImage("/assets/trophy_gold.png")

function GameOverState:enter(params)
    assert(params["score"], "score paramters is required")
    self.score = params.score
end

function GameOverState:render()
    local trophyImage
    if self.score >= 15 then
        trophyImage = goldTrophyImage
    elseif self.score >= 10 then
        trophyImage = silverTrophyImage;
    elseif self.score >= 5 then
        trophyImage = bronzeTrophyImage
    end
    if trophyImage then
        love.graphics.draw(trophyImage, VIRTUAL_WIDTH / 2 - bronzeTrophyImage:getWidth() / 2, VIRTUAL_HEIGHT / 2 - 60)
    end

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
