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

    self.mapRenderer = MapRenderer(self.map)
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

    self.mapRenderer:render()
end
