import com.netoleal.events.Event;

class com.netoleal.events.SliderEvent extends Event {
	
	public static var CHANGE:String = "change";
	public static var START_CHANGE:String = "startChange";
	public static var STOP_CHANGE:String = "stopChange";
	
	function SliderEvent( type:String ) {
		super( type );
	}
}
