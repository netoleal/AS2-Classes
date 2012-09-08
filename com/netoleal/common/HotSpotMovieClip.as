import com.netoleal.events.UIDispatcher;
import com.netoleal.events.SimpleUIEvent;

class com.netoleal.common.HotSpotMovieClip extends UIDispatcher {
	
	public static function get linkage( ):String {
		return "common.HotSpotMovieClip";
	}
	
	function HotSpotMovieClip( Void ) {
		super( );
		MovieClip( this )._alpha = 0;
		
		this.disableDragOverOut( );
	}
	
	/**
	* Enable using dragOver and dragOut events.
	* By default, dragOver and dragOut are triggered at same time of rollOver and rollOut.
	* 
	* @param	Void
	*/
	public function enableDragOverOut( Void ):Void {
		MovieClip( this ).onDragOver = this.dragOver;
		MovieClip( this ).onDragOut = this.dragOut;
	}
	
	/**
	* Set dragOver and dragOut equals to rollOver and rollOut.
	* After using this method, dragOver and dragOut are no longer fired.
	* 
	* @param	Void
	*/
	public function disableDragOverOut( Void ):Void {
		MovieClip( this ).onDragOver = this.onRollOver;
		MovieClip( this ).onDragOut = this.onRollOut;
	}
	
	/**
	* Handler for dragOver if enabled
	* 
	* @param	Void
	*/
	private function dragOver( Void ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.DRAG_OVER ) );
	}
	
	/**
	* Handler for dragOut if enabled
	* 
	* @param	Void
	*/
	private function dragOut( Void ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.DRAG_OUT ) );
	}
	
	/**
	* Handler for release
	* 
	* @param	Void
	*/
	private function onRelease( Void ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.CLICK ) );
	}
	
	/**
	* Handler for roll over
	* 
	* @param	Void
	*/
	private function onRollOver( Void ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.ROLL_OVER ) );
	}
	
	/**
	* Handler for roll out
	* 
	* @param	Void
	*/
	private function onRollOut( Void ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.ROLL_OUT ) );
	}
}
