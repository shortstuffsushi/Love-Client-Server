require "messageSender.lua"

function love.load()
    clientThread = love.thread.newThread("client", "client.lua")
    sentCount = 0
    msgCheck = 0
    typing = false
    shift = false
    text = ""
end

function love.draw()
    love.graphics.print("Typing: " .. (typing and "Yes" or "No"), 20, 20)
    love.graphics.print("Connected: " .. (connected and "Yes" or "No"), 100, 20)
    love.graphics.print(text, 20, 40)
    if (sent) then
        love.graphics.print("Sent " .. sent, 20, 60)
    end
    if (msg) then
        love.graphics.print("Recv " .. msg, 20, 80)
    end
end

function love.update(dt)
    if (connected) then
        if (msgCheck < 0) then
            -- TODO do something with the message
            msg = clientThread:receive("status")
            msgCheck = 2
        else
            msgCheck = msgCheck - dt
        end
    end

    if (sentCount > 0) then
        sentCount = sentCount - dt
    else
        sent = nil
    end
end

function love.keypressed(key, unicode)
    if (not typing) then
        -- Start typing
        if (key == "return") then
            typing = true
            text = ""
        
        -- Connect to server
        elseif (key == "c" and not connected) then
            clientThread:start()
            connect()
            connected = true
        
        -- Exit the game
        elseif (key == "escape") then
            love.event.push("q")
        end
    
    -- Send a message to the server
    elseif (key == "return" and typing) then
        if (connected) then
            message(text)
        end
        typing = false
    elseif (typing) then
        handleKey(key, unicode)
    end
end

function love.keyreleased(key)
    if (key == "lshift" or key == "rshift") then
        shift = false
    end
end

function handleKey(key, unicode)
    if (key == "backspace") then
        text = string.sub(text, 0, string.len(text) - 1)
    elseif (key == "escape") then
        text = ""
        typing = false
    elseif (key == "lshift" or key == "rshift") then
        shift = true
    elseif (key == "tab") then
        text = text .. "    "
    else
        text = text .. (shift and string.char(unicode) or key)
    end
end
