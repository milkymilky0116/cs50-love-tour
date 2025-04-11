local Trail = require("trail")
---@class Ball
---@field posX number
---@field posY number
---@field dx number
---@field dy number
---@field radius number
---@field serve number
---@field trails Trail[]
---@field timer number
Ball = {}
Ball.__index = Ball

local speedMultiplier = 1.03

---@param posX number
---@param posY number
---@param radius number
function Ball.new(posX, posY, radius)
  math.randomseed(os.time())
  ---@type Ball
  local self = setmetatable({}, Ball)
  self.posX = posX
  self.posY = posY

  self.serve = math.random(2) == 1 and -1 or 1
  self.dx = self.serve * 300
  self.dy = math.random(-200, 200) * 1.5
  self.radius = radius
  self.trails = {}
  self.timer = 4
  return self
end

---@param paddle Paddle
---@return boolean
function Ball:collide(paddle)
  if self.posX > paddle.posX + paddle.width or paddle.posX > self.posX + self.radius then
    return false
  end

  if self.posY > paddle.posY + paddle.height or paddle.posY > self.posY + self.radius then
    return false
  end
  return true
end

function Ball:render()
  for _, trail in ipairs(self.trails) do
    trail:render()
  end
  love.graphics.setColor(0.8, 0.5, 0.15, 1)
  love.graphics.circle("fill", self.posX, self.posY, self.radius - 1)
  love.graphics.setColor(1, 1, 1, 1)
end

---@param dt number
---@param state State
function Ball:update(dt, state)
  self.posX = self.posX + self.dx * dt
  self.posY = self.posY + self.dy * dt
  self.timer = self.timer - 1
  local trail = Trail.new(math.random(self.posX - 10, self.posX + 10), math.random(self.posY - 2, self.posY + 2),
    self.radius, 15)
  table.insert(self.trails, trail)

  for i, point in ipairs(self.trails) do
    point:update(dt)
    if point.timer <= 0 then
      table.remove(self.trails, i)
    end
  end
  -- Ball Hits Top Border
  if self.posY - self.radius <= 0 then
    self.posY = self.radius
    self.dy = -self.dy * speedMultiplier
    WallHitSound:play()
  end

  -- Ball Hits Bottom Border
  if self.posY + self.radius >= WINDOW_HEIGHT then
    self.posY = WINDOW_HEIGHT - self.radius
    self.dy = -self.dy * speedMultiplier
    WallHitSound:play()
  end

  -- Ball Hits Right Border
  if self.posX + self.radius >= WINDOW_WIDTH then
    self.posX = WINDOW_WIDTH - self.radius
    self.dx = -self.dx * speedMultiplier
    state.player1Score = state.player1Score + 1
    state.state = "serve"
    self.serve = -1
    self:reset()
    ScoreSound:play()
  end

  -- Ball Hits Left Border
  if self.posX - self.radius <= 0 then
    self.posX = self.radius
    self.dx = -self.dx * speedMultiplier
    state.player2Score = state.player2Score + 1
    state.state = "serve"
    self.serve = 1
    self:reset()
    ScoreSound:play()
  end
end

function Ball:reset()
  self.posX = WINDOW_WIDTH / 2
  self.posY = WINDOW_HEIGHT / 2
  self.dx = self.serve * 300
  self.dy = math.random(-200, 200) * 1.5
end

return Ball
