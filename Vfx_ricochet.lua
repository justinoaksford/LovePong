Vfx_ricochet = Object:extend()

function Vfx_ricochet:new(x, y)
    Vfx_ricochet.super.new(self, x, y)
    self.x = ricochetLocationX
    self.y = ricochetLocationY

    local imgSpark = love.graphics.newImage('gfx/spark.png')

    vfxSpark = love.graphics.newParticleSystem(imgSpark, 17)
    vfxSpark:setParticleLifetime(1, 3)
    vfxSpark:setEmissionRate(5)
    vfxSpark:setSizeVariation(1)
    vfxSpark:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
    vfxSpark:setColors(1, 1, 1, 1, 1, 1, 1, 0)

end

function Vfx_ricochet:update(dt)
    vfxSpark:update(dt)

end

--
--function Vfx_ricochet:draw()
--    vfxSpark:
--end



