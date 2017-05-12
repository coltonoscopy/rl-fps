--[[
    Used to display textual notifications to the player.
]]

NotificationBox = Class{}

function NotificationBox:init()
    self.visible = true
    self.x = virtualWidth / 2 - virtualWidth / 4
    self.y = virtualWidth / 16
    self.width = virtualWidth / 2
    self.height = virtualHeight / 5
    self.text = 'Press Space to open and close menu!\nPress Enter to dismiss!'
end

function NotificationBox:setText(text)
    self.text = text
end

function NotificationBox:show()
    self.visible = true
end

function NotificationBox:hide()
    self.visible = false
end

function NotificationBox:update(dt)
    if love.keyboard.wasPressed('return') and self.visible then
        self.visible = false
        gSounds['menu2']:stop()
        gSounds['menu2']:play()
    end
end

function NotificationBox:render()
    if self.visible then
        -- white outline
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle('fill', self.x - 1, self.y - 1, self.width + 2, self.height + 2)

        -- actual box
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.print(self.text, self.x + 2, self.y + 2)
    end
end
