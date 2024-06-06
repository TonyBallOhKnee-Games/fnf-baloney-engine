function onEvent(eventName, val1, val2, strumTime)
    if eventName == "cameraSpeed" then
        setProperty('cameraSpeed', val1)
    end
    if getProperty("cameraSpeed", false) == nil then
        setProperty('cameraSpeed', 1)
    end
end