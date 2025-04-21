---@class Heart
---@field posX number
---@field posY number
---@field isDamaged boolean
Heart = {}
Heart.__index = Heart

---@param posX number
---@param posY number
---@param isDamaged boolean
---@return Heart
function Heart.new(posX, posY, isDamaged)
  local self = setmetatable({}, Heart)
  self.posX = posX
  self.posY = posY
  self.isDamaged = isDamaged
  return self
end

function Heart:render()
  local heart_quads = GHearts
  if self.isDamaged then
    love.graphics.draw(GImage["main"], heart_quads[2], self.posX, self.posY)
  else
    love.graphics.draw(GImage["main"], heart_quads[1], self.posX, self.posY)
  end
end

return Heart
