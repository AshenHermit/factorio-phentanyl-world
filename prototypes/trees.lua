local config = require("config")

throw_projectile_sound =
{
  switch_vibration_data =
  {
    filename = "__base__/sound/fight/throw-projectile.bnvib",
  },
  variations =
  {
    {
      filename = "__base__/sound/fight/throw-projectile-1.ogg",
      volume = 0.4
    },
    {
      filename = "__base__/sound/fight/throw-projectile-2.ogg",
      volume = 0.4
    },
    {
      filename = "__base__/sound/fight/throw-projectile-3.ogg",
      volume = 0.4
    },
    {
      filename = "__base__/sound/fight/throw-projectile-4.ogg",
      volume = 0.4
    },
    {
      filename = "__base__/sound/fight/throw-projectile-5.ogg",
      volume = 0.4
    },
    {
      filename = "__base__/sound/fight/throw-projectile-6.ogg",
      volume = 0.4
    }
  }

}

local seed_projectile = table.deepcopy(data.raw["projectile"]["grenade"])
seed_projectile.name = "bullet-seed"
seed_projectile.action[2] = 
{
  type = "direct",
  action_delivery =
  {
    type = "instant",
    target_effects =
    {
      {
        type = "create-entity",
        entity_name = "bullet-tree",
      },
      {
        type = "create-entity",
        entity_name = "explosion"
      }
    }
  }
}
seed_projectile.animation = {
  filename = config.graphics_path .. "icons/bullet-seed.png",
  scale=0.5,
  draw_as_glow = true,
  frame_count = 1,
  line_length = 1,
  animation_speed = 0.80,
  width = 64,
  height = 64,
  shift = { 0, 0 },
  priority = "high",
}

local bullet_tree = table.deepcopy(data.raw["tree"]["tree-01"])
bullet_tree.name = "bullet-tree"
bullet_tree.icon = config.graphics_path .. "icons/bullet-tree.png"
bullet_tree.icon_size = 128
bullet_tree.minable.result = "firearm-magazine"
bullet_tree.minable.count = 1
bullet_tree.minable.mining_time = 0.80
bullet_tree.max_health = 200
bullet_tree.pictures = {
  layers = 
  {
    {
      filename = config.graphics_path .. "/entity/bullet-tree/bullet-tree.png",
      width = 512,
      height = 512,
      shift = util.by_pixel(0, -5),
      scale = 1,
    }
  }
}
bullet_tree.variations = nil
bullet_tree.variation_weights = {1}

data:extend({
  bullet_tree,
  seed_projectile,
  {
    type = "capsule",
    name = "bullet-seed",
    icon = config.graphics_path .. "icons/bullet-seed.png",
    icon_size = 64, icon_mipmaps = 1,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = 30,
        projectile_creation_distance = 0.6,
        range = 15,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "bullet-seed",
                starting_speed = 0.3
              }
            },
            {
              type = "direct",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "play-sound",
                    sound = throw_projectile_sound
                  }
                }
              }
            }
          }
        }
      }
    },
    -- radius_color = { r = 0.25, g = 0.05, b = 0.25, a = 0.25 },
    subgroup = "capsule",
    order = "a[seed]-a[normal]",
    stack_size = 100
  },
})

data.raw["resource"]["iron-ore"].autoplace = nil
