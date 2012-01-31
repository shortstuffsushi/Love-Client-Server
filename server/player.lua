player = {}

-- Faux construtor
function player:new(x)
    setmetatable(x, self)
    x.active = true
    self.__index = self
    return x
end

-- Just draw
function player:draw()
    -- Don't draw inactive players
    if (not self.active) then return end

    -- Draw green
    love.graphics.setColor(0, 255, 0)

    -- Draw IP Address
    love.graphics.print(self.addr, self.x - 50, self.y - 20)

    -- Draw player rectangle
    love.graphics.circle("fill", self.x, self.y, 4, 10)
end

-- Return string version
function player:tostring()
   return "{x=" .. self.x .. ",y=" .. self.y .. "}"
end