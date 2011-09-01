require "socket"

function listen()
    thisThread = love.thread.getThread()
    udpport = socket.udp()
    udpport:setsockname ('*', 3149)
    udpport:settimeout (nil)
    while (true) do
        message = udpport:receive(1024)
        thisThread:send("status", message)
    end
end

listen()