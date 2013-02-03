package utilities.Mathematics 
{
	
	/**
	 * ...
	 * @Jonathan Justice ...
	 */
	public class Probability 
	{
		
		public function Probability() 
		{
			
		}
		
		public function createNewFixedProbabilityTable():void {
			
		}
		
		//do it a bunch to make it slightly less terrible
		public static function generateRandomValue(min:Number, max:Number):Number {
			var randomNumber:int=0;
			for (var i:int = 0; i < 10; i++ ) {
				randomNumber = min + Math.random() * (max - min);
			}
			return randomNumber;
		}
	}
}