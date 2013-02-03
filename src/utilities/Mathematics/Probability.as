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
		
		public function generateRandomValue(min:Number, max:Number):Number {
			return min + Math.random() * (max - min);
		}
	}
}