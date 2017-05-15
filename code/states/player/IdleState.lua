--[[
    State the player is in when idle, ready to take action. Can move, use
    weapon, etc.
]]

IdleState = Class{__includes = BaseState}

function IdleState:init(player)
    self.player = player
end

function IdleState:update(dt)
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
        self.player.controller:change('using-weapon')
    end

    -- transition game state to menu
    if love.keyboard.wasPressed('tab') then
        Event.dispatch('player-menu-enter', self.player.inventory)
    end
end

function IdleState:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][1814], virtualWidth - 8,
        virtualHeight / 2 + 8, 0, -4, 4)
end
