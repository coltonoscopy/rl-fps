--[[
    Represents the player in the game.
]]

Player = Class{}

function Player:init(def)
    self.x = def.x
    self.y = def.y
    self.map = def.map
    self.direction = def.direction
    self.controller = PlayerController(self)
    self.inventory = Inventory()
    self.visibleTiles = self:computeVisibleTiles()
end

--[[
    Grabs from the Map all tiles that branch out in the viewport of the player
    based on his/her current direction and position.
]]
function Player:computeVisibleTiles()
    --
    -- facing north
    --
    if self.direction == 'N' then
        return {
            -- standing on
            self.map:getTile(self.x, self.y),

            -- standing row sides
            self.map:getTile(self.x - 1, self.y),
            self.map:getTile(self.x + 1, self.y),

            -- second row
            self.map:getTile(self.x - 1, self.y - 1),
            self.map:getTile(self.x, self.y - 1),
            self.map:getTile(self.x + 1, self.y - 1),

            -- third row
            self.map:getTile(self.x - 2, self.y - 2),
            self.map:getTile(self.x - 1, self.y - 2),
            self.map:getTile(self.x, self.y - 2),
            self.map:getTile(self.x + 1, self.y - 2),
            self.map:getTile(self.x + 2, self.y - 2),

            -- fourth row
            self.map:getTile(self.x - 3, self.y - 3),
            self.map:getTile(self.x - 2, self.y - 3),
            self.map:getTile(self.x - 1, self.y - 3),
            self.map:getTile(self.x, self.y - 3),
            self.map:getTile(self.x + 1, self.y - 3),
            self.map:getTile(self.x + 2, self.y - 3),
            self.map:getTile(self.x + 3, self.y - 3),
        }
    --
    -- facing south
    --
    elseif self.direction == 'S' then
        return {
            -- standing on
            self.map:getTile(self.x, self.y),

            -- standing row sides
            self.map:getTile(self.x + 1, self.y),
            self.map:getTile(self.x - 1, self.y),

            -- second row
            self.map:getTile(self.x + 1, self.y + 1),
            self.map:getTile(self.x, self.y + 1),
            self.map:getTile(self.x - 1, self.y + 1),

            -- third row
            self.map:getTile(self.x + 2, self.y + 2),
            self.map:getTile(self.x + 1, self.y + 2),
            self.map:getTile(self.x, self.y + 2),
            self.map:getTile(self.x - 1, self.y + 2),
            self.map:getTile(self.x - 2, self.y + 2),

            -- fourth row
            self.map:getTile(self.x + 3, self.y + 3),
            self.map:getTile(self.x + 2, self.y + 3),
            self.map:getTile(self.x + 1, self.y + 3),
            self.map:getTile(self.x, self.y + 3),
            self.map:getTile(self.x - 1, self.y + 3),
            self.map:getTile(self.x - 2, self.y + 3),
            self.map:getTile(self.x - 3, self.y + 3),
        }
    --
    -- facing west
    --
    elseif self.direction == 'W' then
        return {
            -- standing on
            self.map:getTile(self.x, self.y),

            -- standing row sides
            self.map:getTile(self.x, self.y + 1),
            self.map:getTile(self.x, self.y - 1),

            -- second row
            self.map:getTile(self.x - 1, self.y + 1),
            self.map:getTile(self.x - 1, self.y),
            self.map:getTile(self.x - 1, self.y - 1),

            -- third row
            self.map:getTile(self.x - 2, self.y + 2),
            self.map:getTile(self.x - 2, self.y + 1),
            self.map:getTile(self.x - 2, self.y),
            self.map:getTile(self.x - 2, self.y - 1),
            self.map:getTile(self.x - 2, self.y - 2),

            -- fourth row
            self.map:getTile(self.x - 3, self.y + 3),
            self.map:getTile(self.x - 3, self.y + 2),
            self.map:getTile(self.x - 3, self.y + 1),
            self.map:getTile(self.x - 3, self.y),
            self.map:getTile(self.x - 3, self.y - 1),
            self.map:getTile(self.x - 3, self.y - 2),
            self.map:getTile(self.x - 3, self.y - 3),
        }
    --
    -- facing east
    --
    elseif self.direction == 'E' then
        return {
            -- standing on
            self.map:getTile(self.x, self.y),

            -- standing row sides
            self.map:getTile(self.x, self.y - 1),
            self.map:getTile(self.x, self.y + 1),

            -- second row
            self.map:getTile(self.x + 1, self.y - 1),
            self.map:getTile(self.x + 1, self.y),
            self.map:getTile(self.x + 1, self.y + 1),

            -- third row
            self.map:getTile(self.x + 2, self.y - 2),
            self.map:getTile(self.x + 2, self.y - 1),
            self.map:getTile(self.x + 2, self.y),
            self.map:getTile(self.x + 2, self.y + 1),
            self.map:getTile(self.x + 2, self.y + 2),

            -- fourth row
            self.map:getTile(self.x + 3, self.y - 3),
            self.map:getTile(self.x + 3, self.y - 2),
            self.map:getTile(self.x + 3, self.y - 1),
            self.map:getTile(self.x + 3, self.y),
            self.map:getTile(self.x + 3, self.y + 1),
            self.map:getTile(self.x + 3, self.y + 2),
            self.map:getTile(self.x + 3, self.y + 3),
        }
    end
end

--[[
    Adds whatever item is on the current tile to the player's inventory.
]]
function Player:pickupItem()
    if #self.map:getTile(self.x, self.y).items > 0 then
        gSounds['item']:play()
        table.insert(self.inventory.items, self.map:getTile(self.x, self.y).items[1])
        self.map:getTile(self.x, self.y).items = {}
    end
end

--[[
    Global to the map, not the player's direction.
]]
function Player:globalMoveUp()
    if self.map:getTile(self.x, self.y - 1)
        and self.map:getTile(self.x, self.y - 1).id ~= 858 then
        self.y = self.y - 1
        self:pickupItem()
        Event.dispatch('player-move', self)
    else
        gSounds['bump']:play()
    end
end

function Player:globalMoveDown()
    if self.map:getTile(self.x, self.y + 1)
        and self.map:getTile(self.x, self.y + 1).id ~= 858 then
        self.y = self.y + 1
        self:pickupItem()
        Event.dispatch('player-move', self)
    else
        gSounds['bump']:play()
    end
end

function Player:globalMoveLeft()
    if self.map:getTile(self.x - 1, self.y)
        and self.map:getTile(self.x - 1, self.y).id ~= 858 then
        self.x = self.x - 1
        self:pickupItem()
        Event.dispatch('player-move', self)
    else
        gSounds['bump']:play()
    end
end

function Player:globalMoveRight()
    if self.map:getTile(self.x + 1, self.y)
        and self.map:getTile(self.x + 1, self.y).id ~= 858 then
        self.x = self.x + 1
        self:pickupItem()
        Event.dispatch('player-move', self)
    else
        gSounds['bump']:play()
    end
end

--[[
    Dispatches to the appropriate move call depending on the player's orientation.
]]
function Player:attemptMoveForward()
    if self.direction == 'N' then
        self:globalMoveUp()
    elseif self.direction == 'S' then
        self:globalMoveDown()
    elseif self.direction == 'W' then
        self:globalMoveLeft()
    else
        self:globalMoveRight()
    end

    self.visibleTiles = self:computeVisibleTiles()
end

function Player:attemptMoveBackward()
    if self.direction == 'N' then
        self:globalMoveDown()
    elseif self.direction == 'S' then
        self:globalMoveUp()
    elseif self.direction == 'W' then
        self:globalMoveRight()
    else
        self:globalMoveLeft()
    end

    self.visibleTiles = self:computeVisibleTiles()
end

function Player:attemptMoveLeft()
    if self.direction == 'N' then
        self:globalMoveLeft()
    elseif self.direction == 'S' then
        self:globalMoveRight()
    elseif self.direction == 'W' then
        self:globalMoveDown()
    else
        self:globalMoveUp()
    end

    self.visibleTiles = self:computeVisibleTiles()
end

function Player:attemptMoveRight()
    if self.direction == 'N' then
        self:globalMoveRight()
    elseif self.direction == 'S' then
        self:globalMoveLeft()
    elseif self.direction == 'W' then
        self:globalMoveUp()
    else
        self:globalMoveDown()
    end

    self.visibleTiles = self:computeVisibleTiles()
end

function Player:rotateLeft()
    if self.direction == 'N' then
        self.direction = 'W'
    elseif self.direction == 'S' then
        self.direction = 'E'
    elseif self.direction == 'W' then
        self.direction = 'S'
    else
        self.direction = 'N'
    end

    self.visibleTiles = self:computeVisibleTiles()
    Event.dispatch('player-move', self)
end

function Player:rotateRight()
    if self.direction == 'N' then
        self.direction = 'E'
    elseif self.direction == 'S' then
        self.direction = 'W'
    elseif self.direction == 'W' then
        self.direction = 'N'
    else
        self.direction = 'S'
    end

    self.visibleTiles = self:computeVisibleTiles()
    Event.dispatch('player-move', self)
end

function Player:update(dt)
    self.controller:update(dt)
end
