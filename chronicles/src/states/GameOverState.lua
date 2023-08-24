--[[

    -- GameOverState Class --
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:init()

end

function GameOverState:enter(params)
    
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function GameOverState:render()
    love.graphics.draw(gTextures['background1'])
    love.graphics.draw(gTextures['background2'])
    love.graphics.draw(gTextures['background3'])

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('You Lost', 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end

