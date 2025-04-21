---@class SelectBallState
---@field currentIndex number
SelectBallState = {}
SelectBallState.__index = SelectBallState
setmetatable(SelectBallState, { __index = State })


---@return SelectBallState
function SelectBallState.new()
  local self = setmetatable({}, SelectBallState)
  self.currentIndex = 0
  return self
end

function SelectBallState:enter() end

function SelectBallState:exit()
  GStateMachine.ballTier = self.currentIndex + 1
end

---@param dt number
function SelectBallState:update(dt)
  if love.waspressed("d") then
    self.currentIndex = self.currentIndex + 1
  elseif love.waspressed("a") then
    self.currentIndex = self.currentIndex - 1
  elseif love.waspressed("return") then
    GStateMachine:change("prepare")
  end
  self.currentIndex = self.currentIndex % #GBalls
end

function SelectBallState:render()
  local ballQuads = GBalls[self.currentIndex + 1]
  love.graphics.setFont(GFont["mediumFont"])
  love.graphics.printf("Select Ball", 10, 10, VIRTURE_WIDTH, "center")
  love.graphics.draw(GImage["main"], ballQuads, VIRTURE_WIDTH / 2 - BALL_SIZE, VIRTURE_HEIGHT / 2)
end

return SelectBallState
