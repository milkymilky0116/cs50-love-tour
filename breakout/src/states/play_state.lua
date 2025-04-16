---@class PlayState
---@field paddle Paddle
---@field ball Ball
---@field levelManager LevelManager
PlayState = {}
PlayState.__index = PlayState
setmetatable(PlayState, { __index = State })

---@return PlayState|State
function PlayState.new()
  local self = setmetatable({}, PlayState)
  self.paddle = Paddle.new(VIRTURE_WIDTH / 2, VIRTURE_HEIGHT - 32, 100, 1, 2)
  self.ball = Ball.new(VIRTURE_WIDTH / 2 - BALL_SIZE, VIRTURE_HEIGHT / 2 - BALL_SIZE, 1)
  self.levelManager = LevelManager.new(VIRTURE_WIDTH / 2 - 80, 30, 8, 8, 3, true, false, false)
  self.levelManager:makeLevel()
  return self
end

function PlayState:exit() end

function PlayState:enter() end

---@param dt number
function PlayState:update(dt)
  self.ball:update(dt)
  self.paddle:update(dt)

  if self.ball:collide(self.paddle) then
    self.ball.posY = self.paddle.posY - BALL_SIZE
    local centerDistance = (self.ball.posX - (self.paddle.posX + self.paddle.width / 2)) / (self.paddle.width / 2)
    local acceleration = 1.0 + 0.5 * math.abs(centerDistance)
    self.ball.dy = -self.ball.dy
    self.ball.dy = self.ball.dy * acceleration
  end
end

function PlayState:render()
  self.ball:render()
  self.paddle:render()
  self.levelManager:render()
end

return PlayState
