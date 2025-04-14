---@class Pipe
---@field image love.Image
---@field x number
---@field y number
---@field speed number
---@field oreientation "top"|"bottom"
Pipe = {}
Pipe.__index = Pipe
---@param x number
---@param y number
---@param image string
---@param speed number
---@param oreientation "top"|"bottom"
---@return Pipe
function Pipe.new(x, y, image, speed, oreientation)
	local self = setmetatable({}, Pipe)
	self.image = love.graphics.newImage(image)
	self.speed = speed
	self.x = x
	self.y = y
	self.oreientation = oreientation
	return self
end

---@param dt number
function Pipe:update(dt) end

function Pipe:render()
	if self.oreientation == "top" then
		love.graphics.draw(self.image, self.x + 0.5, self.y, 0, 1, -1)
	else
		love.graphics.draw(self.image, self.x + 0.5, self.y, 0, 1, 1)
	end
end

return Pipe
