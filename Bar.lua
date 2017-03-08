-- Bar
--
local Constants = require('Constants')

Bar = {}
Bar.__index = Bar

--
-- Constructor
--
function Bar.new(xpos, width, height, cmd)
    self = setmetatable({}, Bar)

    self.xpos   = xpos
    self.ypos   = (Constants.WIN_HEIGHT - height)/2

    self.speed  = Constants.bar_speed

    self.height = height
    self.width  = width

    self.cmd = cmd

    return self
end

function Bar:update(dt)
    if love.keyboard.isDown(self.cmd.up) then
        self.ypos = self.ypos - self.speed
    end
    -- Check that we are still in the upper window
    if self.ypos < 0 then
        self.ypos = 0
    end

    if love.keyboard.isDown(self.cmd.down) then
        self.ypos = self.ypos + self.speed
    end
    -- Check that we are still in the lower window
    if self.ypos + self.height > Constants.WIN_HEIGHT then
        self.ypos = Constants.WIN_HEIGHT - self.height
    end
end

function Bar:draw()
    love.graphics.rectangle("fill", self.xpos, self.ypos, self.width, self.height)
end
