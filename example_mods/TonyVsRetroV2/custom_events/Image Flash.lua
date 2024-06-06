function onEvent(name, value1, value2)
	if name == "Image Flash" then
		makeLuaSprite('image', value1, 0, 0);
		screenCenter('image')
		setScrollFactor(0,0);
		addLuaSprite('image', true);
		setObjectCamera('image', 'hud');
		runTimer('wait', value2);
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'wait' then
		doTweenAlpha('byebye', 'image', 0, 0.3, 'linear');
	end
end

function onTweenCompleted(tag)
	if tag == 'byebye' then
		removeLuaSprite('image', true);
	end
end