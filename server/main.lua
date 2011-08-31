function love.load()
    serverThread = love.thread.newThread("server", "server.lua")
    serverThread:start()
    msgCheck = 2
end

function love.draw()
    if (checked) then
        love.graphics.print(checked, 20, 20)
    end
    
    if (msg) then
        love.graphics.print(msg, 20, 40)
    end
    
    if (err) then
        love.graphics.print(err, 20, 60)
    end
end

function love.update(dt)
    if (msgCheck < 0) then
        msg = serverThread:receive("message")
        err = serverThread:receive("error")
        checked = os.date("Last checked at %X")
        msgCheck = 2
    else
        msgCheck = msgCheck - dt
    end
end