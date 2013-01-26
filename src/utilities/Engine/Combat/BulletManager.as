﻿/*
FYI:
access other managers:Game.manager name



*/


package utilities.Engine.Combat{
	
	import utilities.Engine.DefaultManager;
	import utilities.Actors.Actor;
	import utilities.Actors.Avatar;
	import utilities.Actors.Bullet;
	import utilities.Engine.Game;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class BulletManager extends utilities.Engine.DefaultManager{
		
		public static var bullets:Array;
		private var gameTimer:Timer = new Timer(0,0);
		private static var currentDelay:int = 0;
		private static var delay:int = 1;
		public function BulletManager(){
			setUp();			
		}
		
		public function setUp():void{
			gameTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			bullets =[];
		}
		
		private function timerHandler(e:TimerEvent):void{
			
		}
		
		public override function updateLoop():void{
			
			for each(var bullet:Bullet in bullets){
				bullet.updateLoop();
			}
			if_shooting_create_a_new_bullet();
		}
		
		public static function if_shooting_create_a_new_bullet():void{
			if(Main.keyInputManager.getRightBracket() == true){
				currentDelay ++;
				if(currentDelay >= delay){
					currentDelay = 0;
					createNewBullet();
					//trace("BulletManager: createBullet");
				}
			}
		}
		
		public static function createNewBullet():void{
			var newBullet:Bullet = new Bullet()
			bullets.push(newBullet);
		}
		
		/*THIS SHOULD BE FURTHER ABSTRACTED*/
		//pause the bullets & the times at which they were create(for if they have a lifespan)
		//pass in the array and possibly the type, if no type is passed, then it should just pause everything in the array
		public function pauseAllBulletTimes():void{
			for each(var bullet:utilities.Actors.Bullet in bullets){
				bullet.pauseBulletTime();
			}
		}
		
		public override function getArrayLength():int{
			return bullets.length-1;
		}
		
		public override function getArray():Array{
			return bullets;
		}
		
		public override function testFunction():void{
			trace("BulletManager: testFunction");
		}
		
		//resume the bullets & the times at which they were paused
		public function resumeAllBulletTimes():void{
			/*for each(var bullet:utilities.Actor.Bullet in bullets){
				bullet.resumeBulletTime();
			}*/
		}
		
	}
}