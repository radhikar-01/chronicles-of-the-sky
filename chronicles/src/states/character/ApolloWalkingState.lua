--[[

]]

ApolloWalkingState = Class{__includes = BaseState}

function ApolloWalkingState:init(apollo)
    self.apollo = apollo
    self.animation = Animation {
        frames = {26, 29, 32, 35, 38, 41, 44, 47},
        interval = 0.1
    }
    self.apollo.currentAnimation = self.animation
end

function ApolloWalkingState:update(dt)
    self.apollo.currentAnimation:update(dt)

    -- idle if we're not pressing anything at all
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        self.apollo:changeState('idle')
    else
        local tileBottomLeft = self.apollo.map:pointToTile(self.apollo.x + 1, self.apollo.y + self.apollo.height)
        local tileBottomRight = self.apollo.map:pointToTile(self.apollo.x + self.apollo.width - 1, self.apollo.y + self.apollo.height)
        
        if (tileBottomLeft and tileBottomRight) and (not tileBottomLeft.collidable and not tileBottomRight.collidable) then
            self.apollo.dy = 0
            self.apollo:changeState('falling')
        elseif love.keyboard.isDown('left') then
            self.apollo.direction = 'left'
            self.apollo.x = self.apollo.x - PLAYER_WALK_SPEED * dt
            self.apollo:checkLeftCollisions(dt)
        elseif love.keyboard.isDown('right') then
            self.apollo.direction = 'right'
            self.apollo.x = self.apollo.x + PLAYER_WALK_SPEED * dt
            self.apollo:checkRightCollisions(dt)
        end

    end

    if love.keyboard.wasPressed('up') then
        self.apollo:changeState('jump')
    end
end