local config = require("config")

-- Todo: make public function library for transition templates
local function append_transition_mask_template(normal_res_transition, high_res_transition, options, tab)
    local function make_transition_variation(x_, cnt_, line_len_)
      local t =
      {
        picture = normal_res_transition,
        count = cnt_,
        line_length = line_len_ or cnt_,
        x = x_
      }
  
      if high_res_transition then
        t.hr_version =
        {
          picture = high_res_transition,
          count = cnt_,
          line_length = line_len_ or cnt_,
          x = 2 * x_,
          scale = 0.5
        }
      end
      return t
    end
  
    local mv = (options and options.mask_variations) or 8
    local suffix = (options and options.mask_suffix) or "mask"
    tab["inner_corner_" .. suffix] = make_transition_variation(0, mv)
    tab["outer_corner_" .. suffix] = make_transition_variation(288, mv)
    tab["side_" .. suffix]         = make_transition_variation(576, mv)
    tab["u_transition_" .. suffix] = make_transition_variation(864, 1, 1)
    tab["o_transition_" .. suffix] = make_transition_variation(1152, 1, 2)
  
    return tab
end

function tile_variations_template(normal_res_picture, normal_res_transition, high_res_picture, high_res_transition, options)
    local function main_variation(size_)
      local y_ = ((size_ == 1) and 0) or ((size_ == 2) and 64) or ((size_ == 4) and 160) or 320
      local ret =
      {
        picture = normal_res_picture,
        count = 16,
        size = size_,
        y = y_,
        line_length = (size_ == 8) and 8 or 16,
      }
  
      if options[size_] then
        for k, v in pairs(options[size_]) do
          ret[k] = v
        end
      end
  
      return ret
    end
  
    local main_ =
    {
      main_variation(1),
      main_variation(2),
      main_variation(4)
    }
    if (options.max_size == 8) then
      table.insert(main_, main_variation(8))
    end
  
    if options.empty_transitions then
      return
      {
        main = main_,
        empty_transitions = true
      }
    end
  
    return append_transition_mask_template(normal_res_transition, false, options, { main = main_ })
end

function copyPrototype(type, name, newName)
    if not data.raw[type][name] then error("type "..type.." name "..name.." does not exist") end
    local p = table.deepcopy(data.raw[type][name])
    p.name = newName
    if p.minable and p.minable.result then
        p.minable.result = newName
    end
    return p
end

-- Копируем тайл grass-1 и создаем новый
local acid_grass = copyPrototype("tile", "grass-1", "acid-grass")

acid_grass.name = "acid-grass"
acid_grass.order = "b[natural]-a[grass]-a[acid-grass]"

-- Изменяем параметры нового тайла
acid_grass.autoplace = {
    peaks = {
        {
            influence = 1.0,
            starting_area_weight_optimal = 1,
            starting_area_weight_range = 0,
            starting_area_weight_max_range = 2,
            richness_influence = 0
        }
    }
}
acid_grass.variants = tile_variations_template(
    config.graphics_path .. "terrain/acid-grass-1.png", "__base__/graphics/terrain/masks/transition-3.png",
    config.graphics_path .. "terrain/acid-grass-1.png", "__base__/graphics/terrain/masks/hr-transition-3.png",
    {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 0.91, weights = {0.150, 0.150, 0.150, 0.150, 0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025 }, },
        [4] = { probability = 0.91, weights = {0.100, 0.80, 0.80, 0.100, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
    }
),


data:extend{ acid_grass }


local function disable_autoplace(tile_name)
    local tile = data.raw.tile[tile_name]
    if tile and tile.autoplace then
        tile.autoplace = nil
    end
end
local function disable_tiles(tile_table)
    for key, value in pairs(tile_table) do
        disable_autoplace(value)
    end
end
disable_tiles{ 
"stone-path",
"concrete",
"hazard-concrete-left",
"hazard-concrete-right",
"refined-concrete",
"refined-hazard-concrete-left",
"refined-hazard-concrete-right",
"landfill",
"acid-refined-concrete",
"black-refined-concrete",
"blue-refined-concrete",
"brown-refined-concrete",
"cyan-refined-concrete",
"green-refined-concrete",
"orange-refined-concrete",
"pink-refined-concrete",
"purple-refined-concrete",
"red-refined-concrete",
"yellow-refined-concrete",
"grass-1",
"grass-2",
"grass-3",
"grass-4",
"dry-dirt",
-- "dirt-1",
"dirt-2",
"dirt-3",
"dirt-4",
"dirt-5",
"dirt-6",
"dirt-7",
"sand-1",
"sand-2",
"sand-3",
"red-desert-0",
"red-desert-1",
"red-desert-2",
"red-desert-3",
-- "water",
-- "deepwater",
-- "water-green",
-- "deepwater-green",
-- "water-shallow",
-- "water-mud",
-- "nuclear-ground",
-- "water-wube",
-- "tile-unknown",
-- "out-of-map",
-- "lab-dark-1",
-- "lab-dark-2",
-- "lab-white",
-- "tutorial-grid",
}