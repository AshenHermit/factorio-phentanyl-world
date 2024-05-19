
local config = require("config")
local enemy_autoplace = require("enemy-autoplace")

local walker = table.deepcopy(data.raw["unit"]["small-biter"])

walker.name = "walker"
walker.icon = config.graphics_path .. "entity/walkers/walker-icon.png"
walker.icon_size = 128
walker.flags = {'placeable-player', 'placeable-off-grid', 'breaths-air', 'not-repairable'}
walker.alert_when_damaged = false
walker.order = 'b-b-c'

walker.distraction_cooldown = 300
walker.vision_distance = 20
walker.movement_speed = 0.12
walker.distance_per_frame = 0.1
walker.pollution_to_join_attack = 10000
walker.healing_per_tick = 0.01

walker.move_while_shooting = true
walker.affected_by_tiles = false
walker.has_belt_immunity = true

walker.attack_parameters.range = 0

walker.run_animation = {
    layers = {
        {
            filename = config.graphics_path .. "entity/walkers/walker-idle.png",
            priority = "high",
            width = 128,
            height = 128,
            shift = { 0, 0 },
            frame_count = 15,
            direction_count = 8,
            line_length = 11,
            animation_speed = 0.26666666666666666,
            scale = 2.0,
        },
    },
}

data:extend{walker}

data:extend({
    {
      type = "unit-spawner",
      name = "walker-spawner",
      icon = "__base__/graphics/icons/biter-spawner.png",
      icon_size = 64, icon_mipmaps = 4,
      flags = {"placeable-neutral", "not-repairable"},
      max_health = 500,
      order = "b-b-b",
      subgroup = "enemies",
      resistances = {
        {
          type = "physical",
          decrease = 2,
          percent = 15
        },
        {
          type = "explosion",
          decrease = 5,
          percent = 15
        },
        {
          type = "fire",
          percent = 10
        }
      },
      working_sound = {
        sound = {
          {
            filename = "__base__/sound/creatures/spawner.ogg",
            volume = 1.0
          }
        },
        apparent_volume = 2
      },
      dying_sound = {
        {
          filename = "__base__/sound/creatures/spawner-death-1.ogg",
          volume = 1.0
        },
        {
          filename = "__base__/sound/creatures/spawner-death-2.ogg",
          volume = 1.0
        }
      },
      healing_per_tick = 0.02,
      collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
      selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
      pollution_absorption_absolute = 20,
      pollution_absorption_proportional = 0.01,
      corpse = "biter-spawner-corpse",
      dying_explosion = "blood-explosion-big",
      max_count_of_owned_units = 20,
      max_friends_around_to_spawn = 20,
      animations = {
        layers = {
          {
            filename = config.graphics_path .. "entity/dweller-house/dweller-house-idle.png",
            priority = "high",
            width = 400,
            height = 400,
            shift = { 0, 0 },
            frame_count = 40,
            line_length = 13,
            direction_count = 4,
            animation_speed = 0.4,
            scale = 1.7679998779296873,
          },
        }
      },
      result_units = (function()
        local res = {}
        res[1] = {"walker", {{0.0, 0.3}, {0.7, 0.0}}}
        return res
      end)(),
      spawning_cooldown = {0, 2},
      spawning_radius = 16,
      spawning_spacing = 3,
      call_for_help_radius = 0,
      max_spawn_shift = 0,
      max_richness_for_spawn_shift = 100,
      autoplace = enemy_autoplace.enemy_spawner_autoplace(0)
    }
})