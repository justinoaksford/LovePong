
--WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

Object = require "classic"
Tween = require "tween"

--Font init
smallFontSize = 16
largeFontSize = 32
smallFont = love.graphics.newFont(smallFontSize, normal)
largeFont = love.graphics.newFont(largeFontSize, normal)

--Field dimensions
fieldPaddingX = 100
fieldPaddingY = 100
field_width = (WINDOW_WIDTH - fieldPaddingX * 2 )
field_height = (WINDOW_HEIGHT - fieldPaddingY * 2)
field_centerX = (field_width / 2 + fieldPaddingX)
field_centerY = (field_height / 2 + fieldPaddingY)


--ScoreBoard
player1Score = 0
player2Score = 0
scoreTitleFont = smallFont
scoreNumberFont = largeFont
scoreNumberPadding = 10
scoreP1PosX = (field_centerX + -scoreNumberPadding + -largeFontSize)
scoreP2PosX = (field_centerX + scoreNumberPadding)
scorePosYOffset = 40
scoreTitlePosX = (field_centerX)




require "Paddle"
require "Ball"
require "Vfx_ricochet"


function love.load()
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    -- Paddle Init
    player1Paddle = Paddle(paddle_L_PosX, paddle_L_StartPosY, paddle_width, paddle_height)
    player2Paddle = Paddle(paddle_R_PosX, paddle_R_StartPosY, paddle_width, paddle_height)

    -- Ball Init
    ball = Ball(ball_startPosX, ball_startPosY, ball_width, ball_height)

    --vfxSpark = Vfx_ricochet(0, 0)

    gameState = 'start'
end

function love.keypressed(key)
    --Quit Function
    if key == '`' then
        love.event.quit()

    --Start Game Function
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()

        end
    end


end


function love.update(dt)
    --Player 1 Movement
    if love.keyboard.isDown('w') then
        player1Paddle.deltaY = -paddle_speed
    elseif love.keyboard.isDown('s') then
        player1Paddle.deltaY = paddle_speed
    else
        player1Paddle.deltaY = 0
    end
    --Player 2 Movement
    if love.keyboard.isDown('up') then
        player2Paddle.deltaY = -paddle_speed
    elseif love.keyboard.isDown('down') then
        player2Paddle.deltaY = paddle_speed
    else
        player2Paddle.deltaY = 0
    end



    --Ball Position
    if gameState == 'play' then
        if ball:collides(player1Paddle) then
            ball.deltaX = -ball.deltaX * ballVelocityIncreaseFactor
            --resetting ball to prevent it from being "inside" the paddle.
            ball.x = player1Paddle.x + paddle_width

            ball:ricochetVFX(ball)

            if ball.deltaY < 0 then    
                ball.deltaY = ball.deltaY - math.random(5,50) + player1Paddle.deltaY
            elseif ball.deltaY > 0 then
                ball.deltaY = ball.deltaY + math.random(5,50) + player1Paddle.deltaY
            end
        end
        
        if ball:collides(player2Paddle) then
            ball.deltaX = -ball.deltaX * ballVelocityIncreaseFactor
            --resetting ball to prevent it from being "inside" the paddle.
            ball.x = player2Paddle.x - ball_width

            ball:ricochetVFX(ball)

            if ball.deltaY < 0 then
                ball.deltaY = ball.deltaY - math.random(5,50) + player2Paddle.deltaY * paddleSpinMultiplier
            elseif ball.deltaY > 0 then
                ball.deltaY = ball.deltaY + math.random(5,50) + player2Paddle.deltaY * paddleSpinMultiplier
            end

        end

        if ball.y <= fieldPaddingY then
            ball.y = fieldPaddingY
            ball.deltaY = -ball.deltaY
        end

        if ball.y + ball.height >= field_height + fieldPaddingY then
            ball.y = fieldPaddingY + field_height - ball_height
            ball.deltaY = -ball.deltaY
        
        end



        ball:update(dt)

        -- Score Functions
        if ball.x < fieldPaddingX then
            player2Score = player2Score + 1
            gameState = 'Start'
            Ball:reset()
        elseif ball.x > fieldPaddingX + field_width then
            player1Score = player1Score + 1
            gameState = 'Start'
            Ball:reset()
        end

        --ballX = ballX + ball_deltaX * dt
        --ballY = ballY + ball_deltaY * dt
    end
    player1Paddle:update(dt)
    player2Paddle:update(dt)
    --vfxSpark:update(dt)

end

function love.draw()
    love.graphics.printf('Love Pong', 0, WINDOW_HEIGHT - 60, WINDOW_WIDTH, 'center')
    
    if gameState == 'start' then
        love.graphics.printf('Fuck It, We Ball. Press Enter.', fieldPaddingX, field_centerY - 200, field_width, 'center')
    end

    --Drawing Scoreboard
    --SCORE Title print
    love.graphics.setFont(scoreTitleFont)
    love.graphics.printf('SCORE', 0, 20, WINDOW_WIDTH, 'center')
    -- Score Numbers print
    love.graphics.setFont(scoreNumberFont)
    love.graphics.print(tostring(player1Score), scoreP1PosX, scorePosYOffset)
    love.graphics.print(tostring(player2Score), scoreP2PosX, scorePosYOffset)

    --draw the field
    love.graphics.rectangle('line', fieldPaddingX, fieldPaddingY, field_width, field_height)
    
    player1Paddle:render()
    player2Paddle:render()
    ball:render()

    --love.graphics.draw(vfxSpark, ricochetLocationX, ricochetLocationY)

end