---@class PauseState
PauseState = {}
PauseState.__index = PauseState
setmetatable(PauseState, { __index = State })

---@return PauseState
function PauseState.new()
  local this = setmetatable({}, PauseState)
  return this
end

function PauseState:enter() end

function PauseState:exit()
  IsScrolling = true
end

---@param dt number
function PauseState:update(dt)
  if love.waspressed("z") then
    GStateMachine:change("play")
  end
end

function PauseState:render()
  love.graphics.setFont(MediumFont)
  love.graphics.printf("Paused", 0, 120, VIRTURE_WIDTH, "center")
end

return PauseState
