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
	public class City extends Actor 
	{
		private static const MANBOAT_COUNTDOWN_MAX:int = 180;
		private static const MANBOAT_COUNTDOWN_MIN:int = 60;
		
		public var puppet:MovieClip;
		public var manboatCounter:int;
		private var formattedAngle:Number;
		public function City() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			puppet = Main.getClassFromSWF("assets", "city");
			addChild(puppet);
			
			manboatCounter = Math.random() * (MANBOAT_COUNTDOWN_MAX - MANBOAT_COUNTDOWN_MIN) + MANBOAT_COUNTDOWN_MIN;
			
		}
		
		public function getBoundingRect():Rectangle {
			return new Rectangle(x - 8, 0, 16, 2);
		}

		public function move(planetData:Array):void {
			
			if (puppet) {

				var angle:Number = 360 * (x / SurfaceManager.CIRCUMFERENCE);
				formattedAngle = angle;
				puppet.rotation = angle+90;
				var radians:Number =  MathFormulas.degreesToRadians(angle);
				puppet.x = Math.cos(radians) * 240 + GemManager.originPoint.x - x;
				puppet.y = Math.sin(radians) * 240 + GemManager.originPoint.y;
				
				var index:int = int(16 * (x / SurfaceManager.CIRCUMFERENCE));
				if (index > 16) {
					index = 16;
				}
				if (index < 0) {
					index = 0;
				}
				if (planetData[index] == "water") {
					markDeathFlag();
				}
			}
		}
		
		public function get360FormattedAngle():Number {
			var angle:Number = 360 * (x / SurfaceManager.CIRCUMFERENCE);
			return angle;
		}
		
		public function tick(manager:SurfaceManager):void {
			
			manboatCounter--;
			
			if (manboatCounter < 0) {
				
				var manboat:Manboat = new Manboat();
				manager.addManboat(manboat);
				manboat.x = x;
				manboat.move(GemManager.planet.data);
				manboatCounter = Math.random() * (MANBOAT_COUNTDOWN_MAX - MANBOAT_COUNTDOWN_MIN) + MANBOAT_COUNTDOWN_MIN;;
			}
			
		}
		
	}

}