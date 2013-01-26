/*
You can access another manager this way:
Game.avatarManager.doSomeFunction();
*/
package utilities.Actors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Actors.Actor;
	import utilities.Actors.Behaviors.SpeedyBullet;
	import utilities.Actors.Behaviors.Behavior_HeatSeeking;
	import utilities.Actors.Behaviors.Behavior_Blob;
	import utilities.Actors.Stats.WeaponStats;
	import utilities.Mathematics.QuadTree;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Game;

	import utilities.Mathematics.MathFormulas;
	public class Gem extends Actor{
		
		//private var gameContainer;
		private var speed:Number=15;
		private var xVelocity:Number=0;//velocity
		private var yVelocity:Number=0;
		private var velocityMultiplier:Number=20;//used for setting initialy velocity
		private var pausedTime:Number = 0;//for pausing the game
		private var gamePausedAtTime:Number = 0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 10000;
		private var oldTarget:MovieClip;
		public var damage:Number=20;
		public var deltaX:Number = 0;
		public var deltaY:Number = 0;
		private var targetTweenPoint:Point = new Point();
		//public var xDiff:Number=0;
		//public var yDiff:Number=0;
	
		public function Gem(){
			setUp();
		}
		
		
		public function setUp():void{
			//addActorToGameEngine(utilities.Engine.Game.bulletManager);
		//	setInitialLocationAndVector();
			addActorToGameEngine();
			defineGraphics3();
		}
		
		//the enter frame, does everything
		public function updateLoop():void{
			
			checkForDeathFlag();
			//trace(target);
		}
			
		public function setTargetTweenPoint(target:Point):void {
			targetTweenPoint = target;
		}
		
		public function getTargetTweenPoint():Point {
			return targetTweenPoint;
		}
		
		
		public override function defineProperties():void{
			//classes to get behaviors from
			
			//define visuals of the bullet based on its properties
		
		}
		
		public function setInitialLocationAndVector():void{
			//trace("setInitialLocationAndVector");
			var spawnPoint:Point = Game.avatarManager.getAvatarLocation();
			
			//trace("spawnPoint",spawnPoint);
			var vector:Point;
			//variances that come from bullet properties that affect spawning
			var spread:Number;
			//trace("setSpawnTime");
		//	setSpawnTime();
			//get initial position from the avatar
			this.x = spawnPoint.x;
			this.y = spawnPoint.y;
			//trace(this.x);
			//get initial velocity from keyInputManager or avatar direction based on controller input
			
			this.rotation = Game.avatarManager.getAvatarAngle()-90;
			
			//if the vector is affected by bullet properties
			if(utilities.Actors.Stats.WeaponStats.getBlobular() > 0){
				/*spread = change_vector_based_on_bullet_properties();
				spread = Math.random()*spread*2 - spread;
				vector = MathFormulas.degreesToSlope(Game.avatarManager.getAvatarAngle() + spread);
				this.rotation += spread; */
			}else{
				//if the vector is not affected by bullet properties
				vector = MathFormulas.degreesToSlope(Game.avatarManager.getAvatarAngle());
			}
			
			//angle based on direction avatar is facing when the bullet is spawned
			xVelocity = velocityMultiplier * vector.x;
			yVelocity = velocityMultiplier * vector.y;
			
			//used when keeping speed but changing angle or rotatiing
			var totalmove:Number = Math.sqrt(xVelocity * xVelocity + yVelocity * yVelocity);
				
			//apply easing
			xVelocity = speed*xVelocity/totalmove;
			yVelocity = speed*yVelocity/totalmove;
			//trace(this.x);
		}
			
	}
}