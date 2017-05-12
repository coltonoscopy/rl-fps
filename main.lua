love.keyboard.keysPressed = {}
love.keyboard.keysReleased = {}
love.mouse.buttonsPressed = {}
love.mouse.buttonsReleased = {}

math.randomseed(os.time())
love.math.setRandomSeed(os.time())

require 'code/Dependencies'

virtualWidth = 384
virtualHeight = 216

-- state machine controlling our various game states
local exploreState = ExploreState()
local menuState = MenuState()

gGameSM = StateMachine {
    ['explore'] = function() return exploreState end,
    -- ['mainmenu'] = function() return MainMenuState() end,
    ['menu'] = function() return menuState end
}
gGameSM:change('explore')

Event.on('player-menu-enter', function(inventory)
    gGameSM:change('menu', inventory)
end)

Event.on('player-menu-exit', function()
    gGameSM:change('explore')
end)

function love.load()
    love.graphics.setFont(love.graphics.newFont('fonts/font.ttf', 8))
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Roguelike RPG')

    push:setupScreen(virtualWidth, virtualHeight, 1280, 720, {
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gGameSM:update(dt)
    Timer.update(dt)

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
    love.mouse.buttonsPressed = {}
    love.mouse.buttonsReleased = {}
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.keyboard.wasReleased(key)
    if love.keyboard.keysReleased[key] then
        return true
    else
        return false
    end
end

function love.mouse.wasPressed(key)
    if love.mouse.buttonsPressed[key] then
        return true
    else
        return false
    end
end

function love.mouse.wasReleased(key)
    if love.mouse.buttonsReleased[key] then
        return true
    else
        return false
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.mousereleased(x, y, button)
    love.mouse.buttonsReleased[button] = true
end

function love.draw()
    push:apply('start')

    gGameSM:render()
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()))

    push:apply('end')
end
