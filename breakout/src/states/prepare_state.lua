---@class PrepareState
---@field paddle Paddle
---@field ball Ball
---@field health Health
---@field levelManager LevelManager
PrepareState = {}
PrepareState.__index = PrepareState
setmetatable(PrepareState, State)

---@return PrepareState
function PrepareState.new()
  local self = setmetatable({}, PrepareState)
  return self
end

function PrepareState:enter()
  self.paddle = Paddle.new(VIRTURE_WIDTH / 2, VIRTURE_HEIGHT - 32, 200, GStateMachine.paddleTier, 2)
  self.ball = Ball.new(self.paddle.posX + self.paddle.width / 2 - BALL_SIZE / 2, self.paddle.posY - BALL_SIZE,
    GStateMachine.ballTier)
  self.health = Health.new(GStateMachine.health, VIRTURE_WIDTH - 105, 10)
  if GStateMachine.currentLevelManager == nil then
    self.levelManager = GLevel[GStateMachine.level]
    self.levelManager:makeLevel()
    GStateMachine.currentLevelManager = self.levelManager
  else
    self.levelManager = GStateMachine.currentLevelManager
  end
end

function PrepareState:exit()
  GStateMachine.paddleX = self.paddle.posX + self.paddle.width / 2
  GStateMachine.paddleY = self.paddle.posY
  GStateMachine.ballX = self.ball.posX
  GStateMachine.ballY = self.ball.posY
end

---@param dt number
function PrepareState:update(dt)
  self.paddle:update(dt)
  self.ball.posX = self.paddle.posX + self.paddle.width / 2 - BALL_SIZE / 2
  self.ball.posY = self.paddle.posY - BALL_SIZE
  if love.waspressed("space") then
    GStateMachine:change("play")
  end
end

function PrepareState:render()
  love.graphics.setFont(GFont["smallFont"])
  self.paddle:render()
  self.ball:render()
  self.levelManager:render()
  self.health:render()
  love.graphics.printf("choose paddle position, space to start", 10, 5, VIRTURE_WIDTH, "center")
end

return PrepareState
