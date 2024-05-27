local config = require("prototypes.config")

data:extend{
    {
        type = "container",
        name = "robot-remnants",
        enable_inventory_bar = false,
        icon = "__base__/graphics/icons/ship-wreck/big-ship-wreck-1.png",
        icon_size = 64, icon_mipmaps = 1,
        flags = {"placeable-neutral"},
        subgroup = "wrecks",
        order = "d[remnants]-d[ship-wreck]-a[big]-a",
        map_color = {r = 0, g = 0.365, b = 0.58, a = 1},
        max_health = 50,
        collision_box = {{-2.2, -1.5}, {2.2, 1.5}},
        selection_box = {{-2.7, -1.5}, {2.7, 1.5}},
        inventory_size = 3,
        picture =
        {
          filename = config.graphics_path .. "entity/dead_bot/dead_bot-a.png",
          width = 256,
          height = 256,
          shift = {0, 0}
        }
    },
}