local loot = require('loot')
require('event-dispatcher')
require('timer')
require('underground')

event_dispatcher:on_event(defines.events.on_chunk_generated, function(event)
    if(event.surface.name ~= game.surfaces[1].name) then return end
    local surface = event.surface
    local area = event.area
  
    if math.random() < 0.1 then
        local pos = {
            x = math.random(area.left_top.x, area.right_bottom.x),
            y = math.random(area.left_top.y, area.right_bottom.y)
        }

        local enemy = surface.create_entity{
            name = "twister",
            position = pos,
            force = "enemy"
        }
    end
end)

event_dispatcher:on_event(defines.events.on_entity_died, function(event)
  local entity = event.entity
  if entity.name == "twister" then

    loot.spill_random_loot(entity.surface, entity.position, {{name = "bullet-worms", count_min = 1, count_max = 10, probability = 0.5}})
  end
end)

transition_started = false
event_dispatcher:on_event(defines.events.on_entity_damaged, function(event)
  -- Получение информации о событии
  local entity = event.entity
  local damage = event.final_damage_amount
  local cause = event.cause

  -- Проверка, что поврежденный объект - турель врага
  if entity and entity.valid and entity.type == "turret" and entity.name == "human-flower" then
    -- Проверка, что урон нанесен врагом игроку (исключить урон от дружественных юнитов)
    if cause and cause.valid and cause.force == game.forces.player then
      local player = cause.player
      -- Сделать турель агрессивной
      entity.active = true
      
      if(not transition_started) then
        transition_started = true
        timer_manager:on_timeout(50, function()
          surface = create_underground()
          if surface == nil then return end
          player.teleport({0, 0}, surface)
          transition_started = false
        end)
      end
    end
  end
end)