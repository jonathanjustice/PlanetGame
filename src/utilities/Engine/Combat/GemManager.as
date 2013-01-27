﻿package utilities.Engine.Combat{
	

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
	import com.greensock.*;
	import flash.events.*;
	import flash.geom.*;
	import utilities.Actors.*;
	import utilities.Engine.*;
	import utilities.Mathematics.*;
	import utilities.Audio.*;
	
	public class GemManager extends utilities.Engine.DefaultManager{
		
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
		private static var originPoint:Point = new Point(300, 300);
		private var isKeysEnabled:Boolean = true;
		private var planet:Planet;
		public function GemManager(){
			setUp();
			Main.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			isKeysEnabled = true;

			turnSequence = [2, 1, 0, 1, 2];

			var a:SoundManager = new SoundManager();

		}
		
		public function setUp():void{
			createNewRings();
		}
		
		private function createNewRings():void {

			planet = new Planet();
			planet.x = originPoint.x;
			planet.y = originPoint.y;

			for (var i:int = 0; i < gemRingSize_0; i++) {
				addGemToRing(gemsRing_0);
			}
			for (var j:int = 0; j < gemRingSize_1; j++) {
				addGemToRing(gemsRing_1);
			}
			for (var k:int = 0; k < gemRingSize_2; k++) {
				addGemToRing(gemsRing_2);
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
			var angle:Number =  MathFormulas.degreesToRadians(360*((i+0.5)/ringArray.length));

			positionOfGem.x = Math.cos(angle) * ((41 * ringNumber) + 72)+ originPoint.x;
			positionOfGem.y = Math.sin(angle)  * ((41 * ringNumber) + 72) + originPoint.y;
			return positionOfGem;
		}
		
		private function arrangeMyGems(ringArray:Array, ringNumber:int):void {
			
			for (var i:int = 0; i < ringArray.length; i++) {
				var angle:Number =  MathFormulas.degreesToRadians(360*((i+0.5)/ringArray.length));
				ringArray[i].x = Math.cos(angle) * ((41 * ringNumber) + 72)+ originPoint.x;
				ringArray[i].y = Math.sin(angle)  * ((41 * ringNumber) + 72) + originPoint.y;
				var gemPoint:Point = new Point();
				gemPoint.x = ringArray[i].x;
				gemPoint.y = ringArray[i].y;
				//ringArray[i].rotation = MathFormulas.getAngle(gemPoint, originPoint);
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
			ringsArray.unshift(ringsArray.pop())
		//	ringsArray.push(ringsArray.shift());
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
			
			incrementTurnSequence();
			//checkForTurnSequenceOver();
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
				currentTurn = 0;
				activeRotatingArray = turnSequence[currentTurn];
			}
			planet.setFrame("_"+activeRotatingArray);
		}
		
		private function checkForTurnSequenceOver():void {
			
		}
		
		private function removeKeyListeners():void{
			Main.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void {
		
			if(isKeysEnabled == true){
				if(e.keyCode == 32){
					obliterateAllGems();
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
					createNewRings();
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
	}
}