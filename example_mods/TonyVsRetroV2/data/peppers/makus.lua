function onNoteHit(player, note)
    -- Check if the note is a double note and not an up note
    if note:isDoubleNote() and note:getNote() ~= 0 then
        -- Get the opponent player
        local opponent = (player == 'player1') and 'player2' or 'player1'
        
        -- Get the name of the note hit
        local noteName = getNoteName(note:getNote())

        -- Check if it's a jack note (singDOWN, singLEFT, or singRIGHT)
        if noteName == "singDOWN" or noteName == "singLEFT" or noteName == "singRIGHT" then
            -- Play the alternative animation on the opponent's side
            playAnimation(opponent, noteName .. "-alt")
        end
    end
end
