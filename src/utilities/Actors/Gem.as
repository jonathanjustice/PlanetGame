﻿/*
You can access another manager this way:
Game.avatarManager.doSomeFunction();
*/
package utilities.Actors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Actors.Actor;
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	
	public class Gem extends Actor{
		private var pausedTime:Number = 0;//for pausing the game
		private var gamePausedAtTime:Number = 0;
		public var damage:Number=20;
		private var targetTweenPoint:Point = new Point();
		private var gemType:String = "";
		private var isMatching:Boolean=false;
	
		public function Gem(){
			setUp();
		}
		
		
		public function setUp():void{
			addActorToGameEngine();

			setGemType();
			addChild(Main.getClassFromSWF("assets", gemType));
		}
		
		//the enter frame, does everything
		public function updateLoop():void{
			checkForDeathFlag();
		}
			
		public function setTargetTweenPoint(target:Point):void {
			targetTweenPoint = target;
		}
		
		public function getTargetTweenPoint():Point {
			return targetTweenPoint;
		}
		
		
		//TEMPORARY
		private function setGemType():void {
			var randomNumber:Number = Math.floor(Math.random() * 6);
			switch (randomNumber) {
				case 0:
					gemType = "blue";
					break;
				case 1:
					gemType = "green";
					break;
				case 2:
					gemType = "purple";
					break;
				case 3:
					gemType = "gold";
					break;
				case 4:
					gemType = "silver";
					break;
				case 5:
					gemType = "copper";
					break;
			}
		}
		
		public function getGemType():String {
			return gemType;
		}
		
		public function setIsMatching(boo:Boolean):void {
			isMatching = boo;
			highlightMatches();
		}
		
		private function highlightMatches():void {
			if (isMatching) {
				this.alpha = 0.5;
			}else {
				this.alpha = 1;
			}
		}
		
		public override function defineProperties():void{
			//classes to get behaviors from
			
			//define visuals of the bullet based on its properties
		
		}
		
		
			
	}
}