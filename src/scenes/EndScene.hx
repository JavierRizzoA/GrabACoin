package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class EndScene extends Scene
{
    var texts:Array<Image>;
    var time:Float;

	public override function begin()
	{
        time = 0;
		Input.define("space", [Key.SPACE]);
        texts = new Array<Image>();
        var bigCoin = new Image("graphics/bigcoin.png");
        texts.push(cast(new Text("YOU WON!", 0, 0, 0, 0, {size: 144}), Image));
#if android
        texts.push((new Text("Tap to restart.", 0, 0, 0, 0, {size: 72})));
        add(new entities.CoinButton(0, 0));
#else

        texts.push((new Text("Press space to restart.", 0, 0, 0, 0, {size: 72})));
#end
        bigCoin.scaleX = Globals.scaleX;
        bigCoin.scaleY = Globals.scaleY;
        for(i in 0 ... 2) texts[i].scaleX = Globals.scaleX;
        for(i in 0 ... 2) texts[i].scaleY = Globals.scaleY;
        addGraphic(texts[0], 0, HXP.halfWidth - texts[0].scaledWidth / 2, (HXP.halfHeight - bigCoin.scaledHeight / 2 - texts[0].scaledHeight / 2) / 2);
        addGraphic(texts[1], 0, HXP.halfWidth - texts[1].scaledWidth / 2, HXP.halfHeight + bigCoin.scaledHeight / 2);
		addGraphic(bigCoin, 0, HXP.halfWidth - bigCoin.scaledWidth / 2, HXP.halfHeight - bigCoin.scaledHeight / 2);

	}

#if android
    public function handlePoint(touch:com.haxepunk.utils.Touch) {
        var e = HXP.scene.collidePoint("button", touch.sceneX, touch.sceneY);
        if(e != null) {
            var button = cast(e, entities.TouchButton);
            if(button != null) {
                if(time > 0.5) button.doAction();
            }
        }
    }
#end

	public override function update() {
        time += HXP.elapsed;
#if android
        Input.touchPoints(handlePoint);
#end
		if(Input.pressed("space")) {
			HXP.scene = new MainScene();

		}
		super.update();
	}
}
