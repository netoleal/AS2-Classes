
class com.netoleal.utils.Broadcaster
{
	private var _listeners:Array;
	
	public function Broadcaster( ){
		AsBroadcaster.initialize( this );
	}
	
	// Methods to AsBroadcaster -------------------------
	
	/**
	* Add an object to listen Loading events
	* 
	* @param	listener
	*/
	public function addListener( listener:Object ):Void { /* ... */ }
	
	/**
	* Remove an object from listeners list
	* 
	* @param	listener
	*/
	public function removeListener( listener:Object ):Void { /* ... */ }
	
	/**
	* Broadcast an event to listeners
	* 
	* @param	eventName
	* @param	args
	*/
	private function broadcastMessage( eventName:String, args:Object ):Void { /* ... */ }
	
}
