import com.netoleal.events.Event;

class com.netoleal.events.fms.ConnectionEvent extends Event {
	
	public static var CONNECT			:String = "connect";
	public static var DISCONNECT		:String = "disconnect";
	public static var STATUS			:String = "status";
	public static var CONNECTION_FAILED	:String = "connectionFailed";
	
	public var description:String;
	public var statusCode:String;
	
	function ConnectionEvent( type:String ) {
		super( type );
	}
}
