import com.netoleal.events.Event;
/**
* com.netoleal.events.MouseEvent
*
* @author Neto Leal
* @version 0.1
*/

class com.netoleal.events.MouseEvent extends Event {

	public static var CLICK:String = "click";
	public static var MOUSE_MOVE:String = "mouseMove";
	public static var ROLL_OVER:String = "rollOver";
	public static var ROLL_OUT:String = "rollOut";
	
	public function MouseEvent( type:String ) {
		super( type );
	}
	
}