package utilities.Engine{
	import flash.utils.Timer;
	import utilities.Mathematics.Time;
	import utilities.Screens.xpBarSystem;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.DefaultTextField;
	import utilities.Screens.UIContainer;
	import utilities.Screens.GameScreens.ScreenStart;
	import utilities.Screens.GameScreens.HighScoreScreen;
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class UIManager extends utilities.Engine.DefaultManager{
		public static var uiContainer:MovieClip = new utilities.Screens.UIContainer();
		private var padding:int=11;
		private var screen_LevelUp:MovieClip;
		private var highScoreScreen:MovieClip;
		private var screenStart:MovieClip;
		private var defaultTextField:MovieClip;
		public static var score:int = 0;
		public function UIManager(){
			setUp();
		}
		
		public function setUp():void{
			Main.theStage.addChild(uiContainer);
			addHighScoreField();
			uiContainer = new UIContainer;	
		}
		
		public function getUIContainer():Object{
			return uiContainer;
		}
		
		public function openStartScreen():void{
			screenStart = new ScreenStart();
			//trace("start");
		}
		
		public static function addToScore(amount:int):void {
			score += amount;
		}
		
		public function addHighScoreField():void{
			highScoreScreen = new HighScoreScreen();
			defaultTextField = new DefaultTextField()
			//trace("start");
		}
		
		public function update_xpBar():void{
			
		}
		
		public override function updateLoop():void {
			var timePlaying:String = "TIME: " + utilities.Mathematics.Time.timeElapsedSinceGameStarted();
			defaultTextField.updateTextField(timePlaying);
			highScoreScreen.updateTextField(score);
		}
	}
}
