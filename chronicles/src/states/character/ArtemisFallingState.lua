--[[

]]

ArtemisFallingState = Class{__includes = BaseState}

function ArtemisFallingState:init(artemis, gravity)
    self.artemis = artemis
    self.gravity = gravity
    self.animation = Animation {
        frames = {26},
        interval = 1
    }
    self.artemis.currentAnimation = self.animation
end

function ArtemisFallingState:update(dt)
    self.artemis.currentAnimation:update(dt)
    self.artemis.dy = self.artemis.dy + self.gravity
    self.artemis.y = self.artemis.y + (self.artemis.dy * dt)

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.artemis.map:pointToTile(self.artemis.x + 1, self.artemis.y + self.artemis.height)
    local tileBottomRight = self.artemis.map:pointToTile(self.artemis.x + self.artemis.width - 1, self.artemis.y + self.artemis.height)

    -- if we get a collision beneath us, go into either walking or idle
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft.collidable or tileBottomRight.collidable) then
        self.artemis.dy = 0
        
        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
            self.artemis:changeState('walking')
        else
            self.artemis:changeState('idle')
        end

        --og: self.artemis.y = (tileBottomLeft.y) - self.artemis.height
        self.artemis.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.artemis.height
    
    -- go back to start if we fall below the map boundary
    elseif self.artemis.y > VIRTUAL_HEIGHT then
        gSounds['fall']:play()
        gStateMachine:change('gameOver')
    
    -- check side collisions and reset position
    elseif love.keyboard.isDown('a') then
        self.artemis.direction = 'left'
        self.artemis.x = self.artemis.x - PLAYER_WALK_SPEED * dt
        self.artemis:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('d') then
        self.artemis.direction = 'right'
        self.artemis.x = self.artemis.x + PLAYER_WALK_SPEED * dt
        self.artemis:checkRightCollisions(dt)
    end

end