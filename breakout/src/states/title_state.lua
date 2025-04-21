---@class TitleState
---@field menu Menu
TitleState = {}
TitleState.__index = TitleState
setmetatable(TitleState, { __index = State })

---@return TitleState|State
function TitleState.new()
  local self = setmetatable({}, TitleState)
  self.menu = Menu.new({ Select.new("Start", "select_paddle"), Select.new("High Scores", "highscore") }, 10,
    VIRTURE_HEIGHT / 2 - 20)
  return self
end

function TitleState:enter() end

function TitleState:exit() end

function TitleState:update(dt)
  self.menu:update(dt)
end

function TitleState:render()
  love.graphics.setFont(GFont["largeFont"])
  love.graphics.printf("Breakout!", 10, 10, VIRTURE_WIDTH, "center")
  self.menu:render()
end

return TitleState
