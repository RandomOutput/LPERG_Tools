package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class lpergLevelConverter extends MovieClip{
		
		private var CLIP:MovieClip;
		
		private var xmlOutput:String;
		private var enemyOutputs:Vector.<String>;

		public function lpergLevelConverter() {
	
			xmlOutput = "<wave>";
			enemyOutputs = new Vector.<String>(0, false);
			
			for(var i:int=0;i<stage.numChildren;i++){
				var currentChild = (stage.getChildAt(0) as MovieClip).getChildAt(i);
				if(currentChild is MovieClip) {
						CLIP = (currentChild as MovieClip);
						trace(CLIP);
				}
			}
			
			this.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function tick(e:Event) {		
			if(CLIP.currentLabel != null && CLIP.currentLabel == "endFrame") {
				this.removeEventListener(Event.ENTER_FRAME, tick);
				exportData();
			}
			
			for(var i:int=0; i<CLIP.numChildren; i++) {
				if(CLIP.getChildAt(i) is lvlEnemy) {
					var objX:int = CLIP.getChildAt(i).x;
					var objY:int = CLIP.getChildAt(i).y;
					var objT:int = (CLIP.getChildAt(i) as lvlEnemy).type;
					
					if((CLIP.getChildAt(i) as lvlEnemy).waveID == -1) {
						(CLIP.getChildAt(i) as lvlEnemy).waveID = enemyOutputs.length;
						enemyOutputs.push("<enemy><startframe>" + (CLIP.currentFrame - 1) + "</startframe>");
					}
						
					enemyOutputs[(CLIP.getChildAt(i) as lvlEnemy).waveID] += "<frames><xLoc>"+objX+"</xLoc><yLoc>"+objY+"</yLoc><types>"+objT+"</types></frames>";
				}
			}
		}
		
		private function exportData() {			
			for(var i:int=0;i<enemyOutputs.length;i++) {
				xmlOutput += "" + enemyOutputs[i] + "</enemy>";
			}
			
			xmlOutput += "</wave>";
			
			trace(xmlOutput);
			CLIP.stop();
		}
	}
}
