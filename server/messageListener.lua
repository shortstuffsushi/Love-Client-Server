require "socket"

local function listen()

    local thisThread = love.thread.getThread()
    local udpport = socket.udp()
    udpport:setsockname ('*', 3150)
    udpport:settimeout (nil)


    -- Listen for all messages and place them into a sort of queue, such that with each
    -- message received, the 'channel' is incremented. Similarly, when the server receives
    -- the messages, it increments the 'channel' it will listen to, thusly losing no messages
    local index = 0
    while (true) do
        message, port = udpport:receivefrom(1024)
        thisThread:send(index, message)
        thisThread:send("p" .. index, port)

        index = index + 1
    end
end

listen()