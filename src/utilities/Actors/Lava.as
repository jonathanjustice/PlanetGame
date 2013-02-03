package utilities.Actors 
{
	import br.com.stimuli.loading.BulkLoader;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import utilities.Engine.Combat.SurfaceManager;
	import utilities.Mathematics.Probability;
	/**
	 * Dick
	 * @author ...
	 */
	public class Lava extends Actor {
		public var decay:int;
		public var puppet:MovieClip;
		private var direction:int;
		private var deltaX:Number;
		private var deltaY:Number;
		//private var deltaXDecay:Number;
		private var deltaYDecay:Number = 3;
		
		public function Lava(left:Boolean) 
		{
			setUp(left);
			decay = Math.random() * 50 + 25;
		}
		
		public function setUp(left:Boolean):void {
			addActorToGameEngine();
			deltaX = Probability.generateRandomValue(-7, 7)
			deltaY = Probability.generateRandomValue(8,13)
			
			puppet = Main.getClassFromSWF("assets", "volcano");
			
			addChild(puppet);
		}
		
		public function getBoundingRect():Rectangle {
			return new Rectangle(x - 3, 0, 6, 2);
		}

		public function move():void {
			x += deltaX;
			while (x > SurfaceManager.CIRCUMFERENCE) {
				x -= SurfaceManager.CIRCUMFERENCE;
			}
			while (x < 0) {
				x += SurfaceManager.CIRCUMFERENCE;
			}
			y -= deltaY;
			deltaY -= 1;
			if (y > 0) {
				y = 0;
				deltaY = 0;
				deltaX = 0;
			}
			decay--;
		}	
	}
}