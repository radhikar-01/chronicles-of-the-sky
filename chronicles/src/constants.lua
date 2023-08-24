--[[
   all constants
]]

-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 288
VIRTUAL_HEIGHT = 160

-- global standard tile size
TILE_SIZE = 16

-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

-- player walking speed
PLAYER_WALK_SPEED = 60
-- player jumping velocity
PLAYER_JUMP_VELOCITY = -150