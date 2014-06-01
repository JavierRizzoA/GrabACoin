package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class LightBlock extends Block {

	var yVelocity = 0;

	public function new(x:Float, y:Float) {
		super(x, y);
		
	}

	public function checkCollision() {
		var p:Entity = collide("player", x + 5, y);
		if(p != null) {
			if(y == p.y) {
				moveBy(-2, 0);
			}
		}

		var p:Entity = collide("player", x - 5, y);
		if(p != null) {
			if(y == p.y) {
				moveBy(2, 0);
			}
		}

		var f:Entity = collide("block", x, y + 32);
        if(f == null) {
            yVelocity+= 2;
        } else {
        	moveTo(x, f.y - 32);
        	yVelocity = 0;
        }

        var f:Entity = collide("block", x, y);
        if(f != null && f.y <= y) {
        	if(f.x < x) {
        		moveTo(f.x + 32, y);
        	} else {
        		moveTo(f.x - 32, y);
        	}
        }

        moveBy(0, yVelocity);

	}

	public override function update() {
		checkCollision();
		super.update();
	}
}