---@class Bird
---@field x number
---@field y number
---@field dy number
---@field image love.Image
---@field speed number
---@field gravity number
Bird = {}

Bird.__index = Bird

local margin = 50

---@param image string
---@param speed number
---@param gravity number
---@return Bird
function Bird.new(image, speed, gravity)
	local self = setmetatable({}, Bird)
	self.image = love.graphics.newImage(image)
	self.speed = speed
	self.gravity = gravity
	self.x = VIRTURE_WIDTH / 2 - self.image:getWidth() / 2
	self.y = VIRTURE_HEIGHT / 2 - self.image:getHeight() / 2
	self.dy = 0
	return self
end

---@param dt number
function Bird:update(dt)
	self.dy = self.dy + self.gravity * dt
	self.y = self.y + self.dy
	if love.waspressed("space") then
		self.dy = -5
	end
end

---@param pipe Pipe
---@return boolean
function Bird:collide(pipe)
	local bird_width = self.image:getWidth() - margin
	local bird_height = self.image:getHeight() - margin
	local pipe_width = pipe.image:getWidth() - margin
	local pipe_height = pipe.image:getHeight() - margin
	if
		self.x < pipe.x + pipe_width
		and self.x + bird_width > pipe.x
		and self.y < pipe.y + pipe_height
		and self.y + bird_height > pipe.y
	then
		return true
	end
	return false
end

-- ---@param pipe Pipe
-- ---@return boolean
-- function Bird:collide(pipe)
-- 	-- the 2's are left and top offsets
-- 	-- the 4's are right and bottom offsets
-- 	-- both offsets are used to shrink the bounding box to give the player
-- 	-- a little bit of leeway with the collision
-- 	if (self.x + 2) + (self.image:getWidth() - 4) >= pipe.x and self.x + 2 <= pipe.x + pipe.image:getWidth() then
-- 		if (self.y + 2) + (self.image:getHeight() - 4) >= pipe.y and self.y + 2 <= pipe.y + pipe.image:getHeight() then
-- 			return true
-- 		end
-- 	end
--
-- 	return false
-- end

function Bird:render()
	love.graphics.draw(self.image, self.x, self.y, 0, 0.6, 0.6)
end

return Bird
