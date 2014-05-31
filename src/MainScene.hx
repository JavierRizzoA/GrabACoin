import com.haxepunk.Scene;

import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.HXP;

class MainScene extends Scene
{

	private var player:entities.Player;
	private var currentY:Float;

	public override function begin()
	{
		createMap();
	}

	public function createMap() {
		var map = TmxMap.loadFromFile("maps/map.tmx");
		for(object in map.getObjectGroup("Blocks").objects) {
			add(new entities.Block(object.x, object.y));
		}
		for(object in map.getObjectGroup("Player").objects) {
			player = new entities.Player(object.x, object.y);
			add(player);
		}
		for(object in map.getObjectGroup("Coins").objects) {
			add(new entities.Coin(object.x, object.y));
		}
	}

	private function adjustCamera() {
		currentY = camera.y;
		camera.x = player.x - HXP.width / 2;

		if(player.y >= currentY + HXP.height) {
			camera.y += HXP.height;
		} else if(player.y < currentY) {
			camera.y -= HXP.height;
		}
	}

	public override function update() {
		adjustCamera();
		super.update();
	}
}