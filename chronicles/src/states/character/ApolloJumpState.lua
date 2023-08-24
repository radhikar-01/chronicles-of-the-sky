--[[

]]

ApolloJumpState = Class{__includes = BaseState}

function ApolloJumpState:init(apollo, gravity)
    self.apollo = apollo
    self.gravity = gravity
    self.animation = Animation {
        frames = {26},
        interval = 1
    }
    self.apollo.currentAnimation = self.animation
end

function ApolloJumpState:enter(params)
    self.apollo.dy = PLAYER_JUMP_VELOCITY
end

function ApolloJumpState:update(dt)
    self.apollo.currentAnimation:update(dt)
    self.apollo.dy = self.apollo.dy + self.gravity
    self.apollo.y = self.apollo.y + (self.apollo.dy * dt)

    -- go into the falling state when y velocity is positive
    if self.apollo.dy >= 0 then
        self.apollo:changeState('falling')
    end

    self.apollo.y = self.apollo.y + (self.apollo.dy * dt)

    -- look at two tiles above our head and check for collisions; 3 pixels of leeway for getting through gaps
    local tileLeft = self.apollo.map:pointToTile(self.apollo.x + 3, self.apollo.y)
    local tileRight = self.apollo.map:pointToTile(self.apollo.x + self.apollo.width - 3, self.apollo.y)

    -- if we get a collision up top, go into the falling state immediately
    if (tileLeft and tileRight) and (tileLeft.collidable or tileRight.collidable) then
        self.apollo.dy = 0
        self.apollo:changeState('falling')

    -- else test our sides for blocks
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