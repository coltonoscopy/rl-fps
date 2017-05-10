--[[
    Using a Map as its data source, renders a 2d grid map in a pseudo-3D
    fashion, drawing out faces for every wall in the scene, back to front.
]]

MapRenderer = Class{}

X_UV_OFF = 0.003
Y_UV_OFF = 0.000001

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
        ['floorA-L'] = {
            {-virtualWidth / 3, virtualHeight - virtualHeight / 8},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {-virtualWidth / 23, virtualHeight + virtualHeight / 8},
            {-virtualWidth / 3, virtualHeight + virtualHeight / 8}
        },
        ['floorA-R'] = {
            {virtualWidth + virtualWidth / 3, virtualHeight - virtualHeight / 8},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth + virtualWidth / 23, virtualHeight + virtualHeight / 8},
            {virtualWidth + virtualWidth / 3, virtualHeight + virtualHeight / 8}
        },
        ['floorB'] = {
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
        },
        ['floorB-L'] = {
            {-virtualWidth / 8, virtualHeight - virtualHeight / 3},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {-virtualWidth / 3, virtualHeight - virtualHeight / 8},
        },
        ['floorB-R'] = {
            {virtualWidth + virtualWidth / 8, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth + virtualWidth / 3, virtualHeight - virtualHeight / 8},
        },
        ['floorC'] = {
            {virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
        },
        ['floorC-L'] = {
            {virtualWidth / 6, virtualHeight / 1.9},
            {virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {-virtualWidth / 8, virtualHeight - virtualHeight / 3},
        },
        ['floorC-LL'] = {
            {-virtualWidth / 10, virtualHeight / 1.9},
            {virtualWidth / 6, virtualHeight / 1.9},
            {-virtualWidth / 8, virtualHeight - virtualHeight / 3},
            {-virtualWidth / 4, virtualHeight - virtualHeight / 3},
        },
        ['floorC-R'] = {
            {virtualWidth - virtualWidth / 6, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth + virtualWidth / 8, virtualHeight - virtualHeight / 3},
        },
        ['floorC-RR'] = {
            {virtualWidth + virtualWidth / 10, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 6, virtualHeight / 1.9},
            {virtualWidth + virtualWidth / 8, virtualHeight - virtualHeight / 3},
            {virtualWidth + virtualWidth / 4, virtualHeight - virtualHeight / 3},
        },
        ['floorD'] = {
            {virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth - virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 2.55, virtualHeight / 1.9},
        },
        ['wallA-L'] = {
            {-virtualWidth / 12, -virtualHeight / 8},
            {virtualWidth / 7, virtualHeight / 13},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {-virtualWidth / 12, virtualHeight + virtualHeight / 6}
        },
        ['wallA-R'] = {
            {virtualWidth + virtualWidth / 12, -virtualHeight / 8},
            {virtualWidth - virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth + virtualWidth / 12, virtualHeight + virtualHeight / 6}
        },
        ['wallB-L'] = {
            {virtualWidth / 7, virtualHeight / 13},
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8}
        },
        ['wallB-R'] = {
            {virtualWidth - virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8}
        },
        ['wallC-L'] = {
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3}
        },
        ['wallC-R'] = {
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3}
        },
        ['wallD-L'] = {
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth / 2.25, virtualHeight / 2.85},
            {virtualWidth / 2.25, virtualHeight / 2.2},
            {virtualWidth / 2.55, virtualHeight / 1.9}
        },
        ['wallD-R'] = {
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
        ['faceA-L'] = {
            {-virtualWidth / 2, virtualHeight / 13},
            {virtualWidth / 7, virtualHeight / 13},
            {virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {-virtualWidth / 2, virtualHeight - virtualHeight / 8}
        },
        ['faceA-R'] = {
            {virtualWidth + virtualWidth / 2, virtualHeight / 13},
            {virtualWidth - virtualWidth / 7, virtualHeight / 13},
            {virtualWidth - virtualWidth / 7, virtualHeight - virtualHeight / 8},
            {virtualWidth + virtualWidth / 2, virtualHeight - virtualHeight / 8}
        },
        ['faceB'] = {
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3}
        },
        ['faceB-L'] = {
            {-virtualWidth / 8, virtualHeight / 4.7},
            {virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {-virtualWidth / 8, virtualHeight - virtualHeight / 3}
        },
        ['faceB-R'] = {
            {virtualWidth + virtualWidth / 8, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight / 4.7},
            {virtualWidth - virtualWidth / 3.4, virtualHeight - virtualHeight / 3},
            {virtualWidth + virtualWidth / 8, virtualHeight - virtualHeight / 3}
        },
        ['faceC'] = {
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 2.55, virtualHeight / 1.9}
        },
        ['faceC-L'] = {
            {virtualWidth / 6, virtualHeight / 3.3},
            {virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth / 6, virtualHeight / 1.9}
        },
        ['faceC-LL'] = {
            {-virtualWidth / 10, virtualHeight / 3.3},
            {virtualWidth / 6, virtualHeight / 3.3},
            {virtualWidth / 6, virtualHeight / 1.9},
            {-virtualWidth / 10, virtualHeight / 1.9}
        },
        ['faceC-R'] = {
            {virtualWidth - virtualWidth / 6, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 2.55, virtualHeight / 1.9},
            {virtualWidth - virtualWidth / 6, virtualHeight / 1.9}
        },
        ['faceC-RR'] = {
            {virtualWidth + virtualWidth / 10, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 6, virtualHeight / 3.3},
            {virtualWidth - virtualWidth / 6, virtualHeight / 1.9},
            {virtualWidth + virtualWidth / 10, virtualHeight / 1.9}
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
    persp.setRepeat({23/62 + X_UV_OFF / 2, 14/48}, {1/62 - 1/(62*32), 1/48})

    self:drawQuad('floorA')
    self:drawQuad('floorA-L')
    self:drawQuad('floorA-R')

    self:drawQuad('floorB')
    self:drawQuad('floorB-L')
    self:drawQuad('floorB-R')

    self:drawQuad('floorC')
    self:drawQuad('floorC-L')
    self:drawQuad('floorC-LL')
    self:drawQuad('floorC-R')
    self:drawQuad('floorC-RR')

    self:drawQuad('floorD')

    -- draw walls
    persp.setRepeat({26/62 + X_UV_OFF, 17/48 - Y_UV_OFF}, {1/62 - 1/(62*32), 1/48})

    -- self:drawQuad('wallA-L')
    -- self:drawQuad('wallA-R')
    -- self:drawQuad('wallB-L')
    -- self:drawQuad('wallB-R')

    -- self:drawQuad('wallC-L')
    -- self:drawQuad('wallC-R')

    self:drawQuad('wallD-L')
    self:drawQuad('wallD-R')

    -- draw faces
    self:drawQuad('faceD')
    -- self:drawQuad('faceC')
    self:drawQuad('faceC-L')
    self:drawQuad('faceC-LL')
    self:drawQuad('faceC-R')
    self:drawQuad('faceC-RR')
    -- self:drawQuad('faceB')
    -- self:drawQuad('faceA')
    -- self:drawQuad('faceA-L')
    -- self:drawQuad('faceA-R')
    -- self:drawQuad('faceB-L')
    -- self:drawQuad('faceB-R')
    -- self:drawQuad('faceC-L')
    -- self:drawQuad('faceC-R')
end
