player = {}

-- Faux construtor
function player:new(x)
    setmetatable(x, self)
    self.__index = self
    return x
end

-- Just draw
function player:draw()
    -- Draw green
    love.graphics.setColor(0, 255, 0)
    -- Draw player rectangle
    love.graphics.circle("fill", self.x, self.y, 4, 10)
end

function player:update()
    -- Update position
    if (self.moving) then 
        local angle = (self.y > self.destY and 0 or math.pi) - math.atan((self.destX - self.x)/(self.destY - self.y))

        self.x = self.x + math.sin(angle)
        self.y = self.y - math.cos(angle)
        
        if (math.abs(self.x - self.destX) < 1 and math.abs(self.y - self.destY) < 1) then
            self.moving = false
        end
    end
end

function player:goto(x, y)
    self.moving = true
    self.destX = x
    self.destY = y
end
