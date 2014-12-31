import com.haxepunk.Scene;

import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;


class MainScene extends Scene
{

	private var player:entities.Player;
	private var cameraXAdjustTime:Float;
	private var cameraYAdjustTime:Float;

	public override function begin()
	{
		createMap();
	}

	public function createMap() {
		var map = TmxMap.loadFromFile("maps/map.tmx");
		for(object in map.getObjectGroup("Blocks").objects) {
			if(object.custom.resolve("light") == "true") {
				add(new entities.LightBlock(object.x, object.y));
			} else {
				add(new entities.Block(object.x, object.y));
			}
			
		}
		for(object in map.getObjectGroup("Player").objects) {
			player = new entities.Player(object.x, object.y);
			add(player);
		}
		for(object in map.getObjectGroup("Coins").objects) {
			add(new entities.Coin(object.x, object.y));
		}

		addGraphic(new Text("This is a very easy game.", 4*32, 80*32, 0, 0, {size: 32}));
		addGraphic(new Text("Seriously you can't win?", 46*32, 76*32, 0, 0, {size: 32}));
		addGraphic(new Text("This is like the easiest game ever...", 46*32, 77*32, 0, 0, {size: 32}));
		addGraphic(new Text("You're a failure in life.", 73*32, 67*32, 0, 0, {size: 32}));
		addGraphic(new Text("Here, have some coins and just win. Please.", 106*32, 66*32, 0, 0, {size: 32}));
		addGraphic(new Text("So you want to loose, huh?", 135*32, 67*32, 0, 0, {size: 32}));
		addGraphic(new Text("Ok...", 167*32, 66*32, 0, 0, {size: 32}));
		addGraphic(new Text("You'll have to kill yourself.", 173*32, 66*32, 0, 0, {size: 32}));
		addGraphic(new Text("But you can't...", 178*32, 86*32, 0, 0, {size: 32}));
		addGraphic(new Text("you can just win.", 178*32, 87*32, 0, 0, {size: 32}));

		camera.x = player.x - HXP.width / 2;
		camera.y = player.y - HXP.height / 2;
		cameraXAdjustTime = 0;
		cameraYAdjustTime = 0;


	}

	private function adjustCamera() {
		camera.x = player.x - HXP.width / 2 - player.speed.x * 2;
		camera.y = player.y - HXP.height / 1.5;
	}

	public override function update() {
		adjustCamera();
		super.update();
	}
}
