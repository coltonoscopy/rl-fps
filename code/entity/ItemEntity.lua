--[[
    An entity displayable in the game world that represents an item on the
    ground or otherwise.
]]

ItemEntity = Class{}

function ItemEntity:init(def)
    self.x = def.x
    self.y = def.y
    self.frame = def.frame
end
