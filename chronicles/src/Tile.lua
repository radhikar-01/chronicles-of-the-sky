--[[
    --Tile Class-
]]

Tile = Class{}

function Tile:init(x, y, id, flip, collidable)
    self.x = x
    self.y = y

    self.id = id

    self.flip = flip

    self.collidable = collidable --this is another way of saying this tile is ground
end

function Tile:render()
    --[[ this was the original way I drew the tiles:
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id], 
            self.x, self.y, 0, (self.flip * 1), 1)
    ]]
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id],
            (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end