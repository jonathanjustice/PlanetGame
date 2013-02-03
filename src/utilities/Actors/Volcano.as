package utilities.Actors 
{
	import br.com.stimuli.loading.BulkLoader;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import utilities.Engine.Combat.SurfaceManager;
	/**
	 * Dick
	 * @author ...
	 */
	public class Volcano extends Actor {
		public var decay:int;
		public var puppet:MovieClip;
		private var direction:int;
		
		public function Volcano(left:Boolean) 
		{
			setUp(left);
			decay = Math.random() * 250 + 250;
		}
		
		public function setUp(left:Boolean):void{
			addActorToGameEngine();
			alpha = 0;
		//	puppet = Main.getClassFromSWF("assets", "volcano");
			/*if (left) {
				direction = -3;
				puppet = Main.getClassFromSWF("assets", "waveL");
			}else{
				direction = 3;
				puppet = Main.getClassFromSWF("assets", "wave");
			}*/
			addChild(puppet);
		}
		
		public function getBoundingRect():Rectangle {
			return new Rectangle(x - 3, 0, 6, 2);
		}

		public function move():void {
			if (alpha < 1) {
				alpha += .005;
			}
			decay--;
		}
		/*public function move():void {
			x += direction; 
			while (x > SurfaceManager.CIRCUMFERENCE) {
				x -= SurfaceManager.CIRCUMFERENCE;
			}
			while (x < 0) {
				x += SurfaceManager.CIRCUMFERENCE;
			}
			
			decay--;
		}*/
		
	}

}