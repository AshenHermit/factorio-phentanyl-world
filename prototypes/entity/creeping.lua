local config = require("prototypes.config")
local enemy_autoplace = require("prototypes.enemy-autoplace")

local creeping = table.deepcopy(data.raw["unit"]["small-biter"])

creeping.name = "creeping"
creeping.icon = config.graphics_path .. "icons/creeping.png"
creeping.icon_size = 256
creeping.flags = {'placeable-enemy', 'placeable-off-grid', 'breaths-air', 'not-repairable'}
creeping.alert_when_damaged = false
creeping.order = 'b-b-c'

creeping.ai_settings.do_separation = true
creeping.ai_settings.path_resolution_modifier = -2
creeping.distraction_cooldown = 300
creeping.vision_distance = 40
creeping.max_pursue_distance = 70
creeping.movement_speed = 0.1
creeping.distance_per_frame = 0.2
creeping.pollution_to_join_attack = 10000
creeping.healing_per_tick = 0.01

creeping.affected_by_tiles = false
creeping.has_belt_immunity = false

creeping.dying_explosion = "blood-explosion-big"
creeping.corpse = "creeping-corpse"
creeping.attack_parameters.range = 1
creeping.attack_parameters.cooldown = 30
creeping.attack_parameters.animation = {
    filename = config.graphics_path .. "entity/creeping/creeping-attack.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 15,
    line_length = 11,
    direction_count = 8,
    animation_speed = 0.4,
    scale = 1.0,
}

creeping.run_animation = {
    filename = config.graphics_path .. "entity/creeping/creeping-walk.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 27,
    line_length = 15,
    direction_count = 8,
    animation_speed = 1,
    scale = 1.0,
}

creeping.idle_animation = {
    filename = config.graphics_path .. "entity/creeping/creeping-idle.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 20,
    direction_count = 8,
    line_length = 13,
    animation_speed = 0.8,
    scale = 0.7875000238418579,
}

local die_animation = {
    filename = config.graphics_path .. "entity/creeping/creeping-die.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 20,
    line_length = 13,
    direction_count = 8,
    animation_speed = 0.4,
    scale = 1.0,
}

local creeping_corpse = {
    type = "corpse",
    name = "creeping-corpse",
    icon = config.graphics_path .. "icons/creeping.png",
    icon_size = 256,
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

data:extend{creeping, creeping_corpse}