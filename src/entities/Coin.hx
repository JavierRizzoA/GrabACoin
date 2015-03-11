package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

class Coin extends Entity {

	private var sound:Sfx;
    private var image:Image;

	public function new(x:Float, y:Float) {
		super(x, y);
		setHitbox(Std.int(96 * Globals.scaleX), Std.int(96 * Globals.scaleX));
        image = new Image("graphics/coin.png");
        image.scale = Globals.scaleX;
		graphic = image;
		type = "coin";

		#if flash
		sound = new Sfx("audio/coin.mp3");
		#else
		sound = new Sfx("audio/coin.ogg");
		#end

	}

	private function destroy() {
		HXP.scene.remove(this);
	}

	private function checkCollision() {
		var f:Entity = collide("player", x, y);
		if(f != null) {
			sound.play();
			HXP.scene = new scenes.EndScene();
		}
	}

	public override function update() {
		checkCollision();
		super.update();
	}
}
