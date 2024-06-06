local isItReal = false
local creditsInfo = {
    songName = "",
    creddz = ""
}
local bpmTweener = 0

local songColors = {
    ["lil-lad"] = "BF80FF",
    ["big-dead"] = "FF4000",
    ["big-dead-old"] = "DDDDDD",
    ["sus-space"] = "FFFFFF"
}

function onCreatePost()
    if checkFileExists("data/"..songName.."/songInfo.txt", false) then
        local fileContent = getTextFromFile("data/"..songName.."/songInfo.txt", false)
        local delimiterIndex = string.find(fileContent, "::")
        if delimiterIndex then
            creditsInfo.songName = string.sub(fileContent, 1, delimiterIndex - 1)
            creditsInfo.creddz = string.sub(fileContent, delimiterIndex + 2)
            isItReal = true
            
            -- Check for line break (\n) in song name
            local lineBreakIndex = string.find(creditsInfo.songName, "\\n")
            if lineBreakIndex then
                local firstLine = string.sub(creditsInfo.songName, 1, lineBreakIndex - 1)
                local secondLine = string.sub(creditsInfo.songName, lineBreakIndex + 2)
                creditsInfo.songName = firstLine .. "\n" .. secondLine
            end
        else
            debugPrint('Malformed songInfo.txt: There is likely no delimiter (::).')
        end
        
        if isItReal then
            makeLuaSprite("credzBackdrop", nil, -320, screenHeight/2)
            makeGraphic("credzBackdrop", 320, 200, '400080')
            setObjectCamera("credzBackdrop", 'other')
            setProperty("credzBackdrop.alpha", 0.5, false)
            makeLuaText("songNameText", creditsInfo.songName, 300, -320, screenHeight/2 + getProperty("credzBackdrop.width", false)/6)
            makeLuaText("creddzText", creditsInfo.creddz, 300, -320, screenHeight/2 + getProperty("credzBackdrop.width", false)/3)
            setTextAlignment("songNameText", 'center')
            setTextAlignment("creddzText", 'center')
            setTextSize("songNameText", 24)
            setTextSize("creddzText", 20)
            setObjectCamera("songNameText", 'other')
            setObjectCamera("creddzText", 'other')
            local songColor = songColors[songName] or "FFFFFF"  -- Default to FFFFFF if not found
            setTextColor("songNameText", songColor)
            if songName ~= "sus-space" then
                setTextColor("creddzText", "FF9933")
            else
                setTextColor("creddzText", "D0BC98")
            end
        end
    end
    bpmTweener = (60/curBpm)/playbackRate
end

function onSongStart()
    if isItReal then
        -- debugPrint("Credits: "..creditsInfo.creddz)
        -- debugPrint("Song Name: "..creditsInfo.songName)
        addLuaSprite("credzBackdrop", true)
        addLuaText("songNameText")
        addLuaText("creddzText")
        doTweenX("credzBackdropMove", "credzBackdrop", 0, bpmTweener, "bounceOut")
        doTweenX("songNameTextMove", "songNameText", 0, bpmTweener, "bounceOut")
        doTweenX("creddzTextMove", "creddzText", 0, bpmTweener, "bounceOut")
    end
end

function onSectionHit()
    if curSection == 2 then
        doTweenX("credzBackdropMove2", "credzBackdrop", -320, bpmTweener*2, "sineInOut")
        doTweenX("songNameTextMove2", "songNameText", -320, bpmTweener*2, "sineInOut")
        doTweenX("creddzTextMove2", "creddzText", -320, bpmTweener*2, "sineInOut")
    end
end

function onTweenCompleted(tag, vars)
    if tag == "credzBackdropMove2" then
        removeLuaSprite("credzBackdrop", true)
    end
    if tag == "songNameTextMove2" then
        removeLuaText("songNameText", true)
    end
    if tag == "creddzTextMove2" then
        removeLuaText("creddzText", true)
    end
end