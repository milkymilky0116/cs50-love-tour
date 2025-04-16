---@class PlayState
PlayState = {}
PlayState.__index = PlayState
setmetatable(PlayState, { __index = State })

---@return PlayState|State
function PlayState.new()
  local self = setmetatable({}, PlayState)
  return self
end

function PlayState:exit() end

function PlayState:enter() end

---@param dt number
function PlayState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("test")
  end
end

function PlayState:render()
  love.graphics.printf("Play State", 10, 10, VIRTURE_WIDTH, "center")
end

return PlayState
