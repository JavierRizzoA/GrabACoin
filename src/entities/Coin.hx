package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

class Coin extends Entity {

	private var sound:Sfx;

	public function new(x:Float, y:Float) {
		super(x, y);
		setHitbox(32, 32);
		graphic = new Image("graphics/coin.png");
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