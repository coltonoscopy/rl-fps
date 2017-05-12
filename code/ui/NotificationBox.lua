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
    self.text = 'This is a test!'
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

function NotificationBox:render()
    if self.visible then
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.print(self.text, self.x + 2, self.y + 2)
    end
end
