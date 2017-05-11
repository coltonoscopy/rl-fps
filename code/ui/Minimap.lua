--[[
    Texture generated from the map, displayed in the bottom-right corner.
]]

Minimap = Class{}

function Minimap:init(map, player)
    self.map = map
    self.player = player

    self:computeMinimap()
    self.mapImg:setFilter('nearest', 'nearest')

    Event.on('player-move', function()
        self:computeMinimap()
    end)
end

function Minimap:computeMinimap()
    self.pixelData = love.image.newImageData(self.map.mapWidth, self.map.mapHeight)

    for y = 1, self.map.mapHeight do
        for x = 1, self.map.mapWidth do
            if self.map:getTile(x - 1, y - 1) and self.map:getTile(x - 1, y - 1).id == 858 then
                self.pixelData:setPixel(x - 1, y - 1, 160, 160, 160, 255)
            else
                self.pixelData:setPixel(x - 1, y - 1, 48, 48, 48, 255)
            end
        end
    end

    self.pixelData:setPixel(self.player.x, self.player.y, 255, 0, 0, 255)

    self.mapImg = love.graphics.newImage(self.pixelData)
end

function Minimap:update(dt)

end

function Minimap:render()
    love.graphics.draw(self.mapImg, virtualWidth - 60, virtualHeight - 60, 0, 2, 2)
end
