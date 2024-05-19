local resource_autoplace = require("resource-autoplace")
local config = require("config")

resource_autoplace.initialize_patch_set("pelmen-ore", true)

data:extend({
  {
    type = "item",
    name = "pelmen-ore",
    icon = config.graphics_path .. "icons/pelmen-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    stack_size = 50
  },
  {
    type = "resource",
    name = "pelmen-ore",
    icon = config.graphics_path .. "icons/pelmen-ore.png",
    icon_size = 64,
    icon_mipmaps = 1,
    flags = {},
    order = "a-b-a",
    minable = {
      mining_particle = "iron-ore-particle",
      mining_time = 1,
      result = "pelmen-ore"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "pelmen-ore",
      order = "b",
      base_density = 10,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 1.10
    },
    stage_counts = {15000, 10000, 5000, 2000, 1000, 500, 250, 100},
    stages = {
      sheet = {
        filename = config.graphics_path .. "entity/pelmen-ore/pelmen-ore.png",
        priority = "extra-high",
        size = 64,
        frame_count = 8,
        variation_count = 8,
      }
    },
    map_color = {r=255/255, g=198/255, b=155/255},
    mining_visualisation_tint = {r=255/255, g=198/255, b=155/255}
  }
})

data.raw["resource"]["iron-ore"].autoplace = nil
