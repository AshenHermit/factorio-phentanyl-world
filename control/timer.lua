require("event-dispatcher")

-- Класс TimerManager
TimerManager = {}
TimerManager.__index = TimerManager

function TimerManager:new()
    local self = setmetatable({}, TimerManager)
    self.timers = {}
    self.next_id = 1
    return self
end

function TimerManager:update(delta_time)
    for id, timer in pairs(self.timers) do
        timer.time_remaining = timer.time_remaining - delta_time
        if timer.time_remaining <= 0 then
            timer.callback()
            self.timers[id] = nil -- Удаляем таймер после его выполнения
        end
    end
end

function TimerManager:on_timeout(duration, callback)
    local id = self.next_id
    self.next_id = self.next_id + 1
    self.timers[id] = {
        time_remaining = duration,
        callback = callback
    }
    return id
end

function TimerManager:remove_timer(id)
    self.timers[id] = nil
end

timer_manager = TimerManager:new()
event_dispatcher:on_event(defines.events.on_tick, function(event)
    timer_manager:update(1)
end)