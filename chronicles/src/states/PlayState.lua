--[[

    -- PlayState Class --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:enter(params)
    currLevel = params.cLevel 
    
    if (currLevel == 1) then
        self.level = LevelOne.generate(VIRTUAL_WIDTH/16, VIRTUAL_HEIGHT/16)
    elseif (currLevel == 2) then
        self.level = LevelTwo.generate(VIRTUAL_WIDTH/16, VIRTUAL_HEIGHT/16)
    else
        self.level = LevelThree.generate(VIRTUAL_WIDTH/16, VIRTUAL_HEIGHT/16)
    end

    self.tileMap = self.level.tileMap
    
    self.artemis = Character({
        x = 0, y = VIRTUAL_HEIGHT - 32,
        width = 16, height = 16,
        texture = 'artemis',
        stateMachine = StateMachine {
            ['idle'] = function() return ArtemisIdleState(self.artemis) end,
            ['walking'] = function() return ArtemisWalkingState(self.artemis) end,
            ['jump'] = function() return ArtemisJumpState(self.artemis, 6) end,
            ['falling'] = function() return ArtemisFallingState(self.artemis, 6) end
        },
        magic = 'moon',
        map = self.tileMap,
        level = self.level
    })
    self.artemis:changeState('idle')

    
    self.apollo = Character({
        x = VIRTUAL_WIDTH - 16, y = VIRTUAL_HEIGHT - 32,
        width = 16, height = 16,
        texture = 'apollo',
        stateMachine = StateMachine {
            ['idle'] = function() return ApolloIdleState(self.apollo) end,
            ['walking'] = function() return ApolloWalkingState(self.apollo) end,
            ['jump'] = function() return ApolloJumpState(self.apollo, 6) end,
            ['falling'] = function() return ApolloFallingState(self.apollo, 6) end
        },
        magic = 'sun',
        map = self.tileMap,
        level = self.level
    })
    self.apollo.direction = 'left'
    self.apollo:changeState('idle')
    
end

function PlayState:update(dt)
    self.level:update(dt)
    self.artemis:update(dt)
    self.apollo:update(dt)

    -- constrain player X no matter which state
    if self.artemis.x <= 0 then
        self.artemis.x = 0
    elseif self.artemis.x > VIRTUAL_WIDTH - self.artemis.width then
        self.artemis.x = VIRTUAL_WIDTH - self.artemis.width
    end

    --constrain player X no matter which state
    if self.apollo.x <= 0 then
        self.apollo.x = 0
    elseif self.apollo.x > VIRTUAL_WIDTH - self.apollo.width then
        self.apollo.x = VIRTUAL_WIDTH - self.apollo.width
    end
    

    --check for when the game is won
    if (#self.level.objects == 0) then 
        if (currLevel == 1) then 
            gStateMachine:change('play', {
                cLevel = 2
            })
        elseif (currLevel == 2) then 
            gStateMachine:change('play', {
                cLevel = 3
            })
        else
            gSounds['fanfare']:play()
            gStateMachine:change('youWon')
        end

    end
end

function PlayState:render()
    love.graphics.draw(gTextures['background1'])
    love.graphics.draw(gTextures['background2'])
    love.graphics.draw(gTextures['background3'])

    --tiles
    self.level:render()
    -- artemis
    self.artemis:render()
    -- apollo
    self.apollo:render()
end

