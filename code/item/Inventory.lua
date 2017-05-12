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
