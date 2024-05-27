local config = require("prototypes.config")
local enemy_autoplace = require("prototypes.enemy-autoplace")

local twister = table.deepcopy(data.raw["unit"]["small-biter"])

twister.name = "twister"
twister.icon = config.graphics_path .. "icons/twister.png"
twister.icon_size = 128
twister.flags = {'placeable-enemy', 'placeable-off-grid', 'breaths-air', 'not-repairable'}
twister.alert_when_damaged = false
twister.order = 'b-b-c'

twister.ai_settings.do_separation = true
twister.ai_settings.path_resolution_modifier = -2
twister.distraction_cooldown = 300
twister.vision_distance = 20
twister.movement_speed = 0.14
twister.distance_per_frame = 0.2
twister.pollution_to_join_attack = 10000
twister.healing_per_tick = 0.01

twister.affected_by_tiles = false
twister.has_belt_immunity = true

twister.dying_explosion = "blood-explosion-big"
twister.corpse = "twister-corpse"
twister.attack_parameters.range = 1
twister.attack_parameters.cooldown = 20
twister.attack_parameters.animation = {
    filename = config.graphics_path .. "entity/twister/twister-attack.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 17,
    direction_count = 8,
    line_length = 12,
    animation_speed = 1,
    scale = 1.2000000476837158,
}

twister.run_animation = {
    filename = config.graphics_path .. "entity/twister/twister-walk.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 17,
    direction_count = 8,
    line_length = 12,
    animation_speed = 1,
    scale = 1.2000000476837158,
}

twister.idle_animation = {
    filename = config.graphics_path .. "entity/twister/twister-idle.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 30,
    direction_count = 8,
    line_length = 16,
    animation_speed = 1,
    scale = 1.2000000476837158,
}

local die_animation = {
    filename = config.graphics_path .. "entity/twister/twister-die.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 15,
    direction_count = 8,
    line_length = 11,
    animation_speed = 1,
    scale = 1.2000000476837158,
}

local twister_corpse = {
    type = "corpse",
    name = "twister-corpse",
    icon = config.graphics_path .. "icons/twister.png",
    icon_size = 128,
    selectable_in_game = false,
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    tile_width = 1,
    tile_height = 1,
    subgroup = "corpses",
    order = "c[corpse]-a[biter]-a[small]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
    animation = die_animation,
    dying_speed = 0.04,
    time_before_removed = 15 * 60 * 60,
    final_render_layer = "corpse"
}

data:extend{twister, twister_corpse}