--[[

]]

LevelOne = Class{}

function LevelOne.generate(width, height)
    local tiles = {}
    local objects = {}

    -- insert blank tables into tiles for later access
    for x = 1, height do
        table.insert(tiles, {})
    end

    for x = 1, width do 
        for y = 1, height do
            table.insert(tiles[y], Tile(x, y, 18, 1, false))
        end
    end

    --general ground
    for i = 1, 7, 1
    do 
        local tile = Tile(i, 10, 162 + i, 1, true)
        table.insert(tiles[10], i, tile)
    end

    local bush1 = Tile(8, 10, 152, 1, false)
    table.insert( tiles[10], 8, bush1)
    local bush2 = Tile(9, 10, 153, 1, false)
    table.insert(tiles[10], 9, bush2)

    for i = 15, 18, 1
    do 
        local tile = Tile(i, 10, 162 + i, 1, true)
        table.insert(tiles[10], i, tile)
    end

    --small tree
    local offset = 1
    for i = 145, 91, -18
    do 
        for j = 1, 4, 1
        do 
            local tree = Tile(j, (height - offset), i + (j - 1), 1, false)
            table.insert(tiles[height - offset], j, tree)
        end
        offset = offset + 1
    end

    --platform 1
    local idOffset = 78
    for i = 6, 8, 1
    do 
        local platOne = Tile(i, (height - 2), idOffset, 1, true)
        table.insert(tiles[height - 2], i, platOne)
        idOffset = idOffset + 2
    end

    --sparkle 1
    table.insert(objects,
        GameObject {
            texture = 'moon',
            x = (7 * TILE_SIZE) + 4,
            y = (height - 4) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            -- sparkle has it's own function when collided
            onConsume = function(player)
                if (player.magic == 'moon') then
                    gSounds['pickup']:play()
                else
                    gSounds['damage']:play()
                    gStateMachine:change('gameOver')
                end
            end
        }
    )

     --platform 2
     local idOffset = 78
     for i = 9, 11, 1
     do 
         local platTwo = Tile(i, (height/2), idOffset, 1, true)
         table.insert(tiles[(height/2)], i, platTwo)
         idOffset = idOffset + 2
     end
     
     --sparkle 2
    table.insert(objects,
        GameObject {
            texture = 'sun',
            x = (13 * TILE_SIZE) + 4,
            y = (height/2) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            onConsume = function(player)
                if (player.magic == 'sun') then
                    gSounds['pickup']:play()
                else
                    gSounds['damage']:play()
                    gStateMachine:change('gameOver')
                end
            end
        }
    )

     --platform 3
     local idOffset = 78
     for i = 12, 14, 1
     do 
         local platThree = Tile(i, height - 3, idOffset, 1, true)
         table.insert(tiles[height - 3], i, platThree)
         idOffset = idOffset + 2
     end

     --sparkle 3
    table.insert(objects,
        GameObject {
            texture = 'sun',
            x = (10 * TILE_SIZE) + 4,
            y = ((height/2) - 2) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            onConsume = function(player)
                if (player.magic == 'sun') then
                    gSounds['pickup']:play()
                else
                    gSounds['damage']:play()
                    gStateMachine:change('gameOver')
                end
            end
        }
    )

     --platform 4
    local idOffset = 78
    for i = 4, 6, 1
    do 
        local platFour = Tile(i, (height/2) - 2, idOffset, 1, true)
        table.insert(tiles[(height/2) - 2], i, platFour)
        idOffset = idOffset + 2
    end
     --sparkle 4
     table.insert(objects,
         GameObject {
             texture = 'moon',
             x = (5 * TILE_SIZE) + 4,
             y = ((height/2) - 4) * TILE_SIZE + 4,
             width = 8,
             height = 8,
             collidable = true,
             consumable = true,
             solid = false,
 
             onConsume = function(player)
                if (player.magic == 'moon') then
                    gSounds['pickup']:play()
                else
                    gSounds['damage']:play()
                    gStateMachine:change('gameOver')
                end
            end
         }
     )

    --big tree
    local offset = 1
    for i = 156, 12, -18
    do 
        for j = 1, 4, 1
        do 
            local tree = Tile(width - (4-j), (height - offset), i + (j - 1), 1, false)
            table.insert(tiles[height - offset], width - (4-j), tree)
        end
        offset = offset + 1
    end

    local map = TileMap()
    map.tiles = tiles
    
    return GameLevel(objects, map)
end