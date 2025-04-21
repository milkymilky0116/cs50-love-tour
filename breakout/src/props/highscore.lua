---@class ScoreTable
---@field name string
---@field score number

---@class HighScore
---@field posX number
---@field posY number
---@field scores ScoreTable[]
HighScore = {}
HighScore.__index = HighScore

local SCORES_FILE = "highscores.txt"

---@param posX number
---@param posY number
---@return HighScore
function HighScore.new(posX, posY)
  local self = setmetatable({}, HighScore)
  self.scores = {}
  self.posX = posX
  self.posY = posY
  if love.filesystem.getInfo(SCORES_FILE) then
    for line in love.filesystem.lines(SCORES_FILE) do
      local name, score = line:match("([^,]+),(%d+)")
      if name and score then
        table.insert(self.scores, { name = name, score = score })
      end
    end
  end
  return self
end

---@param name string
---@param score number
function HighScore:add(name, score)
  table.insert(self.scores, { name = name, score = score })
  -- self:sort()
  while #self.scores >= 10 do
    table.remove(self.scores)
  end

  self:save()
end

function HighScore:save()
  local data = ""
  for _, score in pairs(self.scores) do
    data = data .. score.name .. "," .. score.score .. "\n"
  end
  love.filesystem.write(SCORES_FILE, data)
end

function HighScore:sort()
  table.sort(self.scores, function(a, b) return a.score > b.score end)
end

function HighScore:render()
  love.graphics.setFont(GFont["smallFont"])
  local tempPosY = self.posY
  for i, score in ipairs(self.scores) do
    love.graphics.printf(i .. ". " .. score.name .. " - " .. score.score, self.posX, tempPosY, VIRTURE_WIDTH,
      "center")
    tempPosY = tempPosY + 10
  end
end

return HighScore
