--[[
  
]]

ArtemisIdleState = Class{__includes = BaseState}

function ArtemisIdleState:init(artemis)
    self.artemis = artemis

    self.animation = Animation {
        frames = {26},
        interval = 1
    }

    self.artemis.currentAnimation = self.animation
end

function ArtemisIdleState:update(dt)
    if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
        --print("got to walking state")
        self.artemis:changeState('walking')
    end

    if love.keyboard.wasPressed('w') then
        self.artemis:changeState('jump')
    end
end