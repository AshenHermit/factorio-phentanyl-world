local config = require("prototypes.config")

local particle_animations = {}

particle_animations.get_blood_particle_pictures = function(options)
    local options = options or {}
    return
    {
        sheet =
        {
            filename = "__base__/graphics/particle/blood-particle/hr-blood-particle.png",
            line_length = 12,
            width = 16,
            height = 16,
            frame_count = 12,
            variation_count = 7,
            tint = options.tint,
            shift = util.add_shift(util.by_pixel(2, -1), options.shift),
            scale = 1.5,
            hr_version =
            {
                filename = "__base__/graphics/particle/blood-particle/hr-blood-particle.png",
                line_length = 12,
                width = 16,
                height = 16,
                frame_count = 12,
                variation_count = 7,
                tint = options.tint,
                scale = 1.5,
                shift = util.add_shift(util.by_pixel(1.5, -1), options.shift)
            }
        }
    }
end

local sounds = {}

sounds.small_splash =
{
  {
    filename = "__base__/sound/particles/small-splash-1.ogg",
    volume = 0.7
  },
  {
    filename = "__base__/sound/particles/small-splash-2.ogg",
    volume = 0.7
  },
  {
    filename = "__base__/sound/particles/small-splash-3.ogg",
    volume = 0.7
  },
  {
    filename = "__base__/sound/particles/small-splash-4.ogg",
    volume = 0.7
  },
  {
    filename = "__base__/sound/particles/small-splash-5.ogg",
    volume = 0.7
  }
}

local default_ended_in_water_trigger_effect = function()
    return
    {

        {
            type = "create-particle",
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "deep-water-particle",
            offset_deviation = { { -0.05, -0.05 }, { 0.05, 0.05 } },
            tile_collision_mask = nil,
            initial_height = 0,
            initial_height_deviation = 0.02,
            initial_vertical_speed = 0.05,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.006,
            frame_speed = 1,
            frame_speed_deviation = 0,
            tail_length = 2,
            tail_length_deviation = 1,
            tail_width = 3
        },
        {
            type = "create-particle",
            repeat_count = 10,
            repeat_count_deviation = 6,
            probability = 0.03,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "water-particle",
            offsets =
            {
                { 0,       0 },
                { 0.01563, -0.09375 },
                { 0.0625,  0.09375 },
                { -0.1094, 0.0625 }
            },
            offset_deviation = { { -0.2969, -0.1992 }, { 0.2969, 0.1992 } },
            tile_collision_mask = nil,
            initial_height = 0,
            initial_height_deviation = 0.02,
            initial_vertical_speed = 0.053,
            initial_vertical_speed_deviation = 0.005,
            speed_from_center = 0.02,
            speed_from_center_deviation = 0.006,
            frame_speed = 1,
            frame_speed_deviation = 0,
            tail_length = 9,
            tail_length_deviation = 0,
            tail_width = 1
        },
        {
            type = "play-sound",
            sound = sounds.small_splash
        }
    }
end

local make_particle = function(params)
    if not params then error("No params given to make_particle function") end
    local name = params.name or error("No name given")

    local ended_in_water_trigger_effect = params.ended_in_water_trigger_effect or default_ended_in_water_trigger_effect()
    if params.ended_in_water_trigger_effect == false then
        ended_in_water_trigger_effect = nil
    end

    local particle =
    {

        type = "optimized-particle",
        name = name,

        life_time = params.life_time or 60 * 15,
        fade_away_duration = params.fade_away_duration,

        render_layer = params.render_layer or "projectile",
        render_layer_when_on_ground = params.render_layer_when_on_ground or "corpse",

        regular_trigger_effect_frequency = params.regular_trigger_effect_frequency or 2,
        regular_trigger_effect = params.regular_trigger_effect,
        ended_in_water_trigger_effect = ended_in_water_trigger_effect,

        pictures = params.pictures,
        shadows = params.shadows,
        draw_shadow_when_on_ground = params.draw_shadow_when_on_ground,

        movement_modifier_when_on_ground = params.movement_modifier_when_on_ground,
        movement_modifier = params.movement_modifier,
        vertical_acceleration = params.vertical_acceleration,

        mining_particle_frame_speed = params.mining_particle_frame_speed,

    }

    return particle
end

function bloodtint()
    return { r = 155, g = 40, b = 40 }
end

data.raw['optimized-particle']['blood-particle'] = make_particle{
    name = "blood-particle",
    life_time = 180,
    pictures = particle_animations.get_blood_particle_pictures({ tint = bloodtint() }),
    shadows = particle_animations.get_blood_particle_pictures({ tint = shadowtint(), shift = util.by_pixel(1, 0) }),
    draw_shadow_when_on_ground = false,
    ended_in_water_trigger_effect = false,
    movement_modifier_when_on_ground = 0,
    render_layer = "higher-object-under"
}



data:extend({
    {
        type = "simple-entity",
        name = "blood-puddle",
        icon =config.graphics_path .. "entity/blood-puddle/blood-puddle.png",
        icon_size = 256,
        flags = {"placeable-neutral", "not-on-map"},
        subgroup = "grass",
        order = "b[decorative]-b[puddle]",
        max_health = 100,
        render_layer = "decals",
        pictures =
        {
        {
            filename = config.graphics_path .. "entity/blood-puddle/blood-puddle.png",
            width = 256,
            height = 256,
            shift = {0, 0}
        }
        }
    }
})