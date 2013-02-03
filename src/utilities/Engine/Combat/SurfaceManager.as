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
		private var lavas:Array;
		private var earthquakes:Array;
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
			lavas = new Array();
			earthquakes = new Array();
			
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
		
		public function makeLava(xLoc:Number):void {
			
			var lava:Lava = new Lava(true);
			lava.x = xLoc;
			lava.move();
			lavas.push(lava);
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
			wave2.x = (angle / 360) * CIRCUMFERENCE;
			waves.push(wave1,wave2)
		}
		
		public function makeEarthquake(angle:Number):void {
			
			var earthquake:Earthquake = new Earthquake(false);
			earthquake.x = (angle / 360) * CIRCUMFERENCE;
			
			earthquakes.push(earthquake);
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
					manboat.markDeathFlag();
				}
				
				for each (var lava2:Lava in lavas) {
					if (manboat.getBoundingRect().intersects(lava2.getBoundingRect())) {
						manboat.markDeathFlag();
						//add score for each man murdered
						utilities.Engine.UIManager.addToScore(50);
					}
				}
				if (manboat.getDeathFlag()) {
					manboat.removeActorFromGameEngine(manboat,menboats);
				}
			}
			
			for each (var lava:Lava in lavas) {
				lava.move();
				if (lava.puppet) {
					lava.puppet.x = -lava.x;
					lava.puppet.y = -lava.y;
					angle = 360 * (lava.x / CIRCUMFERENCE);
					lava.puppet.rotation = angle+90;
					radians =  MathFormulas.degreesToRadians(angle);
					lava.puppet.x = Math.cos(radians) * (240 - lava.y) + GemManager.originPoint.x - lava.x;
					lava.puppet.y = Math.sin(radians) * (240 - lava.y) + GemManager.originPoint.y - lava.y;
				}
				if (lava.decay < 0) {
					lava.markDeathFlag();
				}
				if (lava.getDeathFlag()) {
					lava.removeActorFromGameEngine(lava,lavas);
				}
			}
			
			for each (var earthquake:Earthquake in earthquakes) {
				earthquake.move();
				if (earthquake.puppet) {
					earthquake.puppet.x = -earthquake.x;
					earthquake.puppet.y = -earthquake.y;
					angle = 360 * (earthquake.x / CIRCUMFERENCE);
					earthquake.puppet.rotation = angle+90;
					radians =  MathFormulas.degreesToRadians(angle);
					earthquake.puppet.x = Math.cos(radians) * 240 + GemManager.originPoint.x - earthquake.x;
					earthquake.puppet.y = Math.sin(radians) * 240 + GemManager.originPoint.y;
				}
				if (earthquake.decay < 0) {
					earthquake.markDeathFlag();
				}
				if (earthquake.getDeathFlag()) {
					earthquake.removeActorFromGameEngine(earthquake,earthquakes);
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
					volcano.markDeathFlag();
				}
				
				for each (var wave2:Wave in waves) {
					if (volcano.getBoundingRect().intersects(wave.getBoundingRect())) {
						volcano.markDeathFlag();
						wave2.markDeathFlag();
					}
					if (wave2.getDeathFlag()) {
						wave2.removeActorFromGameEngine(wave2,waves);
					}
				}	
				
				for each (var manboat3:Manboat in menboats) {
					if (manboat3.getBoundingRect().intersects(volcano.getBoundingRect())) {
						manboat3.markDeathFlag();
						//add score for each man murdered
						utilities.Engine.UIManager.addToScore(50);
					}
					if (manboat3.getDeathFlag()) {
						manboat3.removeActorFromGameEngine(manboat3,menboats);
					}
				}
				for each (var earthquake2:Earthquake in earthquakes) {
					if (volcano.getBoundingRect().intersects(earthquake2.getBoundingRect())) {
						volcano.markDeathFlag();
						earthquake2.markDeathFlag();
					}
					if (earthquake2.getDeathFlag()) {
						earthquake2.removeActorFromGameEngine(earthquake2,earthquakes);
					}
				}
				if (volcano.getDeathFlag()) {
					volcano.removeActorFromGameEngine(volcano,volcanos);
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
					wave.markDeathFlag();
				}
				
				for each (var manboat2:Manboat in menboats) {
					if (manboat2.getBoundingRect().intersects(wave.getBoundingRect())) {
						manboat2.markDeathFlag();
						//add score for each man murdered
						utilities.Engine.UIManager.addToScore(50);
					}
					if (volcano.getDeathFlag()) {
						manboat2.removeActorFromGameEngine(manboat2,menboats);
					}
				}
			}
			
			for each (var city:City in cities) {
					city.tick(this);
			}
		}
	}
}