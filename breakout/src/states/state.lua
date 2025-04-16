---@class State
State = {}
State.__index = State

---@return State
function State.new()
  local self = setmetatable({}, State)
  return self
end

function State:enter() end

function State:exit() end

function State:update(dt) end

function State:render() end

return State
