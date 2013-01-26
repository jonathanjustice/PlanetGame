package utilities.Engine{
	import flash.display.MovieClip;
	public class DefaultManager extends MovieClip{
		
		public function DefaultManager(){
			
		}
		
		public function testFunction():void{
			trace(this,"class exists, probably means you fucked up somewhere else")
		}
		
		public function updateLoop():void{
			
		}
		
		public function getArray():Array{
			var array:Array = new Array();
			return array;
		}
		
		public function get_Index_of_actor_in_array(actor:MovieClip,array:Array):int{
			array = getArray();
			var index:int = array.indexOf(actor);
			return index;
		}
		
		public function getArrayLength():int{
			var array:Array = new Array(); 
			return array.length-1;
		}
	}
}