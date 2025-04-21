---@class Score
---@field posX number
---@field posY number
---@field score number
Score = {}
Score.__index = Score

---@param score number
---@param posX number
---@param posY number
---@return Score
function Score.new(score, posX, posY)
  local self = setmetatable({}, Score)
  self.score = score
  self.posX = posX
  self.posY = posY
  return self
end

---@param block Block
function Score:add(block)
  self.score = self.score + ((block.tier + 1) * 100) + ((block.level + 1) * 10)
end

function Score:render()
  love.graphics.setFont(GFont["smallFont"])
  love.graphics.printf("Score: " .. self.score, self.posX, self.posY, VIRTURE_WIDTH, "center")
end

return Score
