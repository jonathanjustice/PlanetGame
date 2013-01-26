package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;

	public class Wall extends utilities.Actors.Actor{
		private var isBulletBlocker:Boolean=false;;
		public function Wall(){
			setUp();
		}
		
		public function setUp():void{
			defineGraphics2();
			addActorToGameEngine();
			setPreviousPosition();
			//trace("Wall:Setup");
		}
		
		public function updateLoop():void{
			
		}
	}
}