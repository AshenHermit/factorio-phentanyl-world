
script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    local surface = player.surface
    local position = player.position
    
    surface.create_entity({
      name = "walker-spawner",
      position = {position.x + 5, position.y + 5},
      force = game.forces.neutral
    })
end)