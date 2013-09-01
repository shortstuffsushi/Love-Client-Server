Button = {}
Button.__index = Button

local EDGE_OFFSET = 10
local MOUSE_X
local MOUSE_Y

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
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.text, self.frame.x + EDGE_OFFSET, self.frame.y + EDGE_OFFSET)

    if (MOUSE_X) then
    love.graphics.setColor(255, 0, 0)
    love.graphics.print("Mouse Pressed in button at" .. MOUSE_X .. ", " .. MOUSE_Y, 50, 50)
end
end

function Button:mouseDown(x, y)
    MOUSE_X = x
    MOUSE_Y = y
end