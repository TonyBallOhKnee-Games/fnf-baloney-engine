function onCreate()
    -- Variables
    Dodged = false
    canDodge = false
    DodgeTime = 0
    
    -- Precache resources
    precacheImage('spacebar')
    precacheSound('DODGE')
    precacheSound('Dodged')
end

function onEvent(name, value1, value2)
    if name == "DodgeEvent" then
        -- Get Dodge time
        DodgeTime = tonumber(value1) -- Ensure DodgeTime is treated as a number
        
        -- Create Dodge Sprite
        makeAnimatedLuaSprite('spacebar', 'spacebar', 400, 200)
        luaSpriteAddAnimationByPrefix('spacebar', 'spacebar', 'spacebar', 25, true)
        luaSpritePlayAnimation('spacebar', 'spacebar')
        setObjectCamera('spacebar', 'other')
        scaleLuaSprite('spacebar', 0.50, 0.50)
        addLuaSprite('spacebar', true)
        
        -- Set values to allow dodging
        playSound('DODGE')
        canDodge = true
        runTimer('Died', DodgeTime)
    end
end

function onUpdate(elapsed)
    if canDodge and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.E') then
        Dodged = true
        playSound('Dodged', 0.7)
        
        -- Boyfriend dodge animation
        characterPlayAnim('boyfriend', 'dodge', true)
        setProperty('boyfriend.specialAnim', true)
        
        -- Dad kick animation
        characterPlayAnim('dad', 'kick', true)
        setProperty('dad.specialAnim', true)
        
        removeLuaSprite('spacebar')
        canDodge = false
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'Died' then
        if not Dodged then
            setProperty('health', 0)
        else
            Dodged = false
        end
    end
end
