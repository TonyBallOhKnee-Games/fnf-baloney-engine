	package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import objects.Character;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '1.1'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	
	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if MODS_ALLOWED 'mods', #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		#if !switch 'donate', #end
		'gallery',
		'help',
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	private var char1:Character = null;
	private var char2:Character = null;
	private var char3:Character = null;
	private var char4:Character = null;
	private var char5:Character = null;
	private var char6:Character = null;
	private var char7:Character = null;
	
	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Main Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xFF33CC99;//#33CC99
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFF3399CC; //#3399CC look at NOTESSUBSTATE.HX
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			//menuItem.screenCenter(X);
			menuItem.x = 100;

			
		}
		
		char1 = new Character(600, -300, 'story', true);//retrowrath
		char1.setGraphicSize(Std.int(char1.width = 0.8));
		add(char1);
		char1.visible = false;

		char2 = new Character(500, -300, 'freeplay', true);//ace
		char2.setGraphicSize(Std.int(char2.width = 0.8));
		add(char2);
		char2.visible = false;

		char3 = new Character(350, -80, 'mods', true);//tonybfnew
		char3.setGraphicSize(Std.int(char3.width = 0.8));
		add(char3);
		char3.visible = false;

		char4 = new Character(300, 100, 'awards', true);//metro
		char4.setGraphicSize(Std.int(char4.width = 0.8));
		add(char4);
		char4.visible = false;

		char5 = new Character(400, 250, 'credits', true);//maku
		char5.setGraphicSize(Std.int(char5.width = 0.8));
		add(char5);
		char5.visible = false;

		char6 = new Character(450, 300, 'donate', true);//baloney
		char6.setGraphicSize(Std.int(char6.width = 0.8));
		add(char6);
		char6.visible = false;

		char7 = new Character(500, 300, 'options', true);//sakuroma
		char7.setGraphicSize(Std.int(char7.width = 0.8));
		add(char7);
		char7.visible = false;



		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Baloney Engine v" + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		


		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end	

		super.create();

		FlxG.camera.follow(camFollow, null, 9);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}



		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://www.youtube.com/channel/UCM1BU8sTwSL08Q6bBmHe2wg');
				}
				else
				{
					selectedSomethin = true;

					if (ClientPrefs.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (optionShit[curSelected])
						{
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());

							#if MODS_ALLOWED
							case 'mods':
								MusicBeatState.switchState(new ModsMenuState());
							#end

							#if ACHIEVEMENTS_ALLOWED
							case 'awards':
								MusicBeatState.switchState(new AchievementsMenuState());
							#end

							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
							case 'gallery':
								MusicBeatState.switchState(new GalleryState());
							case 'help':
								MusicBeatState.switchState(new HelpState());
						}
					});

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(menuItems.members[i], {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
				}
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}
		if (optionShit[curSelected] == 'story_mode')
			{
				
	
				char1.dance();
				char1.updateHitbox();
				char1.visible = true;
			}
			else
			{
				char1.visible = false;
			}
	
			if (optionShit[curSelected] == 'freeplay')
			{
				
	
				char2.dance();
				char2.updateHitbox();
				char2.visible = true;
			}
			else
			{
				char2.visible = false;
			}
	
			if (optionShit[curSelected] == 'mods')
			{
				
	
				char3.dance();
				char3.updateHitbox();
				char3.visible = true;
			}
			else
			{
				char3.visible = false;
			}
	
			if (optionShit[curSelected] == 'awards')
			{
				
	
				char4.dance();
				char4.updateHitbox();
				char4.visible = true;
			}
			else
			{
				char4.visible = false;
			}
	
			if (optionShit[curSelected] == 'credits')
			{
				
				char5.dance();
				char5.updateHitbox();
				char5.visible = true;
			}
			else
			{
				char5.visible = false;
			}
	
			if (optionShit[curSelected] == 'donate')
			{
				
	
				char6.dance();
				char6.updateHitbox();
				char6.visible = true;
			}
			else
			{
				char6.visible = false;
			}
	
			if (optionShit[curSelected] == 'options')
			{
				
	
				char7.dance();
				char7.updateHitbox();
				char7.visible = true;
			}
			else
			{
				char7.visible = false;
			}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();
		//menuItems.members[curSelected].screenCenter(X);

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();
		//menuItems.members[curSelected].screenCenter(X);

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}
