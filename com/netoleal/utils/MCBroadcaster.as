
class com.netoleal.utils.MCBroadcaster extends MovieClip {
	private var _listeners:Array;
	
	public function MCBroadcaster( ){
		AsBroadcaster.initialize( this );
	}
	
	public function addListener( listener:Object ):Void {}
	public function removeListener( listener: Object ):Void {}
	private function broadcastMessage( eventName:String, args:Object ):Void{}
}
