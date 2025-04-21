---@class Select
---@field name string
---@field target "select_paddle"|"select_ball"|"play"|"prepare"|"gameover"|"nextstage"|"complete"|"title"|"highscore"|"input"
Select = {}
Select.__index = Select

---@param name string
---@param target "select_paddle"|"select_ball"|"play"|"prepare"|"gameover"|"nextstage"|"complete"|"title"|"highscore"|"input"
---@return Select
function Select.new(name, target)
  local self = setmetatable({}, Select)
  self.name = name
  self.target = target
  return self
end

function Select:change()
  GStateMachine:change(self.target)
end

return Select
