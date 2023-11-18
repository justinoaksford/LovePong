Vfx = Object:extend()

ricochetLocationX = ball.x 
ricochetLocationY = ball.y
vfxSpark = love.graphics.newParticleSystem('gfx/spark', 17)
vfxSpark.setParticleLifetime(1, 3)
vfxSpark.setEmissionRate(5)
vfxSpark.setSizeVaration(2)
vfxSpark.setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
vfxSpark.setColors(1, 1, 1, 1, 1, 1, 1, 0)

