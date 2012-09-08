import com.netoleal.events.Event;
import mx.events.EventDispatcher;

class com.netoleal.events.Dispatcher {
	
	function Dispatcher()
	{
		EventDispatcher.initialize( this );
	}
	
	// Methodos for EventDispatcher
	public function addEventListener( eventName:String, listener:Object ):Void { /* ... */ }
	public function removeEventListener( listener:Object ):Void { /* .. */ }
	private function dispatchEvent( eventObject:Event ):Void { /* ... */ }
}
