TitleScreenState = Class { __includes = BaseState }

local textY = 64
local animatingDown = false

function TitleScreenState:render()
    love.graphics.setFont(BigFont)
    love.graphics.printf("Crappy Bird", 0, textY, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(SmallFont)
    love.graphics.printf("Press SPACE to start", 0, textY + 60, VIRTUAL_WIDTH, "center")
end

function TitleScreenState:update(dt)
    if textY <= 50 then
        animatingDown = true
        textY = 51
    elseif  textY >= 78 then
        animatingDown = false
        textY = 77
    end
    if animatingDown then
        textY = math.max(50, textY + 50 * dt)
    else
        textY = math.min(78, textY - 50 * dt)
    end
end

function TitleScreenState:keypressed(key)
    print(key)
    if(key == 'space') then
        StateMachine:change("GameState")
    end
end