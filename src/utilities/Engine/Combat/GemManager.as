package utilities.Engine.Combat{
	

	import com.greensock.plugins.EndVectorPlugin;
	import utilities.Actors.Gem;
	import utilities.Engine.UIManager;
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
		private var isMatchesResolved:Boolean = true;
		private var gameStarted:Boolean = false;
		private var turnStartedTime:Number = 0;
		private var rockWaitTime:Number = 2500;
		private var resolveStartedTime:Number = 0;
		private var resolveLength:Number = 5000;
		private var isResolvingMatches:Boolean = false;
		private var turnLength:Number = 3000;
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
		private var innerTweensComplete:Boolean = true;
		private var middleTweensComplete:Boolean = true;
		private var outerTweensComplete:Boolean = true;
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
			checkForMatches();
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
			while (gemsRing_0.length) {
				gemsRing_0[0].removeActorFromGameEngine(gemsRing_0[0],gemsRing_0);
			}
			while (gemsRing_1.length) {
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
			var angle:Number =  MathFormulas.degreesToRadians(360 * ((i + 0.5) / ringArray.length));
			positionOfGem.x = Math.cos(angle) * ((41 * ringNumber) + 72)+ originPoint.x;
			positionOfGem.y = Math.sin(angle)  * ((41 * ringNumber) + 72) + originPoint.y;
			return positionOfGem;
		}
		
		private function arrangeMyGems(ringArray:Array, ringNumber:int):void {
			for (var i:int = 0; i < ringArray.length; i++) {
				var angle:Number =  MathFormulas.degreesToRadians(360 * ((i + 0.5) / ringArray.length));
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
			var order:int;
		
			//put all the gems in level 1 into level 2
			for (var i:int = 0; i < gemsRing_1.length; i++ ) {
			
				order = Math.round(Math.random() * 1);
				var somePoint:Point = new Point(0, 0);
				
				if (order == 1) {
					//array to be put in, spawn poisition, point to spawn to, result
					var gem1A:Object = createNewGem(tempRing2, gemsRing_1[i].getPosition(), getPositionOfGem(gemsRing_2, (i*2)) , gemsRing_1[i].getGemType());
					var randomGem1A:Gem = createNewGem( tempRing2, gemsRing_1[i].getPosition(), getPositionOfGem(gemsRing_2,((i*2)+1)), "random");
				}else {
					var randomGem1B:Gem = createNewGem(tempRing2, gemsRing_1[i].getPosition(),  getPositionOfGem(gemsRing_2,(i*2)), "random");
					var gem1B:Object = createNewGem( tempRing2, gemsRing_1[i].getPosition(), getPositionOfGem(gemsRing_2, ((i*2)+1)) , gemsRing_1[i].getGemType());
					
				}
			}
			for (var r:int = 0; r < gemsRing_0.length; r++ ) {
				order = Math.round(Math.random() * 1);
				var gemType2:String = gemsRing_0[r].getGemType();
				var gem2:Gem = new Gem(gemType2);
				if (order == 1) {
					var gem2A:Object = createNewGem( tempRing1, gemsRing_0[r].getPosition(), getPositionOfGem(gemsRing_1,((r*2))) , gemsRing_0[r].getGemType());
					var randomGem2A:Gem = createNewGem( tempRing1, gemsRing_0[r].getPosition(),  getPositionOfGem(gemsRing_1,((r*2)+1)), "random");
				}else {
					var randomGem2B:Gem = createNewGem( tempRing1, gemsRing_0[r].getPosition(),  getPositionOfGem(gemsRing_1,(r*2)), "random");
					var gem2B:Object = createNewGem( tempRing1, gemsRing_0[r].getPosition(),  getPositionOfGem(gemsRing_1,((r*2)+1)) , gemsRing_0[r].getGemType());
				}
			}
			for (var z:int = 0; z < gemRingSize_0; z++) {
				var randomGem3A:Gem = createNewGem( tempRing0, originPoint,  getPositionOfGem(gemsRing_0,z), "random");
			}
			
			
			
			
			
			
			
			
			obliterateAllGems();
			gemsRing_2 = tempRing2;
			gemsRing_1 = tempRing1;
			gemsRing_0 = tempRing0;
			
			tweenGemsAfterTurnSequenceComplete(gemsRing_0);
			tweenGemsAfterTurnSequenceComplete(gemsRing_1);
			tweenGemsAfterTurnSequenceComplete(gemsRing_2);
			isKeysEnabled = true;
			
			//clearing out the temporary arrays
		/*	while (tempRing0.length) {
				tempRing0[0].removeActorFromGameEngine(tempRing0[0],tempRing0);
			}
			while (tempRing1.length) {
				tempRing1[0].removeActorFromGameEngine(tempRing1[0],tempRing1);
			}
			while (tempRing2.length) {
				tempRing2[0].removeActorFromGameEngine(tempRing2[0],tempRing2);
			}*/
		}
		
		private function tweenGemsAfterTurnSequenceComplete(gemArray:Array):void {
				//object to tween, speed, target, result
			for (var i:int = 0; i < gemArray.length; i++){
			var completedTweens:int = 0;
			TweenMax.to(gemArray[i], 1, { x:gemArray[i].getTargetTweenPoint().x, y:gemArray[i].getTargetTweenPoint().y, onComplete:markTurnSequenceComplete } );
				function markTurnSequenceComplete():void{
					completedTweens++;
					if (completedTweens == gemArray.length) {
						if (gemArray == gemsRing_0) {
							innerTweensComplete = true;
						}
						if (gemArray == gemsRing_1) {
							middleTweensComplete = true;
						}
						if (gemArray == gemsRing_2) {
							outerTweensComplete = true;
						}
						completedTweens = 0;
						resetTurnSequence();
					}
				}
			}
		}
		
		public override function updateLoop():void {
			if (gameStarted) {
				if (!isResolvingMatches) {
					checkForTurnTimeExpired();
				}else {
					isKeysEnabled = false;
					checkForResolveTimeExpired();
				}
			}
		}
		
		private function checkForResolveTimeExpired():void {
			//trace("checkForResolveTimeExpired");
			var currentTime:uint = getTimer();
			if (currentTime > resolveStartedTime + rockWaitTime) {
				if (!isMatchesResolved) {
					resolveMatches(gemsRing_0);
					resolveMatches(gemsRing_1);
					resolveMatches(gemsRing_2);
				}
			}
			if (currentTime > resolveStartedTime + resolveLength + rockWaitTime) {
				isResolvingMatches = false;
				isMatchesResolved = true;
				growRingsOut();
			}	
		}
			
		private function resetTurnSequence():void {
			if (innerTweensComplete && middleTweensComplete && outerTweensComplete) {
				isKeysEnabled  = true;
				setAllMatchesTofalse(gemsRing_0);
				setAllMatchesTofalse(gemsRing_1);
				setAllMatchesTofalse(gemsRing_2);
				checkForMatches();
				setTurnStartTime();
				
			}
		}
		
		private function incrementTurnSequence():void {
			currentTurn++;
			activeRotatingArray = turnSequence[currentTurn];
			//trace("incrementTurnSequence: currentTurn:",currentTurn);
			if (currentTurn > maxTurns) {
			//	trace("turn sequence has ended:",currentTurn);
				for (var i:int = 0; i < gemsRing_2.length; i++ ) {
					gemsRing_2[i].triggerMatchEvent();
				}
				startResolvingMatches();
				currentTurn = 0;
				activeRotatingArray = turnSequence[currentTurn];
			//	growRingsOut();
			}
			planet.setFrame("_"+activeRotatingArray);
		}
		
		private function startResolvingMatches():void {
			isMatchesResolved = false;
			//trace("startResolvingMatches");
			resolveStartedTime = getTimer();
			
			activateMatches(gemsRing_0);
			activateMatches(gemsRing_1);
			activateMatches(gemsRing_2);
			isResolvingMatches = true;
		}
		
		private function activateMatches(ringsArray:Array):void {
			//trace("activateMatches");
			for (var i:int = 0; i < ringsArray.length; i++ ) {
				if (ringsArray[i].getIsMatching()) {
					//do a highlight thing to 
					ringsArray[i].activateFinalMatchHighlightState();
				}
			}
		}
		
		private function resolveMatches(ringsArray:Array):void {
			//trace("resolveMatches");
			for (var i:int = 0; i < ringsArray.length; i++ ) {
				if (ringsArray[i].getIsMatching()) {
					var gem:Gem = new Gem("rock");
					gem.x = ringsArray[i].x;
					gem.y = ringsArray[i].y;
					ringsArray[i].replaceActorInGameEngine(ringsArray[i],ringsArray,gem);
				}
			}
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
				if (e.keyCode == 38) {
					
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