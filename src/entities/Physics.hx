package entities;

import openfl.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.HXP;

class Physics extends Entity {
	public var speed:Point;
	public var acceleration:Point;
	public var mGravity:Float;
	public var solid:String;
	public var mFriction:Point;
	public var slopeHeight:Int;
	public var mMaxSpeed:Point;

	public function new(x:Int = 0, y:Int = 0) {
		super(x, y);
		speed = new Point(0, 0);
		acceleration = new Point(0, 0);
		mGravity = 0.8;
		solid = "Solid";
		mFriction = new Point(0.5, 0.5);
		slopeHeight = 1;
		mMaxSpeed = new Point(3, 8);

		type = solid;
	}

	public override function update() {
		motion();
		gravity();
	}

	public function motion(mx:Bool = true, my:Bool = true):Void {
		if(mx) {
			if(!motionX(this, speed.x)) {
				speed.x = 0;
			}

			speed.x += acceleration.x;
		}

		if(my) {
			if(!motionY(this, speed.y)) {
				speed.y = 0;
			}
			speed.y += acceleration.y;
		}
	}

	public function gravity():Void {
		speed.y += mGravity;
	}

	public function friction(x:Bool = true, y:Bool = true):Void {
		if(x) {
			if(speed.x > 0) {
				speed.x -= mFriction.x;
				if(speed.x < 0) speed.x = 0;
			}

			if(speed.x < 0) {
				speed.x += mFriction.x;
				if(speed.x > 0) speed.x = 0;
			}
		}
	}

	public function maxSpeed(x:Bool = true, y:Bool = true):Void {
		if(x) {
			if(Math.abs(speed.x) > mMaxSpeed.x) speed.x = mMaxSpeed.x * HXP.sign(speed.x);
		}
		if(y) {
			if(Math.abs(speed.y) > mMaxSpeed.y) speed.y = mMaxSpeed.y * HXP.sign(speed.y);
		}
	}

	public function motionX(e:Entity, spdx:Float):Bool {
		for (i in 0...Std.int(Math.abs(spdx))) {
			var moved:Bool = false;
			var below:Bool = true;
			
			if (e.collide(solid, e.x, e.y + 1) == null) {
				below = false;
			}
			
			for (s in 0...(slopeHeight + 1)) {
				if (e.collide(solid, e.x + HXP.sign(spdx), e.y - s) == null) {
					if (e.collide("Player", e.x + HXP.sign(spdx), e.y - s) == null) {
						e.x += HXP.sign(spdx);
					}

					e.y -= s;
					
					moved = true;
					
					break;
				}				
			}
			
			if (below && e.collide(solid, e.x, e.y + 1) == null) {
				e.y += 1;
			}
			
			if (!moved) {
				return false;
			}
		}
		return true;
	}

	public function motionY(e:Entity, spdy:Float):Bool {
		for (i in 0...Std.int(Math.abs(spdy))) {
			if (e.collide(solid, e.x, e.y + HXP.sign(spdy)) == null) { 
				if (e.collide("Player", e.x, e.y + HXP.sign(spdy)) == null) {
					e.y += HXP.sign(spdy);
				}
			} else { 
				return false; 
			}
		}
		return true;
	}

	public function moveOnTop(type:String, speed:Float):Void {
		var e:Entity = collide(type, x, y - 1);
		if (e != null) {
			motionX(e, speed);
			var p:Physics = cast(e, Physics);
			if (p != null) {
				p.moveOnTop("Player", speed);
			}
		}
	}

}
