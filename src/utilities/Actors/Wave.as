package utilities.Actors 
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import utilities.Engine.Combat.SurfaceManager;
	/**
	 * Dick
	 * @author ...
	 */
	public class Wave extends Actor {

		public var puppet:MovieClip;
		private var direction:int;
		
		public function Wave() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			if (Math.random()>0.5) {
				direction = -3;
				puppet = Main.getClassFromSWF("assets", "waveL");
			}else{
				direction = 3;
				puppet = Main.getClassFromSWF("assets", "wave");
			}
			addChild(puppet);
		}
		
		public function getBoundingRect():Rectangle {
			return new Rectangle(x - 3, 0, 6, 2);
		}

		public function move():void {
			x += direction; 
			while (x > SurfaceManager.CIRCUMFERENCE) {
				x -= SurfaceManager.CIRCUMFERENCE;
			}
			while (x < 0) {
				x += SurfaceManager.CIRCUMFERENCE;
			}
		}
		
	}

}