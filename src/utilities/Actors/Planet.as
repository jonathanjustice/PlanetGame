package utilities.Actors 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import utilities.Audio.SoundManager;
	/**
	 * Dick
	 * @author ...
	 */
	public class Planet extends Actor 
	{
		
		private var world:MovieClip;
		private var chunkMovieClip:MovieClip;
		private var heart:MovieClip;
		public var data:Array;
		public function Planet() 
		{
			setUp();
		}
		
		public function setUp():void {
			
			addActorToGameEngine();
			world = Main.getClassFromSWF("assets", "WORLD");
			addChild(world);
			MovieClip(world.getChildByName("base")).gotoAndStop("_0");
			
			chunkMovieClip =  MovieClip(MovieClip(world.getChildByName("base")).getChildByName("chunks"));
			
			heart =  MovieClip(MovieClip(world.getChildByName("base")).getChildByName("heart"));
			heart.gotoAndStop("end");
			genWorld();
		}
		
		private function genWorld():void {
			var i:int;
			var frame:int;
			data = new Array();
			for (i = 0; i < 16; i++ ) {
				frame = int(Math.random() * 2 + 1);
				MovieClip(chunkMovieClip.getChildByName("_" + i)).gotoAndStop(frame);
				
				data[i] = (frame == 1)?"land":"water";
				
			}
		}
		
		public function beatHeart():void {
			heart.gotoAndPlay(1);
			SoundManager.heartSound.playSound(1, 0.5);
		}
		
		public function setFrame(label:String):void{
			MovieClip(world.getChildByName("base")).gotoAndStop(label);	
		}
		
	}

}