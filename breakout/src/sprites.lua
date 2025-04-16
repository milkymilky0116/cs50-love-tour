---@return love.Quad[]
function GetPaddles()
  local baseX = 0
  local baseY = PADDLE_HEIGHT * 4
  local quads = {}

  for row = 0, 3 do
    local y = baseY + row * (PADDLE_HEIGHT * 2)
    local index = row * 4 + 1

    quads[index] = love.graphics.newQuad(baseX, y, PADDLE_BASE_WIDTH, PADDLE_HEIGHT, GImage["main"])
    quads[index + 1] = love.graphics.newQuad(baseX + PADDLE_BASE_WIDTH, y, PADDLE_BASE_WIDTH * 2, PADDLE_HEIGHT,
      GImage["main"])
    quads[index + 2] = love.graphics.newQuad(baseX + PADDLE_BASE_WIDTH * 3, y, PADDLE_BASE_WIDTH * 3, PADDLE_HEIGHT,
      GImage["main"])
    quads[index + 3] = love.graphics.newQuad(baseX, y + PADDLE_HEIGHT, PADDLE_BASE_WIDTH * 4, PADDLE_HEIGHT,
      GImage["main"])
  end

  return quads
end

---@return love.Quad[]
function GetBalls()
  local baseX = 32 * 3
  local baseY = 16 * 3
  local quads = {}
  for row = 0, 1 do
    local y = baseY + row * (BALL_SIZE)
    local index = row * 4 + 1

    quads[index] = love.graphics.newQuad(baseX, y, BALL_SIZE, BALL_SIZE, GImage["main"])
    quads[index + 1] = love.graphics.newQuad(baseX + BALL_SIZE, y, BALL_SIZE, BALL_SIZE, GImage["main"])
    quads[index + 2] = love.graphics.newQuad(baseX + BALL_SIZE * 2, y, BALL_SIZE, BALL_SIZE, GImage["main"])
    quads[index + 3] = love.graphics.newQuad(baseX + BALL_SIZE * 3, y, BALL_SIZE, BALL_SIZE, GImage["main"])
  end
  table.remove(quads, 8)
  return quads
end

---@return love.Quad[]
function GetBlocks()
  local baseX = 0
  local baseY = 0
  local quads = {}
  for i = 0, 3 do
    for j = 0, 5 do
      table.insert(quads,
        love.graphics.newQuad(baseX + (BLOCK_WIDTH * j), baseY + (BLOCK_HEIGHT * i), BLOCK_WIDTH, BLOCK_HEIGHT,
          GImage["main"]))
    end
  end
  return quads
end
