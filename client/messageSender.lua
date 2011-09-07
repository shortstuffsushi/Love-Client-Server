require "socket"

-- Home Address
local ipaddr  = "192.168.1.105"
-- UWM Address
-- local ipaddr  = "129.89.202.137"
local udpport = socket.udp()

local function sendMessage(cmd, opts)
    sent = "message={cmd='" .. cmd .. "'," .. opts .. "}"
    udpport:sendto(sent, ipaddr, 3150)
    sentCount = 2
end

function connect()
    sendMessage("connect", "loc={x=" .. me.x .. ",y=" .. me.y .. "}")
end

function disconnect()
    sendMessage("disconnect", "id=" .. id)
end

function reconnect()
    sendMessage("reconnect", "id=" .. id .. ",loc={x=" .. me.x .. ",y=" .. me.y .. "}")
end

function message(txt)
    sendMessage("msg", "txt='" .. txt .. "'")
end

function update()
    sendMessage("update", "id=" .. id .. ",loc={x=" .. me.x .. ",y=" .. me.y .. "}")
end
