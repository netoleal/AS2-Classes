
class com.netoleal.desenv.TestConsole
{
	private var className:String = "";
	
	private static var _instance:TestConsole;
	
	public static function init( scopeReference:Object ):Void {
		if( _instance == undefined ) _instance = new TestConsole( );
		
		scopeReference.console = _instance.console;
	}
	
	private function console( text:Object ):Void {
		trace( "[" + this.className + "] " + text.toString( ) );
	}
}
