require "socket"

function listen()
    thisThread = love.thread.getThread()
    udpport = socket.udp()
    udpport:setsockname ('*', 3150)
    udpport:settimeout (nil)
    while (true) do
        message = udpport:receive(1024)
        thisThread:send("message", message)
    end
end

listen()