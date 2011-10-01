require "client.lua"
require "keyHandler.lua"

local others
local seconds = 0
local frames  = 0
local fps     = 0
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
	
	if (fps) then
		love.graphics.print("FPS: " .. fps, 20, 80)
	end

    -- Draw me
    love.graphics.circle("fill", me.x, me.y, 4, 10)
end

function love.update(dt)

	if (seconds < 1) then
		seconds = seconds + dt
		frames = frames + 1
	else
		fps = frames
		frames = 0
		seconds = 0
	end

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
