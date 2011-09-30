require "client.lua"
require "keyHandler.lua"

local others
function love.load()
    typing = false
    me = { x = 100, y = 100 }
    text = ""
end

function love.draw()
    love.graphics.print((typing and "> " .. text or ""), 20, 40)
    
    if (sent) then
        love.graphics.print("Sent " .. sent, 20, 60)
    end
    
    -- Draw them
    if (others) then
        for i,o in ipairs(others) do
            love.graphics.circle("fill", o.x, o.y, 4, 10)
        end
    end

    -- Draw me
    love.graphics.circle("fill", me.x, me.y, 4, 10)
end

function love.update(dt)
    -- Vertical movement, up has preference
    if (mUp) then
        me.y = me.y - 2
    elseif (mDown) then
        me.y = me.y + 2
    end
    
    -- Horizontal movement, left has preference
    if (mLeft) then
        me.x = me.x - 2
    elseif (mRight) then
        me.x = me.x + 2
    end
    
    if (mUp or mDown or mLeft or mRight) then
        client.update(me)
    end
end

function client.receiveStatus(status)
    loadstring(status)()
    others = o
end
