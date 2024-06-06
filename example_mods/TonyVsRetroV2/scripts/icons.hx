import flixel.math.FlxRect;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;
import flixel.graphics.FlxGraphic;

var isWinningDad:Bool = false;
var isWinningBF:Bool = false;

final ICON_WIDTH:Int = 450;
final FRAME_WIDTH:Int = 150; // Width of each frame in the sprite sheet
final FRAME_HEIGHT:Int = 150; // Height of each frame in the sprite sheet

/**
 * Changes the icons based on the health icon of dad and boyfriend.
 */
function changeIcon() {
    var dadGraphic:FlxGraphic = Paths.image('icons/icon-' + game.dad.healthIcon, false); 
    var bfGraphic:FlxGraphic = Paths.image('icons/icon-' + game.boyfriend.healthIcon, false);

    if (dadGraphic != null && dadGraphic.width == ICON_WIDTH) {
        updateIcon(game.iconP2, dadGraphic, game.dad.healthIcon);
    }

    if (bfGraphic != null && bfGraphic.width == ICON_WIDTH) {
        updateIcon(game.iconP1, bfGraphic, game.boyfriend.healthIcon);
    }
}

/**
 * Updates the icon with the given graphic and icon name.
 * @param icon The icon object to update.
 * @param graphic The graphic to use for the icon.
 * @param iconName The name of the icon to load.
 */
function updateIcon(icon:Dynamic, graphic:FlxGraphic, iconName:String) {
    // Load the new graphic for the icon as a sprite sheet
    icon.loadGraphic(Paths.image('icons/icon-' + iconName, false), true, FRAME_WIDTH, FRAME_HEIGHT);
    
    // Set icon offsets
    icon.iconOffsets[0] = 0; // Adjust if necessary
    icon.iconOffsets[1] = 0; // Adjust if necessary
    icon.updateHitbox();

    // Add and play the animation if it does not already exist
    if (!icon.animation.hasAnimation(iconName)) {
        // Create animation frames [0, 1, 2] for a 3-frame animation
        icon.animation.add(iconName, [0, 1, 2], 24, true);
    }
    icon.animation.play(iconName);
}
    