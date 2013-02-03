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
	public class Earthquake extends Actor {
		public var decay:int;
		public var puppet:MovieClip;
		private var direction:int;
		
		public function Earthquake(left:Boolean) 
		{
			setUp(left);
			decay = Math.random() * 10250 + 10250;
		}
		
		public function setUp(left:Boolean):void{
			addActorToGameEngine();
			//alpha = 0;
			puppet = Main.getClassFromSWF("assets", "earthquake");
			
			addChild(puppet);
		}
		
		public function getBoundingRect():Rectangle {
			return new Rectangle(x - 3, 0, 6, 2);
		}

		public function move():void {
			
			decay--;
		}
	}
}