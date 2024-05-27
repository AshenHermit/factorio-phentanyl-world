local loot = require('loot')
require('event-dispatcher')

event_dispatcher:on_event(defines.events.on_chunk_generated, function (event)
    if(event.surface.name ~= game.surfaces[1].name) then return end
    local surface = event.surface
    local area = event.area

    if math.random() < 0.2 then
        local wreck_position = {}
        for i = 1, 10, 1 do
            wreck_position = {
                x = math.random(area.left_top.x, area.right_bottom.x),
                y = math.random(area.left_top.y, area.right_bottom.y)
            }
            local tile_name = surface.get_tile(wreck_position).name
            if(tile_name:find("water")==nil and tile_name~="out-of-map") then break end
        end
        
        local wreck = surface.create_entity{
            name = "robot-remnants",
            position = wreck_position,
            force = "neutral"
        }

        if wreck and wreck.valid then
            local inventory = wreck.get_inventory(defines.inventory.chest)
            loot.add_random_loot(inventory, {
                {name = "metal-junk", count_min = 1, count_max = 10, probability = 0.8},
                {name = "bullet-worms", count_min = 1, count_max = 10, probability = 0.5},
                {name = "iron-gear-wheel", count_min = 1, count_max = 1, probability = 0.3}})
        end
    end
end)