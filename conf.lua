local Constants = require('Constants')

function love.conf(t)
    t.title = "Pong"

    t.window.height = Constants.WIN_HEIGHT
    t.window.width = Constants.WIN_WIDTH

    t.console = true
end
