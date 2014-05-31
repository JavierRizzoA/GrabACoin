package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Player extends Entity {

	private var xVelocity:Float;
    private var xAcceleration:Float;
    private var yVelocity:Float;
    private var yAcceleration:Float;

    private static inline var xMaxVelocity:Float = 8;
    private static inline var xSpeed:Float = 2;
    private static inline var floorDrag:Float = 0.8;
    private static inline var yMaxVelocity:Float = 16;
    private static inline var ySpeed:Float = 2;
    private static inline var gravity:Float = 0.15;

    private var jumpEnabled:Bool;

	public function new(x:Float, y:Float) {
		super(x, y);
		setHitbox(32, 32);
        type = "player";
		graphic = new Image("graphics/player/player.png");
		Input.define("right", [Key.D]);
		Input.define("left", [Key.A]);
        Input.define("up", [Key.W, Key.SPACE]);
		xVelocity = 0;
		yVelocity = 0;
		jumpEnabled = false;
	}

	private function move() {

        xVelocity += xAcceleration * xSpeed;
        yVelocity += yAcceleration * ySpeed;

        if (Math.abs(xVelocity) > xMaxVelocity) {
            xVelocity = xMaxVelocity * HXP.sign(xVelocity);
        }

        if(Math.abs(yVelocity) > yMaxVelocity) {
            if(yVelocity < 0) {
                yVelocity = yMaxVelocity * HXP.sign(yVelocity);
                jumpEnabled = false;
            }
        }

        if (xVelocity < 0) {
            xVelocity = Math.min(xVelocity + floorDrag, 0);
        } else if (xVelocity > 0) {
            xVelocity = Math.max(xVelocity - floorDrag, 0);
        }

        if(yVelocity < 0) {
            yVelocity = Math.min(yVelocity + gravity, 0);
        }

        if(yVelocity > 0 && onFloor()) {
            yVelocity = 0;
        }

        if(xVelocity != 0) {
            var f:Entity = collide("block", x + xVelocity, y);
            if(f != null) {
                xVelocity = 0;
            } else {
                f = collide("block", x + xVelocity, y + height);
            }
        }

        moveBy(xVelocity, yVelocity);
    }

    private function handleInput()
    {
        xAcceleration = 0;
        yAcceleration = 0;

        if (Input.check("left")) {

            xAcceleration = -1;
        }

        if (Input.check("right")) {
            xAcceleration = 1;
        }

        if(Input.released("up")) {
            jumpEnabled = false;
        }

        if (Input.check("up") && jumpEnabled) {
            yAcceleration = -1;
        } else {
            if(!onFloor()) {
                yAcceleration = 1;
            }
        }

        if(onCeiling()) {
            yAcceleration = 1;
            jumpEnabled = false;
        }

    }

	private function onCeiling():Bool {
		var f:Entity = collide("block", x, y + yVelocity);
		if(f != null) {
			if(f.y <= this.y) {
                moveTo(x, f.y + 35);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	private function onFloor():Bool {
		//for(i in Std.int(y) ... Std.int(y + yVelocity)) {
            var f:Entity = collide("block", x, y + yVelocity);
            if(f != null) {
                if(f.y >= this.y + height) {
                    moveTo(x, f.y - 32);
                    jumpEnabled = true;
                    return true;
                }
            }
        //}
        return false;
	}

	public override function update() {
		handleInput();
		move();
		super.update();
	}
}