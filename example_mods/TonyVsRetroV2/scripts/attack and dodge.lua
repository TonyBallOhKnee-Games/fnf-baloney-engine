-- Pre-cached sounds
precacheSound('attack')
precacheSound('yeahSound')

-- Create UI elements
makeLuaSprite('tonyballohknee', 'tonyBall', 0, 0)
setObjectCamera('tonyballohknee', 'other')
addLuaSprite('tonyballohknee', true)

makeAnimatedLuaSprite('me', 'watermakers/Me', 900, 400)

scaleObject('me', 0.7, 0.7)
setObjectCamera('me', 'hud')
--addLuaSprite('me', true)
setProperty('me.alpha', 0.7)
addAnimationByPrefix('me', 'points', 'CreditLoop', 24, true)
makeAnimatedLuaSprite('yes', 'watermakers/Yea', 350, 500)
setObjectCamera('yes', 'other')
setProperty('yes.alpha', 0)
addLuaSprite('yes')
scaleObject("yes", 0.7, 0.7)

function onStart()
    -- Set the new botplay text
    setBotplayText('Subs to TonyBallOhKnee')
    
end

local credits = {
    'Coding: TonyBallOhKnee',
    'Art: Retrospecter Mod 1.7.5',
    'Composition: TonyBallOhKnee',
    'Controls: Space = Taunt, Shift = Attack',
    'Minimum Mode: Keybaord 5',
}

for i, credit in ipairs(credits) do
    makeLuaText('credit' .. i, credit, 0, 1, 350 + i * 20)
    addLuaText('credit' .. i)
end

function onUpdate(elapsed)
    local health = getProperty('health')

    -- Attack animation and sound
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') then
        characterPlayAnim('boyfriend', 'attack', true)
        setProperty('boyfriend.specialAnim', true)
        playSound('attack')
        setProperty('health', health + 0.2)
    end

    -- Taunt animation and sound
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
        characterPlayAnim('boyfriend', 'hey', true)
        setProperty('boyfriend.specialAnim', true)
        playSound('yeahSound')
        -- Show the "yes" sprite when "hey" animation plays
        addAnimationByPrefix('yes','balls','goYeah',24,false)
        setProperty('yes.alpha', 1)
    end

    -- Reduce health when opponent hits a note
    function opponentNoteHit()
        health = getProperty('health')
        if getProperty('health') > 0.05 then
            setProperty('health', health- 0.02);
        end
    end
        
        


    -- Display current song name
    displayCurrentSongName()
end



-- Function to display current song name in the UI
function displayCurrentSongName()
    -- Get the current song name
    local currentSong = getProperty('curSong')

    -- Create a LuaText object to display the song name
    makeLuaText('songNameText', 'Current Song: ' .. currentSong, 0, 1, 20)
    setObjectCamera('songNameText', 'hud')
    addLuaText('songNameText')
end