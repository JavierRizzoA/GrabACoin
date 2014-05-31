package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class EndScene extends Scene
{
	public override function begin()
	{
		addGraphic(new Image("graphics/endbg.png"));
		Input.define("space", [Key.SPACE]);
	}

	public override function update() {
		if(Input.pressed("space")) {
			HXP.scene = new MainScene();
		}
		super.update();
	}
}