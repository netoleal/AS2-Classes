
class com.netoleal.common.Locker extends MovieClip {
	
	function Locker() {
		
		MovieClip( this ).onDragOut = function(){};
		MovieClip( this ).useHandCursor = false;
		
		lock( );
	}
	
	public function lock( ):Void {
		this._visible = true;
	}
	
	public function unlock( ):Void {
		this.setInvisible( );
	}
	
	private function setInvisible( ):Void {
		MovieClip( this )._visible = false;
	}
}
