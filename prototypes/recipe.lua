data:extend({
    {
        type = "recipe",
        name = "worm-centrifuge",
        enabled = true,
        ingredients = {
            {"metal-junk", 5},
            {"iron-gear-wheel", 1},
        },
        result = "worm-centrifuge"
    }
})

data:extend({
    {
        type = "recipe",
        name = "bullet-seed",
        category = "worm-centrifuge-crafting",
        enabled = true,
        energy_required = 4,
        ingredients = {
            {"bullet-worms", 1},
            {"honeysuckle-ore", 5}
        },
        result = "bullet-seed"
    }
})