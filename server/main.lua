require "socket"
require "player.lua"

function love.load()
    udpport = socket.udp()
    serverThread = love.thread.newThread("server", "server.lua")
    serverThread:start()
    msgCheck = 2
    players = {}
end

function love.draw()
    if (checked) then
        love.graphics.print(checked, 20, 20)
    end
    
    if (msg) then
        love.graphics.print(msg, 20, 40)
    end
    
    for i, p in pairs(players) do
        p:draw()
    end
    
    if (err) then
        love.graphics.print(err, 20, 60)
    end
end

function love.update(dt)
    if (msgCheck < 0) then
        msg = serverThread:receive("message")
        if (msg) then
            loadstring(msg)()
            if (message.cmd == "connect") then
                -- Set player's IP
                port = serverThread:receive("port")
                players[#players + 1] = player:new(message.opts)
                players[#players].addr = port
                text = "You were successfully connected"
                udpport:sendto(text, port, 3149)
            end
        end
        err = serverThread:receive("error")
        checked = os.date("Last checked at %X")
        msgCheck = 2
    else
        msgCheck = msgCheck - dt
    end
end