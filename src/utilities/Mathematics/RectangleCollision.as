/*
	Author - Jonathan Justice
	VERY IMPORTANT:
	this assumes both rectangles have their registration points in the center.
	Resolution vectors are dependent on the tick prior to collision!
	this collision model is only useful for interactions where ONLY 1 rectangle is moving(i.e. platformers)
*/
package utilities.Mathematics{
	import flash.display.MovieClip;
	public class RectangleCollision{  
	
		 public function RectangleCollision(){
			
		 }
		 
		 //check to see if rectangles 1 & 2 are colliding, but no resolution
		 //in other words, the same things as hitTestObject
		 public static function simpleIntersection(rect_1:MovieClip,rect_2:MovieClip,boolean:Boolean):Boolean{
			//If any of these are false, then then the rectangles are not colliding
			
			//rect 1's left side is farther right than rect 2's right side
			return!(rect_1.x > rect_2.x + (rect_2.width) 
			//rect 1's right side is farther left than rect 2's left side   
			|| rect_1.x + (rect_1.width) < rect_2.x 
			//rect 1's top side is further down than rect 2's bottom side
			|| rect_1.y > rect_2.y + (rect_2.height) 
			//rect 1's bottom side is further up than rect 2's top side
			|| rect_1.y + (rect_1.height) < rect_2.y)
		 }
		 
		//resolves collision between a stationary rectangle and a moving rectangle
		 public static function resolveCollisionBetweenMovingAndStationaryObjects(movable:MovieClip,stationary:MovieClip):void{
			//above
			if(movable.getPreviousPosition().y + movable.height/2 <= stationary.y - stationary.height/2 && (movable.getPreviousPosition().x + movable.width/2 >=stationary.x - stationary.width/2 || movable.getPreviousPosition().x - movable.width/2 <=stationary.x + stationary.width/2))//above
			{
				movable.y = stationary.y - stationary.height/2 - movable.height/2 -.05;
			}
			//below
			else if(movable.getPreviousPosition().y - movable.height/2 >= stationary.y + stationary.height/2  && (movable.getPreviousPosition().x + movable.width/2 >=stationary.x - stationary.width/2 || movable.getPreviousPosition().x - movable.width/2 <=stationary.x + stationary.width/2))//below
			{
				movable.y = stationary.y + stationary.height/2 + movable.height/2 +.05;
			}
			//left
			else if(movable.getPreviousPosition().x - movable.width/2 <=stationary.x - stationary.width/2 &&  movable.y + movable.height/2 >= stationary.y - stationary.height/2  &&   movable.y - movable.height/2 <= stationary.y + stationary.height/2 )//left
			{
				movable.x = (stationary.x - stationary.width/2) - movable.width/2 -.05;
			}
			//right
			else if(movable.getPreviousPosition().x + movable.width/2 >=stationary.x + stationary.width/2 &&  movable.y + movable.height/2 >= stationary.y - stationary.height/2  &&   movable.y - movable.height/2 <= stationary.y + stationary.height/2 )
			{
				movable.x = (stationary.x + stationary.width/2) + movable.width/2 +.05;
			}
			else
			{
				movable.y = stationary.y + stationary.height/2 + movable.height/2;
			}
		}
	 }
}