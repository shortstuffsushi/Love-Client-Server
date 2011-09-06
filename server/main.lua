require "socket"
require "player.lua"
require "messageHandler.lua"

function love.load()
    udpport = socket.udp()
    serverThread = love.thread.newThread("server", "server.lua")
    serverThread:start()
    timeOut = 0
    players = {}
end

function love.draw()
    if (checked) then
        love.graphics.print(checked, 20, 20)
    end
    
    if (msg) then
        love.graphics.print(msg, 20, 40)
    end
    
    if (port) then
        love.graphics.print(port, 20, 80)
    end
    
    for i, p in pairs(players) do
        p:draw()
    end
    
    if (err) then
        love.graphics.print(err, 20, 60)
    end
end

function love.update(dt)
        msg = serverThread:receive("message")
        if (msg) then
            handleMessage(msg)
        end
        err = serverThread:receive("error")
        checked = os.date("Last checked at %X")
end