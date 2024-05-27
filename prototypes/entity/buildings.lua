local config = require("prototypes.config")

local entity = {
    type = "simple-entity-with-owner",
    name = "building-wood-1",
    render_layer = "object",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "not-blueprintable", "not-deconstructable"},
    minable = nil,
    max_health = 1000,
    resistances = {{type = "fire", percent = 100}},
    collision_box = {{-3.20075, -4.10002}, {3.20075, 4.10002}},
    selection_box = {{-3.20075, -4.10002}, {3.20075, 4.10002}},
    picture = {
        sheet = {
            filename = config.graphics_path .. "entity/building-wood-1/building-wood-1-init.png",
            frames = 4,
            width = 300,
            height = 300,
            scale = 1.4613332112630208,
            shift = { 0, 0 },
        },
    }
}

data:extend{
    entity,
}