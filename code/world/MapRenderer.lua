--[[
    Using a Map as its data source, renders a 2d grid map in a pseudo-3D
    fashion, drawing out faces for every wall in the scene, back to front.
]]

MapRenderer = Class{}

X_UV_OFF = 0.0025
Y_UV_OFF = 0.00015

function MapRenderer:init(map)
    self.map = map

    -- all the quads that represent our scene
    self.quads = {
        ['floorA'] = {
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth + virtualWidth / 5, virtualHeight + virtualHeight / 3},
            {-virtualWidth / 5, virtualHeight + virtualHeight / 3}
        },
        ['floorB'] = {
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
        },
        ['floorC'] = {
            {virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
        },
        ['floorD'] = {
            {virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth - virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 2.55, virtualHeight / 1.9},
        },
        ['wallLeftA'] = {
            {-virtualWidth / 12, -virtualHeight / 8},
            {virtualWidth / 7, virtualHeight / 13},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {-virtualWidth / 12, virtualHeight + virtualHeight / 6}
        },
        ['wallRightA'] = {
            {virtualWidth + virtualWidth / 12, -virtualHeight / 8},
            {virtualWidth - virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth + virtualWidth / 12, virtualHeight + virtualHeight / 6}
        },
        ['wallLeftB'] = {
            {virtualWidth / 7, virtualHeight / 13},
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8}
        },
        ['wallRightB'] = {
            {virtualWidth - virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8}
        },
        ['wallLeftC'] = {
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3}
        },
        ['wallRightC'] = {
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3}
        },
        ['wallLeftD'] = {
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth / 2.25, virtualHeight / 2.85},
            {virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth / 2.55, virtualHeight / 1.9}
        },
        ['wallRightD'] = {
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.25, virtualHeight / 2.85},
            {virtualWidth - virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9}
        },
        ['faceA'] = {
            {virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8}
        },
        ['faceB'] = {
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3}
        },
        ['faceC'] = {
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 2.55, virtualHeight / 1.9}
        },
        ['faceD'] = {
            {virtualWidth / 2.25, virtualHeight / 2.85},
            {virtualWidth - virtualWidth / 2.25, virtualHeight / 2.85},
            {virtualWidth - virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth / 2.25, virtualHeight / 2.2}
        }
    }
end

--[[
    Draws a quad by looking up its vertices in the renderer's quad table.
]]
function MapRenderer:drawQuad(name)
    persp.quad(
        gTextures['tiles'],
        self.quads[name][1],
        self.quads[name][2],
        self.quads[name][3],
        self.quads[name][4]
    )
end

--[[
    Given a texture and its frame # (starting top-left, moving to bottom-right),
    calculate its UV coordinates, top left and bottom right.
]]
function MapRenderer:getUVsByFrame(texture, frame, tileHeight, tileWidth)
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

function MapRenderer:render()
    -- draw floors
    persp.setRepeat({26/62 + X_UV_OFF, 18/48 - Y_UV_OFF}, {1/62, 1/48})
    self:drawQuad('floorA')
    self:drawQuad('floorB')
    self:drawQuad('floorC')
    self:drawQuad('floorD')

    -- draw walls
    persp.setRepeat({25/62 + X_UV_OFF, 16/48 - Y_UV_OFF}, {1/62, 1/48})
    self:drawQuad('wallLeftA')
    self:drawQuad('wallRightA')
    self:drawQuad('wallLeftB')
    self:drawQuad('wallRightB')
    self:drawQuad('wallLeftC')
    self:drawQuad('wallRightC')
    self:drawQuad('wallLeftD')
    self:drawQuad('wallRightD')

    -- draw faces
    self:drawQuad('faceD')
    -- self:drawQuad('faceC')
    -- self:drawQuad('faceB')
    -- self:drawQuad('faceA')
end
