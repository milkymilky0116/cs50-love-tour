---@class ScoreState:State
---@field medal string
ScoreState = {}
ScoreState.__index = ScoreState

setmetatable(ScoreState, { __index = State })

---@return ScoreState|State
function ScoreState.new()
  local this = setmetatable({}, ScoreState)
  return this
end

function ScoreState:enter()
  IsScrolling = false
end

function ScoreState:exit()
  Score = 0
  IsScrolling = true
  GStateMachine.states["play"]:reset()
end

---@param dt number
function ScoreState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("countdown")
  end
end

function ScoreState:render()
  love.graphics.setFont(FlappyFont)
  love.graphics.printf("Oops.. Your Score is " .. Score, 0, 64, VIRTURE_WIDTH, "center")

  if Score < 5 then
    self.medal = "Bronze"
  elseif Score < 10 then
    self.medal = "Silver"
  else
    self.medal = "Gold"
  end

  love.graphics.printf("Your Medal is " .. self.medal, 0, 120, VIRTURE_WIDTH, "center")

  love.graphics.setFont(MediumFont)
  love.graphics.printf("Press enter to try again", 0, 100, VIRTURE_WIDTH, "center")
end

return ScoreState
