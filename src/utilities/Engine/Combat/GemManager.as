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
	import com.greensock.TweenMax;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	import com.greensock.*;
	import flash.events.*;
	import flash.geom.*;
	import utilities.Actors.*;
	import utilities.Engine.*;
	import utilities.Mathematics.*;
	import utilities.Audio.*;
	
	public class GemManager extends utilities.Engine.DefaultManager {
		private var gameStarted:Boolean = false;
		private var turnStartedTime:Number = 0;
		private var turnLength:Number = 100;
		//private var turnLength:Number = 1.5e4;
		private var maxTurns:int = 4;
		private var turnSequence:Array = new Array();
		private var currentTurn:int = 0;
		public static var activeRotatingArray:int = 2;
		public static var gemsRing_0:Array=new Array();
		public static var gemsRing_1:Array=new Array();
		public static var gemsRing_2:Array=new Array();
		private static var gemRingSize_0:int = 4;
		private static var gemRingSize_1:int = 8;
		private static var gemRingSize_2:int = 16;
		public static var originPoint:Point = new Point(300, 300);
		private var isKeysEnabled:Boolean = true;
		private var planet:Planet;
		public function GemManager(){
			setUp();
			Main.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			isKeysEnabled = true;
			turnSequence = [2, 1, 0, 1, 2];
			setTurnStartTime();
			gameStarted = true;
		}
		
		public function setUp():void{
			createNewRings();
		}
		
		private function createNewRings():void {
			planet = new Planet();
			planet.x = originPoint.x;
			planet.y = originPoint.y;

			for (var i:int = 0; i < gemRingSize_0; i++) {
				addRandomGemToRing(gemsRing_0);
			}
			for (var j:int = 0; j < gemRingSize_1; j++) {
				addRandomGemToRing(gemsRing_1);
			}
			for (var k:int = 0; k < gemRingSize_2; k++) {
				addRandomGemToRing(gemsRing_2);
			}
			arrangeMyGems(gemsRing_0,0);
			arrangeMyGems(gemsRing_1,1);
			arrangeMyGems(gemsRing_2,2);
		}
		
		private function obliterateAllGems():void {
			//trace("BEFORE obliterateAllGems");
			while (gemsRing_0.length) {
				gemsRing_0[0].removeActorFromGameEngine(gemsRing_0[0],gemsRing_0);
			}
			while (gemsRing_1.length) {
				//trace("PARENT:", gemsRing_1[0].parent);
				gemsRing_1[0].removeActorFromGameEngine(gemsRing_1[0],gemsRing_1);
			}
			while (gemsRing_2.length) {
				gemsRing_2[0].removeActorFromGameEngine(gemsRing_2[0],gemsRing_2);
			}
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
			positionOfGem.x = Math.cos(angle) * ((41 * ringNumber) + 72)+ originPoint.x;
			positionOfGem.y = Math.sin(angle)  * ((41 * ringNumber) + 72) + originPoint.y;
			return positionOfGem;
		}
		
		private function arrangeMyGems(ringArray:Array, ringNumber:int):void {
			for (var i:int = 0; i < ringArray.length; i++) {
				var angle:Number =  MathFormulas.degreesToRadians(360 * ((i + 0.5) / ringArray.length));
				//trace("angle", angle);
				//trace("ringArray[i]", ringArray[i]);
				//trace("originPoint",originPoint);
				ringArray[i].x = Math.cos(angle) * ((41 * ringNumber) + 72)+ originPoint.x;
				ringArray[i].y = Math.sin(angle)  * ((41 * ringNumber) + 72) + originPoint.y;
				var gemPoint:Point = new Point();
				gemPoint.x = ringArray[i].x;
				gemPoint.y = ringArray[i].y;
			}
		}
		
		private function addRandomGemToRing(ringArray:Array):void {
			var gem:Gem = new Gem("random");
			ringArray.push(gem);
		}
		
		public override function updateLoop():void {
			if (gameStarted) {
				checkForTurnTimeExpired();
			}
		}
		
		private function rotateArrayLeft(gemArray:Array):void {
			var tweenPoint:Point = new Point();
			var completedTweens:int = 0;
			SoundManager.stoneSound.playSound(1, 1);
			for (var i:int = 0; i < gemArray.length; i++) {
				if (i == 0) {
					tweenPoint = getPositionOfGem(gemArray, gemArray.length-1);
					gemArray[i].setTargetTweenPoint(tweenPoint);
				}else {
					tweenPoint = getPositionOfGem(gemArray, (i-1));
					gemArray[i].setTargetTweenPoint(tweenPoint);
				}
			}
			for (var j:int = 0; j < gemArray.length; j++) {

				TweenMax.to(gemArray[j], 1, { x:gemArray[j].getTargetTweenPoint().x, y:gemArray[j].getTargetTweenPoint().y, onComplete:resetGems } );
				function resetGems():void{
					completedTweens++;
					if (completedTweens == gemArray.length) {
						resetRingsLeft(gemArray);
						completedTweens = 0;
					}
				}
			}
		}
		
		private function rotateArrayRight(gemArray:Array):void {
			var tweenPoint:Point = new Point();
			var completedTweens:int = 0;
			SoundManager.stoneSound.playSound(1, 1);
			for (var i:int = 0; i < gemArray.length; i++) {
				if (i == gemArray.length-1) {
					tweenPoint = getPositionOfGem(gemArray, 0);
					gemArray[i].setTargetTweenPoint(tweenPoint);
				}else {
					tweenPoint = getPositionOfGem(gemArray, (i+1));
					gemArray[i].setTargetTweenPoint(tweenPoint);
				}
			}
			for (var j:int = 0; j < gemArray.length; j++) {
				
				TweenMax.to(gemArray[j], 1, { x:gemArray[j].getTargetTweenPoint().x, y:gemArray[j].getTargetTweenPoint().y, onComplete:resetGems } );
				function resetGems():void{
					completedTweens++;
					if (completedTweens == gemArray.length) {
						resetRingsRight(gemArray);
						completedTweens = 0;
					}
				}
			}
		}
		
		private function resetRingsLeft(ringsArray:Array):void {
			isKeysEnabled  = true;
			ringsArray.push(ringsArray.shift());
			for (var iiii:int = 0; iiii <  ringsArray.length ; iiii++ ) {
				var newTweenPoint:Point = getPositionOfGem(ringsArray, (iiii-1));
				ringsArray[iiii].setTargetTweenPoint(newTweenPoint);
			}
			setAllMatchesTofalse(gemsRing_0);
			setAllMatchesTofalse(gemsRing_1);
			setAllMatchesTofalse(gemsRing_2);
			checkForMatches();
		}
		
		private function resetRingsRight(ringsArray:Array):void {
			isKeysEnabled  = true;
			ringsArray.unshift(ringsArray.pop());
			for (var iiii:int = 0; iiii <  ringsArray.length ; iiii++ ) {
				var newTweenPoint:Point = getPositionOfGem(ringsArray, (iiii-1));
				ringsArray[iiii].setTargetTweenPoint(newTweenPoint);
			}
			setAllMatchesTofalse(gemsRing_0);
			setAllMatchesTofalse(gemsRing_1);
			setAllMatchesTofalse(gemsRing_2);
			checkForMatches();
		}
		
		private function setAllMatchesTofalse(ringsArray:Array):void {
			for (var i:int = 0; i < ringsArray.length; i++ ) {
				ringsArray[i].setIsMatching(false);
			}
		}
		
		private function checkForMatches():void {
			//for gem in the outer circe, take its index / divide it by 2 and floor it to get the one below
			for (var i:int = 0; i < gemsRing_2.length; i++ ) {
				if (gemsRing_2[i].getGemType() == gemsRing_1[~~(i / 2)].getGemType() ) {
					if (gemsRing_1[~~(i / 2)].getGemType() == gemsRing_0[~~(i / 4)].getGemType()) {
						//return true;
						gemsRing_2[i].setIsMatching(true);
						gemsRing_1[~~(i / 2)].setIsMatching(true);
						gemsRing_0[~~(i / 4)].setIsMatching(true);
					}
				}
			}
		}
		
		private function createNewGem(ringArray:Array, spawnPosition:Point, pointToTweenTo:Point,gemType:String):Gem {
			var gem:Gem = new Gem(gemType);
			gem.x = spawnPosition.x;
			gem.y = spawnPosition.y;
			gem.setTargetTweenPoint(pointToTweenTo);
			ringArray.push(gem);
			return gem;
		}
		
		//move the rings out to the next level
		private function growRingsOut():void {
			var tempRing2:Array = new Array();
			var tempRing1:Array = new Array();
			var tempRing0:Array = new Array();
			//trace("GROW RINGS OUT");
			var order:int;
		
			//put all the gems in level 1 into level 2
			for (var i:int = 0; i < gemsRing_1.length; i++ ) {
				trace(i,gemsRing_1.length);
				//move all these up to level 2
				//for every gem, put 2 gems into the array, randomize whice one to put first
				order = Math.round(Math.random() * 1);
				var somePoint:Point = new Point(0, 0);
				trace("define new gems");
				
				if (order == 1) {
					var gem1A:Object = createNewGem( tempRing2, gemsRing_1[i].getPosition(), somePoint , gemsRing_1[i].getGemType());
					var randomGem1A:Gem = createNewGem( tempRing2, gemsRing_1[i].getPosition(), somePoint, "random");
				}else {
					var randomGem1B:Gem = createNewGem( tempRing2, gemsRing_1[i].getPosition(), somePoint, "random");
					var gem1B:Object = createNewGem( tempRing2, gemsRing_1[i].getPosition(), somePoint , gemsRing_1[i].getGemType());
				}
				
				trace("new gems defined");
			}
			
			for (var r:int = 0; r < gemsRing_0.length; r++ ) {
				order = Math.round(Math.random() * 1);
				var gemType2:String = gemsRing_0[r].getGemType();
				var gem2:Gem = new Gem(gemType2);
				if (order == 1) {
					var gem2A:Object = createNewGem( tempRing1, gemsRing_0[r].getPosition(), somePoint , gemsRing_0[r].getGemType());
					var randomGem2A:Gem = createNewGem( tempRing1, gemsRing_0[r].getPosition(), somePoint, "random");
				}else {
					var randomGem2B:Gem = createNewGem( tempRing1, gemsRing_0[r].getPosition(), somePoint, "random");
					var gem2B:Object = createNewGem( tempRing1, gemsRing_0[r].getPosition(), somePoint , gemsRing_0[r].getGemType());
				}
			}
			for (var z:int = 0; z < gemRingSize_0; z++) {
				var randomGem3A:Gem = createNewGem( tempRing0, originPoint, somePoint, "random");
			}
			trace("BEFORE");
			trace(gemsRing_2);
			trace(gemsRing_1);
			trace(gemsRing_0);
			obliterateAllGems();
			
			trace("AFTER");
			trace(gemsRing_2);
			trace(gemsRing_1);
			trace(gemsRing_0);
			gemsRing_2 = tempRing2;
			gemsRing_1 = tempRing1;
			gemsRing_0 = tempRing0;
			
		
			arrangeMyGems(gemsRing_2,2);
			arrangeMyGems(gemsRing_1, 1);
			arrangeMyGems(gemsRing_0, 0);
			trace("done arranging all gems");
			isKeysEnabled = true;
		}
		
		private function resolveMatches(ringsArray:Array):void {
			trace("Before resolveMatches",ringsArray);
			for (var i:int = 0; i < ringsArray.length; i++ ) {
				if (ringsArray[i].getIsMatching()) {
					var gem:Gem = new Gem("blue");
					gem.x = ringsArray[i].x;
					gem.y = ringsArray[i].y;
					ringsArray[i].replaceActorInGameEngine(ringsArray[i],ringsArray,gem);
				}
			}
			trace("After resolveMatches",ringsArray);
		}
		private function incrementTurnSequence():void {
			currentTurn++;
			activeRotatingArray = turnSequence[currentTurn];
			trace("incrementTurnSequence: currentTurn:",currentTurn);
			if (currentTurn > maxTurns) {
				trace("turn sequence has ended:",currentTurn);
				for (var i:int = 0; i < gemsRing_2.length; i++ ) {
					gemsRing_2[i].triggerMatchEvent();
				}
				resolveMatches(gemsRing_0);
				resolveMatches(gemsRing_1);
				resolveMatches(gemsRing_2);
				currentTurn = 0;
				activeRotatingArray = turnSequence[currentTurn];
				growRingsOut();
			}
			planet.setFrame("_"+activeRotatingArray);
		}
		
		private function removeKeyListeners():void{
			Main.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void {
			if(isKeysEnabled == true){
				if(e.keyCode == 32){
				//	obliterateAllGems();
				}
				if (e.keyCode == 37) {
					if (activeRotatingArray == 0) {
						rotateArrayLeft(gemsRing_0);
					}
					if (activeRotatingArray == 1) {
						rotateArrayLeft(gemsRing_1);
					}
					if (activeRotatingArray == 2) {
						rotateArrayLeft(gemsRing_2);
					}
					isKeysEnabled  = false;
				}
				if(e.keyCode == 38){
				//	createNewRings();
				}
				if(e.keyCode == 39){
					if (activeRotatingArray == 0) {
						rotateArrayRight(gemsRing_0);
					}
					if (activeRotatingArray == 1) {
						rotateArrayRight(gemsRing_1);
					}
					if (activeRotatingArray == 2) {
						rotateArrayRight(gemsRing_2);
					}
					isKeysEnabled  = false;
				}
				if(e.keyCode == 40){
					//Key_down_2=true;
				}
				if(e.keyCode == 49){
					activeRotatingArray = 0;
				}
				if(e.keyCode == 50){
					activeRotatingArray = 1;
				}
				if(e.keyCode == 51){
					activeRotatingArray = 2;
				}
			}
		}
		
		private function keyUpHandler(e:KeyboardEvent):void {
			if(isKeysEnabled == false){
				
				if(e.keyCode == 32){
				}
				if(e.keyCode == 37){
					
				}
				if(e.keyCode == 38){
				}
				if(e.keyCode == 39){
				}
				if(e.keyCode == 40){
				}
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
		
		private function setTurnStartTime():void{
			turnStartedTime = getTimer();
		}
		
		private function checkForTurnTimeExpired():void{
			var currentTime:uint = getTimer();
			if(currentTime > turnStartedTime + turnLength){
				incrementTurnSequence();
				setTurnStartTime();
			}
		}
	}
}