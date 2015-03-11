package entities;

import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class ControlButton extends TouchButton {

    private var position:Int;
    public var touched:Bool;
    public var pressed:Bool;
    public var image:Image;

    public function new(x:Float, y:Float, graphic:Image, position:Int) {
        super(x, y);
        type = "button";
        graphic.scale = Globals.dpi / 2 / graphic.width;
        setHitbox(Std.int(graphic.scaledWidth), Std.int(graphic.scaledWidth));
        graphic.alpha = 0.5;
        image = graphic;
        this.graphic = image;
        this.position = position;
        touched = false;
        pressed = false;
    }

    public override function update() {
       y = HXP.scene.camera.y + HXP.height - Globals.dpi * 3 / 4;
        switch(position) {
            case 1:
                x = HXP.scene.camera.x + Globals.dpi / 4;
            case 2:
                x = HXP.scene.camera.x + Globals.dpi * 1;
            case 3:
                x = HXP.scene.camera.x + HXP.width - Globals.dpi * 3 / 4;
        }
        if(touched) image.alpha = 0.7; else image.alpha = 0.5;
        super.update();
    }
}
