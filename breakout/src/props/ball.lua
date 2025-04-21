---@class Ball
---@field posX number
---@field posY number
---@field dx number
---@field dy number
---@field speed number
---@field tier number -- Ball's Color
---@field psystem love.ParticleSystem
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
    GSound["wall-hit"]:play()
    self.posY = BALL_SIZE / 2
    self.dy = -self.dy
    self.speed = self.speed * 1.03
  end

  -- if self.posY >= VIRTURE_HEIGHT - BALL_SIZE / 2 then
  --   self.posY = VIRTURE_HEIGHT - BALL_SIZE / 2
  --   self.dy = -self.dy
  -- end

  if self.posX <= 0 then
    GSound["wall-hit"]:play()
    self.posX = BALL_SIZE / 2
    self.dx = -self.dx
    self.speed = self.speed * 1.002
  end

  if self.posX >= VIRTURE_WIDTH - BALL_SIZE / 2 then
    GSound["wall-hit"]:play()
    self.posX = VIRTURE_WIDTH - BALL_SIZE / 2
    self.dx = -self.dx
    self.speed = self.speed * 1.002
  end
end

---@param paddle Paddle
---@return boolean
function Ball:collideWithPaddle(paddle)
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

---@param block  Block
---@return boolean
function Ball:collideWithBlock(block)
  local ballLeft    = self.posX
  local ballRight   = self.posX + BALL_SIZE
  local ballTop     = self.posY
  local ballBottom  = self.posY + BALL_SIZE

  local blockLeft   = block.posX
  local blockRight  = block.posX + BLOCK_WIDTH
  local blockTop    = block.posY
  local blockBottom = block.posY + BLOCK_HEIGHT


  if ballRight >= blockLeft and ballLeft <= blockRight and
      ballBottom >= blockTop and ballTop <= blockBottom then
    local overlapLeft = ballRight - blockLeft
    local overlapRight = blockRight - ballLeft
    local overlapTop = ballBottom - blockTop
    local overlapBottom = blockBottom - ballTop

    local minOverlap = math.min(overlapLeft, overlapRight, overlapTop, overlapBottom)

    if minOverlap == overlapLeft then
      self.posX = blockLeft - BALL_SIZE
      self.dx = -math.abs(self.dx)
    elseif minOverlap == overlapRight then
      self.posX = blockRight
      self.dx = math.abs(self.dx)
    elseif minOverlap == overlapTop then
      self.posY = blockTop - BALL_SIZE
      self.dy = -math.abs(self.dy)
    elseif minOverlap == overlapBottom then
      self.posY = blockBottom
      self.dy = math.abs(self.dy)
    end
    return true
  end
  return false
end

function Ball:render()
  local ballQuad = GBalls[self.tier]
  love.graphics.draw(GImage["main"], ballQuad, self.posX, self.posY)
end

return Ball
