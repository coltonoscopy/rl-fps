--[[
    Represents the player's inventory.
]]

Inventory = Class{}

function Inventory:init()
    self.items = {}
end

function Inventory:addItem(item)
    table.insert(self.items, item)
end

function Inventory:removeItem(item)
    table.remove(self.items, item)
end

function Inventory:render()
    local counter = 0
    for k, v in pairs(self.items) do
        love.graphics.draw(gTextures['tiles'], gFrames['tiles'][v.frame], counter * 16, 0, 0, 0.5, 0.5)
        counter = counter + 1
    end
end
