package utilities.Actors 
{
	import flash.display.*;
	import flash.geom.*;
	import utilities.Engine.Combat.*;
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.Probability;
	
	/**
	 * Dick
	 * @author ...
	 */
	public class Manboat extends Actor 
	{
		private static const DIRECTION_COUNTDOWN_MAX:int = 60;
		private static const DIRECTION_COUNTDOWN_MIN:int = 20;
		private static const NON_DIRECTION_MULTIPLIER:Number = 3;
		
		private var turnedIntoCity:Boolean = false;
		public var puppet:MovieClip;
		private var direction:int;
		private var direction_countdown:int;
		
		private var ladyMan:Boolean;
		private var boatmode:Boolean;
		private var formattedAngle:Number;
		
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
			direction = (Math.random() > 0.5)? -4:4;
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
					
					boatmode = true;
					removeChild(puppet)
					puppet = Main.getClassFromSWF("assets", "boat");
					addChild(puppet);
					
				}
				if (planetData[index] == "land" && boatmode) {
					
					boatmode = false;
					removeChild(puppet)
					if (ladyMan) {
						puppet = Main.getClassFromSWF("assets", "lady");
					}else {
						puppet = Main.getClassFromSWF("assets", "man");
					}
					addChild(puppet);
				}
				
				chanceToBecomeCity();
				//puppet.x = -x;
			//	puppet.y = -y;
				var angle:Number = 360 * (x / SurfaceManager.CIRCUMFERENCE);
				puppet.rotation = angle+90;
				var radians:Number =  MathFormulas.degreesToRadians(angle);
				puppet.x = Math.cos(radians) * 240 + GemManager.originPoint.x - x;
				puppet.y = Math.sin(radians) * 240 + GemManager.originPoint.y;
			}
			
		}
		
		private function chanceToBecomeCity():void {
			if (Probability.generateRandomValue(1, 1000) < 10000 ) {
				//if the manboat is not in tile that is already taken AND that tile is land tile
				var node:int = get360FormattedAngle()/ SurfaceManager.nodeDenomenator;
				if (GemManager.planet.cityNodes[node] == 0) {
					//trace("Manboat: There was no city here, checking for land!");
					if (GemManager.planet.data[node] == "land") {
						
						turnedIntoCity = true;
						SurfaceManager.inst.makeCity(x);
						trace("Manboat: There was no city here, I'm a city now!");
						trace("its a", GemManager.planet.data[node]);
						trace(GemManager.planet.data);
					}
				}
			}
			//	trace(GemManager.planet.cityNodes);
		}
		
		public function getTurnedIntoCity():Boolean {
			return turnedIntoCity;
		}
		
		public function get360FormattedAngle():Number {
			var angle:Number = 360 * (x / SurfaceManager.CIRCUMFERENCE);
			return angle;
		}
		
	}

}