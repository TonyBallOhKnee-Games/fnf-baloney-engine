local noteColors = {
    lust = {
        {'ED9CB7', 'FFFFFF', 'C3347C'},
        {'ED9CB7', 'FFFFFF', 'C3347C'},
        {'ED9CB7', 'FFFFFF', 'C3347C'},
        {'ED9CB7', 'FFFFFF', 'C3347C'}
    },
    retro = {
        {'2E4456', 'FFFFFF', '0C1030'},
        {'00FFFF', 'FFFFFF', '213EBB'},
        {'1EE368', 'FFFFFF', '245A89'},
        {'99C3C2', 'FFFFFF', '3D67AA'}
    },
    green = {
        {'12FA05', 'FFFFFF', '0A4447'},
        {'12FA05', 'FFFFFF', '0A4447'},
        {'12FA05', 'FFFFFF', '0A4447'},
        {'12FA05', 'FFFFFF', '0A4447'}
    },
    minusLust = {
        {'F8366B', 'FFFFFF', '332B31'},
        {'F8366B', 'FFFFFF', '332B31'},
        {'F8366B', 'FFFFFF', '332B31'},
        {'F8366B', 'FFFFFF', '332B31'}
    }
}

local characterNoteColors = {
    
    tonybfnew = "green",
    retrowrath="retro",
    retro2wrath="retro",
    sakuroma="lust",
    maku="minusLust",
    sakuPlush="lust"


}

function iterateNotes(charName, strumsGroup, mustPress) -- strumsGroup and "mustPress" for a single function
    local colorType = characterNoteColors[charName]
    if not colorType then
        -- debugPrint("Character note colors not defined for character: "..charName)
        return -- unessecary debugPrint, just uses default if undefined.
    end
    
    local colors = noteColors[colorType]
    if not colors then
        debugPrint("Note colors not defined for type: " .. colorType)
        return
    end
    
    for i = 0, 3 do
        local colorSet = colors[i + 1]
        setPropertyFromGroup(strumsGroup, i, 'rgbShader.r', getColorFromHex(colorSet[1]))
        setPropertyFromGroup(strumsGroup, i, 'rgbShader.g', getColorFromHex(colorSet[2]))
        setPropertyFromGroup(strumsGroup, i, 'rgbShader.b', getColorFromHex(colorSet[3]))
        callMethod(strumsGroup..'.members['..i..'].playAnim', {'static'})
    end
    
    for i = 0, getProperty("unspawnNotes.length") - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == mustPress then
            local noteData = getPropertyFromGroup('unspawnNotes', i, 'noteData')
            local colorSet = colors[(noteData % 4) + 1]
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex(colorSet[1]))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex(colorSet[2]))
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex(colorSet[3]))
        end
    end
end

function onCreatePost()
    iterateNotes(dadName, "opponentStrums", false)
    iterateNotes(boyfriendName, "playerStrums", true)
end