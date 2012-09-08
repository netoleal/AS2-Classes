import com.netoleal.events.Event;

class com.netoleal.events.SimpleUIEvent extends Event {
	
	public static var CLICK:String = "click";
	public static var ROLL_OVER:String = "rollOver";
	public static var ROLL_OUT:String = "rollOut";
	public static var MOUSE_DOWN:String = "mouseDown";
	public static var MOUSE_UP:String = "mouseUp";
	public static var DRAG_OVER:String = "dragOver";
	public static var DRAG_OUT:String = "dragOut";
	public static var ENTER_FRAME:String = "enterFrame";
	
	function SimpleUIEvent( type:String ) {
		super( type );
	}
}
