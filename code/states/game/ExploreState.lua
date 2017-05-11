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
        mapWidth = 20,
        mapHeight = 20
    }

    self.player = Player {
        x = 7,
        y = 4,
        direction = 'N',
        map = self.map
    }

    self.mapRenderer = MapRenderer(self.map, self.player)
    self.minimap = Minimap(self.map, self.player)
end

function ExploreState:update(dt)
    self.player:update(dt)
end

function ExploreState:render()
    self:renderMap()
end

function ExploreState:renderMap()
    love.graphics.clear()

    self.mapRenderer:render()
    self.minimap:render()
end
