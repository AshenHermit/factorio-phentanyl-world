require('event-dispatcher')

function create_underground()
    if game.get_surface("underground") ~= nil then return nil end
    local surface = game.create_surface("underground", { width = 1, height = 1 })
    return surface
end

function generate_cave(surface)
    local width, height = 100, 100 -- Размер карты
    local cave = {}
    local fill_probability = 0.55
    local steps = 5

    -- Инициализация карты случайными значениями
    for x = 1, width do
        cave[x] = {}
        for y = 1, height do
            if math.random() < fill_probability then
                cave[x][y] = "none"
            else
                cave[x][y] = "concrete"
            end
        end
    end

    -- Функция для подсчета соседних тайлов типа "none"
    local function count_stone_neighbors(x, y)
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
                local stone_neighbors = count_stone_neighbors(x, y)
                if cave[x][y] == "none" then
                    if stone_neighbors < 4 then
                        new_cave[x][y] = "concrete"
                    else
                        new_cave[x][y] = "none"
                    end
                else
                    if stone_neighbors > 4 then
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
    local tiles = {}
    for x = 1, width do
        for y = 1, height do
            if(cave[x][y] ~= "none") then
                table.insert(tiles, { name = cave[x][y], position = { x - width / 2, y - height / 2 } })
            end
        end
    end
    surface.set_tiles(tiles)
end

event_dispatcher:on_event(defines.events.on_chunk_generated, function(event)
    if (event.surface.name ~= "underground") then return end
    if (event.area.right_bottom.y ~= 0) then return end
    local size = 3
    for x = -size / 2, size / 2 do
        for y = -size / 2, size / 2 do
            event.surface.set_tiles({ { name = "concrete", position = { x, y } } })
        end
    end

    generate_cave(event.surface)
end)

event_dispatcher:on_event(defines.events.on_tick, function(event)
    local surface = game.players[1].surface
    if (surface.name ~= "underground") then return end
    surface.daytime = 0.5
end)
