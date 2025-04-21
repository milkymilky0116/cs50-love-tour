---@class InputState
---@field name string
---@field currentIndex number
InputState = {}
InputState.__index = InputState
setmetatable(InputState, { __index = State })

---@return InputState
function InputState.new()
  local self = setmetatable({}, InputState)
  self.name = "AAA"
  self.currentIndex = 1
  return self
end

function InputState:enter() end

function InputState:exit() end

---@param dt number
function InputState:update(dt)
  if love.waspressed("right") then
    self.currentIndex = self.currentIndex % #self.name
    self.currentIndex = self.currentIndex + 1
  end
  if love.waspressed("left") then
    if self.currentIndex <= 1 then
      self.currentIndex = #self.name
    else
      self.currentIndex = self.currentIndex - 1
      self.currentIndex = self.currentIndex % #self.name
    end
  end

  if love.waspressed("up") then
    local letter = self.name:sub(self.currentIndex, self.currentIndex)
    local asciiCode = string.byte(letter)
    asciiCode = asciiCode + 1
    if asciiCode > 90 then
      asciiCode = string.byte("A")
    end
    local newLetter = string.char(asciiCode)
    self.name = self.name:sub(1, self.currentIndex - 1) .. newLetter .. self.name:sub(self.currentIndex + 1)
  end

  if love.waspressed("down") then
    local letter = self.name:sub(self.currentIndex, self.currentIndex)
    local asciiCode = string.byte(letter)
    asciiCode = asciiCode - 1
    if asciiCode <= 65 then
      asciiCode = string.byte("Z")
    end

    local newLetter = string.char(asciiCode)
    self.name = self.name:sub(1, self.currentIndex - 1) .. newLetter .. self.name:sub(self.currentIndex + 1)
  end

  if love.waspressed("return") then
    GStateMachine.highscore:add(self.name, GStateMachine.score)
    GStateMachine:change("highscore")
  end
end

function InputState:render()
  love.graphics.setFont(GFont["mediumFont"])
  love.graphics.printf("Input State", 10, 10, VIRTURE_WIDTH, "center")

  local tempPosX = 10
  for i = 1, #self.name do
    local letter = self.name:sub(i, i)
    if i == self.currentIndex then
      love.graphics.setColor(0, 1, 0, 1)
    else
      love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.printf(letter, tempPosX, VIRTURE_HEIGHT / 2, VIRTURE_WIDTH, "center")
    tempPosX = tempPosX + 10
  end
end

return InputState
