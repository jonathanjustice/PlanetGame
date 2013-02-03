package utilities.Actors 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import utilities.Audio.SoundManager;
	import utilities.Screens.DefaultTextField;
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
		public var cityNodes:Array;
		public function Planet() 
		{
			setUp();
		}
		
		public function setUp():void {
			
			addActorToGameEngine();
			world = Main.getClassFromSWF("assets", "WORLD");
			addChild(world);
			MovieClip(world.getChildByName("base")).gotoAndStop("_0");
			//world.rotation -= 90;
			chunkMovieClip =  MovieClip(MovieClip(world.getChildByName("base")).getChildByName("chunks"));
			
			heart =  MovieClip(MovieClip(world.getChildByName("base")).getChildByName("heart"));
			heart.gotoAndStop("end");
			genWorld();
			cityNodes = new Array();
			cityNodes=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		}
		
		private function genWorld():void {
			var i:int;
			var frame:int;
			data = new Array();
			var numLandTiles:int = 0;
			while (numLandTiles < 3) {
				trace("genWorld")
				for (i = 0; i < 16; i++ ) {
					frame = int(Math.random() * 2 + 1);
					trace("frame:",frame)
					MovieClip(chunkMovieClip.getChildByName("_" + i)).gotoAndStop(1);
					
					if (frame == 1) {
						data[i] = "land";
							numLandTiles++;
						MovieClip(chunkMovieClip.getChildByName("_" + i)).gotoAndStop(1);
					}else if(frame == 2){
						data[i] = "water";
						MovieClip(chunkMovieClip.getChildByName("_" + i)).gotoAndStop(2);
					}
				}
				//if there are not enough land tiles, run the simulation again
				if (numLandTiles < 3) {
					numLandTiles = 0;
				}
				trace("data:",data);
			}
			//trace("data:",data);
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