--[[

    -- TileMap Class --
]]

TileMap = Class{}

function TileMap:init()
    self.tiles = {}
end

--[[
    If our tiles were animated, this is potentially where we could iterate over all of them
    and update either per-tile or per-map animations for appropriately flagged tiles!
]]
function TileMap:update(dt)

end

--[[
    Returns the x, y of a tile given an x, y of coordinates in the world space.
]]
function TileMap:pointToTile(x, y)
    if x < 0 or x > VIRTUAL_WIDTH or y < 0 or y > VIRTUAL_HEIGHT then
        return nil
    end
    
    return self.tiles[math.floor(y / TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1]
end

function TileMap:render()
    for y = 1, VIRTUAL_HEIGHT/16 do
        for x = 1, VIRTUAL_WIDTH/16 do
            self.tiles[y][x]:render()
        end
    end
end