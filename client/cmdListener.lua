require "socket"

function listen()
    local thisThread = love.thread.getThread()
    local udpport = socket.udp()
    udpport:setsockname ('*', 3149)
    udpport:settimeout (nil)
    
    local received
    while (true) do
        received = udpport:receive(1024)
        thisThread:send("status", received)
    end
end

listen()