---@class Paddle
---@field posX number
---@field posY number
---@field width number
---@field height number
---@field upKey string
---@field downKey string
---@field isAIMode boolean
---@field randomTracking number
local Paddle = {}
Paddle.__index = Paddle

---@param posX number
---@param posY number
---@param width number
---@param height number
---@param upKey string
---@param downKey string
---@param isAIMode boolean
---@return Paddle
function Paddle.new(posX, posY, width, height, upKey, downKey, isAIMode)
  local self = setmetatable({}, Paddle)
  self.posX = posX
  self.posY = posY
  self.width = width
  self.height = height
  self.upKey = upKey
  self.downKey = downKey
  self.isAIMode = isAIMode
  self.randomTracking = math.random(-100, 100)
  return self
end

function Paddle:render()
  love.graphics.rectangle("fill", self.posX, self.posY, self.width, self.height)
end

---@param ball Ball
---@param dt number
function Paddle:update(ball, dt)
  if not self.isAIMode then
    if love.keyboard.isDown(self.upKey) then
      self.posY = self.posY - 300 * dt
    end
    if love.keyboard.isDown(self.downKey) then
      self.posY = self.posY + 300 * dt
    end
  else
    local paddleCenter = self.posY + self.height / 2
    local targetY = ball.posY

    if self.posX - ball.posX <= WINDOW_WIDTH / 4 then
      if targetY > paddleCenter then
        self.posY = self.posY + (250 + self.randomTracking) * dt
      elseif targetY < paddleCenter then
        self.posY = self.posY - (250 + self.randomTracking) * dt
      end
    end
  end

  if self.posY <= 0 then
    self.posY = 0
  end

  if self.posY + self.height >= WINDOW_HEIGHT then
    self.posY = WINDOW_HEIGHT - self.height
  end
end

return Paddle
