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
---@field isLevelMixed boolean
---@field isNone boolean
---@field blocks Block[][]
---@field blockTypes number[]
---@field blockLevels number[]
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
---@param isLevelMixed boolean
---@param blockTypes number[]
---@param blockLevels number[]
---@return LevelManager
function LevelManager.new(posX, posY, row, column, margin, isAlternate, isSkip, isMixed, isLevelMixed, blockTypes,
                          blockLevels)
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
  self.isLevelMixed = isLevelMixed
  self.blockTypes = blockTypes
  self.blockLevels = blockLevels
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
      self.isNone = math.random(self.column) == 1
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

      local blockType = self.blockTypes[1]
      local blockLevel = self.blockLevels[1]
      if self.isAlternate then
        local visibleIndex = i
        local levelIndex = i
        for k = 0, j do
          local wouldSkip = false
          if self.isSkip then
            if (i % 2 == 0 and k % 2 == 0) or (i % 2 ~= 0 and k % 2 ~= 0) then
              wouldSkip = true
            end
          end
          if not wouldSkip then
            visibleIndex = visibleIndex % #self.blockTypes
            visibleIndex = visibleIndex + 1

            levelIndex = levelIndex % #self.blockLevels
            levelIndex = levelIndex + 1
            if self.isLevelMixed then
              levelIndex = math.random(#self.blockLevels)
            end
          end
          blockType = self.blockTypes[visibleIndex]
          blockLevel = self.blockLevels[levelIndex]
        end
      end

      if self.isNone then
        goto continue
      end

      if shouldSkip then
        baseX = baseX + BLOCK_WIDTH + self.margin
        goto continue
      end

      local block = Block.new(baseX, baseY, blockType, blockLevel)
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
