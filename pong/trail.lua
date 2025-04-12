---@class Trail
---@field posX number
---@field posY number
---@field radius number
---@field timer number
Trail = {}
Trail.__index = Trail

---@param posX number
---@param posY number
---@param radius number
---@param timer number
---@return Trail
function Trail.new(posX, posY, radius, timer)
	local self = setmetatable({}, Trail)
	self.posX = posX
	self.posY = posY
	self.radius = radius
	self.timer = timer
	return self
end

---@param dt number
function Trail:update(dt)
	self.timer = self.timer - (dt * 60)
	self.radius = self.radius - (0.5 * dt * 60)
end

function Trail:render()
	-- local r = math.random(81, 100) / 100
	-- local g = math.random(30, 100) / 100
	-- local b = math.random(0, 50) / 100
	-- love.graphics.setColor(r, g, b, self.timer / 10)
	love.graphics.setColor(0.8, 0.5, 0.15, 1)
	love.graphics.circle("fill", self.posX, self.posY, self.radius)
	love.graphics.setColor(1, 1, 1, 1)
end

return Trail
