Ball = Object:extend()

--Ball Data
ball_width = 20
ball_height = 20
ballX = 0
ballY = 0
ball_startPosX = field_centerX
ball_startPosY = field_centerY
ball_deltaX = 1
ball_deltaY = 1
ballSpeedMultiplier = 4
ballVelocityIncreaseFactor = 1.06

function Ball:new(x, y, width, height, deltaX, deltaY)
    Ball.super.new(self, x, y, deltaX, deltaY)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    --Delta tracking
    self.deltaX = (math.random(2) == 1 and 100 or -100) * ballSpeedMultiplier
    self.deltaY = (math.random(-50, 50)) * ballSpeedMultiplier
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    elseif self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false

    end

    return true

end

function Ball:ricochetVFX(ball)
    
end

function Ball:bounce(ball)
    local tween = tween.new(.3, ball_height, {}, 'inOutElastic')
    
end


function Ball:reset()
    self.x = ball_startPosX
    self.y = ball_startPosY
    self.deltaX = (math.random(2) == 1 and 100 or -100) * ballSpeedMultiplier
    self.deltaY = (math.random(-50, 50)) * ballSpeedMultiplier
end

function Ball:update(dt)
    self.x = self.x + self.deltaX * dt
    self.y = self.y + self.deltaY * dt
end

function Ball:render()
    -- render ball
    love.graphics.rectangle('line', self.x, self.y, ball_width, ball_height)
end



