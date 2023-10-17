Paddle = Object:extend()

function Paddle.new(self)
    self.x = 100
    self.y = 100
    self.width = 200
    self.height = 150
    self.speed = 100
end

function Paddle.update(self, dt)
    self.x = self.x + self.speed * dt
end

function Paddle.draw(self)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end