--[[
    State for when we are walking about in the game world ("exploring").
]]

ExploreState = Class{__includes = BaseState}

function ExploreState:init()
    self.map = Map {
        texture = gTextures['tiles'],
        frames = gFrames['tiles'],
        tileHeight = 32,
        tileWidth = 32,
        mapWidth = 100,
        mapHeight = 100
    }

    self.player = Entity {
        x = 7,
        y = 4,
        texture = gTextures['tiles'],
        frame = 129,
    }

    self.floor = self:createFloorVertices()
end

function ExploreState:getUVsByFrame(texture, frame, tileHeight, tileWidth)
    local textureWidth = texture:getWidth()
    local textureHeight = texture:getHeight()
    local tilesPerRow = textureWidth / 32
    local tilesPerColumn = textureHeight / 32
    local numTiles = tilesPerRow * tilesPerColumn

    local x = frame % tilesPerRow + 1
    local y = math.floor(frame / tilesPerRow)

    local xIncrement = 1 / tilesPerRow
    local yIncrement = 1 / tilesPerColumn

    local topLeft = {
        xIncrement * x, yIncrement * y
    }
    print_r(topLeft)

    local topRight = {
        xIncrement * x + xIncrement, yIncrement * y
    }
    print_r(topRight)

    local bottomRight = {
        xIncrement * x + xIncrement, yIncrement * y + yIncrement
    }
    print_r(bottomRight)

    local bottomLeft = {
        xIncrement * x, yIncrement * y + yIncrement
    }
    print_r(bottomLeft)

    return topLeft, topRight, bottomRight, bottomLeft;
end

function ExploreState:createFloorVertices()
    local topLeft, topRight, bottomRight, bottomLeft =
        self:getUVsByFrame(gTextures['tiles'], 1179, 32, 32)

    return {
        {
            -- top-left corner
            0 + 192, 0 + 160,
            topLeft[1], topLeft[2],
            255, 255, 255
        },
        {
            -- top-right corner
            128 + 192, 0 + 160,
            topRight[1], topRight[2],
            255, 255, 255
        },
        {
            -- bottom-right corner
            256 + 192, 128 + 160,
            bottomRight[1], bottomRight[2],
            255, 255, 255
        },
        {
            -- bottom-left corner
            -128 + 192, 128 + 160,
            bottomLeft[1], bottomLeft[2],
            255, 255, 255
        }
    }
end

function ExploreState:update(dt)
    self.player:update(dt)
end

function ExploreState:render()
    self:renderMap()
    self.player:render()
end

function ExploreState:renderMap()
    -- render the ground and the ceiling
    love.graphics.clear()
    persp.setRepeat({26/62 + 0.0025,18/48 - 0.00015}, {1/62, 1/48})
    persp.quad(gTextures['tiles'], self.floor[1], self.floor[2], self.floor[3], self.floor[4])
end
