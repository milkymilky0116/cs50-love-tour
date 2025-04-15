---@class CountdownState:State
---@field timer number
CountdownState = {}
CountdownState.__index = CountdownState

setmetatable(CountdownState, { __index = State })

---@return CountdownState|State
function CountdownState.new()
  local this = setmetatable({}, CountdownState)
  this.timer = 3
  return this
end

function CountdownState:enter() end

function CountdownState:exit()
  self.timer = 3
end

function CountdownState:render()
  love.graphics.setFont(HugeFont)
  love.graphics.printf(math.ceil(self.timer), 0, 120, VIRTURE_WIDTH, "center")
end

---@param dt number
function CountdownState:update(dt)
  local prevInt = math.floor(self.timer)
  self.timer = self.timer - dt
  local nextInt = math.floor(self.timer)
  if nextInt ~= prevInt then
    Sounds["score"]:play()
  end
  if self.timer <= 0 then
    GStateMachine:change("play")
  end
end

return CountdownState
