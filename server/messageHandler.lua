require "socket"

local udpport = socket.udp()

function handleMessage(msg)
    loadstring(msg)()
    
    -- Initial Connect
    if (message.cmd == "connect") then
        connectPlayer(message.loc)
    
    -- Player Disconnect
    elseif (message.cmd == "disconnect") then
        disconnectPlayer(message.id)
    
    -- Reconnect Player
    elseif (message.cmd == "reconnect") then
        reconnectPlayer(message.id, message.loc)

    -- Player Movement
    elseif (message.cmd == "update") then
        movePlayer(message.id, message.loc)
    end
end

function connectPlayer(loc)
    -- Set player's IP
    port = serverThread:receive("port")
    players[#players + 1] = player:new(loc)
    players[#players].addr = port
    udpport:sendto(#players, port, 3149)
end

function disconnectPlayer(id)
    players[id].active = false
end

function reconnectPlayer(id, loc)
    players[id].active = true
    movePlayer(id, loc)
end

function movePlayer(id, loc)
    players[id].x = loc.x
    players[id].y = loc.y
end
