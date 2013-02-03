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
		private var waves:Array;
		private var volcanos:Array;
		private var cities:Array;
		public static var nodeDenomenator:Number = 360/16;
		public static var inst:SurfaceManager;
		public function SurfaceManager(){
			setUp();
			inst = this;
		}
		
		public function setUp():void{
			createMenBoats();
			createStartingCities();
		}
		
		private function createMenBoats():void {
			menboats = new Array();
			volcanos = new Array();
			waves = new Array();
			cities = new Array();
			
		}
		
		private function createStartingCities():void {
			var i:int = 0;
			while(i<3){
				
				//var angle:Number = 360 * ((Math.random() * CIRCUMFERENCE) / SurfaceManager.CIRCUMFERENCE);
				var node:int = Probability.generateRandomValue(0, 15)
				//if there is not already a city in that tile
				if (GemManager.planet.cityNodes[node] === 0) {
					if(GemManager.planet.data[node] === "land") {
						var city:City = new City();
						city.x = (node * nodeDenomenator) - 11.25;
					//	city.x = Math.random() * CIRCUMFERENCE;
						city.move();
						cities.push(city);
						trace("node:", node,"it was land");
						GemManager.planet.cityNodes[node] = 1;
						i++;
					}
				}
					trace(GemManager.planet.cityNodes);
			}
		}
		
		public function makeCity(xLoc:Number):void {
			
			var city:City = new City();
			city.x = xLoc;
			city.move();
			cities.push(city);
			var i:int = city.get360FormattedAngle()/nodeDenomenator;
			trace("node:", i);
			GemManager.planet.cityNodes[i] = 1;
		}
		
		public function addManboat(manboat:Manboat):void {
			menboats.push(manboat);
		}
		
		
		public function makeWaves(angle:Number):void {
			
			var wave1:Wave = new Wave(false);
			wave1.x = (angle / 360) * CIRCUMFERENCE;
			
			var wave2:Wave = new Wave(true);
			waves.push(wave1,wave2)
		}
		
	
		
		public function makeVolcano(angle:Number):void {
			
			
			var volcano:Volcano = new Volcano(false);
			volcano.x = (angle / 360) * CIRCUMFERENCE;
			
			volcanos.push(volcano);
		}
		
		public override function updateLoop():void {
			var angle:Number;
			var radians:Number;
			
			for each (var manboat:Manboat in menboats) {
				manboat.move(GemManager.planet.data);
				
				if (manboat.getTurnedIntoCity()) {
					manboat.removeActorFromGameEngine(manboat, menboats);
				}
			}
			
			for each (var volcano:Volcano in volcanos) {
				volcano.move();
				if (volcano.puppet) {
					volcano.puppet.x = -volcano.x;
					volcano.puppet.y = -volcano.y;
					angle = 360 * (volcano.x / CIRCUMFERENCE);
					volcano.puppet.rotation = angle+90;
					radians =  MathFormulas.degreesToRadians(angle);
					volcano.puppet.x = Math.cos(radians) * 240 + GemManager.originPoint.x - volcano.x;
					volcano.puppet.y = Math.sin(radians) * 240 + GemManager.originPoint.y;
				}
				if (volcano.decay < 0) {
					volcano.removeActorFromGameEngine(volcano, volcanos);
				}
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
				if (wave.decay < 0) {
					wave.removeActorFromGameEngine(wave, waves);
				}
				
				for each (var manboat2:Manboat in menboats) {
					if (manboat2.getBoundingRect().intersects(wave.getBoundingRect())) {
						manboat2.removeActorFromGameEngine(manboat2, menboats);
						//add score for each man murdered
						utilities.Engine.UIManager.addToScore(50);
					}
				}

			}
			
			for each (var city:City in cities) {
					city.tick(this);
			}
			
		}
		
	}
}