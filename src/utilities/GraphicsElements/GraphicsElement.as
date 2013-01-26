package utilities.GraphicsElements{
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	
	public class GraphicsElement extends MovieClip{
		private var myGraphic:Sprite = new Sprite(); 
		
		public function GraphicsElement():void{
			
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		public function drawGraphic():void{
			myGraphic.graphics.lineStyle(3,0x00ff00);
			myGraphic.graphics.beginFill(0x0000FF);
			myGraphic.graphics.drawRect(0,0,50,50);
			myGraphic.graphics.endFill();
			myGraphic.x = -25;
			myGraphic.y = -25;
			this.addChild(myGraphic);
		}
		
		public function drawGraphic2():void{
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x0000FF);
			myGraphic.graphics.drawRect(0,0,50,50);
			myGraphic.graphics.endFill();
			myGraphic.x = -25;
			myGraphic.y = -25;
			this.addChild(myGraphic);
		}
		
		public function drawGraphic3():void{
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,50,50);
			myGraphic.graphics.endFill();
			myGraphic.x = -25;
			myGraphic.y = -25;
			this.addChild(myGraphic);
		}
	}
}
