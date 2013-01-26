﻿package utilities.Engine{
	import flash.events.Event;
	import flash.display.MovieClip;
	import utilities.Screens.GameContainer;
	import utilities.Engine.Builders.LevelBuilder;
	import utilities.Engine.Builders.LootManager;
	import utilities.Engine.Combat.CombatManager;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Combat.GemManager;
	import utilities.Audio.SoundManager;
	import utilities.Actors.Avatar;
	import utilities.Mathematics.QuadTree;
	
	public class Game extends MovieClip{
		public static var theGame:Game;
		public static var gemManager:GemManager;
		public static var avatarManager:AvatarManager;
		public static var bulletManager:BulletManager;
		public static var enemyManager:EnemyManager;
		public static var combatManager:CombatManager;
		public static var lootManager:LootManager;
		public static var levelBuilder:LevelBuilder;
		public static var levelManager:LevelManager;
		public static var soundManager:SoundManager;
		public static var avatar:Avatar;
		private static var quadTree:QuadTree;
		private static var gamePaused:Boolean=true;
		
		//public var player:Player;
		public var hero:MovieClip;
		//Not adding objects directly to stage so that I can manipulate the world globally when needed
		//usually for things like zooming in and out, recentering the camera, etc.
		public static var gameContainer:MovieClip;
		
		public function Game():void{
			theGame = this;
			createGameContainer();
			createQuadTree();
			//startGame("debug");
		//	createHero();
		}
	
		private static function createGameContainer():void{
			gameContainer = new utilities.Screens.GameContainer();
			Main.theStage.addChild(gameContainer);
			
		}
		
		private static function createQuadTree():void{
			quadTree = new utilities.Mathematics.QuadTree();
		}
		
		//star the game from various places, such as a loaded game, new game, restarted game, etc.
		public static function startGame(startLocation:String):void{
			switch(startLocation){
				case "debug":
				
					trace("Started Game: From debug method");
					createManagersAndControllers();
					enableMasterLoop();
					break;
				case "start":
				
					trace("Started Game: From the Start Screen");
					createManagersAndControllers();
					enableMasterLoop();
					break;
				case "pause":
					enableMasterLoop();
					break;
				case "restart":
					//stop the loop while I clear everything out of it
					disableMasterLoop();
					//clear everything so it can be resetup
					clearGame();
					//recreate everything
					
					//restart the loop
					enableMasterLoop();
					break;
			}
			Main.returnFocusToGampelay();
		}
		
		public static function enableMasterLoop():void{
			gamePaused=false;
			gameContainer.addEventListener(Event.ENTER_FRAME, masterLoop);
		}
		
		public static function disableMasterLoop():void{
			gamePaused=true;
			gameContainer.removeEventListener(Event.ENTER_FRAME, masterLoop);
		}
		
		//clear everything out of the arrays
		//useful for restarting a level or the game
		public static function clearGame():void{
			
		}
		
		private static function createManagersAndControllers():void {
			createGameManagers();
		//	createLevelManager();
		//	createLevelBuilder();
		//	createAvatarManager();
			createBulletManager();
			createEnemyManager();
			createCombatManager();
		//	createLootManager();
			//createSoundManager();
		}
		
		private static function createGameManagers():void{
			gemManager = new GemManager();
		}
		
		private static function createLevelManager():void{
			levelManager = new LevelManager();
		}
		
		private static function createLevelBuilder():void{
			levelBuilder = new utilities.Engine.Builders.LevelBuilder();
		}
		
		private static function createAvatarManager():void{
			avatarManager = new AvatarManager();
		}
		
		private static function createBulletManager():void{
			bulletManager = new BulletManager();
		}
		
		private static function createEnemyManager():void{
			enemyManager = new EnemyManager();
		}
		
		private static function createCombatManager():void{
			combatManager = new CombatManager();
		}
		
		private static function createLootManager():void{
			lootManager = new LootManager();
		}
		
		private static function createSoundManager():void {
			trace("Game: createSoundManager");
			soundManager = new SoundManager();
		}
		
		
		
		private static function masterLoop(event:Event):void{
			if (!gamePaused) {
				updateGemManager();
			//	updateAvatarManager();
			//	updateBulletManager();
			//	updateEnemyManager();
			//	updateLootManager();
				//updateCombatManager();
				updateUIManager();
			}else{
				//can use this section for when the game is paused but I still need to update UI stuff
			}
		}
		
		private static function updateGemManager():void{
			gemManager.updateLoop();
		}
		
		private static function updateBulletManager():void{
			bulletManager.updateLoop();
		}
			
		private static function updateEnemyManager():void{
			enemyManager.updateLoop();
		}
		
		private static function updateLootManager():void{
			lootManager.updateLoop();
		}
		
		//for when you need to communicate things to the UI manager
		private static function updateUIManager():void{
			Main.uiManager.updateLoop();
		}
		
		//pause the update loops
		//pause any other specific things like, spawnTimes, decayRates etc. that are dependent on getTimer
		public static function pauseGame():void{
			gamePaused = true;
			bulletManager.pauseAllBulletTimes()
		}
		
		public static function resumeGame():void{
			gamePaused = false;
			bulletManager.resumeAllBulletTimes();
		}
		
		public static function getBulletManager():Object{
			return bulletManager;
		}
		
		public static function getGameContainer():MovieClip{
			return gameContainer;
		}
	}
}