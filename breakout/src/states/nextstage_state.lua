---@class NextStageState
NextStageState = {}
NextStageState.__index = NextStageState
setmetatable(NextStageState, { __index = State })


---@return NextStageState
function NextStageState.new()
  local self = setmetatable({}, NextStageState)
  return self
end

function NextStageState:enter() end

function NextStageState:exit()
  GStateMachine.level = GStateMachine.level + 1
  GStateMachine.currentLevelManager = GLevel[GStateMachine.level]
  GStateMachine.currentLevelManager:makeLevel()
end

---@param dt number
function NextStageState:update(dt)
  if love.waspressed("return") then
    GStateMachine:change("prepare")
  end
end

function NextStageState:render()
  love.graphics.setFont(GFont["mediumFont"])
  love.graphics.printf("You beat Level " .. GStateMachine.level .. "! press enter to go to Level " ..
    GStateMachine.level + 1, 5, 10, VIRTURE_WIDTH, "center")
end

return NextStageState
