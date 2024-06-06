function onEvent(eventName, val1, val2, strumTime)
    if eventName == "cameraZoom" then
        if val1 ~= "" then
            setProperty('defaultCamZoom', val1)
            if val2 == "true" then
                setProperty('camGame.zoom', val1)
            end
        end
    end
end