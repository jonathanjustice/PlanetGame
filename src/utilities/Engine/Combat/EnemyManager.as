package utilities.Engine.Combat{
	
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Mathematics.MathFormulas;
	import utilities.Screens.xpBarSystem;
	import utilities.Actors.Enemy;
	import utilities.Actors.Bullet;
	public class EnemyManager extends utilities.Engine.DefaultManager{
		public static var enemies:Array;
		private var xVelocity:Number;
		private var yVelocity:Number;
		private var velocityMultiplier:Number;
		private var avatar:Point = new Point();
		public var numEnemies:Number=0;
		//private static var enemyFactory = new Factory_Enemy();
		public static var shittyTimer:int = 0;
		
		private static var numnum:Number=0;
		
		public function EnemyManager(){
			setUp();
		}
		
		public function setUp():void{
			numnum = 0;
			enemies =[];
			placeholderValues();
		}
		
		private function placeholderValues():void{
			velocityMultiplier = 1;
			xVelocity = 1;
			yVelocity = 1;
		}
		
		//FPO way to create enemies
		//check the enemies for collisions with bullets
		public override function updateLoop():void{
			if(numnum < 999){
				shittyTimer++;
				if(shittyTimer ==25){
					shittyTimer = 0;
					createNewEnemy();
				}
			}
			checkForCollisionWithBullets();
		}
		
		public static function createNewEnemy():void{
			var enemy:Enemy = new Enemy();
			enemies.push(enemy);
			//give the bullet some placeholder properties
			enemy.x = Math.random()*500;
			enemy.y = Math.random()*200;
			//var enemyGraphics = enemyFactory.GenerateBody();
			
			//placeholder debug var
			numnum+=1;
		}
		
		public static function checkForCollisionWithBullets():void{
			for each(var enemy:Enemy in enemies){
				enemy.updateLoop();
				for each(var bullet:Bullet in BulletManager.bullets){
					//if(enemy.getQuadTreeNode() == bullet.getQuadTreeNode()){
						//this whole minDist business really should get pushed down into the math formulas, its confusing to read
						//perhaps i need to break it into to 2 functions, one that returns and that doesn't
						var minDist:Number = (bullet.width/2 + enemy.width/2) * (bullet.width/2 + enemy.width/2);
						if(MathFormulas.distanceFormulaOptimized(bullet,enemy) < minDist){
							enemy.markDeathFlag();
							bullet.markDeathFlag();
						}
					//}
				}
			}
		}
		
		public override function getArrayLength():int{
			return enemies.length;
		}
		
		public function getObjectAtIndex(index:int):Object{
			return enemies[index];
		}
		
		public override function getArray():Array{
			return enemies;
		}
	}
}