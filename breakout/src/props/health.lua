---@class Health
---@field life number
---@field posX number
---@field posY number
Health = {}
Health.__index = Health

---@param posX number
---@param posY number
---@param life number
---@return Health
function Health.new(life, posX, posY)
  local self = setmetatable({}, Health)
  self.posX = posX
  self.posY = posY
  self.life = life
  return self
end

function Health:render()
  local hearts = {}
  local tempPosX = self.posX
  for i = 0, 2 do
    ---@type Heart
    local heart
    if i <= self.life - 1 then
      heart = Heart.new(tempPosX, self.posY, false)
    else
      heart = Heart.new(tempPosX, self.posY, true)
    end
    table.insert(hearts, heart)
    tempPosX = tempPosX + 12
  end

  for _, heart in pairs(hearts) do
    heart:render()
  end
end

return Health
