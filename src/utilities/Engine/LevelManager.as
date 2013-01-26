package utilities.Engine{
	import flash.display.MovieClip;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.GameBoardPieces.Level;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.GameBoardPieces.Terrain;
	import flash.geom.Point;
	public class LevelManager extends utilities.Engine.DefaultManager{
		private var tempArray:Array = new Array();
		public static var level:MovieClip;
		public static var levels:Array;
		public function LevelManager(){
			setUp();
		}
		
		public function setUp():void{
			levels =[];
			createLevel();
			create_a_bunch_of_walls_forTesting();
		}
		
		public function create_a_bunch_of_walls_forTesting():void{
			var theX:Number = 50;
			var theY:Number = 50;
			for(var i:int=0;i<5;i++){
				theX+=50;
				theY+=50;
				var wall:Wall = new Wall();
				wall.x=theX;
				wall.y=theY;
				levels.push(wall);
				//wall.setPreviousPosition();
			}
		}
		
		public function getLevelLocation():Point{
			return levels[0].getLevelLocation();
		}
		
		public override function updateLoop():void{
			for each(var level:Level in levels){
				level.updateLoop();
			}
		}
		
		private static function createLevel():void{
			level = new utilities.Actors.GameBoardPieces.Level();
			levels.push(level);
		}
		
		public override function getArray():Array{
			return levels;
		}
		
		public function getLevel():Object{
			return levels[0];
		}
	}
}
