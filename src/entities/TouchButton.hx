package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;

class TouchButton extends Entity {

    public function new(x:Float, y:Float) {
        type = "button";

        super(x, y);
    }

    public function doAction() {
    }
}
