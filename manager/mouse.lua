MouseManager = { listeners = {}, currentPressedObjects = {} }
MouseManager.__index = MouseManager

local BUCKET_SIZE = 100

-- Listeners are added to buckets, each container 100x100 grid.
-- A listener can cross the boundary of several buckets, and will be put in both.
-- TODO some sort of z-index management
function MouseManager.addListener(listener)
    local finalXBucketIndex = math.floor((listener.frame.x + listener.frame.width) / BUCKET_SIZE)
    local finalYBucketIndex = math.floor((listener.frame.y + listener.frame.height) / BUCKET_SIZE)

    -- Start at the X of the listener, offsetting by the bucket size each time,
    -- going until put the listener into all of the x buckets in has area in
    for xBucketIndex = math.floor(listener.frame.x / BUCKET_SIZE), finalXBucketIndex do
        -- Grab or create x bucket, which contains an array of y buckets
        local xBucket = MouseManager.listeners[xBucketIndex]
        if (not xBucket) then
            xBucket = {}
            MouseManager.listeners[xBucketIndex] = xBucket
        end

        for yBucketIndex = math.floor(listener.frame.y / BUCKET_SIZE), finalYBucketIndex do
            local yBucket = xBucket[yBucketIndex]
            if (not yBucket) then
                yBucket = {}
                xBucket[yBucketIndex] = yBucket
            end

            yBucket[#yBucket + 1] = listener
        end
    end
end

function MouseManager.removeListener(listener)
    -- TODO figure out how to delete array items in lua
end

function MouseManager.rectContainsPoint(rect, x, y)
    return rect.x <= x and rect.x + rect.width >= x and rect.y <= y and rect.y + rect.height >= y
end

function love.mousepressed(x, y, button)
    if (button == 'l') then
        local xBase = math.floor(x / BUCKET_SIZE)
        local yBase = math.floor(y / BUCKET_SIZE)

        local xBucket = MouseManager.listeners[xBase]
        if (not xBucket) then return end

        local yBucket = xBucket[yBase]
        if (not yBucket) then return end

        for i=1,#yBucket do
            local listener = yBucket[i]
            if (MouseManager.rectContainsPoint(listener.frame, x, y) and listener.mouseDown) then
                currentPressedObjects[#currentPressedObjects + 1] = listener
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
            if (MouseManager.rectContainsPoint(listener.frame, x, y) and listener.mouseUp) then
                listener:mouseUp(x, y)
            end
        end
    end
end