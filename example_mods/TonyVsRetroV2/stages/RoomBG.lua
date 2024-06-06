function onCreate()
    -- Create and configure background sprite
    makeLuaSprite("testBlackSquare", "", 0, 0)
    makeGraphic('testBlackSquare', 1280, 720, 'FFFFFF')
    setScrollFactor("testBlackSquare", 0.0, 0.0)
    addLuaSprite('testBlackSquare', false)

    -- Create and configure animated sprite
    makeAnimatedLuaSprite("dancing", "deskStage/Sien", 800, -30)  -- Adjusted position to center
    
    addLuaSprite("dancing", false)

    -- Set camera speed
    setProperty('cameraSpeed', 10)

	
end

function onBeatHit()
    -- Play animation
	addAnimationByPrefix('dancing', 'dance', 'dancin bg', 24, true)
    objectPlayAnimation("dancing", "dance", true)
end
	function onCreatePost()
		setProperty("gf.scale.x", 0)
		setProperty("gf.scale.y", 0)
	end