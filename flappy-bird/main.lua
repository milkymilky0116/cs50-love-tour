local push = require("push")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTURE_WIDTH = 512
VIRTURE_HEIGHT = 288

local background = love.graphics.newImage("assets/background.png")
local ground = love.graphics.newImage("assets/ground.png")
local bird = love.graphics.newImage("assets/bird.png")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle("flappy bird")
	math.randomseed(os.time())

	push:setupScreen(VIRTURE_WIDTH, VIRTURE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = false,
	})
end

function love.draw()
	push:start()
	love.graphics.draw(background, 0, 0)
	love.graphics.draw(ground, 0, VIRTURE_HEIGHT - 16)
	push:finish()
end

function love.update(dt) end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.resize(w, h)
	push:resize(w, h)
end
