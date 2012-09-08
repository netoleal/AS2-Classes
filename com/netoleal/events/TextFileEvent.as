import com.netoleal.events.Event;
import com.netoleal.loaders.LoadingProgress;

class com.netoleal.events.TextFileEvent extends Event {
	
	public static var LOAD:String = "load";
	public static var ERROR:String = "error";
	public static var PROGRESS:String = "progress";
	
	public var textContent:String;
	public var errorMessage:String;
	public var progress:LoadingProgress;
	
	function TextFileEvent( type:String ) {
		super( type );
	}
}
