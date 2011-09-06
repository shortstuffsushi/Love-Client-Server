require "socket"

local udpport = socket.udp()
local ipaddr  = "192.168.1.105"

local function sendMessage(cmd, opts)
    sent = "message={cmd='" .. cmd .. "',opts=" .. opts .. "}"
    udpport:sendto(sent, ipaddr, 3150)
    sentCount = 5
end

function connect()
    sendMessage("connect", "{x=" .. me.x .. ",y=" .. me.y .. "}")
end

function message(txt)
    sendMessage("msg", "{txt='" .. txt .. "'}")
end

function update()
    sendMessage("update", "{id=" .. id .. ",loc={x=" .. me.x .. ",y=" .. me.y .. "}}")
end
