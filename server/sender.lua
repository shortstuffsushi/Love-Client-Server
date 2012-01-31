require "socket"
local udpport = socket.udp()

sender = {}

function sender.updateAll(ps)
    others = "o={"
    for i, p in pairs(ps) do
        others = others .. p:tostring()
        if (i < #ps) then
            others = others .. ","
        end
    end
    others = others .. "}"

    for i,p in pairs(ps) do
        if (p.active) then
            udpport:sendto(others, p.addr, 3149)
        end
    end
end

function sender.sendID(p)
    udpport:sendto(p.id, p.addr, 3151)
end