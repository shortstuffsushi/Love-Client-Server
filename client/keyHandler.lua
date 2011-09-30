local shift = false

function love.keypressed(key, unicode)
    if (not typing) then
        -- Start typing
        if (key == "return") then
            typing = true
        
        -- Connect to server
        elseif (key == "c") then
            client.connect(me)
        
        -- Disconnect from server
        elseif (key == "x") then
            client.disconnect()
            
        -- Up movement
        elseif (key == "w") then
            mUp = true

        -- Down movement
        elseif (key == "s") then
            mDown = true

        -- Left movement
        elseif (key == "a") then
            mLeft = true

        -- Right movement
        elseif (key == "d") then
            mRight = true
        
        -- Exit the game
        elseif (key == "escape") then
            love.event.push("q")
        end
    
    -- Send a message to the server
    elseif (key == "return" and typing) then
        client.message(text)
        text = ""
        typing = false
    elseif (typing) then
        handleKey(key, unicode)
    end
end

function love.keyreleased(key)
    if (key == "lshift" or key == "rshift") then
        shift = false
    elseif (key == "w") then
        mUp = false
    elseif (key == "s") then
        mDown = false
    elseif (key == "a") then
        mLeft = false
    elseif (key == "d") then
        mRight = false
    end
end

function handleKey(key, unicode)
    if (key == "backspace") then
        text = string.sub(text, 0, string.len(text) - 1)
    elseif (key == "escape") then
        text = ""
        typing = false
    elseif (key == "lshift" or key == "rshift") then
        shift = true
    elseif (key == "tab") then
        text = text .. "    "
    else
        text = text .. (shift and string.char(unicode) or key)
    end
end