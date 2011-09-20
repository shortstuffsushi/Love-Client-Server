require "messageSender.lua"
require "keyHandler.lua"

function love.load()
    clientThread = love.thread.newThread("client", "client.lua")
    sentCount = 0
    typing = false
    me = { x = 100, y = 100 }
    text = ""
end

function love.draw()
    love.graphics.print("Typing: "    ..  (typing            and "Yes" or "No"),  20, 20)
    love.graphics.print("Connected: " .. ((connected and id) and "Yes" or "No"), 100, 20)
    love.graphics.print(text, 20, 40)
    if (sent) then
        love.graphics.print("Sent " .. sent, 20, 60)
    end
    if (msg) then
        love.graphics.print("Recv " .. msg,  20, 80)
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

    if (connected) then
        -- TODO do something with the message
        msg = clientThread:receive("status")
        
        -- First message from the server is an ID
        if (not id) then
            id = msg
        end
    
        -- Update if connected and change has occurred
        if (id and (mUp or mDown or mLeft or mRight)) then
            update()
        end
    end

    if (sentCount > 0) then
        sentCount = sentCount - dt
    else
        sent = nil
    end
end

function love.quit()
    -- Kill existing connection if it exists
    if (connected and id) then
        disconnect()
    end
end
