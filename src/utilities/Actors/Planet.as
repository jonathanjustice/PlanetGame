package utilities.Actors 
{
	import flash.display.MovieClip;
	/**
	 * Dick
	 * @author ...
	 */
	public class Planet extends Actor 
	{
		
		private var world:MovieClip;
		private var chunkMovieClip:MovieClip;
		public function Planet() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			world = Main.getClassFromSWF("assets", "WORLD");
			addChild(world);
			MovieClip(world.getChildByName("base")).gotoAndStop("_0");
			
			chunkMovieClip =  MovieClip(MovieClip(world.getChildByName("base")).getChildByName("chunks"));
			genWorld();
		}
		
		private function genWorld():void {
			var i:int;
			var frame:int;
			
			for (i = 0; i < 16; i++ ) {
				frame = int(Math.random() * 2 + 1);	
				MovieClip(chunkMovieClip.getChildByName("_"+i)).gotoAndStop(frame);
			}
		}
		
		
		public function setFrame(label:String):void{
			MovieClip(world.getChildByName("base")).gotoAndStop(label);	
		}
		
	}

}