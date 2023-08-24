--[[
    --Start State Class -
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            cLevel = 1
        })
    end
end

function StartState:render()
    love.graphics.draw(gTextures['title'], 0, 0, 0, 0.3, 0.3)

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('* Chronicles of the Sky *', 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end