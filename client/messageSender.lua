require "socket"

local udpport = socket.udp()
local ipaddr  = "192.168.1.105"

function sendMessage(cmd, opts)
    opts = opts or "{}"

    text = "message={cmd='" .. cmd .. "',opts=" .. opts .. "}"
    udpport:sendto(text, ipaddr, 3150)
end

function connect()
    sendMessage("connect")
end