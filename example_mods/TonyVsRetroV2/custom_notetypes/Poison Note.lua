function onCreate()
    -- Create poison note type
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Poison Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'poisonNotes'); -- Change note texture
            setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'poisonSplashes'); -- Change splash texture
            setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '-0.2'); -- Damage player health
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', '-0.1'); -- Damage player health even if missed
            setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); -- Allow note to be hit/missed
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'Poison Note' then
        -- Additional effects when a poison note is hit
        setProperty('health', getProperty('health') - 0.1); -- Additional health reduction
        -- You can add other effects like screen shake, color change, etc.
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if noteType == 'Poison Note' then
        -- Effects when a poison note is missed
        setProperty('health', getProperty('health') - 0.05); -- Additional health reduction
        -- You can add other effects like screen shake, color change, etc.
    end
end
