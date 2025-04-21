---@class HighScoreState
---@field highscore HighScore
HighScoreState = {}
HighScoreState.__index = HighScoreState
setmetatable(HighScoreState, { __index = State })

---@return HighScoreState
function HighScoreState.new()
  local self = setmetatable({}, HighScoreState)
  return self
end

function HighScoreState:exit()
  GStateMachine:reset()
end

function HighScoreState:enter()
  self.highscore = GStateMachine.highscore
end

---@param dt number
function HighScoreState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("title")
  end
end

function HighScoreState:render()
  love.graphics.setFont(GFont["largeFont"])
  love.graphics.printf("HighScore", 10, 10, VIRTURE_WIDTH, "center")
  self.highscore:render()
end

return HighScoreState
