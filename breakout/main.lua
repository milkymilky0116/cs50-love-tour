require("src.module")
require("src.constants")
function love.load()
  math.randomseed(os.time())
  love.keyboard.keypressed = {}
  GImage = {
    ["background"] = love.graphics.newImage("assets/images/background.png"),
    ["main"] = love.graphics.newImage("assets/images/breakout.png"),
    ["arrows"] = love.graphics.newImage("assets/images/arrows.png"),
    ["hearts"] = love.graphics.newImage("assets/images/hearts.png"),
    ["particles"] = love.graphics.newImage("assets/images/particle.png")
  }

  GSound = {
    ["paddle-hit"] = love.audio.newSource("assets/sounds/paddle_hit.wav", "static"),
    ["score"] = love.audio.newSource("assets/sounds/score.wav", "static"),
    ["wall-hit"] = love.audio.newSource("assets/sounds/wall_hit.wav", "static"),
    ["confirm"] = love.audio.newSource("assets/sounds/confirm.wav", "static"),
    ["select"] = love.audio.newSource("assets/sounds/select.wav", "static"),
    ["no-select"] = love.audio.newSource("assets/sounds/no-select.wav", "static"),
    ["brick-hit-1"] = love.audio.newSource("assets/sounds/brick-hit-1.wav", "static"),
    ["brick-hit-2"] = love.audio.newSource("assets/sounds/brick-hit-2.wav", "static"),
    ["hurt"] = love.audio.newSource("assets/sounds/hurt.wav", "static"),
    ["victory"] = love.audio.newSource("assets/sounds/victory.wav", "static"),
    ["recover"] = love.audio.newSource("assets/sounds/recover.wav", "static"),
    ["high-score"] = love.audio.newSource("assets/sounds/high_score.wav", "static"),
    ["pause"] = love.audio.newSource("assets/sounds/pause.wav", "static"),

    ["music"] = love.audio.newSource("assets/sounds/music.wav", "static")
  }

  GFont = {
    ["smallFont"] = love.graphics.newFont("assets/font/font_breakout.ttf", 10),
    ["mediumFont"] = love.graphics.newFont("assets/font/font_breakout.ttf", 16),
    ["largeFont"] = love.graphics.newFont("assets/font/font_breakout.ttf", 24),
  }

  local levelPosX = VIRTURE_WIDTH / 2
  local levelPosY = VIRTURE_WIDTH / 2 - 100

  GLevel = {
    [1] = LevelManager.new(levelPosX, levelPosY, 10, 5, 3, false, false, false, false, { 1 }, { 1 }),
    [2] = LevelManager.new(levelPosX, levelPosY, 10, 5, 3, true, false, false, false, { 1, 2 }, { 1, 2 }),
    [3] = LevelManager.new(levelPosX, levelPosY, 10, 6, 3, true, true, true, true, { 2, 3, 4 }, { 2, 3, 4 }),
    [4] = LevelManager.new(levelPosX, levelPosY, 10, 6, 3, true, true, true, false, { 2, 3, 4 }, { 2, 3, 4 }),
    [5] = LevelManager.new(levelPosX, levelPosY, 12, 8, 3, true, true, false, true, { 1, 2, 3, 4 }, { 1, 2, 3, 4 }),
  }

  GPaddles = GetPaddles()
  GBalls = GetBalls()
  GBlocks = GetBlocks()
  GHearts = GetHeart()

  local states = {
    ["select_paddle"] = SelectPaddleState.new(),
    ["select_ball"] = SelectBallState.new(),
    ["prepare"] = PrepareState.new(),
    ["gameover"] = GameOverState.new(),
    ["nextstage"] = NextStageState.new(),
    ["complete"] = CompleteState.new(),
    ["title"] = TitleState.new(),
    ["highscore"] = HighScoreState.new(),
    ["input"] = InputState.new(),
    ["play"] = PlayState.new()
  }

  GStateMachine = StateMachine.new(states)
  GStateMachine:change("title")

  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setTitle("Breakout")
  love.graphics.setFont(GFont["largeFont"])
  Push:setupScreen(VIRTURE_WIDTH, VIRTURE_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = false,
    fullscreen = false,
    resizable = false,
  })
end

function love.resize(w, h)
  Push:resize(w, h)
end

function love.update(dt)
  GSound["music"]:play()
  GStateMachine:update(dt)
  love.keyboard.keypressed = {}
end

function love.keypressed(key)
  love.keyboard.keypressed[key] = true
end

---@return boolean
function love.waspressed(key)
  return love.keyboard.keypressed[key] == true
end

function love.draw()
  Push:apply("start")
  love.graphics.draw(GImage["background"], 0, 0, 0, VIRTURE_WIDTH / (GImage["background"]:getWidth() - 1),
    VIRTURE_HEIGHT / (GImage["background"]:getHeight() - 1))
  GStateMachine:render()
  Push:apply("end")
end
