local State = require('states.state') -- Make sure to require the State file

---@class TitleState : State
TitleState = {}
TitleState.__index = TitleState

-- Proper inheritance
setmetatable(TitleState, { __index = State })

---@return TitleState|State
function TitleState.new()
  local this = setmetatable({}, TitleState)
  return this
end

function TitleState:enter()
end

function TitleState:exit()
end

---@param dt number
function TitleState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("countdown")
  end
end

function TitleState:render()
  love.graphics.setFont(FlappyFont)
  love.graphics.printf("Flappy Bird", 0, 64, VIRTURE_WIDTH, "center")

  love.graphics.setFont(MediumFont)
  love.graphics.printf("Press enter to start", 0, 100, VIRTURE_WIDTH, "center")
end

return TitleState
