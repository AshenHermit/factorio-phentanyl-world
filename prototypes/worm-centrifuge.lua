local config = require("config")

data:extend({
    {
        type = "recipe-category",
        name = "worm-centrifuge-crafting"
    }
})

-- item
data:extend({
    {
        type = "item",
        name = "worm-centrifuge",
        icon = config.graphics_path .. "icons/worm-centrifuge.png",
        icon_size = 128,
        subgroup = "production-machine",
        order = "a[items]-b[worm-centrifuge]",
        place_result = "worm-centrifuge",
        stack_size = 50
    }
})
-- entity
data:extend({
    {
        type = "assembling-machine",
        name = "worm-centrifuge",
        icon = config.graphics_path .. "icons/worm-centrifuge.png",
        icon_size = 128,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {mining_time = 1, result = "worm-centrifuge"},
        max_health = 300,
        corpse = "big-remnants",
        dying_explosion = "big-explosion",
        collision_box = {{-1, -1}, {1, 1}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        crafting_categories = {"worm-centrifuge-crafting"},
        crafting_speed = 1,
        energy_source = {
            type = "void",
        },
        energy_usage = "1W",
        ingredient_coun = 4,
        animation = {
            layers = {
                {
                    filename = config.graphics_path .. "entity/worm-centrifuge/worm-centrifuge-idle.png",
                    width = 256,
                    height = 256,
                    frame_count = 20,
                    line_length = 5,
                    shift = { 0, 0 },
                },
            }
        },
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        working_sound = {
            sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
            idle_sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
            apparent_volume = 1.5
        }
    }
})