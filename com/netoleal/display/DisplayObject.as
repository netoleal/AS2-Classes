import com.netoleal.events.SimpleUIEvent;
import com.netoleal.display.SimpleDisplayObject;

class com.netoleal.display.DisplayObject extends SimpleDisplayObject {
	
	function DisplayObject( ) { }
	
	private function onPress( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.MOUSE_DOWN ) );
	}
	
	private function onRelease( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.CLICK ) );
	}
	
	private function onMouseUp( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.MOUSE_UP ) );
	}
		
	private function onRollOver( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.ROLL_OVER ) );
	}
	
	private function onRollOut( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.ROLL_OUT ) );
	}
	
	private function onDragOver( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.DRAG_OVER ) );
	}
	
	private function onDragOut( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.DRAG_OUT ) );
	}
		
}
