-- LÖVE PONG

local Constants = require('Constants')
require('Ball')
require('Bar')

--
-- Loading
--
--
function love.load()
    print("=== Welcome in PONG ===\n")
    print("  Toy project for LÖVE")

    -- Ball
    -- Beginning in the center, random vertical speed
    local position = {x=Constants.WIN_WIDTH/2, y=Constants.WIN_HEIGHT/2}
    local speed    = {vx=Constants.ball_speed, vy=(math.random() - 1/2) * 6}

    ball = Ball.new(position, speed)

    -- Bar
    -- West bar
    bar_west = Bar.new(0, Constants.bar_width, Constants.bar_height,
        {up="w", down="s"})
    -- East bar
    bar_east = Bar.new(Constants.WIN_WIDTH - Constants.bar_width, Constants.bar_width, Constants.bar_height,
        {up="up", down="down"})
end

function love.update(dt)
    if ball.win ~= nil then
        return
    end

    ball:update(dt)
    bar_east:update(dt)
    bar_west:update(dt)

    -- Collision ball / bar?
    local radian_max_abs = Constants.degree_max_abs * math.pi/180
    -- West
    if  ball.position.x - ball.radius <= bar_west.width and
        ball.position.y >= bar_west.ypos and
        ball.position.y <= bar_west.ypos + bar_west.height
    then
        ball.position.x = 2 * (bar_west.xpos + bar_west.width + ball.radius) - ball.position.x
        ball.speed.vx = -ball.speed.vx
        -- y bounce, relative \in [-1, 1]
        local relative = (2/bar_west.height) * (bar_west.ypos + bar_west.height/2 - ball.position.y)
        ball.speed.vy = - math.tan(radian_max_abs * relative) * math.abs(ball.speed.vx)
    end

    -- East
    if  ball.position.x + ball.radius >= Constants.WIN_WIDTH - bar_east.width and
        ball.position.y >= bar_east.ypos and
        ball.position.y <= bar_east.ypos + bar_east.height
    then
        ball.position.x = 2 * (bar_east.xpos - ball.radius) - ball.position.x
        ball.speed.vx = -ball.speed.vx
        -- y bounce, relative \in [-1, 1]
        local relative = (2/bar_east.height) * (bar_east.ypos + bar_east.height/2 - ball.position.y)
        ball.speed.vy = - math.tan(radian_max_abs * relative) * math.abs(ball.speed.vx)
    end
end

function love.draw()
    ball:draw()
    bar_east:draw()
    bar_west:draw()
    --
    -- Win?
    if ball.win ~= nil then
        local fontsize = 25
        local font = love.graphics.newFont(fontsize)
        local sentence = "Player " .. ball.win .. " won!"
        love.graphics.setFont(font)
        love.graphics.setColor(224, 224, 224, 255)

        love.graphics.print(sentence,
            (Constants.WIN_WIDTH - sentence:len()*fontsize/2)/2, Constants.WIN_HEIGHT/2)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
