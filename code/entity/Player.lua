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

function Player:attemptMoveForward()
    -- north
    if self.direction == 'N' then
        self.y = self.y - 1
    end

    -- south

    -- west

    -- east

    self.visibleTiles = self:computeVisibleTiles()
    Event.dispatch('player-move', self)
end

function Player:attemptMoveBackward()
    -- north
    if self.direction == 'N' then
        self.y = self.y + 1
    end

    -- south

    -- west

    -- east

    self.visibleTiles = self:computeVisibleTiles()
    Event.dispatch('player-move', self)
end

function Player:attemptMoveLeft()
    -- north

    -- south

    -- west

    -- east
end

function Player:attemptMoveRight()
    -- north

    -- south

    -- west

    -- east
end

function Player:rotateLeft()
    -- north

    -- south

    -- west

    -- east
end

function Player:rotateRight()
    -- north

    -- south

    -- west

    -- east
end

function Player:update(dt)
    self.controller:update(dt)
end
