---@class LevelManager
---@field posX number
---@field posY number
---@field row number
---@field width number
---@field height number
---@field column number
---@field level number
---@field margin number
---@field isAlternate boolean
---@field isSkip boolean
---@field isMixed boolean
---@field blocks Block[][]
LevelManager = {}
LevelManager.__index = LevelManager
---@param posX number
---@param posY number
---@param row number
---@param column number
---@param margin number
---@param isAlternate boolean
---@param isSkip boolean
---@param isMixed boolean
---@return LevelManager
function LevelManager.new(posX, posY, row, column, margin, isAlternate, isSkip, isMixed)
  local self = setmetatable({}, LevelManager)
  self.margin = margin
  self.row = row
  self.column = column
  self.width = (BLOCK_WIDTH + self.margin) * self.row
  self.height = (BLOCK_HEIGHT + self.margin) * self.row
  self.posX = posX - self.width / 2
  self.posY = posY - self.height / 2
  self.isAlternate = isAlternate
  self.isSkip = isSkip
  self.isMixed = isMixed
  return self
end

function LevelManager:makeLevel()
  local blocks = {}
  local baseX = self.posX
  local baseY = self.posY


  for i = 0, self.column - 1 do
    local row = {}
    if self.isMixed then
      self.isSkip = math.random(2) == 1
      self.isAlternate = math.random(2) == 1
    end

    for j = 0, self.row - 1 do
      local skipCount = 0
      local shouldSkip = false
      if self.isSkip then
        if (i % 2 == 0 and j % 2 == 0) or (i % 2 ~= 0 and j % 2 ~= 0) then
          shouldSkip = true
        else
          skipCount = skipCount + 1
        end
      else
        skipCount = skipCount + 1
      end

      local blockType = 1
      if self.isAlternate then
        local visibleIndex = 0
        for k = 0, j do
          local wouldSkip = false
          if self.isSkip then
            if (i % 2 == 0 and k % 2 == 0) or (i % 2 ~= 0 and k % 2 ~= 0) then
              wouldSkip = true
            end
          end

          if not wouldSkip then
            visibleIndex = visibleIndex + 1
          end
        end

        if visibleIndex % 2 == 0 then
          blockType = i % 2 == 0 and 2 or 1
        else
          blockType = i % 2 == 0 and 1 or 2
        end
      end

      if shouldSkip then
        baseX = baseX + BLOCK_WIDTH + self.margin
        goto continue
      end


      local block = Block.new(baseX, baseY, blockType, 1)
      table.insert(row, block)
      baseX = baseX + BLOCK_WIDTH + self.margin
      ::continue::
    end
    baseX = self.posX
    baseY = baseY + BLOCK_HEIGHT + self.margin
    table.insert(blocks, row)
  end
  self.blocks = blocks
end

function LevelManager:render()
  for _, row in pairs(self.blocks) do
    for _, block in pairs(row) do
      if block then
        block:render()
      end
    end
  end
end

return LevelManager
