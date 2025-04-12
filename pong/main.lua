local Ball = require("ball")
local Paddle = require("paddle")
local State = require("state")
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

RECTANGLE_WIDTH = 20
RECTANGLE_HEIGHT = 80
RECTANGLE_MARGIN = 20

---@type Ball
local ball = Ball.new(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 10)

---@type Paddle
local player1 = Paddle.new(
	RECTANGLE_MARGIN,
	WINDOW_HEIGHT / 2 - RECTANGLE_HEIGHT / 2,
	RECTANGLE_WIDTH,
	RECTANGLE_HEIGHT,
	"w",
	"s",
	false
)

---@type Paddle
local player2 = Paddle.new(
	WINDOW_WIDTH - (RECTANGLE_MARGIN + RECTANGLE_WIDTH),
	WINDOW_HEIGHT / 2 - RECTANGLE_HEIGHT / 2,
	RECTANGLE_WIDTH,
	RECTANGLE_HEIGHT,
	"up",
	"down",
	false
)
---@type State
local state = State.new()

SmallFont = love.graphics.newFont("font.ttf", 16)
LargeFont = love.graphics.newFont("font.ttf", 32)

PaddleHitSound = love.audio.newSource("sounds/paddle_hit.wav", "static")
WallHitSound = love.audio.newSource("sounds/wall_hit.wav", "static")
ScoreSound = love.audio.newSource("sounds/score.wav", "static")

local scoreLimit = 10

function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true,
	})
end

function love.update(dt)
	if state.state == "playing" then
		ball:update(dt, state)
		player1:update(ball, dt)
		player2:update(ball, dt)

		if ball:collide(player1) then
			--ball.posX = player1.posX + player1.width
			ball.dx = -ball.dx * 1.05
			ball.dy = ball.dy + math.random(-300, 300)
			player1.randomTracking = math.random(0, 100)
			PaddleHitSound:play()
		end

		if ball:collide(player2) then
			--ball.posX = player2.posX - player2.width
			ball.dx = -ball.dx * 1.05
			ball.dy = ball.dy + math.random(-300, 300)
			player2.randomTracking = math.random(0, 100)
			PaddleHitSound:play()
		end
	elseif state.state == "serve" then
		ball:reset()
	end

	if state.player1Score >= scoreLimit or state.player2Score >= scoreLimit then
		state.state = "over"
	end
end

function love.draw()
	player1:render()
	player2:render()
	ball:render()
	state:draw()
end

function love.keypressed(key)
	if key == "return" then
		if state.state == "start" then
			state.state = "serve"
		elseif state.state == "over" then
			state:reset()
		end
	end

	if key == "space" then
		if state.state == "serve" then
			state.state = "playing"
		elseif state.state == "playing" then
			state.state = "serve"
		end
	end
end
