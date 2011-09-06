function handleMessage(msg)
    loadstring(msg)()
    
    -- Initial Connect
    if (message.cmd == "connect") then
        connectPlayer(message.opts)

    -- Player Movement
    elseif (message.cmd == "update") then
        movePlayer(players[message.opts.id], message.opts.loc)
    end
end

function connectPlayer(opts)
    -- Set player's IP
    port = serverThread:receive("port")
    players[#players + 1] = player:new(opts)
    players[#players].addr = port
    udpport:sendto(#players, port, 3149)
end

function movePlayer(player, loc)
    player.x = loc.x
    player.y = loc.y
end
