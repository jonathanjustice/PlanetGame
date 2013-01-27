package utilities.Audio{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	public class SoundManager extends MovieClip{
		
		
		public var soundObjects:Array = new Array();
		private var filePath:String = "assets/GuileTheme.mp3";
		private var file2:String = "assets/stoneGrind2.mp3";
		private var file3:String = "assets/Notify.mp3";
		private var file4:String = "assets/HeartBeat.mp3";
		
		public static var stoneSound:SoundObject;
		public static var matchSound:SoundObject;
		public static var heartSound:SoundObject;
		
		public function SoundManager():void{
			//createNewSoundObject(filePath);
			//stop_a_sound_channel(filePath);
			
			
			stoneSound = createNewSoundObject(file2);
			matchSound = createNewSoundObject(file3);
			heartSound = createNewSoundObject(file4);
		}
		
		public function createNewSoundObject(file_path:String):SoundObject {
			trace(file_path);
			var newSoundObject:SoundObject = new SoundObject(file_path);
			soundObjects.push(newSoundObject);
			return newSoundObject; 
		}
		
		public function stop_a_sound_channel(channel_to_stop:String):void {
			for each(var soundObject:SoundObject in soundObjects) {
				if (soundObject.name == channel_to_stop) {
					soundObject.stopSound();
				}				
			}
		}
		
		public function stopAllSounds():void{
			for each(var soundObject:SoundObject in soundObjects) {
				soundObject.stopSound();				
			}
		}
	}
}