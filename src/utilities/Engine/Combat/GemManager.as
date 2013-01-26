package utilities.Engine.Combat{
	
	import com.greensock.plugins.EndVectorPlugin;
	import utilities.Actors.Gem;
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Mathematics.MathFormulas;
	import utilities.Actors.Enemy;
	import utilities.Actors.Gem;
	import utilities.Actors.Bullet;
	import utilities.Input.KeyInputManager;
	import utilities.Input.MouseInputManager;
	import com.greensock.TweenMax
	import flash.events.KeyboardEvent;
	public class GemManager extends utilities.Engine.DefaultManager{
		
		
		private var avatar:Point = new Point();
		public var numEnemies:Number = 0;
		public static var activeRotatingArray:int = 2;
		
		public static var gemsRing_0:Array=new Array();
		public static var gemsRing_1:Array=new Array();
		public static var gemsRing_2:Array=new Array();
		//private static var enemyFactory = new Factory_Enemy();
		public static var shittyTimer:int = 0;
		
		private static var numnum:Number = 0;
		private static var gemRingSize_0:int = 4;
		private static var gemRingSize_1:int = 8;
		private static var gemRingSize_2:int = 16;
		private static var originPoint:Point = new Point(300, 300);
		private var isKeysEnabled:Boolean = true;
		
		public function GemManager(){
			setUp();
			Main.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			isKeysEnabled = true;
		}
		
		public function setUp():void{
			numnum = 0;
			setUpRings();
			
			trace("GemManager:setUp");
		}
		
		public function setUpRings():void {
			for (var i:int = 0; i < gemRingSize_0; i++) {
				addGemToRing(gemsRing_0);
			}
			for (var j:int = 0; j < gemRingSize_1; j++) {
				addGemToRing(gemsRing_1);
			}
			for (var k:int = 0; k < gemRingSize_2; k++) {
				addGemToRing(gemsRing_2);
			}
			//trace("gemsRing_0:", gemsRing_0);
			//trace("gemsRing_1:", gemsRing_1);
			//trace("gemsRing_2:", gemsRing_2);
			arrangeMyGems(gemsRing_0,0);
			arrangeMyGems(gemsRing_1,1);
			arrangeMyGems(gemsRing_2,2);
		}
		
		private function getPositionOfGem(ringArray:Array, indexOfGem:int):Point {
			var positionOfGem:Point = new Point();
			var i:int = indexOfGem;
			var ringNumber:int;
			if (ringArray == gemsRing_0) {
				ringNumber = 0;
			}
			if (ringArray == gemsRing_1) {
				ringNumber = 1;
			}
			if (ringArray == gemsRing_2) {
				ringNumber = 2;
			}
			var angle:Number =  MathFormulas.degreesToRadians(360*((i+0.5)/ringArray.length));
			positionOfGem.x = Math.cos(angle) * ((70 * ringNumber) + 70)+ originPoint.x;
			positionOfGem.y = Math.sin(angle)  * ((70 * ringNumber) + 70) + originPoint.y;
			trace("positionOfGem", positionOfGem);
			return positionOfGem;
		}
		
		private function arrangeMyGems(ringArray:Array, ringNumber:int):void {
			for (var i:int = 0; i < ringArray.length; i++) {
				var angle:Number =  MathFormulas.degreesToRadians(360*((i+0.5)/ringArray.length));
				ringArray[i].x = Math.cos(angle) * ((70 * ringNumber) + 70)+ originPoint.x;
				ringArray[i].y = Math.sin(angle)  * ((70 * ringNumber) + 70) + originPoint.y;
	
				var gemPoint:Point = new Point();
				gemPoint.x = ringArray[i].x;
				gemPoint.y = ringArray[i].y;
				
				ringArray[i].rotation = MathFormulas.getAngle(gemPoint, originPoint);
			}
		}
		
		private function addGemToRing(ringArray:Array):void {
			var gem:Gem = new Gem();
			ringArray.push(gem);
		}
		
		//FPO way to create enemies
		//check the enemies for collisions with bullets
		public override function updateLoop():void {
		
		}
		
		private function rotateArray():void {
			//var gemToTweenTo:Gem;
			trace("rotateArray");
			var tweenPoint:Point = new Point();
			var completedTweens:int = 0;
			switch (activeRotatingArray) {
				case 2:
						for (var i:int = 0; i < gemsRing_2.length; i++) {
							if (i == 0) {
								tweenPoint = getPositionOfGem(gemsRing_2, gemsRing_2.length-1);
								gemsRing_2[i].setTargetTweenPoint(tweenPoint);
								//trace(tweenPoint);
							}else {
								tweenPoint = getPositionOfGem(gemsRing_2, (i-1));
								gemsRing_2[i].setTargetTweenPoint(tweenPoint);
								//trace(tweenPoint);
							}
						}
						for (var j:int = 0; j < gemsRing_2.length; j++) {
							
							TweenMax.to(gemsRing_2[j], 1, { x:gemsRing_2[j].getTargetTweenPoint().x, y:gemsRing_2[j].getTargetTweenPoint().y, onComplete:incrementCompleted } );
							function incrementCompleted():void{
								completedTweens++;
								if (completedTweens == gemsRing_2.length) {
									crash();
								}
							}
							
						}
					
						/*for each(var gemA:Gem in gemsRing_0) {
							//gemA.x -= 25;
							//object, time, destination, event when reach target
							TweenMax.to(gemA, 10, { x:0, y:0, onComplete:crash } );
							
							function crash():void {
								trace (":(");
							}
							
						}*/
					break;
				
			}
			
		//	trace("activeRotatingArray", activeRotatingArray);
		}
		
		public function crash():void {
			trace (":(");
			isKeysEnabled  = true;
			gemsRing_2.push(gemsRing_2.shift());
			for (var iiii:int = 0; iiii <  gemsRing_2.length ; iiii++ ) {
				var newTweenPoint:Point = getPositionOfGem(gemsRing_2, (iiii-1));
				gemsRing_2[iiii].setTargetTweenPoint(newTweenPoint);
				
			//	Gems(gemsRing_2[iiii]) getPositionOfGem(gemsRing_2, iiii);
			}
		}
		
		public function removeKeyListeners():void{
			Main.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		public function keyDownHandler(e:KeyboardEvent):void {
			
			if(isKeysEnabled == true){
				//trace(e.keyCode);
				if(e.keyCode == 32){
				//	Key_space=true;
				}//
				if(e.keyCode == 37){
					//Key_left_2=true;
					rotateArray();
					isKeysEnabled  = false;
					trace("keydown",e.keyCode);
					
				}
				if(e.keyCode == 38){
				//	Key_up_2=true;
				}
				if(e.keyCode == 39){
					//Key_right_2=true;
					isKeysEnabled  = false;
				}
				if(e.keyCode == 40){
					//Key_down_2=true;
				}
				//isKeysEnabled = false;
			}
		}
		
		public function keyUpHandler(e:KeyboardEvent):void {
			
			if(isKeysEnabled == false){
				
				if(e.keyCode == 32){
					//Key_space=false;
				}
				if(e.keyCode == 37){
					//Key_left_2 = false;
					//isKeysEnabled  = true;
					trace("keyup",e.keyCode);
					
				}
				if(e.keyCode == 38){
					//Key_up_2=false;
				}
				if(e.keyCode == 39){
					//Key_right_2=false;
					//isKeysEnabled  = true;
				}
				if(e.keyCode == 40){
					//Key_down_2=false;
				}
				//isKeysEnabled = true;
			}
		}
		
		
		
		public override function getArrayLength():int{
			return gemsRing_0.length;
		}
		
		public function getObjectAtIndex(index:int):Object{
			return gemsRing_0[index];
		}
		
		public override function getArray():Array{
			return gemsRing_0;
		}
	}
}