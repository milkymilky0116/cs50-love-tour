---@class StateMachine
---@field states State[]
---@field currentState State
StateMachine = {}
StateMachine.__index = StateMachine

---@param states State[]
---@return StateMachine
function StateMachine.new(states)
  local self = setmetatable({}, StateMachine)
  self.states = states
  return self
end

---@param state "play"
function StateMachine:change(state)
  if self.currentState then
    self.currentState:exit()
    self.currentState = self.states[state]
    self.currentState:enter()
  else
    self.currentState = self.states[state]
  end
end

---@param dt number
function StateMachine:update(dt)
  self.currentState:update(dt)
end

function StateMachine:render()
  self.currentState:render()
end

return StateMachine
