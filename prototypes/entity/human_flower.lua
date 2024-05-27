local config = require("prototypes.config")
local enemy_autoplace = require("prototypes.enemy-autoplace")

local eater = table.deepcopy(data.raw["turret"]["small-worm-turret"])

eater.name = "human-flower"
eater.flags = {"placeable-player", "placeable-off-grid", "not-repairable", "breaths-air"}

eater.folded_animation = {
    filename = config.graphics_path .. "entity/human-flower/human-flower-idle.png",
    priority = "high",
    width = 400,
    height = 400,
    shift = { 0, 0 },
    frame_count = 25,
    direction_count = 1,
    line_length = 5,
    animation_speed = 0.8,
    scale = 1.8399998474121095,
}

eater.preparing_animation = eater.folded_animation
eater.prepared_animation = eater.folded_animation
eater.prepared_alternative_animation = eater.folded_animation
eater.starting_attack_animation = eater.folded_animation
eater.ending_attack_animation = eater.folded_animation
eater.folding_animation = eater.folded_animation
eater.attack_parameters.ammo_type.action.action_delivery = nil

data:extend{eater}