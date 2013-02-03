package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.*;
	import utilities.Mathematics.MathFormulas;
	import utilities.Engine.Game;
	import utilities.Engine.UIManager;
	import utilities.Input.KeyInputManager;
	import utilities.Input.MouseInputManager;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.ApplicationDomain;
	
	/*bulk loader*/
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.lazyloaders.LazyXMLLoader;
	import flash.display.Shape;
	public class Main extends MovieClip{
	public var loader:LazyXMLLoader;
	//public var _loadingSWF:DisplayObject;
		
		public static var theStage:Object;
		public static var game:Object;
		public static var uiContainer:MovieClip;//empty MC?
		public static var uiManager:Object;//empty MC?
		public static var keyInputManager:Object;
		public static var mouseInputManager:Object;

		//check to see if the stage exists
		//usually only necessary if this is on the web or deployed inside another swf
		public function Main():void {
			
			var background:Shape = new Shape();
			background.graphics.beginFill(0xc4fefb);
			background.graphics.drawRect(-800, -600, 1600, 1200);
			background.graphics.endFill();
			
			addChild(background);
			
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//once the stage exists, launch the game
        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			loader = new LazyXMLLoader("assets/assets.xml","assets",5);
			loader.addEventListener(BulkProgressEvent.COMPLETE,doneLoading);
			loader.start();
			
        }
		
		//define the stage for use in other classes
		//launch the engine
		//set up a some important managers
		private function initialSetup():void{
			stage.stageFocusRect = false;
			defineTheStage();
			//createKeyInputManager();
			createUIManager();
			createTheGameEngine();
			openStartScreen();
		}
		
		//make sure to get rid of this eventually
		private function defineTheStage():void{
			//trace("the stage exists")
			theStage = this.stage;
		}
		
		private function createKeyInputManager():void{
			//trace("the input manager exists")
			keyInputManager = new utilities.Input.KeyInputManager();
			mouseInputManager = new utilities.Input.MouseInputManager();
		}
		
		private static function createUIManager():void{
			uiManager = new UIManager()
		}
		
		private function createTheGameEngine():void{
			game = new utilities.Engine.Game();
		}
		
		private function openStartScreen():void{
			uiManager.openStartScreen();
		}
		
		//If you lose focus, you can use this to regain it to the stage
		//useful when you click on buttons or click outside the game
		public static function returnFocusToGampelay():void{
			theStage.focus = null;
		}
		
		public static function getMouseCoordinates():Point{
			var mousePoint:Point = new Point(theStage.mouseX,theStage.mouseY);
			return mousePoint;
		}
		
		public static function getClassFromSWF(assetID:String,classID:String,loaderID:String="assets"):MovieClip{
			var bulkLoader:BulkLoader = BulkLoader.getLoader(loaderID);
			var swfLoader:MovieClip= bulkLoader.getMovieClip(assetID);
			var swf:ApplicationDomain = swfLoader.loaderInfo.applicationDomain
			var view:MovieClip = MovieClip(new (swf.getDefinition(classID) as Class)() as MovieClip);
			return view;
		}
		
		private function doneLoading(e:Event):void{
			//loadUI();
			//tileLoad();
			
			initialSetup();
			//openStartScreen();
			//stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			//tracker.trackPageview( "/game/loaded" );
		}
	}
}


/*

EarthQuakes(GREEN):
On land: If there's a volcano, destroys the volcano. If not, sinks land and turns it into water. People become boats and pick a random direction, cities get destroyed. 
On water: Tsunamis. They travel through water and destroy boats, and travel through one land space. upon touching the 2nd land space they get destroyed.

Volcano (PURPLE):
On land: creates volcano. Volcanos sit there and lava flows out. If people touch volcanos, they die. if a tsunami touches a volcano, both get destroyed.
On water: creates land. boats turn into people.

Wind (BLUE):
Fuck, I dunno. Let's see how those two play.

People:
on each tick, if Math.rand() < 0.001 and there's no city on that tile, turn into one.  - DONE

Cities:
	Try making three, lowering the spawn rate by 1/3rd to match.  -DONE


*/