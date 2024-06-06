-- CONSTANTS
local HIDDEN = 0.0000000001
local backgroundLevel = 2
-- UTILS
function set(key, val)
	setProperty(key, val)
end
function get(key)
	return getProperty(key)
end
function addRel(key, val)
	setProperty(key, getProperty(key) + val)
end
function makeSprite(id, image, x, y)
	local im = image
	if im ~= "" then
		im = ""..im
	end
	makeLuaSprite(id, im, x, y)
	set(id..".active", false)
end

function makeSolid(id, width, height, color)
	makeGraphic(id, 1, 1, color)
	scaleObject(id, width, height)
end

function makeAnimSprite(id, image, x, y, spriteType)
	makeAnimatedLuaSprite(id, ""..image, x, y, spriteType)
end

function setVelocity(tag, x, y)
	setProperty(tag..".velocity.x", x)
	setProperty(tag..".velocity.y", y)
end

local lSongName = ""


function lamp(path, x, y)
	makeAnimatedLuaSprite(path, 'stages/ace/lamp-master', x, y)
	addAnimationByPrefix(path, path, path, 0)
	setScrollFactor(path, 1.1, 1.1)
	scaleObject(path, 1, 1)
	updateHitbox(path)
end

function onCreate()
	lSongName = string.lower(songName):gsub(" ", "-")

	if backgroundLevel > 0 then
		makeLuaSprite('background1', 'stages/ace/Background1', -1400, -1400);
		setScrollFactor('background1', 1.1, 1.1);

		makeLuaSprite('Fences', 'stages/ace/Fences', -1922, -1720);
		setScrollFactor('Fences', 1.1, 1.1);
		scaleObject('Fences', 1, 1);

		makeLuaSprite('P2Snow1', 'stages/ace/P2Snow1', -1400, -1400);
		setLuaSpriteScrollFactor('P2Snow1', 1.1, 1.1);
		scaleObject('P2Snow1', 1, 1);

		makeLuaSprite('Overlay', 'stages/ace/Overlay', -1400, -1400);
		setLuaSpriteScrollFactor('Overlay', 1.1, 1.1);
		scaleObject('Overlay', 1, 1);

		--makeLuaSprite('Lamps', 'stages/ace/Lamps', -1400, -1400);
		--setLuaSpriteScrollFactor('Lamps', 1.1, 1.1);
		--scaleObject('Lamps', 1, 1);

		makeAnimatedLuaSprite('BackC','stages/ace/Back_Characters', -820,-795)
		addAnimationByPrefix('BackC','dance','bop',24,true)
		objectPlayAnimation('BackC','dance',false)
		setScrollFactor('BackC', 1.1, 1.1);

		makeAnimatedLuaSprite('FrontC','stages/ace/Front_Characters', -1285,-610)
		addAnimationByPrefix('FrontC','dance','bop',24,true)
		objectPlayAnimation('FrontC','dance',false)
		setScrollFactor('FrontC', 1.1, 1.1);


		local lx = -1400
		local ly = -1400
		lamp("lampleft", lx, ly)
		lamp("lampright", lx, ly)
		lamp("glowleft", lx, ly)
		lamp("glowright", lx, ly)

		addLuaSprite('background1', false);
		addLuaSprite('BackC', false);
		addLuaSprite('Fences', false);
		addLuaSprite('P2Snow1', false);
		addLuaSprite('FrontC', false);
		addLuaSprite("lampleft", false);
		addLuaSprite("lampright", false);
		addLuaSprite("glowleft", true);
		addLuaSprite("glowright", true);
		addLuaSprite('Overlay', true);

	end
end

function onBeatHit()
	objectPlayAnimation("BackC", "dance", true)
	objectPlayAnimation("FrontC", "dance", true)
end

function addBF_X(val)
	addRel("BF_X", val)
	set("boyfriendGroup.x", get("BF_X"))
end
function addBF_Y(val)
	addRel("BF_Y", val)
	set("boyfriendGroup.y", get("BF_Y"))
end

function addGF_X(val)
	addRel("GF_X", val)
	set("gfGroup.x", get("GF_X"))
end
function addGF_Y(val)
	addRel("GF_Y", val)
	set("gfGroup.y", get("GF_Y"))
end

function addDAD_X(val)
	addRel("DAD_X", val)
	set("dadGroup.x", get("DAD_X"))
end
function addDAD_Y(val)
	addRel("DAD_Y", val)
	set("dadGroup.y", get("DAD_Y"))
end

function onCreatePost()
	setProperty("gf.scrollFactor.x", 1.1)
	setProperty("gf.scrollFactor.y", 1.1)
	setProperty("boyfriend.scrollFactor.x", 1.1)
	setProperty("boyfriend.scrollFactor.y", 1.1)
	setProperty("dad.scrollFactor.x", 1.1)
	setProperty("dad.scrollFactor.y", 1.1)
end