Alts = {'singLEFT-alt', 'singDOWN-alt', 'singUP-alt', 'singRIGHT-alt'}
ScaredAnims = {'singLEFT-scared', 'singDOWN-scared', 'singUP-scared', 'singRIGHT-scared'}
NormalAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
MissAnims = {'singLEFTmiss', 'singDOWNmiss', 'singUPmiss', 'singRIGHTmiss'}
gfISonOPPONENTSside = false
canHEY = true
heyCounter = 0
fullHealth = false
KeyBindString = ''
KeyBindString2 = ''
KeyBoardBind = getModSetting("HeyKeyBind", 'FNF-Health reactive Anims')["keyboard"]
ControllerBind = getModSetting("HeyKeyBind", 'FNF-Health reactive Anims')["gamepad"]
botplaywasused = false

function onCreate()
    local location = getModSetting('LOCATION', 'FNF-Health reactive Anims')
    local x, y = 0, 0
    if location == 'BottomRight' then
        x, y = 440, 600
    elseif location == 'BottomLeft' then
        x, y = -420, 600
    elseif location == 'TopLeft' then
        x, y = -420, 0
    elseif location == 'TopRight' then
        x, y = 440, 0
    elseif location == 'BottomCenter' then
        x, y = 0, 500
    elseif location == 'TopCenter' then
        x, y = 0, 150
    elseif location == 'MidLeft' then
        x, y = -420, 350
    elseif location == 'MidRight' then
        x, y = 440, 350
    end
    
    makeLuaText('KOOLER', 'Hey Counter: '..heyCounter, 1250, x, y)
    
    if getModSetting('KOOL', 'FNF-Health reactive Anims') == true then
        addLuaText('KOOLER')
        setTextSize('KOOLER', 50)
        setProperty('KOOLER.alpha', 1)
    else
        setProperty('KOOLER.alpha', 0)
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    characterPlayAnim('boyfriend', MissAnims[direction + 1])
    
    if noteType == 'GF Sing' or noteType == '3rd Player Sing' then
        characterPlayAnim('gf', MissAnims[direction + 1])
    end
end

function opponentNoteHit(i, direction, t, s)
    local health = getProperty('health')
    if health > 1.5 then
        characterPlayAnim('dad', ScaredAnims[direction + 1])
    elseif health < 0.7 then
        characterPlayAnim('dad', Alts[direction + 1])
    end
end

function goodNoteHit(i, direction, t, s)
    canHEY = false
    runTimer('HeyTimer', 0.8)

    local health = getProperty('health')
    if health > 1.5 then
        characterPlayAnim('boyfriend', Alts[direction + 1])
    elseif health < 0.7 then
        characterPlayAnim('boyfriend', ScaredAnims[direction + 1], true)
    end

    if gfISonOPPONENTSside == false then
        if health < 0.7 and (t == 'GF Sing' or t == '3rd Player Sing') then
            characterPlayAnim('gf', ScaredAnims[direction + 1])
        elseif health > 1.5 then
            characterPlayAnim('gf', Alts[direction + 1])
        end
    elseif gfISonOPPONENTSside == true then
        if health > 1.5 and (t == 'GF Sing' or t == '3rd Player Sing') then
            characterPlayAnim('gf', ScaredAnims[direction + 1])
        elseif health < 0.7 then
            characterPlayAnim('gf', Alts[direction + 1])
        end
    end
end

function onUpdate()
    if botPlay == true then
        removeLuaText('KOOLER', true)
        setTextString('botplayTxt', 'YOU CHEATER!')
        heyCounter = 0
        unlockAchievement('CHEATER')
        botplaywasused = true
    end

    local health = getProperty('health')
    if health < 0.7 then
        if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
            characterPlayAnim('boyfriend', 'idle-scared', true)
        end
        if getProperty('dad.animation.curAnim.name') == 'idle' then
            characterPlayAnim('dad', 'idle-alt', true)
        end

    elseif health > 1.5 then
        if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
            characterPlayAnim('boyfriend', 'idle-alt', true)
			
        end
        if getProperty('dad.animation.curAnim.name') == 'idle' then
            characterPlayAnim('dad', 'idle-scared', true)
			
        end

    end

end

function onEndSong()
    if fullHealth == true and not isAchievementUnlocked('test') then
        unlockAchievement('test')
    end   
end
