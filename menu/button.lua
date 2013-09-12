Button = {}
Button.__index = Button

local EDGE_OFFSET = 10
local BUTTON_FONT = love.graphics.newFont(20)
local DEFAULT_COLOR = { 20, 130, 200 }
local PRESSED_COLOR = { 40, 160, 255 }

-- Faux construtor
function Button.new(frame, text)
    local self = setmetatable({}, Button)

    self.frame = frame
    self.text = text
    self.currentColor = DEFAULT_COLOR
    self.isPressed = false

    MouseManager.addListener(self)

    return self
end

function Button:draw()
    -- Draw frame
    love.graphics.setColor(self.currentColor)
    love.graphics.rectangle("fill", self.frame.x, self.frame.y, self.frame.width, self.frame.height)

    -- Draw text
    love.graphics.setFont(BUTTON_FONT)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.text, self.frame.x + EDGE_OFFSET, self.frame.y + EDGE_OFFSET)
end

function Button:mouseDown(x, y)
--    self.is
end