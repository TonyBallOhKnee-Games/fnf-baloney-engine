package torchsthings.objects;

import flixel.ui.FlxBar;
import flixel.util.FlxBitmapDataUtil;
import flixel.graphics.FlxGraphic;

class ImageBar extends FlxBar {
    var bar1:FlxSprite;
    var bar2:FlxSprite;
    public var bounds:Dynamic = {min: 0, max: 2};
    static var enemyColor:FlxColor = 0xFFFFFFFF;
    static var playerColor:FlxColor = 0xFFFFFFFF;
    public var barCenter(default, null):Float = 0;
    public var leftToRight:Bool = false;

    public function new(x:Float = 0, y:Float = 0, emptyBar:Array<String>, fullBar:Array<String>, enemyColor:FlxColor = 0xFFFF0000, playerColor:FlxColor = 0xFF00FF0D, minVal:Float = 0, maxVal:Float = 2, ?parentRef:Dynamic, variable:String = "") {
        super(x, y);

        if (emptyBar[0] == '' || emptyBar[0] == null) emptyBar[0] = 'new_healthBar_empty';
        if (emptyBar[1] == '') emptyBar[1] = null;
        if (fullBar[0] == '' || fullBar[0] == null) fullBar[0] = 'new_healthBar';
        if (fullBar[1] == '') fullBar[1] = null;

        var imageList:Array<String> = [Paths.getPath(emptyBar[0], IMAGE, emptyBar[1]), Paths.getPath(fullBar[0], IMAGE, fullBar[1])]; // DO NOT MOVE THESE IMAGES OR CHANGE THIS TEXT
        for (key in imageList) {if (!Paths.dumpExclusions.contains(key)) Paths.dumpExclusions.push(key);}

        bar1 = new FlxSprite().loadGraphic(Paths.image(emptyBar[0], emptyBar[1], false));
        bar2 = new FlxSprite().loadGraphic(Paths.image(fullBar[0], fullBar[1], false));
        bar1.antialiasing = ClientPrefs.data.antialiasing;
        bar2.antialiasing = ClientPrefs.data.antialiasing;

        if (ImageBar.enemyColor != enemyColor) {
            bar1.replaceColor(0xFFFFFFFF, ImageBar.enemyColor); // Failsafe for if it's white for some reason
            bar1.replaceColor(ImageBar.enemyColor, enemyColor);
        } else {
            bar1.replaceColor(0xFFFFFFFF, enemyColor);
        }
        ImageBar.enemyColor = enemyColor;

        if (ImageBar.playerColor != playerColor) {
            bar2.replaceColor(0xFFFFFFFF, ImageBar.playerColor); // Failsafe for if it's white for some reason
            bar2.replaceColor(ImageBar.playerColor, playerColor);
        } else {
            bar2.replaceColor(0xFFFFFFFF, playerColor);
        }
        ImageBar.playerColor = playerColor;

        bar1.screenCenter(X);
        bar2.screenCenter(X);
        barWidth = Std.int(bar1.width);
        barHeight = Std.int(bar1.height);

        if (parentRef != null) {
            parent = parentRef;
            parentVariable = variable;
        }

        fillDirection = leftToRight ? FlxBarFillDirection.LEFT_TO_RIGHT : FlxBarFillDirection.RIGHT_TO_LEFT;

        createImageBar(bar1.graphic, bar2.graphic);
        bounds = {min: minVal, max: maxVal};
        setRange(bounds.min, bounds.max);
    }

    public var enabled:Bool = true;

    override function update(elapsed:Float){
        if (!enabled) {super.update(elapsed); return;}

        updateBar();
        super.update(elapsed);
    }

    public function setBounds(minVal:Float, maxVal:Float) {
        bounds = {min: minVal, max: maxVal};
        setRange(bounds.min, bounds.max);
    }

    public function setColors(left:FlxColor = null, right:FlxColor = null) {
        if (left != null) {
            bar1.replaceColor(enemyColor, left);
            enemyColor = left;
        }
        if (right != null) {
            bar2.replaceColor(playerColor, right);
            playerColor = right;
        }
        createImageBar(bar1.graphic, bar2.graphic);
        updateBar();
    }

    /*
    public function swapDirection() {
        leftToRight = !leftToRight;
        fillDirection = leftToRight ? FlxBarFillDirection.LEFT_TO_RIGHT : FlxBarFillDirection.RIGHT_TO_LEFT;
        createImageBar(bar1.graphic, bar2.graphic);
        updateBar();
    }
    */

    override function updateBar() {
        barCenter = this.x + FlxMath.lerp(0, barWidth, (leftToRight ? (percent/100) : 1 - (percent/100)));
        super.updateBar();
    }
}