import com.haxepunk.Scene;

import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxMap;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;


class MainScene extends Scene
{

	private var player:entities.Player;
	private var cameraXAdjustTime:Float;
	private var cameraYAdjustTime:Float;
    private var texts:Array<Image>;

	public override function begin()
	{
		createMap();
	}

	public function createMap() {
        texts = new Array<Image>();
		var map = TmxMap.loadFromFile("maps/map.tmx");
		for(object in map.getObjectGroup("Blocks").objects) {
			if(object.custom.resolve("light") == "true") {
				add(new entities.LightBlock(Std.int( object.x / 32 * 96 * Globals.scaleX ), Std.int( object.y / 32 * 96 * Globals.scaleX )));
			} else {
				add(new entities.Block(Std.int( object.x / 32 * 96 * Globals.scaleX ), Std.int( object.y / 32 * 96 * Globals.scaleX )));
			}
			
		}
		for(object in map.getObjectGroup("Player").objects) {
			player = new entities.Player(Std.int( object.x / 32 * 96 * Globals.scaleX ), Std.int( object.y / 32 * 96 * Globals.scaleX ));
			add(player);
		}
		for(object in map.getObjectGroup("Coins").objects) {
			add(new entities.Coin(Std.int( object.x / 32 * 96 * Globals.scaleX ), Std.int( object.y / 32 * 96 * Globals.scaleX )));
		}

        texts.push(cast(new Text("This is a very easy game.", 5*96 * Globals.scaleX, 82*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("Seriously you can't win?", 46*96 * Globals.scaleX, 76*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("This is like the easiest game ever...", 46*96 * Globals.scaleX, 77*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("You're a failure in life.", 73*96 * Globals.scaleX, 67*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("Here, have some coins and just win. Please.", 106*96 * Globals.scaleX, 66*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("So you want to lose, huh?", 135*96 * Globals.scaleX, 67*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("Ok...", 167*96 * Globals.scaleX, 66*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("You'll have to kill yourself.", 173*96 * Globals.scaleX, 66*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("But you can't...", 178*96 * Globals.scaleX, 86*96 * Globals.scaleX, 0, 0, {size: 72}), Image));
        texts.push(cast(new Text("you can just win.", 178*96 * Globals.scaleX, 87*96 * Globals.scaleX, 0, 0, {size: 72}), Image));

		for(i in 0 ... texts.length) {
            texts[i].scale = Globals.scaleX;
            addGraphic(texts[i]);
        }

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
