--[[

]]

ArtemisJumpState = Class{__includes = BaseState}

function ArtemisJumpState:init(artemis, gravity)
    self.artemis = artemis
    self.gravity = gravity
    self.animation = Animation {
        frames = {26},
        interval = 1
    }
    self.artemis.currentAnimation = self.animation
end

function ArtemisJumpState:enter(params)
    --gSounds['jump']:play()
    self.artemis.dy = PLAYER_JUMP_VELOCITY
end

function ArtemisJumpState:update(dt)
    self.artemis.currentAnimation:update(dt)
    self.artemis.dy = self.artemis.dy + self.gravity
    self.artemis.y = self.artemis.y + (self.artemis.dy * dt)

    -- go into the falling state when y velocity is positive
    if self.artemis.dy >= 0 then
        self.artemis:changeState('falling')
    end

    self.artemis.y = self.artemis.y + (self.artemis.dy * dt)

    -- look at two tiles above our head and check for collisions; 3 pixels of leeway for getting through gaps
    local tileLeft = self.artemis.map:pointToTile(self.artemis.x + 3, self.artemis.y)
    local tileRight = self.artemis.map:pointToTile(self.artemis.x + self.artemis.width - 3, self.artemis.y)

    -- if we get a collision up top, go into the falling state immediately
    if (tileLeft and tileRight) and (tileLeft.collidable or tileRight.collidable) then
        self.artemis.dy = 0
        self.artemis:changeState('falling')

    -- else test our sides for blocks
    elseif love.keyboard.isDown('a') then
        self.artemis.direction = 'left'
        self.artemis.x = self.artemis.x - PLAYER_WALK_SPEED * dt
        self.artemis:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('d') then
        self.artemis.direction = 'right'
        self.artemis.x = self.artemis.x + PLAYER_WALK_SPEED * dt
        self.artemis:checkRightCollisions(dt)
    end

    -- check if we've collided with any collidable game objects
    --[[
    for k, object in pairs(self.artemis.level.objects) do
        if object:collides(self.artemis) then
            if object.solid then
                object.onCollide(object)

                self.player.y = object.y + object.height
                self.player.dy = 0
                self.player:changeState('falling')
            elseif object.consumable then
                object.onConsume(self.player)
                table.remove(self.player.level.objects, k)
            end
        end
    end
    ]]
end