function onCreate()
    -- Hook into the health gain mechanic
    setProperty('healthGain', 1)
end

function onUpdate(elapsed)
    -- Ensure health gain remains set to 1 during the game
    if getProperty('healthGain') ~= 1 then
        setProperty('healthGain', 1)
    end
end
