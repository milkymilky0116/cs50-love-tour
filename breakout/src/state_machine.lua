---@class StateMachine
---@field states State[]
---@field currentState State
---@field paddleTier number
---@field ballTier number
---@field level number
---@field health number
---@field score number
---@field paddleX number
---@field paddleY number
---@field ballX number
---@field ballY number
---@field currentLevelManager LevelManager
---@field highscore HighScore
StateMachine = {}
StateMachine.__index = StateMachine

---@param states State[]
---@return StateMachine
function StateMachine.new(states)
  local self = setmetatable({}, StateMachine)
  self.states = states
  self.paddleTier = 1
  self.ballTier = 1
  self.level = 2
  self.health = 3
  self.score = 0
  self.highscore = HighScore.new(10, VIRTURE_HEIGHT / 2 - 40)
  return self
end

---@param state "select_paddle"|"select_ball"|"play"|"prepare"|"gameover"|"nextstage"|"complete"|"title"|"highscore"|"input"
function StateMachine:change(state)
  if self.currentState then
    self.currentState:exit()
    self.currentState = self.states[state]
    self.currentState:enter()
  else
    self.currentState = self.states[state]
  end
end

function StateMachine:reset()
  GStateMachine.level = 1
  GStateMachine.health = 3
  GStateMachine.score = 0
  GStateMachine.currentLevelManager = nil
end

---@param dt number
function StateMachine:update(dt)
  self.currentState:update(dt)
end

function StateMachine:render()
  self.currentState:render()
end

return StateMachine
