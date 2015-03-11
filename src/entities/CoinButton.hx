package entities;

import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class CoinButton extends TouchButton {
    public function new(x:Float, y:Float) {
        super(x, y);
        type = "button";
        setHitbox(Std.int(HXP.width), Std.int(HXP.height));
    }

    public override function doAction() {
        HXP.scene = new MainScene();
    }
}
