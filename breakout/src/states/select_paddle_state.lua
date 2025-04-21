---@class SelectPaddleState
---@field currentIndex number
SelectPaddleState = {}
SelectPaddleState.__index = SelectPaddleState
setmetatable(SelectPaddleState, { __index = State })


---@return SelectPaddleState
function SelectPaddleState.new()
  local self = setmetatable({}, SelectPaddleState)
  self.currentIndex = 0
  return self
end

function SelectPaddleState:enter() end

function SelectPaddleState:exit()
  print("In select paddle state:", self.currentIndex)
  GStateMachine.paddleTier = self.currentIndex + 1
end

---@param dt number
function SelectPaddleState:update(dt)
  if love.waspressed("d") then
    self.currentIndex = self.currentIndex + 1
  elseif love.waspressed("a") then
    self.currentIndex = self.currentIndex - 1
  elseif love.waspressed("return") then
    GStateMachine:change("select_ball")
  end
  self.currentIndex = self.currentIndex % 4
end

function SelectPaddleState:render()
  local paddleQuads = GPaddles[(self.currentIndex * 4) + 2]
  love.graphics.setFont(GFont["mediumFont"])
  love.graphics.printf("Select Paddle", 10, 10, VIRTURE_WIDTH, "center")
  love.graphics.draw(GImage["main"], paddleQuads, VIRTURE_WIDTH / 2 - PADDLE_BASE_WIDTH, VIRTURE_HEIGHT / 2)
end

return SelectPaddleState
