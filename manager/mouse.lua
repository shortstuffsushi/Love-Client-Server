MouseManager = { listeners = {} }
MouseManager.__index = MouseManager

local BUCKET_SIZE = 100

-- Listeners are added to buckets, each container 100x100 grid.
-- A listener can cross the boundary of several buckets, and will be put in both.
-- TODO some sort of z-index management
function MouseManager.addListener(listener)
    -- Start at the X of the listener, offsetting by the bucket size each time,
    -- going until put the listener into all of the x buckets in has area in
    for xBucketOffset = 0, listener.frame.width, BUCKET_SIZE do
        -- Index is x / bucket size, ex: 590 = 5, 315 = 3
        local xBase = math.floor((listener.frame.x + xBucketOffset) / BUCKET_SIZE)

        -- Grab or create x bucket, which contains an array of y buckets
        local xBucket = MouseManager.listeners[xBase]
        if (not xBucket) then
            xBucket = {}
            MouseManager.listeners[xBase] = xBucket
        end

        for yBucketOffset = 0, listener.frame.height, BUCKET_SIZE do
            local yMod = math.floor((listener.frame.y + yBucketOffset) / BUCKET_SIZE)
            local yBucket = xBucket[yMod]
            if (not yBucket) then
                yBucket = {}
                xBucket[yMod] = yBucket
            end

            yBucket[#yBucket + 1] = listener
        end
    end
end

function MouseManager.removeListener(listener)
    -- TODO figure out how to delete array items in lua
end

function love.mousepressed(x, y, button)
    if (button == 'l') then
        local xMod = math.floor(x / BUCKET_SIZE)
        local yMod = math.floor(y / BUCKET_SIZE)

        local xBucket = MouseManager.listeners[xMod]
        if (not xBucket) then return end

        local yBucket = xBucket[yMod]
        if (not yBucket) then return end

        for i=1,#yBucket do
            local listener = yBucket[i]
            if (x < listener.frame.x + listener.frame.width and y < listener.frame.y + listener.frame.height and listener.mouseDown) then
                listener:mouseDown(x, y)
            end
        end
    end
end

function love.mousereleased(x, y, button)
    if (button == 'l') then
        local xMod = x % BUCKET_SIZE
        local yMod = y % BUCKET_SIZE

        local xBucket = MouseManager.listeners[xMod]
        if (not xBucket) then return end

        local yBucket = xBucket[yMod]
        if (not yBucket) then return end
        
        for i=1,#yBucket do
            if (x < listener.frame.x + listener.frame.width and y < listener.frame.y + listener.frame.height and listener.mouseUp) then
                listener:mouseUp(x, y)
            end
        end
    end
end