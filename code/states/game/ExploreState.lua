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
        mapWidth = 69,
        mapHeight = 69
    }

    self.player = Player {
        x = 2,
        y = 2,
        direction = 'S',
        map = self.map
    }

    self.mapRenderer = MapRenderer(self.map, self.player)
    self.minimap = Minimap(self.map, self.player)
    self.notBox = NotificationBox()
end

function ExploreState:update(dt)
    self.player:update(dt)
    self.minimap:update(dt)
    self.notBox:update(dt)
end

function ExploreState:render()
    self:renderMap()
    self.player:render()
end

function ExploreState:renderMap()
    love.graphics.clear()

    self.mapRenderer:render()
    self.minimap:render()
    self.notBox:render()
end
