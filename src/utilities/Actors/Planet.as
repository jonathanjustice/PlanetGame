package utilities.Actors 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Planet extends Actor 
	{
		
		public function Planet() 
		{
			setUp();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			addChild(Main.getClassFromSWF("assets", "WORLD"));
		}
		
	}

}