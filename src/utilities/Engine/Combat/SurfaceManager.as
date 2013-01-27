package utilities.Engine.Combat{
	

	import com.greensock.*;
	import flash.events.*;
	import flash.geom.*;
	import utilities.Actors.*;
	import utilities.Audio.*;
	import utilities.Engine.*;
	import utilities.Mathematics.*;
	
	
	
	
	public class SurfaceManager extends utilities.Engine.DefaultManager{
		public static const CIRCUMFERENCE:Number = 1413.71
		private var menboats:Array;

		public function SurfaceManager(){
			setUp();
		}
		
		public function setUp():void{
			createMenBoats();
		}
		
		private function createMenBoats():void {
			menboats = new Array();
			for (var i:int = 0; i < 8; i++ ) {
				var manboat:Manboat = new Manboat();
				manboat.x = Math.random() * CIRCUMFERENCE;
				menboats.push(manboat);
			}
			
		}		
		
		public override function updateLoop():void {
			for each (var manboat:Manboat in menboats) {
				manboat.move();
				if (manboat.puppet) {
					manboat.puppet.x = -manboat.x;
					manboat.puppet.y = -manboat.y;
					var angle:Number = 360 * (manboat.x / CIRCUMFERENCE);
					manboat.puppet.rotation = angle+90;
					var radians:Number =  MathFormulas.degreesToRadians(angle);
					manboat.puppet.x = Math.cos(radians) * 225 + GemManager.originPoint.x - manboat.x;
					manboat.puppet.y = Math.sin(radians) * 225 + GemManager.originPoint.y;
				}
			}
		}
		
	}
}