---@class CompleteState
CompleteState = {}
CompleteState.__index = CompleteState
setmetatable(CompleteState, { __index = State })


---@return CompleteState
function CompleteState.new()
  local self = setmetatable({}, CompleteState)
  return self
end

function CompleteState:enter() end

function CompleteState:exit()
end

---@param dt number
function CompleteState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("input")
  end
end

function CompleteState:render()
  love.graphics.setFont(GFont["mediumFont"])
  love.graphics.printf("Conglaturation! Press enter to enter your score", 10, 10, VIRTURE_WIDTH, "center")
end

return CompleteState
