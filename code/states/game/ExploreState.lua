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

    self.floor = self:createFloorVertices(1179)
    self.leftWallNear = self:createLeftWallNearVertices()
    self.rightWallNear = self:createRightWallNearVertices()
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
    return {
        {
            -- top-left corner
            192, 160
        },
        {
            -- top-right corner
            320, 160,
        },
        {
            -- bottom-right corner
            448, 288,
        },
        {
            -- bottom-left corner
            64, 288,
        }
    }
end

function ExploreState:createLeftWallNearVertices()
    return {
        {
            -- top-left corner
            0, 64,
        },
        {
            -- top-right corner
            192, 64,
        },
        {
            -- bottom-right corner
            192, 160,
        },
        {
            -- bottom-left corner
            0, 360,
        }
    }
end

function ExploreState:createRightWallNearVertices()
    return {
        {
            -- top-right corner
            virtualWidth, 64,
        },
        {
            -- top-left corner
            virtualWidth - 192, 64,
        },
        {
            -- bottom-left corner
            virtualWidth - 192, 160,
        },
        {
            -- bottom-left corner
            virtualWidth, 360,
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

    -- draw floor
    persp.setRepeat({26/62 + 0.0025,18/48 - 0.00015}, {1/62, 1/48})
    persp.quad(gTextures['tiles'], self.floor[1], self.floor[2], self.floor[3], self.floor[4])

    -- draw left wall
    persp.setRepeat({25/62 + 0.0025,16/48 - 0.00015}, {1/62, 1/48})
    persp.quad(gTextures['tiles'], self.leftWallNear[1], self.leftWallNear[2],
        self.leftWallNear[3], self.leftWallNear[4])

    -- draw right wall
    persp.setRepeat({25/62 + 0.0025,16/48 - 0.00015}, {1/62, 1/48})
    persp.quad(gTextures['tiles'], self.rightWallNear[1], self.rightWallNear[2],
        self.rightWallNear[3], self.rightWallNear[4])
end
