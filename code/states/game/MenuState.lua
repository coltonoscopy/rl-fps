--[[
    State the game is in when we want to render the menu, with links to the
    player's inventory, etc.
]]

MenuState = Class{__includes = BaseState}

function MenuState:init()

end

function MenuState:enter(data)
    self.inventory = data
    print_r(self.inventory)
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('space') then
        Event.dispatch('player-menu-exit')
    end
end

function MenuState:render()
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 8, 8, virtualWidth - 8, virtualWidth + 8)
    love.graphics.setColor(255, 255, 255, 255)

    local counter = 1
    local y = 8
    for k, v in pairs(self.inventory.items) do
        if counter > 16 then
            counter = 1
            y = y + 16
        end

        love.graphics.draw(gTextures['tiles'], gFrames['tiles'][v.frame],
            counter * 16 - 8, y, 0, 0.5, 0.5)
        counter = counter + 1
    end
end
