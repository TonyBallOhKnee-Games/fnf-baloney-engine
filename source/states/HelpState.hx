package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;

class HelpState extends FlxState {
    // Define your variables here
    var helpText:FlxText;
    var helpSprite:FlxSprite;

    // Create method is where you initialize your state
    override public function create():Void {
        super.create();
        
        // Example of adding text to the screen
        helpText = new FlxText(0, 0, 0, "Help Information Here", 16);
        helpText.screenCenter();
        add(helpText);
        
        // Example of adding a sprite
        helpSprite = new FlxSprite(100, 100);
        helpSprite.loadGraphic(Paths.image("your_image"));
        add(helpSprite);
        
        // Add other elements you need in your state here
    }

    // Update method is called every frame
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        
        // Your update logic here

        // Example of checking for input to switch states
        if (FlxG.keys.justPressed.ENTER) {
            FlxG.switchState(new AnotherState());
        }
    }

    // Destroy method is where you clean up your state
    override public function destroy():Void {
        super.destroy();
        
        // Your cleanup code here
        helpText = null;
        helpSprite = null;
    }
}
