local Pipe = require("pipe")

---@class PipePair
---@field TopPipe Pipe
---@field BottomPipe Pipe
---@field x number
---@field y number
---@field bottomY number
---@field topY number
---@field speed number
---@field isScored boolean
PipePair = {}

PipePair.__index = PipePair

local GAP = 90

---@param image string
---@param x number
---@param y number
---@param speed number
---@return PipePair
function PipePair.new(image, x, y, speed)
	local self = setmetatable({}, PipePair)
	local bottomY = math.random(y - GAP / 2, y)
	self.BottomPipe = Pipe.new(x, bottomY, image, speed, "bottom")

	local topY = bottomY - GAP
	self.TopPipe = Pipe.new(x, topY, image, speed, "top")

	self.x = x
	self.y = y
	self.speed = speed
	self.bottomY = bottomY
	self.topY = topY
	self.isScored = false
	return self
end

---@param dt number
function PipePair:update(dt)
	self.x = self.x - self.speed * dt
	self.BottomPipe.x = self.BottomPipe.x - self.speed * dt
	self.TopPipe.x = self.TopPipe.x - self.speed * dt
end

function PipePair:render()
	self.BottomPipe:render()
	self.TopPipe:render()
end

return PipePair
