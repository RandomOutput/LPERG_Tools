package  {
	
	import flash.display.MovieClip;
	
	public class lvlEnemy extends MovieClip{
		
		public var type:int;
		public var waveID:int;
		
		public function lvlEnemy(_type:int) {
			type = _type;
			waveID = -1;
		}

	}
	
}
