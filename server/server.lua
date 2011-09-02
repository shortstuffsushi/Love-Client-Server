require "socket"

function listen()
    thisThread = love.thread.getThread()
    udpport = socket.udp()
    udpport:setsockname ('*', 3150)
    udpport:settimeout (nil)
    while (true) do
        message, port = udpport:receivefrom(1024)
        thisThread:send("message", message)
        thisThread:send("port", port)
    end
end

listen()