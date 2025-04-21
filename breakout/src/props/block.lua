---@class Block
---@field posX number
---@field posY number
---@field tier number -- Block's color
---@field level number -- Block's life
---@field disable boolean
Block = {}
Block.__index = Block

---@param posX number
---@param posY number
---@param tier number
---@param level number
---@return Block
function Block.new(posX, posY, tier, level)
  local self = setmetatable({}, Block)
  self.posX = posX
  self.posY = posY
  self.tier = tier - 1
  self.level = level - 1
  self.disable = false
  return self
end

---@param dt number
function Block:update(dt) end

function Block:render()
  if not self.disable then
    local blockQuads = GBlocks[(self.tier * 4) + self.level + 1]
    love.graphics.draw(GImage["main"], blockQuads, self.posX, self.posY)
  end
end

return Block
