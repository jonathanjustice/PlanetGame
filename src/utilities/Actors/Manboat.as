package utilities.Actors 
{
	import flash.display.MovieClip;
	import utilities.Engine.Combat.SurfaceManager;
	/**
	 * Dick
	 * @author ...
	 */
	public class Manboat extends Actor 
	{
		static const DIRECTION_COUNTDOWN_MAX:int = 60;
		static const DIRECTION_COUNTDOWN_MIN:int = 20;
		static const NON_DIRECTION_MULTIPLIER:Number = 5;
		
		public var puppet:MovieClip;
		private var direction:int;
		private var direction_countdown:int;
		public function Manboat() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			puppet = Main.getClassFromSWF("assets", "man");
			addChild(puppet);
			direction = int(Math.random() * 3 - 1);
			direction_countdown = Math.random() * (DIRECTION_COUNTDOWN_MAX - DIRECTION_COUNTDOWN_MIN) + DIRECTION_COUNTDOWN_MIN;
		}

		public function move() {
			x += direction; 
			while (x > SurfaceManager.CIRCUMFERENCE) {
				x -= SurfaceManager.CIRCUMFERENCE;
			}
			while (x < 0) {
				x += SurfaceManager.CIRCUMFERENCE;
			}
			
			direction_countdown--;
			
			if (direction_countdown < 0) {
				direction = int(Math.random() * 3 - 2);
				if (direction_countdown == 0 ) {
					direction_countdown = Math.random() * (DIRECTION_COUNTDOWN_MAX*NON_DIRECTION_MULTIPLIER - DIRECTION_COUNTDOWN_MIN*NON_DIRECTION_MULTIPLIER) + DIRECTION_COUNTDOWN_MIN*NON_DIRECTION_MULTIPLIER;
				}else {
					direction_countdown = Math.random() * (DIRECTION_COUNTDOWN_MAX - DIRECTION_COUNTDOWN_MIN) + DIRECTION_COUNTDOWN_MIN;
				}
				
				
			}
			
		}
		
	}

}