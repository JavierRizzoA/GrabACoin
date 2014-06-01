import com.haxepunk.Scene;

import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;


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

		addGraphic(new Text("Seriously you can't win?", 46*32, 76*32, 0, 0, {size: 32}));
		addGraphic(new Text("This is like the easiest game ever...", 46*32, 77*32, 0, 0, {size: 32}));
		addGraphic(new Text("You're a failure in life.", 73*32, 67*32, 0, 0, {size: 32}));
		addGraphic(new Text("Here, have some coins and just win. Please.", 106*32, 66*32, 0, 0, {size: 32}));
		addGraphic(new Text("So you want to loose, huh?", 135*32, 67*32, 0, 0, {size: 32}));
		addGraphic(new Text("Ok...", 167*32, 66*32, 0, 0, {size: 32}));
		addGraphic(new Text("You'll have to kill yourself.", 173*32, 66*32, 0, 0, {size: 32}));
		addGraphic(new Text("But you can't.", 177*32, 86*32, 0, 0, {size: 32}));
		addGraphic(new Text("You can just win.", 177*32, 87*32, 0, 0, {size: 32}));


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