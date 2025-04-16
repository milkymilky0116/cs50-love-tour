---@class Paddle
---@field posX number
---@field posY number
---@field speed number
---@field tier number -- Paddle's color
---@field level number -- Paddle's size
---@field width number
Paddle = {}
Paddle.__index = Paddle

---@param posX number
---@param posY number
---@param speed number
---@param tier number
---@param level number
---@return Paddle
function Paddle.new(posX, posY, speed, tier, level)
  local self = setmetatable({}, Paddle)
  if level == 1 then
    self.width = PADDLE_BASE_WIDTH
  else
    self.width = PADDLE_BASE_WIDTH * level
  end

  self.posX = posX - (self.width / 2)
  self.posY = posY
  self.speed = speed
  self.tier = tier - 1
  self.level = level - 1
  return self
end

---@param dt number
function Paddle:update(dt)
  if love.keyboard.isDown("d") then
    self.posX = self.posX + self.speed * dt
  elseif love.keyboard.isDown("a") then
    self.posX = self.posX - self.speed * dt
  end

  if self.posX <= 0 then
    self.posX = math.max(0, self.posX)
  elseif self.posX + self.width >= VIRTURE_WIDTH then
    self.posX = math.min(VIRTURE_WIDTH - self.width, self.posX)
  end
end

function Paddle:render()
  local index = (self.tier * 4) + self.level + 1
  local paddleQuad = GPaddles[index]
  love.graphics.draw(GImage["main"], paddleQuad, self.posX, self.posY)
end

return Paddle
