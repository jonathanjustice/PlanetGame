package utilities.Actors{
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.QuadTree;
	import utilities.Engine.Game;
	import utilities.Actors.Actor;
	import utilities.Input.KeyInputManager;
	import  utilities.Input.MouseInputManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.text.*;

	public class Avatar extends utilities.Actors.Actor{
		//private var mySprite:Sprite = new Sprite();
		private var myTextField:TextField = new TextField(); 
		private var myAngle:Number=0;
		private var velocityIncrease:Number=6;
		private var maxSpeed:Number=6;
		private var xVelocity:Number=50;//velocity
		private var yVelocity:Number=50;
		public var xDiff:Number=0;
		public var yDiff:Number=0;
		
		
		public function Avatar(){
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			defineGraphics();
			this.x=450;
			this.y=250;
		}
		
		public function getAvatarLocation():Point{
			var point:Point=new Point(this.x,this.y);
			return point;
		}
		
		public function updateLoop():void{
			setQuadTreeNode();
			//get key data
			getAnglesFromKeyInputManager();
			//get the velocity
			getVelocityFromKeyInputManager();
			//getRotationFromKeyInputManager();
			//apply the velocities to the avatar
			applyVelocities();
			var myPoint:Point = new Point(mouseX,mouseY);
			myPoint = Main.getMouseCoordinates();
			//Point_Actor_At_Target(myPoint);
			
			//trace("thisX: ",this.x,"thisY:",this.y);
		}
		
		/*public override function Point_Actor_At_Target(target:Point):void{
			MathFormulas.Point_Object_At_Target(this,target);
		}
		*/
		public function getAnglesFromKeyInputManager():void{
			this.rotation = Main.keyInputManager.getMyAngle();
		}
		
		public function getVelocityFromKeyInputManager():void{
			Main.keyInputManager.setSimpleVelocityViaKeys();
			xVelocity = Main.keyInputManager.getMyVelocityX() * velocityIncrease;
			yVelocity = Main.keyInputManager.getMyVelocityY() * velocityIncrease;
		}
		
		public function getRotationFromKeyInputManager():void{
			//trace(KeyInputManager.getMyRotation());
			trace(this.rotation);
			this.rotation += Main.keyInputManager.getMyRotation();
		}
		
		public function applyVelocities():void{
			this.x += xVelocity;
			this.y += yVelocity;
		}

		//don't set this every frame
		//use only when required
		//get the change in vector
		public function getChangeInPosition():Point{
			var changePoint:Point = new Point(xDiff,yDiff);
			return changePoint;
		}
		
		public override function getActor():MovieClip{
			return this;
		}
	}
}