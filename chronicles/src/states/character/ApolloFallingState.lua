--[[

]]

ApolloFallingState = Class{__includes = BaseState}

function ApolloFallingState:init(apollo, gravity)
    self.apollo = apollo
    self.gravity = gravity
    self.animation = Animation {
        frames = {26},
        interval = 1
    }
    self.apollo.currentAnimation = self.animation
end

function ApolloFallingState:update(dt)
    self.apollo.currentAnimation:update(dt)
    self.apollo.dy = self.apollo.dy + self.gravity
    self.apollo.y = self.apollo.y + (self.apollo.dy * dt)

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.apollo.map:pointToTile(self.apollo.x + 1, self.apollo.y + self.apollo.height)
    local tileBottomRight = self.apollo.map:pointToTile(self.apollo.x + self.apollo.width - 1, self.apollo.y + self.apollo.height)

    -- if we get a collision beneath us, go into either walking or idle
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft.collidable or tileBottomRight.collidable) then
        self.apollo.dy = 0
        
        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.apollo:changeState('walking')
        else
            self.apollo:changeState('idle')
        end

        self.apollo.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.apollo.height
    
    -- go back to start if we fall below the map boundary
    elseif self.apollo.y > VIRTUAL_HEIGHT then
        gSounds['fall']:play()
        gStateMachine:change('gameOver')
    
    -- check side collisions and reset position
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