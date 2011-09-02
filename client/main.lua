require "socket"

function love.load()
    clientThread = love.thread.newThread("client", "client.lua")
    udpport = socket.udp()
    sentCount = 0
    msgCheck = 0
    typing = false
    text = ""
end

function love.draw()
    love.graphics.print("Typing: " .. (typing and "Yes" or "No"), 20, 20)
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
    if (key == "return" and not typing) then
        typing = true
    elseif (key == "return" and typing) then
        connected = true
        clientThread:start()
        text = "message={cmd='connect',opts={}}"
        udpport:sendto(text, "192.168.1.105", 3150)
        sent = text
        sentCount = 5
        typing = false
        text = ""
    elseif (typing) then
        text = text .. key
    end
end