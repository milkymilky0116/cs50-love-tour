---@class State
---@field player1Score number
---@field player2Score number
---@field state "start"|"playing"|"serve"|"over"
State = {}
State.__index = State

---@return State
function State.new()
  local self = setmetatable({}, State)
  self.player1Score = 0
  self.player2Score = 0
  self.state = "start"
  return self
end

function State:draw()
  love.graphics.setFont(LargeFont)
  love.graphics.printf(self.player1Score, -150, 100, WINDOW_WIDTH, "center")
  love.graphics.printf(self.player2Score, 150, 100, WINDOW_WIDTH, "center")
  love.graphics.setFont(SmallFont)
  if self.state == "start" then
    love.graphics.printf("press enter to start", 0, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, "center")
  elseif self.state == "serve" then
    love.graphics.printf("press space to serve", 0, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, "center")
  elseif self.state == "over" then
    if self.player1Score > self.player2Score then
      love.graphics.printf("player1 won by " .. self.player1Score .. ". press enter to play again", 0,
        WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, "center")
    else
      love.graphics.printf("player 2 won by " .. self.player2Score .. ". press enter to play again", 0,
        WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, "center")
    end
  end
end

function State:reset()
  self.player1Score = 0
  self.player2Score = 0
  self.state = "start"
end

return State
