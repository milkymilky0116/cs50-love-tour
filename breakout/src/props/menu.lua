---@class Menu
---@field posX number
---@field posY number
---@field selects Select[]
---@field currentIndex number
Menu = {}
Menu.__index = Menu

---@param posX number
---@param posY number
---@param selects Select[]
---@return Menu
function Menu.new(selects, posX, posY)
  local self = setmetatable({}, Menu)
  self.selects = selects
  self.posX = posX
  self.posY = posY
  self.currentIndex = 1
  return self
end

---@param dt number
function Menu:update(dt)
  if love.waspressed("down") then
    self.currentIndex = self.currentIndex % #self.selects
    self.currentIndex = self.currentIndex + 1
  end
  if love.waspressed("up") then
    self.currentIndex = self.currentIndex - 1
    if self.currentIndex == 0 then
      self.currentIndex = #self.selects
    else
      self.currentIndex = self.currentIndex % #self.selects
    end
  end

  if love.waspressed("return") then
    self.selects[self.currentIndex]:change()
  end
end

function Menu:render()
  love.graphics.setFont(GFont["smallFont"])
  local tempPosY = self.posY
  for i, select in ipairs(self.selects) do
    love.graphics.setColor(1, 1, 1, 1)
    if i == self.currentIndex then
      love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.printf(select.name, self.posX, tempPosY, VIRTURE_WIDTH, "center")
    tempPosY = tempPosY + 10
  end
end

return Menu
