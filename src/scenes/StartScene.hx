package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Text;

class StartScene extends Scene
{
    var texts:Array<Image>;
    var bigCoin:Image;

	public override function begin()
	{
        Globals.scaleX = HXP.width / Globals.DEFAULT_X;
        Globals.scaleY = HXP.height / Globals.DEFAULT_Y;
        Globals.dpi = openfl.system.Capabilities.screenDPI;

        bigCoin = new Image("graphics/bigcoin.png");
        texts = new Array<Image>();
        texts.push(cast(new Text("GRAB A COIN TO WIN!", 0, 0, 0, 0, {size: 144}), Image));
        texts.push(cast(new Text("By Javier Rizzo", 0, 0, 0, 0, {size: 72}), Image));
#if android
        texts.push(cast(new Text("Tap the coin to start.", 0, 0, 0, 0, {size: 72}), Image));
#else
        texts.push(cast(new Text("Press space to start.", 0, 0, 0, 0, {size: 72}), Image));
#end

        bigCoin.scaleX = Globals.scaleX;
        bigCoin.scaleY = Globals.scaleY;
        for(i in 0 ... 3) texts[i].scaleX = Globals.scaleX;
        for(i in 0 ... 3) texts[i].scaleY = Globals.scaleY;

        addGraphic(texts[0], 0, HXP.halfWidth - texts[0].scaledWidth / 2, (HXP.halfHeight - bigCoin.scaledHeight / 2 - texts[0].scaledHeight / 2) / 2);
        addGraphic(texts[1], 0, HXP.width - texts[1].scaledWidth, HXP.height - texts[1].scaledHeight);
        addGraphic(texts[2], 0, HXP.halfWidth - texts[2].scaledWidth / 2, HXP.halfHeight + bigCoin.scaledHeight / 2);
		addGraphic(bigCoin, 0, HXP.halfWidth - bigCoin.scaledWidth / 2, HXP.halfHeight - bigCoin.scaledHeight / 2);

		Input.define("space", [Key.SPACE]);

#if android
    add(new entities.CoinButton(0, 0));
#end
	}

#if android
    public function handlePoint(touch:com.haxepunk.utils.Touch) {
        var e = HXP.scene.collidePoint("button", touch.sceneX, touch.sceneY);
        if(e != null) {
            var button = cast(e, entities.TouchButton);
            if(button != null) {
                button.doAction();
            }
        }
    }
#end

	public override function update() {
		if(Input.pressed("space")) {
			HXP.scene = new MainScene();
		}

#if android
        Input.touchPoints(handlePoint);
#end
		super.update();
	}
}
