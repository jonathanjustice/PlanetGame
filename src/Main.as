﻿package {
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
	/*import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.lazyloaders.LazyXMLLoader;
*/
	public class Main extends MovieClip{
	//public var loader:LazyXMLLoader;
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
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//once the stage exists, launch the game
        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			//loader = new LazyXMLLoader("assets/assets.xml","assets",5);
			//loader.addEventListener(BulkProgressEvent.COMPLETE,doneLoading);
			//loader.start();
			initialSetup();
			
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
		
		private function doneLoading(e:Event):void{
			//loadUI();
			//tileLoad();
			openStartScreen();
			//stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			//tracker.trackPageview( "/game/loaded" );
		}
	}
}