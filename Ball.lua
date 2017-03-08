-- Ball
--
-- A ball is defined by its position and speed
--
-- position: 2D vector (x, y)
-- speed: 2D vector (vx, vy)
local Constants = require('Constants')

Ball = {}
Ball.__index = Ball

--
-- Constructor
--
function Ball.new(position, speed)
    local self = setmetatable({}, Ball)

    self.position = position
    self.speed = speed

    -- Graphics options
    self.radius = Constants.ball_radius

    self.win = nil

    return self
end


function Ball:update(dt)
    -- Check if east / west win condition
    if self.position.x - self.radius < 0 then
        self.win = "East"
        return
    end

    if self.position.x + self.radius > Constants.WIN_WIDTH then
        self.win = "West"
        return
    end


    self.position.x = self.position.x + self.speed.vx
    self.position.y = self.position.y + self.speed.vy

    -- Bounce east?
    -- if self.position.x + self.radius > Constants.WIN_WIDTH then
    --     self.position.x = 2 * (Constants.WIN_WIDTH - self.radius) - self.position.x
    --     self.speed.vx = -self.speed.vx
    -- end

    -- Bounce West?
    -- if 0 > self.position.x - self.radius then
    --     self.position.x = -self.position.x + 2*self.radius
    --     self.speed.vx = -self.speed.vx
    -- end

    -- Bounce North?
    if 0 > self.position.y - self.radius then
        self.position.y = -self.position.y + 2*self.radius
        self.speed.vy = -self.speed.vy
    end

    -- Bounce South?
    if self.position.y + self.radius > Constants.WIN_HEIGHT then
        self.position.y = 2 * (Constants.WIN_HEIGHT- self.radius)- self.position.y
        self.speed.vy = -self.speed.vy
    end

end

function Ball:draw()
    love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end
