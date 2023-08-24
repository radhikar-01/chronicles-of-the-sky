--[[

]]

ArtemisWalkingState = Class{__includes = BaseState}

function ArtemisWalkingState:init(artemis)
    self.artemis = artemis
    self.animation = Animation {
        frames = {26, 29, 32, 35, 38, 41, 44, 47},
        interval = 0.1
    }
    self.artemis.currentAnimation = self.animation
end

function ArtemisWalkingState:update(dt)
    self.artemis.currentAnimation:update(dt)

    -- idle if we're not pressing anything at all
    if not love.keyboard.isDown('a') and not love.keyboard.isDown('d') then
        self.artemis:changeState('idle')
    else
        local tileBottomLeft = self.artemis.map:pointToTile(self.artemis.x + 1, self.artemis.y + self.artemis.height)
        local tileBottomRight = self.artemis.map:pointToTile(self.artemis.x + self.artemis.width - 1, self.artemis.y + self.artemis.height)
        
        if (tileBottomLeft and tileBottomRight) and (not tileBottomLeft.collidable and not tileBottomRight.collidable) then
            self.artemis.dy = 0
            self.artemis:changeState('falling')
        elseif love.keyboard.isDown('a') then
            self.artemis.direction = 'left'
            self.artemis.x = self.artemis.x - PLAYER_WALK_SPEED * dt
            self.artemis:checkLeftCollisions(dt)
        elseif love.keyboard.isDown('d') then
            self.artemis.direction = 'right'
            self.artemis.x = self.artemis.x + PLAYER_WALK_SPEED * dt
            self.artemis:checkRightCollisions(dt)
        end
        
        --[[
        -- temporarily shift player down a pixel to test for game objects beneath
        self.player.y = self.player.y + 1

        local collidedObjects = self.player:checkObjectCollisions()

        self.player.y = self.player.y - 1

        -- check to see whether there are any tiles beneath us
        if #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
            self.player.dy = 0
            self.player:changeState('falling')
        elseif love.keyboard.isDown('left') then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
            self.player.direction = 'left'
            self.player:checkLeftCollisions(dt)
        elseif love.keyboard.isDown('right') then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
            self.player.direction = 'right'
            self.player:checkRightCollisions(dt)
        end
        ]]
    end

    --[[
    -- check if we've collided with any entities and die if so
    for k, entity in pairs(self.player.level.entities) do
        if entity:collides(self.player) then
            gSounds['death']:play()
            gStateMachine:change('start')
        end
    end
    ]]

    if love.keyboard.wasPressed('w') then
        self.artemis:changeState('jump')
    end
end