local push = require("push")
local Background = require("background")
local Bird = require("bird")
local PipePair = require("pipe_pair")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTURE_WIDTH = 512
VIRTURE_HEIGHT = 288

local backgroundImg = Background.new("assets/background.png", 0, 0, 100, 413)
local ground = Background.new("assets/ground.png", 0, VIRTURE_HEIGHT - 16, 100, VIRTURE_WIDTH)
local bird = Bird.new("assets/bird.png", 10, 15)
local timer = 2
local isScrolling = true
Score = 0

---@type PipePair[]
local pipe_pairs = {}

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle("flappy bird")
	math.randomseed(os.time())
	love.keyboard.keypressed = {}

	push:setupScreen(VIRTURE_WIDTH, VIRTURE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = false,
	})
end

function love.draw()
	push:start()
	backgroundImg:render()
	for _, pipe_pair in pairs(pipe_pairs) do
		pipe_pair:render()
	end
	ground:render()
	bird:render()
	love.graphics.printf("Score: " .. Score, 10, 10, VIRTURE_WIDTH, "center")
	push:finish()
end

function love.update(dt)
	timer = timer - dt
	if isScrolling then
		ground:update(dt)
		backgroundImg:update(dt)
	end
	bird:update(dt)
	local prevPipePairY = VIRTURE_HEIGHT / 2 + 30
	if timer <= 0 then
		local pipe_pair =
			PipePair.new("assets/pipe.png", VIRTURE_WIDTH, math.random(prevPipePairY - 50, prevPipePairY + 50), 80)
		table.insert(pipe_pairs, pipe_pair)
		timer = 2
	end

	for k, pipe_pair in pairs(pipe_pairs) do
		if isScrolling then
			pipe_pair:update(dt)
		end

		if not pipe_pair.isScored then
			if bird.x > pipe_pair.x + pipe_pair.BottomPipe.image:getWidth() then
				Score = Score + 1
				pipe_pair.isScored = true
			end
		end

		if pipe_pair.x + pipe_pair.BottomPipe.image:getWidth() + 180 <= 0 then
			table.remove(pipe_pairs, k)
		end
		if bird:collide(pipe_pair.TopPipe) or bird:collide(pipe_pair.BottomPipe) then
			isScrolling = false
		end
	end

	love.keyboard.keypressed = {}
end

function love.keypressed(key)
	love.keyboard.keypressed[key] = true
	if key == "escape" then
		love.event.quit()
	end
end

---@return boolean
function love.waspressed(key)
	return love.keyboard.keypressed[key] == true
end

function love.resize(w, h)
	push:resize(w, h)
end
