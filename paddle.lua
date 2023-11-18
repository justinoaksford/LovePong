Paddle = Object:extend()

paddle_height = 150
paddle_width =  20
paddle_speed = 1000

paddleCenterHeight = (fieldPaddingY + ((field_height / 2) - (paddle_height / 2)))
paddle_L_PosY = field_centerY
paddle_R_PosY = field_centerY

--Paddle X Column locations
paddle_L_PosX = (fieldPaddingX)
paddle_R_PosX = ((fieldPaddingX + field_width) - paddle_width)
paddle_PosYMin = fieldPaddingY
paddle_PosYMax = field_height + fieldPaddingY - paddle_height

--Paddle Start Positions

paddle_L_StartPosY = paddleCenterHeight
paddle_R_StartPosY = paddleCenterHeight


function Paddle:new(x, y, width, height)
    Paddle.super.new(self, x, y, deltaY)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.deltaY = 0

end

function Paddle:update(dt)
    if self.deltaY < 0 then
        self.y = math.max(paddle_PosYMin, self.y + -paddle_speed * dt)
    elseif self.deltaY > 0 then
        self.y = math.min(paddle_PosYMax, self.y + paddle_speed * dt)
    --self.x = self.x + self.speed * dt
    end
end

function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end