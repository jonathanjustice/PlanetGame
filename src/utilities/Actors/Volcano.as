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
		private var LAVA_DELAY:int = 10;
		private var lavaCountdown:int = 0;
		private var direction:int;
		
		public function Volcano(left:Boolean) 
		{
			setUp(left);
			decay = Math.random() * 100 + 25;
		}
		
		public function setUp(left:Boolean):void {
			lavaCountdown = LAVA_DELAY;
			addActorToGameEngine();
			puppet = Main.getClassFromSWF("assets", "volcano");
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
		
		private function createNewLava():void {
			SurfaceManager.inst.makeLava(x);
		}

		public function move():void {
			lavaCountdown--;
			if (lavaCountdown == 0) {
				lavaCountdown = LAVA_DELAY;
				createNewLava();
			}
			decay--;
		}
	}
}