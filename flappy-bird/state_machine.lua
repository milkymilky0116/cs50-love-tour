---@class StateMachine
---@field states State[]
---@field currentState State
StateMachine = {}
StateMachine.__index = StateMachine

---@param states State[]
---@param currentState State
---@return StateMachine
function StateMachine.new(states, currentState)
  local self = setmetatable({}, StateMachine)
  self.states = states
  self.currentState = currentState or {}
  return self
end

---@param state "title"|"play"|"countdown"|"score"|"pause"
function StateMachine:change(state)
  self.currentState:exit()
  self.currentState = self.states[state]
  self.currentState:enter()
end

function StateMachine:render()
  self.currentState:render()
end

---@param dt number
function StateMachine:update(dt)
  self.currentState:update(dt)
end

return StateMachine
