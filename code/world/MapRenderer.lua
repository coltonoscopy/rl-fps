--[[
    Using a Map as its data source, renders a 2d grid map in a pseudo-3D
    fashion, drawing out faces for every wall in the scene, back to front.
]]

MapRenderer = Class{}

-- UV offsets to clean up bleeding edges
X_UV_OFF = 0.003
Y_UV_OFF = 0.000001

function MapRenderer:init(map)
    self.map = map

    -- references to virtualWidth and virtualHeight, avoid typing chars
    local vw = virtualWidth
    local vh = virtualHeight

    -- all the quads that represent our scene
    self.quads = {
        ['floorA'] = {
            {vw / 7, vh - vh / 8},
            {vw - vw / 7, vh - vh / 8},
            {vw + vw / 5, vh + vh / 3},
            {-vw / 5, vh + vh / 3}
        },
        ['floorA-L'] = {
            {-vw / 3, vh - vh / 8},
            {vw / 7, vh - vh / 8},
            {-vw / 23, vh + vh / 8},
            {-vw / 3, vh + vh / 8}
        },
        ['floorA-R'] = {
            {vw + vw / 3, vh - vh / 8},
            {vw - vw / 7, vh - vh / 8},
            {vw + vw / 23, vh + vh / 8},
            {vw + vw / 3, vh + vh / 8}
        },
        ['floorB'] = {
            {vw / 3.4, vh - vh / 3},
            {vw - vw / 3.4, vh - vh / 3},
            {vw - vw / 7, vh - vh / 8},
            {vw / 7, vh - vh / 8},
        },
        ['floorB-L'] = {
            {-vw / 8, vh - vh / 3},
            {vw / 3.4, vh - vh / 3},
            {vw / 7, vh - vh / 8},
            {-vw / 3, vh - vh / 8},
        },
        ['floorB-R'] = {
            {vw + vw / 8, vh - vh / 3},
            {vw - vw / 3.4, vh - vh / 3},
            {vw - vw / 7, vh - vh / 8},
            {vw + vw / 3, vh - vh / 8},
        },
        ['floorC'] = {
            {vw / 2.55, vh / 1.9},
            {vw - vw / 2.55, vh / 1.9},
            {vw - vw / 3.4, vh - vh / 3},
            {vw / 3.4, vh - vh / 3},
        },
        ['floorC-L'] = {
            {vw / 6, vh / 1.9},
            {vw / 2.55, vh / 1.9},
            {vw / 3.4, vh - vh / 3},
            {-vw / 8, vh - vh / 3},
        },
        ['floorC-LL'] = {
            {-vw / 10, vh / 1.9},
            {vw / 6, vh / 1.9},
            {-vw / 8, vh - vh / 3},
            {-vw / 4, vh - vh / 3},
        },
        ['floorC-R'] = {
            {vw - vw / 6, vh / 1.9},
            {vw - vw / 2.55, vh / 1.9},
            {vw - vw / 3.4, vh - vh / 3},
            {vw + vw / 8, vh - vh / 3},
        },
        ['floorC-RR'] = {
            {vw + vw / 10, vh / 1.9},
            {vw - vw / 6, vh / 1.9},
            {vw + vw / 8, vh - vh / 3},
            {vw + vw / 4, vh - vh / 3},
        },
        ['floorD'] = {
            {vw / 2.25, vh / 2.2},
            {vw - vw / 2.25, vh / 2.2},
            {vw - vw / 2.55, vh / 1.9},
            {vw / 2.55, vh / 1.9},
        },
        ['floorD-L'] = {
            {vw / 3.15, vh / 2.2},
            {vw / 2.25, vh / 2.2},
            {vw / 2.55, vh / 1.9},
            {vw / 6, vh / 1.9},
        },
        ['floorD-LL'] = {
            {vw / 6, vh / 2.2},
            {vw / 2.25, vh / 2.2},
            {vw / 6, vh / 1.9},
            {-vw / 10, vh / 1.9},
        },
        ['floorD-LLL'] = {
            {0, vh / 2.2},
            {vw / 6, vh / 2.2},
            {-vw / 10, vh / 1.9},
            {-vw / 6, vh / 1.9},
        },
        ['floorD-R'] = {
            {vw - vw / 3.15, vh / 2.2},
            {vw - vw / 2.25, vh / 2.2},
            {vw - vw / 2.55, vh / 1.9},
            {vw - vw / 6, vh / 1.9},
        },
        ['floorD-RR'] = {
            {vw - vw / 6, vh / 2.2},
            {vw - vw / 2.25, vh / 2.2},
            {vw - vw / 6, vh / 1.9},
            {vw + vw / 10, vh / 1.9},
        },
        ['floorD-RRR'] = {
            {vw, vh / 2.2},
            {vw - vw / 6, vh / 2.2},
            {vw + vw / 10, vh / 1.9},
            {vw + vw / 6, vh / 1.9},
        },
        ['wallA-L'] = {
            {-vw / 12, -vh / 8},
            {vw / 7, vh / 13},
            {vw / 7, vh - vh / 8},
            {-vw / 12, vh + vh / 6}
        },
        ['wallA-R'] = {
            {vw + vw / 12, -vh / 8},
            {vw - vw / 7, vh / 13},
            {vw - vw / 7, vh - vh / 8},
            {vw + vw / 12, vh + vh / 6}
        },
        ['wallB-L'] = {
            {vw / 7, vh / 13},
            {vw / 3.4, vh / 4.7},
            {vw / 3.4, vh - vh / 3},
            {vw / 7, vh - vh / 8}
        },
        ['wallB-R'] = {
            {vw - vw / 7, vh / 13},
            {vw - vw / 3.4, vh / 4.7},
            {vw - vw / 3.4, vh - vh / 3},
            {vw - vw / 7, vh - vh / 8}
        },
        ['wallC-L'] = {
            {vw / 3.4, vh / 4.7},
            {vw / 2.55, vh / 3.3},
            {vw / 2.55, vh / 1.9},
            {vw / 3.4, vh - vh / 3}
        },
        ['wallC-R'] = {
            {vw - vw / 3.4, vh / 4.7},
            {vw - vw / 2.55, vh / 3.3},
            {vw - vw / 2.55, vh / 1.9},
            {vw - vw / 3.4, vh - vh / 3}
        },
        ['wallD-L'] = {
            {vw / 2.55, vh / 3.3},
            {vw / 2.25, vh / 2.85},
            {vw / 2.25, vh / 2.2},
            {vw / 2.55, vh / 1.9}
        },
        ['wallD-R'] = {
            {vw - vw / 2.55, vh / 3.3},
            {vw - vw / 2.25, vh / 2.85},
            {vw - vw / 2.25, vh / 2.2},
            {vw - vw / 2.55, vh / 1.9}
        },
        ['wallE-L'] = {
            {},
            {},
            {},
            {}
        },
        ['wallE-R'] = {

        },
        ['faceA'] = {
            {vw / 7, vh / 13},
            {vw - vw / 7, vh / 13},
            {vw - vw / 7, vh - vh / 8},
            {vw / 7, vh - vh / 8}
        },
        ['faceA-L'] = {
            {-vw / 2, vh / 13},
            {vw / 7, vh / 13},
            {vw / 7, vh - vh / 8},
            {-vw / 2, vh - vh / 8}
        },
        ['faceA-R'] = {
            {vw + vw / 2, vh / 13},
            {vw - vw / 7, vh / 13},
            {vw - vw / 7, vh - vh / 8},
            {vw + vw / 2, vh - vh / 8}
        },
        ['faceB'] = {
            {vw / 3.4, vh / 4.7},
            {vw - vw / 3.4, vh / 4.7},
            {vw - vw / 3.4, vh - vh / 3},
            {vw / 3.4, vh - vh / 3}
        },
        ['faceB-L'] = {
            {-vw / 8, vh / 4.7},
            {vw / 3.4, vh / 4.7},
            {vw / 3.4, vh - vh / 3},
            {-vw / 8, vh - vh / 3}
        },
        ['faceB-R'] = {
            {vw + vw / 8, vh / 4.7},
            {vw - vw / 3.4, vh / 4.7},
            {vw - vw / 3.4, vh - vh / 3},
            {vw + vw / 8, vh - vh / 3}
        },
        ['faceC'] = {
            {vw / 2.55, vh / 3.3},
            {vw - vw / 2.55, vh / 3.3},
            {vw - vw / 2.55, vh / 1.9},
            {vw / 2.55, vh / 1.9}
        },
        ['faceC-L'] = {
            {vw / 6, vh / 3.3},
            {vw / 2.55, vh / 3.3},
            {vw / 2.55, vh / 1.9},
            {vw / 6, vh / 1.9}
        },
        ['faceC-LL'] = {
            {-vw / 10, vh / 3.3},
            {vw / 6, vh / 3.3},
            {vw / 6, vh / 1.9},
            {-vw / 10, vh / 1.9}
        },
        ['faceC-R'] = {
            {vw - vw / 6, vh / 3.3},
            {vw - vw / 2.55, vh / 3.3},
            {vw - vw / 2.55, vh / 1.9},
            {vw - vw / 6, vh / 1.9}
        },
        ['faceC-RR'] = {
            {vw + vw / 10, vh / 3.3},
            {vw - vw / 6, vh / 3.3},
            {vw - vw / 6, vh / 1.9},
            {vw + vw / 10, vh / 1.9}
        },
        ['faceD'] = {
            {vw / 2.25, vh / 2.85},
            {vw - vw / 2.25, vh / 2.85},
            {vw - vw / 2.25, vh / 2.2},
            {vw / 2.25, vh / 2.2}
        },
        ['faceD-L'] = {
            {vw / 3.15, vh / 2.85},
            {vw / 2.25, vh / 2.85},
            {vw / 2.25, vh / 2.2},
            {vw / 3.15, vh / 2.2}
        },
        ['faceD-LL'] = {
            {vw / 6, vh / 2.85},
            {vw / 3.15, vh / 2.85},
            {vw / 3.15, vh / 2.2},
            {vw / 6, vh / 2.2}
        },
        ['faceD-LLL'] = {
            {0, vh / 2.85},
            {vw / 6, vh / 2.85},
            {vw / 6, vh / 2.2},
            {0, vh / 2.2}
        },
        ['faceD-R'] = {
            {vw - vw / 3.15, vh / 2.85},
            {vw - vw / 2.25, vh / 2.85},
            {vw - vw / 2.25, vh / 2.2},
            {vw - vw / 3.15, vh / 2.2}
        },
        ['faceD-RR'] = {
            {vw - vw / 6, vh / 2.85},
            {vw - vw / 3.15, vh / 2.85},
            {vw - vw / 3.15, vh / 2.2},
            {vw - vw / 6, vh / 2.2}
        },
        ['faceD-RRR'] = {
            {vw, vh / 2.85},
            {vw - vw / 6, vh / 2.85},
            {vw - vw / 6, vh / 2.2},
            {vw, vh / 2.2}
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
    self:drawQuad('floorD-L')
    self:drawQuad('floorD-LL')
    self:drawQuad('floorD-LLL')
    self:drawQuad('floorD-R')
    self:drawQuad('floorD-RR')
    self:drawQuad('floorD-RRR')

    -- draw walls
    persp.setRepeat({26/62 + X_UV_OFF, 17/48 - Y_UV_OFF}, {1/62 - 1/(62*32), 1/48})

    -- self:drawQuad('wallA-L')
    -- self:drawQuad('wallA-R')
    -- self:drawQuad('wallB-L')
    -- self:drawQuad('wallB-R')

    self:drawQuad('wallC-L')
    self:drawQuad('wallC-R')

    -- self:drawQuad('wallD-L')
    -- self:drawQuad('wallD-R')

    -- draw faces
    self:drawQuad('faceD')
    self:drawQuad('faceD-L')
    self:drawQuad('faceD-LL')
    self:drawQuad('faceD-LLL')
    self:drawQuad('faceD-R')
    self:drawQuad('faceD-RR')
    self:drawQuad('faceD-RRR')

    -- self:drawQuad('faceC')
    -- self:drawQuad('faceC-L')
    -- self:drawQuad('faceC-LL')
    -- self:drawQuad('faceC-R')
    -- self:drawQuad('faceC-RR')

    -- self:drawQuad('faceB')
    -- self:drawQuad('faceA')
    -- self:drawQuad('faceA-L')
    -- self:drawQuad('faceA-R')
    -- self:drawQuad('faceB-L')
    -- self:drawQuad('faceB-R')
    -- self:drawQuad('faceC-L')
    -- self:drawQuad('faceC-R')
end
