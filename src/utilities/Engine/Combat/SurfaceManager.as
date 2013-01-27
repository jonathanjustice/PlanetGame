﻿package utilities.Engine.Combat{
	
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
		private var waves:Array;
		private var cities:Array;

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
			
			waves = new Array();
			for (var j:int = 0; j < 1; j++ ) {
				var wave:Wave = new Wave();
				wave.x = Math.random() * CIRCUMFERENCE;
				waves.push(wave);
			}
			
			cities = new Array();
			for (var i:int = 0; i < 1; i++ ) {
				var city:City = new City();
				city.x = Math.random() * CIRCUMFERENCE;
				city.move();
				cities.push(city);
			}
			
		}
		
		public function addManboat(manboat:Manboat) {
			menboats.push(manboat);
		}
		
		public override function updateLoop():void {
			var angle:Number;
			var radians:Number;
			
			for each (var manboat:Manboat in menboats) {
				manboat.move(GemManager.planet.data);
			}
			
			
			for each (var wave:Wave in waves) {
				wave.move();
				if (wave.puppet) {
					wave.puppet.x = -wave.x;
					wave.puppet.y = -wave.y;
					angle = 360 * (wave.x / CIRCUMFERENCE);
					wave.puppet.rotation = angle+90;
					radians =  MathFormulas.degreesToRadians(angle);
					wave.puppet.x = Math.cos(radians) * 240 + GemManager.originPoint.x - wave.x;
					wave.puppet.y = Math.sin(radians) * 240 + GemManager.originPoint.y;
				}
				
				for each (var manboat2:Manboat in menboats) {
					if (manboat2.getBoundingRect().intersects(wave.getBoundingRect())) {
						manboat2.removeActorFromGameEngine(manboat2, menboats);
						//add score for each man murdered
						utilities.Engine.UIManager.addToScore(50);
					}
				}
				
				
				for each (var city:City in cities) {
					city.tick(this);
				}
				
				
			}
			
			
		}
		
	}
}