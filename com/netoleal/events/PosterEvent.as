import com.netoleal.events.Event;

class com.netoleal.events.PosterEvent extends Event {
	
	public static var SENT:String = "sent";
	public static var ERROR:String = "error";
	
	public var errorMessage:String;
	public var result:Object;
	
	function PosterEvent( type:String ) {
		super( type );
	}
}
