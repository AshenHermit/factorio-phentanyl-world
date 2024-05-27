local function add_random_loot(inventory, loot_table)
    for _, loot in pairs(loot_table) do
        if math.random() < loot.probability then
            inventory.insert{name = loot.name, count = math.random(loot.count_min, loot.count_max)}
        end
    end
end
local function spill_random_loot(surface, position, loot_table)
    for _, loot in pairs(loot_table) do
        if math.random() < loot.probability then
            surface.spill_item_stack(
                position, 
                {name = loot.name, count = math.random(loot.count_min, loot.count_max)},
                true)
        end
    end
end

return {
    add_random_loot = add_random_loot,
    spill_random_loot = spill_random_loot
}