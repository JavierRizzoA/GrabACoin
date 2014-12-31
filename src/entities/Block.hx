package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Block extends Entity {
	public function new(x:Int, y:Int) {
		super(x, y);
		setHitbox(32, 32);
		graphic = new Image("graphics/block.png");
        type = "Solid";

	}

	public override function update() {

		super.update();
	}
}
