require "socket"

local function listen()

    local thisThread = love.thread.getThread()
    local udpport = socket.udp()
    udpport:setsockname ('*', 3150)
    udpport:settimeout (nil)
    
    local received
    while (true) do
        message, port = udpport:receivefrom(1024)
        thisThread:send("message", message)
        thisThread:send("port", port)
    end
end

listen()