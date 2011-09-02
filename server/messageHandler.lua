function handleMessage(msg)
    loadstring(msg)()
    if (message.cmd == "connect") then
        connectPlayer(message.opts)
    end
end

function connectPlayer(opts)
    -- Set player's IP
    port = serverThread:receive("port")
    players[#players + 1] = player:new(opts)
    players[#players].addr = port
    text = "You were successfully connected"
    udpport:sendto(text, port, 3149)
end