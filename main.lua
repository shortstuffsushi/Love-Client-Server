require "menu/menu"
require "manager/mouse"

local inMenu = true

function love.load()
  Menu.load()
end

function love.draw()
  if (inMenu) then
    Menu.draw()
  end
end