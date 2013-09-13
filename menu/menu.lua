require "menu/button"

Menu = {}
Menu.__index = Menu

local BOMBERMAN_TEXT_WIDTH = 465
local TITLE_FONT = love.graphics.newFont(72)

local hostButton
local joinButton
local titleLocation

function Menu.load()
    local windowWidth = love.graphics.getWidth()
    local hostX = windowWidth * 0.275
    local joinX = windowWidth * 0.6
    
    hostButton = Button.new({ x = hostX, y = 220, width = 130, height = 44 }, "Host Game", Menu.buttonPress)
    joinButton = Button.new({ x = joinX, y = 220, width = 120, height = 44 }, "Join Game", Menu.buttonPress)
    
    titleLocation = windowWidth / 2 - BOMBERMAN_TEXT_WIDTH / 2

    love.graphics.setBackgroundColor(255, 255, 255)
end

function Menu.draw()
    love.graphics.setColor(20, 130, 200)
    love.graphics.setFont(TITLE_FONT)
    love.graphics.print("BOMBERMAN", titleLocation, 50)

    hostButton:draw()
    joinButton:draw()
end

function Menu.buttonPress(button)
    print("Button was pressed")
end