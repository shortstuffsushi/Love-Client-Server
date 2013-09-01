require "menu/button"

Menu = {}
Menu.__index = Menu

local BOMBERMAN_TEXT_WIDTH = 465

local hostButton
local joinButton
local titleLocation

function Menu.load()
    local windowWidth = love.graphics.getWidth()
    local hostX = windowWidth * 0.275
    local joinX = windowWidth * 0.6
    
    hostButton = Button.new({ x = hostX, y = 200, width = 130, height = 44 }, "Host Game")
    joinButton = Button.new({ x = joinX, y = 200, width = 120, height = 44 }, "Join Game")
    
    titleLocation = windowWidth / 2 - BOMBERMAN_TEXT_WIDTH / 2
end

function Menu.draw()
    love.graphics.setBackgroundColor(255, 255, 255)

    love.graphics.setColor(20, 130, 200)
    love.graphics.setFont(love.graphics.newFont(72))
    love.graphics.print("BOMBERMAN", titleLocation, 50)

    hostButton:draw()
    joinButton:draw()
end