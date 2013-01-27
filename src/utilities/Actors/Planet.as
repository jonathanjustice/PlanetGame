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
		
		public function Planet() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			world = Main.getClassFromSWF("assets", "WORLD");
			addChild(world);
			MovieClip(world.getChildByName("base")).gotoAndStop("_0");
		}
		
		public function setFrame(label:String):void{
			MovieClip(world.getChildByName("base")).gotoAndStop(label);	
		}
		
	}

}