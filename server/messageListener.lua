require "socket"

local function listen()

    local thisThread = love.thread.getThread()
    local udpport = socket.udp()
    udpport:setsockname ('*', 3150)
    udpport:settimeout (nil)

    local index = 0
    while (true) do
        message, port = udpport:receivefrom(1024)
        thisThread:send(index, message)
        thisThread:send("p" .. index, port)

        index = index + 1
    end
end

listen()