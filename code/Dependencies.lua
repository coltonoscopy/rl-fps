require 'code/libs/require'

lume = require 'code/libs/lume'
push = require 'code/libs/push'

Chain = require 'code/libs/knife.chain'
Class = require 'code/libs/hump.class'
Event = require 'code/libs/knife.event'
Grid = require 'code/libs/jumper.grid'
Pathfinder = require 'code/libs/jumper.pathfinder'
ROT = require 'code/libs/rotLove/rotLove'
Timer = require 'code/libs/knife.timer'

persp = require 'code/Perspective'

require 'code/Colors'
require 'code/StateMachine'
require 'code/Util'

require 'code/entity/Entity'
require 'code/entity/Player'
require 'code/entity/PlayerController'

require 'code/entity/ItemEntity'

require 'code/item/Inventory'

require 'code/states/BaseState'
require 'code/states/game/ExploreState'

require 'code/ui/Minimap'
require 'code/ui/NotificationBox'

require 'code/world/Map'
require 'code/world/MapRenderer'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles_db.png'),
}
gTextures['tiles']:setFilter('nearest', 'nearest')

gFrames = {
    ['creatures'] = GenerateQuads(gTextures['tiles'], 32, 32)
}
gFrames['tiles'] = gFrames['creatures']

gSounds = {
    ['bump'] = love.audio.newSource(love.sound.newSoundData('sounds/bump.wav')),
    ['item'] = love.audio.newSource(love.sound.newSoundData('sounds/item.wav'))
}
