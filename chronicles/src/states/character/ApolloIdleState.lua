--[[
  
]]

ApolloIdleState = Class{__includes = BaseState}

function ApolloIdleState:init(apollo)
    self.apollo = apollo

    self.animation = Animation {
        frames = {26},
        interval = 1
    }

    self.apollo.currentAnimation = self.animation
end

function ApolloIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.apollo:changeState('walking')
    end

    if love.keyboard.wasPressed('up') then
        self.apollo:changeState('jump')
    end
end