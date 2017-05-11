--[[
    Texture generated from the map, displayed in the bottom-right corner.
]]

Minimap = Class{}

function Minimap:init(map, player)
    self.map = map
    self.player = player

    self:computeMinimap()
    self.mapImg:setFilter('nearest', 'nearest')

    self.display = true

    Event.on('player-move', function()
        self:computeMinimap()
    end)
end

function Minimap:computeMinimap()
    self.pixelData = love.image.newImageData(19 * 5, 19 * 5)

    local left = math.max(1, self.player.x - 9)
    local top = math.max(1, self.player.y - 9)
    local right
    local bottom

    -- get the minimap viewport, taking into consideration map edges
    if left + 18 > self.map.mapWidth then
        right = self.map.mapWidth
        left = right - 18
    else
        right = left + 18
    end

    if top + 18 >= self.map.mapHeight then
        bottom = self.map.mapHeight
        top = bottom - 18
    else
        bottom = top + 18
    end

    -- for each tile, draw 5 pixels to represent it
    for y = top, bottom do
        for x = left, right do
            -- filled tiles
            local c = gColors['gray']
            if self.map:getTile(x, y) and self.map:getTile(x, y).id == 858 then
                for y2 = 0, 4 do
                    for x2 = 0, 4 do
                        self.pixelData:setPixel((x - left) * 5 + x2, (y - top) * 5 + y2,
                            c.r, c.g, c.b, 255)
                    end
                end
            else
            -- empty tiles
            local c = gColors['brown_gray']
                for y2 = 0, 4 do
                    for x2 = 0, 4 do
                        self.pixelData:setPixel((x - left) * 5 + x2, (y - top) * 5 + y2,
                            c.r, c.g, c.b, 255)
                    end
                end
            end

            -- draw items
            local c = gColors['lime']
            if self.map:getTile(x, y) and #self.map:getTile(x, y).items > 0 then
                for y2 = 0, 4 do
                    for x2 = 0, 4 do
                        self.pixelData:setPixel((x - left) * 5 + x2, (y - top) * 5 + y2,
                            c.r, c.g, c.b, 255)
                    end
                end
            end
        end
    end

    -- draw player arrow
    local playerX = self.player.x - left
    local playerY = self.player.y - top
    local c = gColors['red']
    local c2 = gColors['red_gray']

    if self.player.direction == 'N' then
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 1, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 1, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 2, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 0, playerY * 5 + 3, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 3, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 0, playerY * 5 + 4, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 4, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 4, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 4, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 4, c.r, c.g, c.b, 255)
    elseif self.player.direction == 'S' then
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 4, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 3, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 3, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 2, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 0, playerY * 5 + 1, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 1, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 0, playerY * 5, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5, c.r, c.g, c.b, 255)
    elseif self.player.direction == 'W' then
        self.pixelData:setPixel(playerX * 5, playerY * 5 + 2, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 1, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 3, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 3, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 0, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 4, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 0, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 4, c.r, c.g, c.b, 255)
    else
        self.pixelData:setPixel(playerX * 5 + 4, playerY * 5 + 2, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 1, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 3, playerY * 5 + 3, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 2, playerY * 5 + 3, c.r, c.g, c.b, 255)

        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 0, c2.r, c2.g, c2.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5 + 1, playerY * 5 + 4, c2.r, c2.g, c2.b, 255)

        self.pixelData:setPixel(playerX * 5, playerY * 5 + 0, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5, playerY * 5 + 1, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5, playerY * 5 + 2, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5, playerY * 5 + 3, c.r, c.g, c.b, 255)
        self.pixelData:setPixel(playerX * 5, playerY * 5 + 4, c.r, c.g, c.b, 255)
    end

    self.mapImg = love.graphics.newImage(self.pixelData)
end

function Minimap:update(dt)
    if love.keyboard.wasPressed('m') then
        if self.display then
            self.display = false
        else
            self.display = true
        end
    end
end

function Minimap:render()
    if self.display then
        love.graphics.draw(self.mapImg, virtualWidth - 100, virtualHeight - 100)
    end
end
