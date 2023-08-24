--[[
    Credits:

    ARTWORK
    Title Artwork: auroradiation via tumblr (https://auroradiation.tumblr.com/post/190395259819)
    Tilesheet = https://trixelized.itch.io/starstring-fields
    Artemis: https://luizmelo.itch.io/huntress-2
    Apollo: https://luizmelo.itch.io/medieval-warrior-pack-2

    MUSIC
    Main Music: https://freesound.org/people/Setuniman/sounds/234106/
    Pickup: https://freesound.org/people/TreasureSounds/sounds/332629/
    Damage: https://freesound.org/people/ash_rez/sounds/518887/
    Fanfare: https://freesound.org/people/joepayne/sounds/413204/

    FONT
    Backslash by SilverDav Studio (https://www.fontspace.com/backslash-font-f46754)
]]

--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/StartState'
require 'src/states/GameOverState'
require 'src/states/YouWonState'

--general
require 'src/Tile'
require 'src/Animation'
require 'src/Character'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/TileMap'
require 'src/LevelOne'
require 'src/LevelTwo'
require 'src/LevelThree'

--character states
require 'src/states/character/ArtemisIdleState'
require 'src/states/character/ArtemisWalkingState'
require 'src/states/character/ArtemisFallingState'
require 'src/states/character/ArtemisJumpState'
require 'src/states/character/ApolloIdleState'
require 'src/states/character/ApolloWalkingState'
require 'src/states/character/ApolloFallingState'
require 'src/states/character/ApolloJumpState'


gSounds = {
    ['music'] = love.audio.newSource('sounds/piano-loop.wav', 'static'),
    ['pickup'] = love.audio.newSource('sounds/pickup.ogg', 'static'),
    ['damage'] = love.audio.newSource('sounds/damage.wav', 'static'),
    ['fall'] = love.audio.newSource('sounds/fall.wav', 'static'),
    ['fanfare'] = love.audio.newSource('sounds/fanfare.mp3', 'static')
}

gTextures = {
    ['title'] = love.graphics.newImage('graphics/TitleArtwork.jpeg'),
    ['background1'] = love.graphics.newImage('graphics/background_0.png'),
    ['background2'] = love.graphics.newImage('graphics/background_1.png'),
    ['background3'] = love.graphics.newImage('graphics/background_2.png'),
    ['tiles'] = love.graphics.newImage('graphics/tileset.png'), --tileset is 18 by 11 tiles
    ['artemis'] = love.graphics.newImage('graphics/Artemis/Run.png'),
    ['apollo'] = love.graphics.newImage('graphics/Apollo/Run.png'),
    ['sun'] = love.graphics.newImage('graphics/sparkle.png'),
    ['moon'] = love.graphics.newImage('graphics/silver.png')
}


gFrames = {
    
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['artemis'] = GenerateQuads(gTextures['artemis'], 100/3, 100/3),
    ['apollo'] = GenerateQuads(gTextures['apollo'], 100/3, 100/3),
}

gFonts = {
    ['title'] = love.graphics.newFont('fonts/Backslash-RpJol.otf', 15)
}
