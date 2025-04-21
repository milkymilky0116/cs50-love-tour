---@class GameOverState
GameOverState = {}
GameOverState.__index = GameOverState
setmetatable(GameOverState, { __index = State })


---@return GameOverState
function GameOverState.new()
  local self = setmetatable({}, GameOverState)
  return self
end

function GameOverState:enter() end

function GameOverState:exit()
end

---@param dt number
function GameOverState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("input")
  end
end

function GameOverState:render()
  love.graphics.setFont(GFont["mediumFont"])
  love.graphics.printf("Game Over! Press enter to enter your score", 10, 10, VIRTURE_WIDTH, "center")
end

return GameOverState
