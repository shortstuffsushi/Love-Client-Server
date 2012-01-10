require "client.lua"
require "keyHandler.lua"

local others
local seconds = 0
local changed = false
local baseFPS = 120

function love.load()
    typing = false
    me = { x = 100, y = 100 }
    text = ""
end

function love.draw()

    if (typing) then
        love.graphics.print("> " .. text , 20, 40)
    end

    -- Display last message sent
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
    fps = love.timer.getFPS()
    seconds = seconds + dt

    -- If it's been more than .025 seconds and you move, send the changes to the server
    if (seconds > .025 and changed) then
        client.update(me)
        changed = false
        seconds = 0
    end

    -- Vertical movement, up has preference
    if (mUp) then
        me.y = math.floor(me.y - baseFPS/fps + 0.5)
    elseif (mDown) then
        me.y = math.floor(me.y + baseFPS/fps + 0.5)
    end

    -- Horizontal movement, left has preference
    if (mLeft) then
        me.x = math.floor(me.x - baseFPS/fps + 0.5)
    elseif (mRight) then
        me.x = math.floor(me.x + baseFPS/fps + 0.5)
    end

    -- On movement, set the flag to true
    if (mUp or mDown or mLeft or mRight) then
        changed = true
    end
end

function client.receiveStatus(status)
    -- Note, we don't use "others" directly because
    -- loadstring is scoped to the current function
    loadstring(status)()
    others = o
end
