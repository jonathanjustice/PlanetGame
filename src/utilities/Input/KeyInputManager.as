package utilities.Input{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyCodes;
	import utilities.Engine.DefaultManager;
	public class KeyInputManager extends utilities.Engine.DefaultManager{
		private var isKeysEnabled:Boolean = false;
		private var Key_right_2:Boolean = false;
		private var Key_left_2:Boolean = false;
		private var Key_up_2:Boolean = false;
		private var Key_down_2:Boolean = false;
		private var Key_right:Boolean = false;
		private var Key_left:Boolean = false;
		private var Key_up:Boolean = false;
		private var Key_down:Boolean = false;
		private var Key_space:Boolean = false;
		private var Key_rightBracket:Boolean = false;//we're using right bracket now, because my keyboard is a jerk
		private var keys:Array = new Array();
		
		public var myAngle:Number=0;
		private var myVelocityX:Number=0;
		private var myVelocityY:Number=0;
		private var myRotation:Number=0;
		private var Key_rotRight:Boolean = false;
		private var Key_rotLeft:Boolean = false;
		
		public function KeyInputManager():void{
			//keys = [];
			setUp();
		}
		
		public function setUp():void{
			//trace("keyinputmanager setup");
			myAngle = 0;
			Main.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			isKeysEnabled = true;
		}
		
		public function removeKeyListeners():void{
			Main.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		public function keyDownHandler(e:KeyboardEvent):void{
			if(isKeysEnabled == true){
				//trace(e.keyCode);
				if(e.keyCode == KeyCodes.key_RIGHT_BRACKET){
					Key_rightBracket=true;
				}
				if(e.keyCode == KeyCodes.key_SPACEBAR){
					Key_space=true;
				}
				if(e.keyCode == 37){
					Key_left_2=true;
				}
				if(e.keyCode == 38){
					Key_up_2=true;
				}
				if(e.keyCode == 39){
					Key_right_2=true;
				}
				if(e.keyCode == 40){
					Key_down_2=true;
				}
				//isKeysEnabled = false;
			}
		}
		
		public function keyUpHandler(e:KeyboardEvent):void{
			if(isKeysEnabled == true){
				if(e.keyCode == KeyCodes.key_RIGHT_BRACKET){
					Key_rightBracket=false;
				}
				if(e.keyCode == KeyCodes.key_SPACEBAR){
					Key_space=false;
				}
				if(e.keyCode == 37){
					Key_left_2=false;
				}
				if(e.keyCode == 38){
					Key_up_2=false;
				}
				if(e.keyCode == 39){
					Key_right_2=false;
				}
				if(e.keyCode == 40){
					Key_down_2=false;
				}
				//isKeysEnabled = true;
			}
		}
		
		public function setSimpleRotationViaKeys():void{
			if(Key_rotRight){
				myRotation = 3;
			}
			if(Key_rotLeft){
				myRotation = -3;
			}
			/*if(!Key_rotRight && !Key_rotLeft){
				myRotation = 0;
			}*/
			//trace("myRotation",myRotation);
		}
		
	//	public function returnKeyDirection():void
		
		
		
		public function getMyAngle():Number{
			//trace(myAngle);
			return myAngle;
		}
		
		public function getMyVelocityX():Number{
			return myVelocityX;
		}
		public function getMyRotation():Number{
			return myRotation;
		}
		public function getMyVelocityY():Number{
			return myVelocityY;
		}
		
		public function getLeftKey():Boolean{
			//trace("space" + Key_space);
			return Key_left_2;
		}
		
		public function getUpKey():Boolean{
			//trace("space" + Key_space);
			return Key_up_2;
		}
		
		public function getRightKey():Boolean{
			//trace("space" + Key_space);
			return Key_right_2;
		}
		
		public function getSpace():Boolean{
			//trace("space" + Key_space);
			return Key_space;
		}
		
		public function getRightBracket():Boolean{
			//trace("space" + Key_space);
			return Key_rightBracket;
		}
		
	}
}

