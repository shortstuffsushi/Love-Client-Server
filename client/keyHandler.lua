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

    -- Return pressed to end a 'typing' session, send the message
    elseif (key == "return") then
        client.message(text)
        text = ""
        typing = false

    -- Continued typing, handle current character
    else
        handleKey(key, unicode)
    end
end

function love.keyreleased(key)
    -- Shift released, set flag to false
    if (key == "lshift" or key == "rshift") then
        shift = false

    -- Stop up movement
    elseif (key == "w") then
        mUp = false

    -- Stop down movement
    elseif (key == "s") then
        mDown = false

    -- Stop left movement
    elseif (key == "a") then
        mLeft = false

    -- Stop right movement
    elseif (key == "d") then
        mRight = false
    end
end

function handleKey(key, unicode)
    -- Backspace, remove a character
    if (key == "backspace") then
        text = string.sub(text, 0, string.len(text) - 1)

    -- Esc, stop typing/clear message
    elseif (key == "escape") then
        text = ""
        typing = false

    -- Shift, set shift flag to true
    elseif (key == "lshift" or key == "rshift") then
        shift = true

    -- Tab, add four spaces
    elseif (key == "tab") then
        text = text .. "    "

    -- Normal key, append to text string
        else
        text = text .. (shift and string.char(unicode) or key)
    end
end