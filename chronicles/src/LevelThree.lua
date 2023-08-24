--[[

]]

LevelThree = Class{}

function LevelThree.generate(width, height)
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


    --platform 1
    local idOffset = 78
    for i = 1, 3, 1
    do 
        local platOne = Tile(i, (10), idOffset, 1, true)
        table.insert(tiles[10], i, platOne)
        idOffset = idOffset + 2
    end

    --platform 3
    local idOffset = 78
    for i = 3, 5, 1
    do 
        local platThree = Tile(i, (height - 3), idOffset, 1, true)
        table.insert(tiles[height - 3], i, platThree)
        idOffset = idOffset + 2
    end

    --platform 5
    local idOffset = 78
    for i = 1, 3, 1
    do 
        local platFive= Tile(i, (height - 6), idOffset, 1, true)
        table.insert(tiles[height - 6], i, platFive)
        idOffset = idOffset + 2
    end

    --sparkle 1
    table.insert(objects,
        GameObject {
            texture = 'sun',
            x = (2 * TILE_SIZE) + 4,
            y = (height - 8) * TILE_SIZE + 4,
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

    --big tree
    local offset = 1
    for i = 156, 12, -18
    do 
        for j = 6, 12, 1
        do 
            local tree = Tile(j, (height - offset), i + (j - 6), 1, false)
            table.insert(tiles[height - offset], j, tree)
        end
        offset = offset + 1
    end

    for i = 6, 12, 1
    do 
        local tile = Tile(i, 10, 162 + i, 1, true)
        table.insert(tiles[10], i, tile)
    end

    --sparkle 3
    table.insert(objects,
        GameObject {
            texture = 'sun',
            x = (8 * TILE_SIZE) + 4,
            y = (height - 2) * TILE_SIZE + 4,
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

    --platform 2
    local idOffset = 78
    for i = 16, 18, 1
    do 
        local platTwo = Tile(i, (10), idOffset, 1, true)
        table.insert(tiles[10], i, platTwo)
        idOffset = idOffset + 2
    end

    --platform 4
    local idOffset = 78
    for i = 14, 16, 1
    do 
        local platFour= Tile(i, (height - 3), idOffset, 1, true)
        table.insert(tiles[height - 3], i, platFour)
        idOffset = idOffset + 2
    end

    --platform 6
    local idOffset = 78
    for i = 16, 18, 1
    do 
        local platSix = Tile(i, (height - 6), idOffset, 1, true)
        table.insert(tiles[height - 6], i, platSix)
        idOffset = idOffset + 2
    end

    --sparkle 2
    table.insert(objects,
        GameObject {
            texture = 'moon',
            x = (15 * TILE_SIZE) + 4,
            y = (height - 8) * TILE_SIZE + 4,
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

    --[[
    --general ground
    for i = 1, 4, 1
    do 
        local tile = Tile(i, 10, 162 + i, 1, true)
        table.insert(tiles[10], i, tile)
    end

    for i = 15, 18, 1
    do 
        local tile = Tile(i, 10, 162 + i, 1, true)
        table.insert(tiles[10], i, tile)
    end

    --sparkle 1
    table.insert(objects,
        GameObject {
            texture = 'moon',
            x = (5 * TILE_SIZE) + 4,
            y = (height - 3) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            -- sparkle has it's own function when collided
            onConsume = function(player, object)
                --gSounds['pickup']:play()
                --table.remove(objects, sparkleID)
            end
        }
    )

    --platform 2
    local idOffset = 78
    for i = 6, 8, 1
    do 
        local platOne = Tile(i, (height - 3), idOffset, 1, true)
        table.insert(tiles[height - 3], i, platOne)
        idOffset = idOffset + 2
    end

    --sparkle 2
    table.insert(objects,
        GameObject {
            texture = 'moon',
            x = (7 * TILE_SIZE) + 4,
            y = (height - 5) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            -- sparkle has it's own function when collided
            onConsume = function(player, object)
                --gSounds['pickup']:play()
                --table.remove(objects, sparkleID)
            end
        }
    )

    --small tree
    local offset = 6
    for i = 145, 91, -18
    do 
        for j = 8, 11, 1
        do 
            local tree = Tile(j, (height - offset), i + (j - 8), 1, false)
            table.insert(tiles[height - offset], j, tree)
        end
        offset = offset + 1
    end

    for i = 8, 11, 1
    do 
        local tile = Tile(i, height - 5, 162 + i, 1, true)
        table.insert(tiles[height - 5], i, tile)
    end

    local hang1 = Tile(9, height - 4, 37, 1, false)
    table.insert(tiles[height - 4], 9, hang1)
    local hang2 = Tile(9, height - 3, 55, 1, false)
    table.insert(tiles[height - 3], 9, hang2)
    local hang3 = Tile(10, height - 4, 38, 1, false)
    table.insert(tiles[height - 4], 10, hang3)

    --platform 3
    local idOffset = 78
    for i = 11, 13, 1
    do 
        local platOne = Tile(i, (height - 3), idOffset, 1, true)
        table.insert(tiles[height - 3], i, platOne)
        idOffset = idOffset + 2
    end

    --sparkle 3
    table.insert(objects,
        GameObject {
            texture = 'moon',
            x = (12 * TILE_SIZE) + 4,
            y = (height - 5) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            -- sparkle has it's own function when collided
            onConsume = function(player, object)
                --gSounds['pickup']:play()
                --table.remove(objects, sparkleID)
            end
        }
    )

    --platform 4
    local idOffset = 78
    for i = 13, 15, 1
    do 
        local platOne = Tile(i, (height - 1), idOffset, 1, true)
        table.insert(tiles[height - 1], i, platOne)
        idOffset = idOffset + 2
    end

    --sparkle 4
    table.insert(objects,
        GameObject {
            texture = 'moon',
            x = (14 * TILE_SIZE) + 4,
            y = (height - 3) * TILE_SIZE + 4,
            width = 8,
            height = 8,
            collidable = true,
            consumable = true,
            solid = false,

            -- sparkle has it's own function when collided
            onConsume = function(player, object)
                --gSounds['pickup']:play()
                --table.remove(objects, sparkleID)
            end
        }
    )
    ]]

    local map = TileMap()
    map.tiles = tiles
    
    return GameLevel(objects, map)
end