require "socket"

local udpport = socket.udp()
connections = ""

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
    local port = serverThread:receive("p" .. listenerIndex)

    -- Ignore multiple connections from the same IP
    if (string.find(connections, port)) then return end

    -- Add new connection to list
    connections = connections .. port .. " "

    -- Create new player, assign their IP
    players[#players + 1]  = player:new(loc)

    player = players[#players]
    player.id   = #players
    player.addr = port

    -- Return the new player an ID
    sender.sendID(player)
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
