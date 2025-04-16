local State = require('states.state') -- Make sure to require the State file
local PipePair = require("pipe_pair")
local Bird = require("bird")
---@class PlayState: State
---@field bird Bird
---@field timer number
---@field pipe_pairs PipePair[]
PlayState = {}
PlayState.__index = PlayState

-- Proper inheritance
setmetatable(PlayState, { __index = State })

---@return PlayState|State
function PlayState.new()
  local this = setmetatable({}, PlayState)
  this.bird = Bird.new("assets/bird.png", 10, 15)
  this.timer = 2
  this.pipe_pairs = {}

  return this
end

function PlayState:enter()
end

function PlayState:exit()
end

function PlayState:reset()
  self.bird = Bird.new("assets/bird.png", 10, 15)
  self.timer = 2
  self.pipe_pairs = {}
  self.score = 0
end

---@param dt number
function PlayState:update(dt)
  if love.waspressed("z") then
    IsScrolling = false
    GStateMachine:change("pause")
  end

  self.timer = self.timer - dt
  self.bird:update(dt)
  local prevPipePairY = VIRTURE_HEIGHT / 2 + 30
  if self.timer <= 0 then
    local pipe_pair =
        PipePair.new("assets/pipe.png", VIRTURE_WIDTH, math.random(prevPipePairY - 50, prevPipePairY + 50), 80)
    table.insert(self.pipe_pairs, pipe_pair)
    self.timer = math.random(2, 4)
  end

  for k, pipe_pair in pairs(self.pipe_pairs) do
    if IsScrolling then
      pipe_pair:update(dt)
    end

    if not pipe_pair.isScored then
      if self.bird.x > pipe_pair.x + pipe_pair.BottomPipe.image:getWidth() then
        Sounds["score"]:play()
        Score = Score + 1
        pipe_pair.isScored = true
      end
    end

    if pipe_pair.x + pipe_pair.BottomPipe.image:getWidth() + 180 <= 0 then
      table.remove(self.pipe_pairs, k)
    end
    if self.bird:collide(pipe_pair.TopPipe) or self.bird:collide(pipe_pair.BottomPipe) then
      Sounds["explosion"]:play()
      Sounds["hurt"]:play()
      IsScrolling = false
      GStateMachine:change("score")
    end
  end
end

function PlayState:render()
  self.bird:render()
  for _, pipe_pair in pairs(self.pipe_pairs) do
    pipe_pair:render()
  end
  love.graphics.setFont(FlappyFont)
  love.graphics.printf("Score: " .. Score, 8, 8, VIRTURE_WIDTH, "center")
end

return PlayState
