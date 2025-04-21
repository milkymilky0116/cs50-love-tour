---@class PlayState
---@field paddle Paddle
---@field ball Ball
---@field level number
---@field health Health
---@field score Score
---@field levelManager LevelManager
PlayState = {}
PlayState.__index = PlayState
setmetatable(PlayState, { __index = State })

---@return PlayState|State
function PlayState.new()
  local self = setmetatable({}, PlayState)
  return self
end

function PlayState:exit()
  GStateMachine.score = self.score.score
end

function PlayState:enter()
  self.paddle = Paddle.new(GStateMachine.paddleX, GStateMachine.paddleY, 200, GStateMachine.paddleTier, 2)
  self.ball = Ball.new(GStateMachine.ballX, GStateMachine.ballY, GStateMachine.ballTier)
  self.health = Health.new(GStateMachine.health, VIRTURE_WIDTH - 105, 10)
  self.level = GStateMachine.level
  self.score = Score.new(GStateMachine.score, 180, 10)
  self.levelManager = GStateMachine.currentLevelManager
end

---@param dt number
function PlayState:update(dt)
  self.ball:update(dt)
  self.paddle:update(dt)

  if self.ball:collideWithPaddle(self.paddle) then
    GSound["paddle-hit"]:play()
    self.ball.posY = self.paddle.posY - BALL_SIZE
    local centerDistance = (self.ball.posX - (self.paddle.posX + self.paddle.width / 2)) / (self.paddle.width / 2)
    local acceleration = 1.0 + 0.01 * math.abs(centerDistance)
    self.ball.dy = -self.ball.dy
    self.ball.dy = self.ball.dy * acceleration
  end

  if self.ball.posY >= VIRTURE_HEIGHT then
    GStateMachine.health = GStateMachine.health - 1
    GStateMachine:change("prepare")
  end

  if GStateMachine.health == 0 then
    GStateMachine:change("gameover")
  end


  for _, row in pairs(self.levelManager.blocks) do
    for k, block in pairs(row) do
      if self.ball:collideWithBlock(block) then
        -- self.ball.psystem:setPosition(self.ball.posX, self.ball.posY)
        -- self.ball.psystem:emit(10)
        if block.level >= 1 then
          GSound["brick-hit-1"]:play()
        else
          GSound["brick-hit-2"]:play()
        end

        self.score:add(block)
        if block.level == 0 then
          table.remove(row, k)
        else
          block.level = block.level - 1
        end
      end
    end
  end

  local beatCount = 0
  for _, row in pairs(self.levelManager.blocks) do
    if #row == 0 then
      beatCount = beatCount + 1
    end
  end

  if beatCount == self.levelManager.column then
    if GStateMachine.level == #GLevel then
      GStateMachine:change("complete")
    else
      GStateMachine:change("nextstage")
    end
  end
end

function PlayState:render()
  self.ball:render()
  self.paddle:render()
  self.levelManager:render()
  self.health:render()
  self.score:render()
end

return PlayState
