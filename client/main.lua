require "socket"

function love.load()
    udpport = socket.udp()
    sentCount = 0
    typing = false
    text = ""
end

function love.draw()
    love.graphics.print("Typing: " .. (typing and "Yes" or "No"), 20, 20)
    love.graphics.print(text, 20, 40)
    if (sent) then
        love.graphics.print("Sent " .. sent, 20, 60)
    end
end

function love.update(dt)
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
        typing = false
        udpport:sendto(text, "192.168.1.105", 3150)
        sent = text
        sentCount = 5
        text = ""
    elseif (typing) then
        text = text .. key
    end
end