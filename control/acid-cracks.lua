require('event-dispatcher')
local math2d = require('math2d')

function generate_cracks(surface, position, village_size)
    global.village_size = village_size
    local width, height = village_size, village_size -- Размер карты
    local cave = {}
    local fill_probability = 0.55
    local steps = 3

    -- Инициализация карты случайными значениями
    for x = 1, width do
        cave[x] = {}
        for y = 1, height do
            cave[x][y] = "none"
            if math2d.position.distance({x,y}, {width/2, height/2}) < width/2 then
                if math.random() < fill_probability then
                    cave[x][y] = "none"
                else
                    cave[x][y] = "concrete"
                end
            end
        end
    end

    -- Функция для подсчета соседних тайлов типа "none"
    local function count_none_neighbors(x, y)
        local count = 0
        for dx = -1, 1 do
            for dy = -1, 1 do
                if not (dx == 0 and dy == 0) then
                    local nx, ny = x + dx, y + dy
                    if nx > 0 and nx <= width and ny > 0 and ny <= height then
                        if cave[nx][ny] == "none" then
                            count = count + 1
                        end
                    else
                        count = count + 1 -- Границы карты считаются как "none"
                    end
                end
            end
        end
        return count
    end

    -- Применение клеточного автомата
    for step = 1, steps do
        local new_cave = {}
        for x = 1, width do
            new_cave[x] = {}
            for y = 1, height do
                local none_neighbors = count_none_neighbors(x, y)
                if cave[x][y] == "none" then
                    if none_neighbors < 4 then
                        new_cave[x][y] = "concrete"
                    else
                        new_cave[x][y] = "none"
                    end
                else
                    if none_neighbors > 4 then
                        new_cave[x][y] = "none"
                    else
                        new_cave[x][y] = "concrete"
                    end
                end
            end
        end
        cave = new_cave
    end

    -- Установка тайлов на новой поверхности
    for x = 1, width do
        for y = 1, height do
            local none_neighbors = count_none_neighbors(x, y)
            if none_neighbors<8 then
                local pos = { x - width / 2 + position.x, y - height / 2 + position.y }
                surface.destroy_decoratives{position=pos}
                for _, entity in pairs(surface.find_entities_filtered{position=pos}) do
                    entity.destroy()
                end
            end
        end
    end

    local tiles = {}

    for x = 1, width do
        for y = 1, height do
            local localPos = { x - width / 2, y - height / 2 }
            local pos = { localPos[1] + position.x, localPos[2] + position.y }
            if(cave[x][y] ~= "none") then
                if(surface.get_tile(pos[1], pos[2]).name == "acid-ground") then
                    table.insert(tiles, { name = "out-of-map", position = pos})
                end
            else
                
            end
        end
    end
    surface.set_tiles(tiles)
end

event_dispatcher:on_event(defines.events.on_chunk_generated, function(event)
    local pos1 = event.area.left_top
    local pos2 = event.area.right_bottom

    local pos = {x=math.ceil((pos1.x + pos2.x)/2), y=math.ceil((pos1.y + pos2.y)/2)}
    if event.surface.get_tile(pos.x, pos.y).name == "acid-ground" then
        if math.random() < 0.3 then
            generate_cracks(event.surface, pos, math.random(25, 120))
        end
    end
    -- local surface = event.surface
    -- local area = {{pos.x-(village_size/2), pos.y-(village_size/2)}, {pos.x+(village_size/2), pos.y+(village_size/2)}} -- Задайте нужную область
end)
