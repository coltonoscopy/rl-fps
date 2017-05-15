--[[
    State the player is in when he is using/swinging his weapon; input should
    be disabled, and an animation should be playing.
]]

UsingWeaponState = Class{__includes = BaseState}

function UsingWeaponState:init(player)
    self.player = player
    self.angle = 45
    self.x = virtualWidth - 8
    self.y = virtualHeight / 2 + 8
end

function UsingWeaponState:enter()
    self.x = virtualWidth - 8
    self.angle = 45
    self.y = virtualHeight / 2 + 8

    Timer.tween(0.12, {
        [self] = {angle = -45, x = virtualWidth - 180, y = virtualHeight / 2 + 64}
    })
    :finish(function()
        self.player.controller:change('idle')
    end)
end

function UsingWeaponState:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][1814], self.x,
        self.y, degreesToRadians(self.angle), -4, 4, 16, 16)
    print(self.angle)
end
