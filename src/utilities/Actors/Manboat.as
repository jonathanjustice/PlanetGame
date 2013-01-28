package utilities.Actors 
{
	import flash.display.*;
	import flash.geom.*;
	import utilities.Engine.Combat.*;
	import utilities.Mathematics.MathFormulas;
	
	/**
	 * Dick
	 * @author ...
	 */
	public class Manboat extends Actor 
	{
		private static const DIRECTION_COUNTDOWN_MAX:int = 180;
		private static const DIRECTION_COUNTDOWN_MIN:int = 60;
		private static const NON_DIRECTION_MULTIPLIER:Number = 3;
		
		public var puppet:MovieClip;
		private var direction:int;
		private var direction_countdown:int;
		
		private var ladyMan:Boolean;
		private var boatmode:Boolean;
		
		public function Manboat() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			
			ladyMan = (Math.random() > 0.5);
			
			if (ladyMan) {
				puppet = Main.getClassFromSWF("assets", "lady");
			}else {
				puppet = Main.getClassFromSWF("assets", "man");
			}
			
			addChild(puppet);
			direction = (Math.random() > 0.5)? -1:1;
			direction_countdown = Math.random() * (DIRECTION_COUNTDOWN_MAX - DIRECTION_COUNTDOWN_MIN) + DIRECTION_COUNTDOWN_MIN;
		}
		
		public function getBoundingRect():Rectangle {
			return new Rectangle(x - 8, 0, 16, 2);
		}

		public function move(planetData:Array):void {
			x += direction; 
			while (x > SurfaceManager.CIRCUMFERENCE) {
				x -= SurfaceManager.CIRCUMFERENCE;
			}
			while (x < 0) {
				x += SurfaceManager.CIRCUMFERENCE;
			}
			
			direction_countdown--;
			
			if (direction_countdown < 0 && !boatmode) {
				direction = int(Math.random() * 3 - 2);
				if (direction_countdown == 0 ) {
					direction_countdown = Math.random() * (DIRECTION_COUNTDOWN_MAX*NON_DIRECTION_MULTIPLIER - DIRECTION_COUNTDOWN_MIN*NON_DIRECTION_MULTIPLIER) + DIRECTION_COUNTDOWN_MIN*NON_DIRECTION_MULTIPLIER;
				}else {
					direction_countdown = Math.random() * (DIRECTION_COUNTDOWN_MAX - DIRECTION_COUNTDOWN_MIN) + DIRECTION_COUNTDOWN_MIN;
				}
			}
			
			if (puppet) {
								
				var index:int = int(16 * (x / SurfaceManager.CIRCUMFERENCE));
				if (index > 16) {
					index = 16;
				}
				if (index < 0) {
					index = 0;
				}
				if (planetData[index] == "water" && !boatmode) {
					trace("be a boat")
					boatmode = true;
					removeChild(puppet)
					puppet = Main.getClassFromSWF("assets", "boat");
					addChild(puppet);
					
				}
				if (planetData[index] == "land" && boatmode) {
					trace("be a pepole")
					boatmode = false;
					removeChild(puppet)
					if (ladyMan) {
						puppet = Main.getClassFromSWF("assets", "lady");
					}else {
						puppet = Main.getClassFromSWF("assets", "man");
					}
					addChild(puppet);
				}
				
				//puppet.x = -x;
			//	puppet.y = -y;
				var angle:Number = 360 * (x / SurfaceManager.CIRCUMFERENCE);
				puppet.rotation = angle+90;
				var radians:Number =  MathFormulas.degreesToRadians(angle);
				puppet.x = Math.cos(radians) * 240 + GemManager.originPoint.x - x;
				puppet.y = Math.sin(radians) * 240 + GemManager.originPoint.y;

				
			}
			
		}
		
	}

}