--[[
    Processes input for the player.
]]

PlayerController = Class{}

function PlayerController:init(player)
    self.player = player
end

function PlayerController:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        self.player:attemptMoveForward()
    elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        self.player:attemptMoveBackward()
    elseif love.keyboard.wasPressed('a') then
        self.player:attemptMoveLeft()
    elseif love.keyboard.wasPressed('d') then
        self.player:attemptMoveRight()
    elseif love.keyboard.wasPressed('right') then
        self.player:rotateRight()
    elseif love.keyboard.wasPressed('left') then
        self.player:rotateLeft()
    end

    if love.keyboard.wasPressed('space') then
        Event.dispatch('player-menu-enter', self.player.inventory)
    end
end
