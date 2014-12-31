package entities;

import openfl.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

class Player extends Physics {

	private static inline var GRAPHIC_FRAME_TIME:Float = 0.02;

	public var sprite:Spritemap;

	public var movement:Float;
	public var jump:Float;

	public var direction:Bool; //true = right, false = left

	public var onGround:Bool;

	public var wallJumping:Int; //0 = no, 1 = left, 2 = right

	public var doubleJump:Bool;

	public var dead:Bool;
	public var start:Point;

	private var walkingImages:Array<Image>;
	private var currentWalkingImage:Int;
	private var walkingImageTime:Float = 0;
	private var duckImage:Image;
	private var hurtImage:Image;
	private var jumpImage:Image;
	private var standImage:Image;
	private var flipGraphic:Bool;
	private var wasWalking:Bool;

    private var jumpSound:Sfx;

	public function new(x:Int, y:Int) {
		super(x, y);

		movement = 1;
		jump = 8;

		direction = true;
		onGround = false;
		wallJumping = 0;
		doubleJump = false;

		dead = false;
		start = new Point();

		mGravity = 0.4;
		mMaxSpeed = new Point(4, 16);
		mFriction = new Point(0.4, 0.5);

		setHitbox(32, 32);
		graphic = new Image("graphics/player/player.png");
		type = "player";

		Input.define("right", [Key.D, Key.RIGHT]);
		Input.define("left", [Key.A, Key.LEFT]);
        Input.define("up", [Key.W, Key.UP]);
        Input.define("down", [Key.S, Key.DOWN]);
        Input.define("jump", [Key.SPACE]);

        walkingImages = [new Image("graphics/player/playerRight.png")];
		currentWalkingImage = 0;
		walkingImageTime = 0;
		jumpImage = new Image("graphics/player/playerJumping.png");
		standImage = new Image("graphics/player/player.png");
		wasWalking = false;

#if flash
        jumpSound = new Sfx("audio/jump.mp3");
#else
        jumpSound = new Sfx("audio/jump.ogg");
#end
	}

	public override function update():Void {
		onGround = false;
		if(collide(solid, x, y + 1) != null) {
			onGround = true;
			wallJumping = 0;
			doubleJump = true;
		}

		acceleration.x = 0;

		if (Input.check("left") && speed.x > -mMaxSpeed.x) { acceleration.x = - movement; direction = false; }
		if (Input.check("right") && speed.x < mMaxSpeed.x) { acceleration.x = movement; direction = true; }

		if ((!Input.check("left") && !Input.check("right")) || Math.abs(speed.x) > mMaxSpeed.x) {
			friction(true, false);
		}

		if (Input.pressed("jump"))
		{
			var jumped:Bool = false;
			
			if (onGround) { 
				speed.y = -jump; 
				jumped = true; 
                jumpSound.play();
			}
			
			
			if (!onGround && !jumped && doubleJump) { 
				speed.y = -jump;
				doubleJump = false;
				wallJumping = 0;
                jumpSound.play();
			}
		}
		gravity();
		maxSpeed(false, true);
		if (speed.y < 0 && !Input.check("jump")) { gravity(); gravity(); }
		motion();
		if(collide("Spikes", x, y) != null && speed.y > 0) {
			killme();
		}

		if(onGround) {
			walkingImageTime += HXP.elapsed;
			if(Math.abs(speed.x) > 0) {
				if(!wasWalking) {
					currentWalkingImage = 0;
					wasWalking = true;
					walkingImageTime = 0;
				}
				if(walkingImageTime >= GRAPHIC_FRAME_TIME) {
					currentWalkingImage ++;
					currentWalkingImage %= 7;
					walkingImageTime = 0;
				}
				if(speed.x > 0) {
					walkingImages[0].flipped = false;
				} else {
					walkingImages[0].flipped = true;
				}
				graphic = walkingImages[0];
			} else {
				standImage.flipped = !direction;
				graphic = standImage;
			}
		} else {
			jumpImage.flipped = !direction;
			graphic = jumpImage;
		}

	}

	public function killme():Void {
		dead = true;
	}

}
