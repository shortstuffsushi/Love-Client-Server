Button = {}
Button.__index = Button

local EDGE_OFFSET = 10
local BUTTON_FONT = love.graphics.newFont(20)

-- Faux construtor
function Button.new(frame, text)
    local self = setmetatable({}, Button)

    self.frame = frame
    self.text = text

    MouseManager.addListener(self)

    return self
end

function Button:draw()
    -- Draw frame
    love.graphics.setColor(20, 130, 200)
    love.graphics.rectangle("fill", self.frame.x, self.frame.y, self.frame.width, self.frame.height)

    -- Draw text
    love.graphics.setFont(BUTTON_FONT)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.text, self.frame.x + EDGE_OFFSET, self.frame.y + EDGE_OFFSET)
end

function Button:mouseDown(x, y)

end