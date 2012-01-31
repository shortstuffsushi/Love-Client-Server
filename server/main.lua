require "player.lua"
require "sender.lua"
require "messageHandler.lua"

listenerIndex = 0

function love.load()
    serverThread = love.thread.newThread("server", "messageListener.lua")
    serverThread:start()
    players = {}

    addr = "Server address  " .. socket.dns.toip(socket.dns.gethostname())
end

function love.draw()
    love.graphics.print(addr, 20, 20)
    love.graphics.rectangle('line', 118, 15, 112, 25)

    if (msg) then
        love.graphics.print(msg, 20, 40)
    end

    for i, p in pairs(players) do
        p:draw()
    end

    if (others) then
        love.graphics.print(others, 20, 100)
    end

    if (connections) then
        love.graphics.print(connections, 20, 80)
    end

    if (err) then
        love.graphics.print(err, 20, 60)
    end
end

function love.update(dt)
    msg = serverThread:receive(listenerIndex)
    if (msg) then
        handleMessage(msg)
        listenerIndex = listenerIndex + 1
        sender.updateAll(players)
    end
    err = serverThread:receive("error")
end