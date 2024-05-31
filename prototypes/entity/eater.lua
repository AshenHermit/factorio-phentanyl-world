local config = require("prototypes.config")
local enemy_autoplace = require("prototypes.enemy-autoplace")

local eater = table.deepcopy(data.raw["unit"]["small-biter"])

eater.name = "eater"
eater.icon = config.graphics_path .. "icons/eater.png"
eater.icon_size = 64
eater.flags = {'placeable-enemy', 'placeable-off-grid', 'breaths-air', 'not-repairable'}
eater.alert_when_damaged = false
eater.order = 'b-b-c'

eater.ai_settings.do_separation = true
eater.ai_settings.path_resolution_modifier = -2
eater.distraction_cooldown = 300
eater.vision_distance = 10
eater.max_pursue_distance = 20
eater.movement_speed = 0.3
eater.distance_per_frame = 0.1
eater.pollution_to_join_attack = 10000
eater.healing_per_tick = 0.01

eater.affected_by_tiles = false
eater.has_belt_immunity = true

eater.dying_explosion = "blood-explosion-big"
eater.corpse = "eater-corpse"
eater.attack_parameters.range = 1
eater.attack_parameters.cooldown = 30
eater.attack_parameters.animation = {
    filename = config.graphics_path .. "entity/eater/eater-attack.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 7,
    direction_count = 8,
    line_length = 8,
    animation_speed = 0.4,
    scale = 0.7875000238418579,
}

eater.run_animation = {
    filename = config.graphics_path .. "entity/eater/eater-run.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 12,
    direction_count = 8,
    line_length = 10,
    animation_speed = 0.8,
    scale = 0.7875000238418579,
}

eater.idle_animation = {
    filename = config.graphics_path .. "entity/eater/eater-idle.png",
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
    filename = config.graphics_path .. "entity/eater/eater-die.png",
    priority = "high",
    width = 256,
    height = 256,
    shift = { 0, 0 },
    frame_count = 8,
    direction_count = 8,
    line_length = 8,
    animation_speed = 0.8,
    scale = 0.7875000238418579,
}

local eater_corpse = {
    type = "corpse",
    name = "eater-corpse",
    icon = config.graphics_path .. "icons/eater.png",
    icon_size = 64,
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

data:extend{eater, eater_corpse}