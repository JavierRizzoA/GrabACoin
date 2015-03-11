package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Block extends Entity {
    private var image:Image;
	public function new(x:Int, y:Int) {
		super(x, y);
		setHitbox(Std.int( 96 * Globals.scaleX ), Std.int(96 * Globals.scaleX));
		image = new Image("graphics/block.png");
        image.scale = Globals.scaleX;
        graphic = image;
        type = "Solid";

	}

	public override function update() {

		super.update();
	}
}
