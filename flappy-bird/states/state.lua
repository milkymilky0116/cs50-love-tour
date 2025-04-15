---@class State
State = {}
State.__index = State

function State:enter() end

function State:exit() end

---@param dt number
function State:update(dt) end

function State:render() end

return State
