require "sender.lua"

local id

-- Basically the same as the default,
-- A few edits for the networking
function love.run()
    -- Create the listening threads
    local cmdThread = love.thread.newThread("cmd",   "cmdListener.lua")
    local msgThread = love.thread.newThread("chat", "chatListener.lua")
    msgThread:start()
    cmdThread:start()

    if love.load then love.load(arg) end

    local dt = 0

    -- Main loop time.
    while true do
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        m = msgThread:receive("message")
        if (m) then
            -- Handles trying to connect
            if (trying) then
                if (not connected) then
                    id = m
                    connected = true
                    trying = false
                else
                    trying = trying - dt
                end

            -- Handle messages when connected
            elseif (connected) then
                if (client.receiveMessage) then client.receiveMessage(m) end
            end
        end

        s = cmdThread:receive("status")
        if (s and client.receiveStatus) then client.receiveStatus(s) end

        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
        if love.graphics then
            love.graphics.clear()
            if love.draw then love.draw() end
        end

        -- Process events.
        if love.event then
            for e,a,b,c in love.event.poll() do
                if e == "q" then

                    -- Kill existing connection if it exists
                    if (connected) then sender.disconnect(id) end

                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c)
            end
        end

        if love.timer then love.timer.sleep(1) end
        if love.graphics then love.graphics.present() end
    end

end

client = {}
function client.update(o)
    if (connected) then
        sender.update(o, id)
    end
end

function client.connect(o)
    if (not id and not trying) then
        sender.connect(o)
        trying = 5
    elseif (id and not connected) then
        sender.reconnect(o, id)
        connected = true
    end
end

function client.disconnect()
    if (connected) then
        sender.disconnect(id)
    end
    connected = false
end

function client.message(t)
    if (connected) then
        sender.message(t)
    end
end