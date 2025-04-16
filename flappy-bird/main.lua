local push = require("push")
local Background = require("background")
local StateMachine = require("state_machine")
local TitleState = require("states.title_state")
local PlayState = require("states.play_state")
local CountdownState = require("states.countdown_state")
local ScoreState = require("states.score_state")
local PauseState = require("states.pause_state")
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTURE_WIDTH = 512
VIRTURE_HEIGHT = 288

local backgroundImg = Background.new("assets/background.png", 0, 0, 100, 413)
local ground = Background.new("assets/ground.png", 0, VIRTURE_HEIGHT - 16, 100, VIRTURE_WIDTH)

local states = {
  ["title"] = TitleState.new(),
  ["play"] = PlayState.new(),
  ["countdown"] = CountdownState.new(),
  ["score"] = ScoreState.new(),
  ["pause"] = PauseState.new()
}

Sounds = {
  ["background"] = love.audio.newSource("assets/marios_way.mp3", "static"),
  ["score"] = love.audio.newSource("assets/score.wav", "static"),
  ["explosion"] = love.audio.newSource("assets/explosion.wav", "static"),
  ["hurt"] = love.audio.newSource("assets/hurt.wav", "static"),
  ["jump"] = love.audio.newSource("assets/jump.wav", "static")
}
GStateMachine = StateMachine.new(states, states["title"])

IsScrolling = true
Score = 0
IsPaused = false

function love.load()
  SmallFont = love.graphics.newFont('assets/font.ttf', 8)
  MediumFont = love.graphics.newFont('assets/font.ttf', 14)
  FlappyFont = love.graphics.newFont('assets/flappy.ttf', 28)
  HugeFont = love.graphics.newFont('assets/flappy.ttf', 56)

  love.graphics.setFont(FlappyFont)
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
  GStateMachine:render()
  ground:render()
  push:finish()
end

function love.update(dt)
  -- Sounds["background"]:play()
  if IsScrolling then
    ground:update(dt)
    backgroundImg:update(dt)
  end

  if not IsPaused then
    GStateMachine:update(dt)
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
