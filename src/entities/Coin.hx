package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Coin extends Entity {
	public function new(x:Float, y:Float) {
		super(x, y);
		setHitbox(32, 32);
		graphic = new Image("graphics/coin.png");
		type = "coin";

	}

	private function destroy() {
		HXP.scene.remove(this);
	}

	private function checkCollision() {
		var f:Entity = collide("player", x, y);
		if(f != null) {
			HXP.scene = new scenes.EndScene();
		}
	}

	public override function update() {
		checkCollision();
		super.update();
	}
}