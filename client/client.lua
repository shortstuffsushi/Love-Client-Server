require "sender"

local id

-- Some global vars
connected = false
tryingToConnect = false

-- Basically the same as the default,
-- A few edits for the networking
function love.run()
    -- Create the listening threads
    local cmdThread = love.thread.newThread("cmd", "cmdListener.lua")
    local msgThread = love.thread.newThread("chat", "chatListener.lua")
    msgThread:start()
    cmdThread:start()

    math.randomseed(os.time())
    math.random() math.random()

    if love.load then love.load(arg) end

    local dt = 0

    -- Main loop time.
    while true do
        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        m = msgThread:get("message")
        if (m) then
            -- Handles trying to connect, and message received
            -- which indicates we are now connected
            if (tryingToConnect) then
                if (not connected) then
                    id = m
                    connected = true
                    tryingToConnect = false
                end
            -- Handle messages when connected
            elseif (connected) then
                if (client.receiveMessage) then client.receiveMessage(m) end
            end
        -- If we didnt get a message while we're trying
        -- to connect, tick down our connect timer
        elseif (tryingToConnect) then
            tryingToConnect = tryingToConnect - dt

            -- Looks like we've failed to connect
            if (tryingToConnect < 0) then
                tryingToConnect = false
            end
        end

        s = cmdThread:get("status")
        if (s and client.receiveStatus) then client.receiveStatus(s) end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
        if love.graphics then
            love.graphics.clear()
            if love.draw then love.draw() end
        end

        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    -- Kill existing connection if it exists
                    if (connected) then sender.disconnect(id) end

                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        if love.timer then love.timer.sleep(0.001) end
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
    if (not id and not tryingToConnect) then
        sender.connect(o)
        tryingToConnect = 5
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