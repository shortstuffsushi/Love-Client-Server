require "socket"

-- Home Address
--local ipaddr  = "192.168.1.104"
-- UWM Address
local ipaddr  = "10.220.226.119"
-- Alan's Address
--local ipaddr = "65.30.60.165"
local udpport = socket.udp()

local function sendMessage(cmd, opts)
    sent = "message={cmd='" .. cmd .. "'," .. opts .. "}"
    udpport:sendto(sent, ipaddr, 3150)
end

sender = {}
function sender.connect(o)
    sendMessage("connect", "loc={x=" .. o.x .. ",y=" .. o.y .. "}")
end

function sender.disconnect(id)
    sendMessage("disconnect", "id=" .. id)
end

function sender.reconnect(o, id)
    sendMessage("reconnect", "id=" .. id .. ",loc={x=" .. o.x .. ",y=" .. me.y .. "}")
end

function sender.message(t)
    sendMessage("msg", "txt='" .. t .. "'")
end

function sender.update(o, id)
    sendMessage("update", "id=" .. id .. ",loc={x=" .. o.x .. ",y=" .. o.y .. "}")
end
