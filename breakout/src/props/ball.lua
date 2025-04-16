---@class Ball
---@field posX number
---@field posY number
---@field dx number
---@field dy number
---@field speed number
---@field tier number -- Ball's Color
Ball = {}
Ball.__index = Ball

---@param posX number
---@param posY number
---@param tier number
---@return Ball
function Ball.new(posX, posY, tier)
  local self = setmetatable({}, Ball)
  self.posX = posX
  self.posY = posY
  self.speed = 100
  self.dx = math.random(2) == 1 and -1 or 1
  self.dy = math.random(2) == 1 and -1 or 1
  self.tier = tier
  return self
end

---@param dt number
function Ball:update(dt)
  self.posX = self.posX + self.dx * self.speed * dt
  self.posY = self.posY + self.dy * self.speed * dt
  if self.posY <= 0 then
    self.posY = BALL_SIZE / 2
    self.dy = -self.dy
    self.speed = self.speed * 1.03
  end

  -- if self.posY >= VIRTURE_HEIGHT - BALL_SIZE / 2 then
  --   self.posY = VIRTURE_HEIGHT - BALL_SIZE / 2
  --   self.dy = -self.dy
  -- end

  if self.posX <= 0 then
    self.posX = BALL_SIZE / 2
    self.dx = -self.dx
    self.speed = self.speed * 1.03
  end

  if self.posX >= VIRTURE_WIDTH - BALL_SIZE / 2 then
    self.posX = VIRTURE_WIDTH - BALL_SIZE / 2
    self.dx = -self.dx
    self.speed = self.speed * 1.03
  end
end

---@param paddle Paddle
---@return boolean
function Ball:collide(paddle)
  local ballLeft = self.posX
  local ballRight = self.posX + BALL_SIZE
  local ballTop = self.posY
  local ballBottom = self.posY + BALL_SIZE

  local paddleLeft = paddle.posX
  local paddleRight = paddle.posX + (PADDLE_BASE_WIDTH * (paddle.level + 1))
  local paddleTop = paddle.posY
  local paddleBottom = paddle.posY + PADDLE_HEIGHT

  if ballRight <= paddleLeft or ballLeft >= paddleRight or ballTop >= paddleBottom or ballBottom <= paddleTop then return false end
  return true
end

function Ball:render()
  local ballQuad = GBalls[self.tier]
  love.graphics.draw(GImage["main"], ballQuad, self.posX, self.posY)
end

return Ball
