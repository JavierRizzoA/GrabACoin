package entities;

import com.haxepunk.Entity;

class Solid extends Entity {
	public function new(x:Int, y:Int, w:Int = 70, h:Int = 70) {
		super(x, y);
		type = "Solid";
		setHitbox(w, h);
		active = false;
		visible = false;
	}
}
