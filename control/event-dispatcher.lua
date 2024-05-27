EventDispatcher = {}
EventDispatcher.__index = EventDispatcher

-- Конструктор
function EventDispatcher:new()
    local self = setmetatable({}, EventDispatcher)
    self.handlers = {}
    return self
end

-- Метод для регистрации обработчика события
function EventDispatcher:on_event(event_code, handler)
    if not self.handlers[event_code] then
        self.handlers[event_code] = {}
    end
    table.insert(self.handlers[event_code], handler)
end

-- Метод для регистрации обработчика события
function EventDispatcher:register()
    for key, handlers in pairs(self.handlers) do
        script.on_event(key, function (event) self:dispatch(key, event) end)
    end
end

-- Метод для вызова всех обработчиков события
function EventDispatcher:dispatch(event_code, event_data)
    local event_handlers = self.handlers[event_code]
    if event_handlers then
        for _, handler in ipairs(event_handlers) do
            handler(event_data)
        end
    end
end

-- Создаем глобальный экземпляр диспетчера событий
event_dispatcher = EventDispatcher:new()