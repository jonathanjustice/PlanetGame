package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.text.*;
	import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
	public class HighScoreScreen extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var theTextField:TextField = new TextField();
		public function HighScoreScreen(){
		}
		
		public override function setUp():void{
			//myScreen = screen_swf;
			setScreen();
			//addDynamicBlocker();
			//addScreenGraphics();
			addScreenToUIContainer();
			//addClickHandler();
			//addOverHandler();
			//addOutHandler();
			//mouseEnabledHandler();
			
			createHighScoreField();
		}
		
		public override function addScreenToUIContainer():void{
			utilities.Engine.UIManager.uiContainer.addChild(this);
		}
		
		private function createHighScoreField():void {
			trace("createHighscoreField");
			theTextField.type = TextFieldType.DYNAMIC;
			theTextField.border = true;
			theTextField.x = 10;
			theTextField.y = 10;
			theTextField.width = 500;
            theTextField.height = 20;
			theTextField.multiline = true;
			theTextField.wordWrap = true;
			theTextField.selectable = false;
			//theTextField.backgroundColor = 0xF5F5DC;
            //theTextField.background = true;
            theTextField.textColor = 0x000000;
            theTextField.autoSize = TextFieldAutoSize.LEFT;
			this.addChild(theTextField);
			theTextField.text = "SCORE: 0";
		}
		
		public function updateTextField(score:int):void {
			theTextField.text = theTextField.text = "SCORE:" + String(score);
		}
		
		public override function clickHandler(event:MouseEvent):void{
			//trace("parent:",event.target.parent.name);
			//trace("target:",event.target.name);
			//switch (event.target){
			/*	case blocker:
				trace("clicked start screen");
					removeThisScreen();
					utilities.Engine.Game.startGame("start");
					break;
				
				case myScreen.btn_start:
				trace("clicked start screen");
					removeThisScreen();
					utilities.Engine.Game.startGame("start");
					break;
					*/
			//}
		}
		
		
		//is there a way to make this more abstract?
		//check for everything that is a button when the screen is created?
		public override function mouseEnabledHandler():void{
			//myScreen.btn_start.buttonMode = true;
		}
		
		//is there a way to make this more abstract?
		//could pass in the screen in setUp or when its loaded
		public override function setScreen():void{
			//replace this with the swf once there is a swf loading class
			//myScreen = screen_swf;
			myScreen = new MovieClip();
			//myScreen = new Screen_Start();
			//trace("ScreenStart: myScreen is:",myScreen);
		}
		
		public override function addScreenGraphics():void{
			//trace("ScreenStart: addScreenGraphics",myScreen);
			this.addChild(myScreen);
		}
	}
}