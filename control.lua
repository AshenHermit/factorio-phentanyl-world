
local remnants = require("control.remnants")
local enemies = require("control.enemies")
require("control.village")
require("control.acid-cracks")

require('event-dispatcher')
event_dispatcher:register()

local function giveItems(event)
  for i, player in pairs(game.players) do
    local inventory = player.get_main_inventory()
    if(inventory==nil) then return end
    player.insert{name="bullet-seed", count=100}
    player.insert{name="worm-centrifuge", count=100}
  end
end

script.on_event(defines.events.on_cutscene_cancelled, giveItems)
script.on_event(defines.events.on_cutscene_finished, giveItems)

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    local surface = player.surface
    local position = player.position

    surface.create_entity({
      name = "walker-spawner",
      position = {position.x + 5, position.y + 5},
      force = game.forces.neutral
    })

    local flower = surface.create_entity({
      name = "human-flower",
      position = {position.x + 40, position.y + 5},
      force = game.forces.enemy
    })
    flower.active = false

    surface.create_entity({
      name = "stone-wall",
      position = {position.x + 10, position.y + 5},
    })
    surface.create_entity({
      name = "stone-wall",
      position = {position.x + 11, position.y + 5},
      direction=1,
    })
    surface.create_entity({
      name = "stone-wall",
      position = {position.x + 12, position.y + 5},
      direction=2,
    })

    surface.create_entity({
      name = "building-wood-1",
      position = {position.x + 20, position.y + 5},
      direction=defines.direction.east,
    })
    surface.create_entity({
      name = "building-wood-1",
      position = {position.x + 30, position.y + 5},
      direction=defines.direction.north,
    })

    surface.set_tiles({{
      name = "concrete",
      position = {position.x + 12, position.y + 4},
    },
    {
      name = "concrete",
      position = {position.x + 11, position.y + 4},
    }})
    
    surface.create_entity({
      name = "twister",
      position = {position.x + 2, position.y + 2},
    })
end)