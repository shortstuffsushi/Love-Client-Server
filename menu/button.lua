Button = {}
Button.__index = Button

local EDGE_OFFSET = 10
local BUTTON_FONT = love.graphics.newFont(20)
local BUTTON_COLOR = { 20, 130, 200 }
local DEFAULT_FILL_MODE = "fill"
local PRESSED_FILL_MODE = "line"
local DEFAULT_FONT_COLOR = { 255, 255, 255 }
local PRESSED_FONT_COLOR = BUTTON_COLOR

-- Faux construtor
function Button.new(frame, text, handlerFn)
    local self = setmetatable({}, Button)

    self.frame = frame
    self.text = text
    self.isPressed = false
    self.fillMode = DEFAULT_FILL_MODE
    self.fontColor = DEFAULT_FONT_COLOR
    self.handlerFn = handlerFn

    MouseManager.addListener(self)

    return self
end

function Button:draw()
    -- Draw frame
    love.graphics.setColor(BUTTON_COLOR)
    love.graphics.rectangle(self.fillMode, self.frame.x, self.frame.y, self.frame.width, self.frame.height)

    -- Draw text
    love.graphics.setFont(BUTTON_FONT)
    love.graphics.setColor(self.fontColor)
    love.graphics.print(self.text, self.frame.x + EDGE_OFFSET, self.frame.y + EDGE_OFFSET)
end

function Button:mouseDown(x, y)
    self.fillMode = PRESSED_FILL_MODE
    self.fontColor = PRESSED_FONT_COLOR
end

function Button:mouseUpOutside(x, y)
    self.fillMode = DEFAULT_FILL_MODE
    self.fontColor = DEFAULT_FONT_COLOR
end

function Button:mouseUpInside(x, y)
    self.fillMode = DEFAULT_FILL_MODE
    self.fontColor = DEFAULT_FONT_COLOR

    if (self.handlerFn) then
        self.handlerFn(self)
    end
end