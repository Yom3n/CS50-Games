TitleScreenState = Class {__includes = BaseState }

function TitleScreenState:render()
    love.graphics.setFont(BigFont)
    love.graphics.printf("Crappy Bird", 0, 64, "center")
end

function TitleScreenState:update(dt) end
