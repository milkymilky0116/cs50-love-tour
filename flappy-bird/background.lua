---@class Background
---@field image love.Image
---@field x number
---@field y number
---@field speed number
---@field scrollParam number
Background = {}
Background.__index = Background

---@param image string
---@param x number
---@param y number
---@param speed number
---@param scrollParam number
---@return Background
function Background.new(image, x, y, speed, scrollParam)
  local self = setmetatable({}, Background)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(image)
  self.speed = speed
  self.scrollParam = scrollParam
  return self
end

---@param dt number
function Background:update(dt)
  self.x = (self.x + self.speed * dt) % self.scrollParam
end

function Background:render()
  love.graphics.draw(self.image, -self.x, self.y)
end

return Background
