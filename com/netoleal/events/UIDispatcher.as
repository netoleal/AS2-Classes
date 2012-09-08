import com.netoleal.events.EventDispatcher;
import com.netoleal.events.Event;

class com.netoleal.events.UIDispatcher extends MovieClip
{
	public function UIDispatcher( Void ){
		
		EventDispatcher.initialize(this);
		
	}
	
	/**
	* Broadcast an event
	* 
	* @param	eventObject
	*/
	private function dispatchEvent( eventObject:Event ):Void { }

	/**
	* Turn event dispatching off
	*/
	public function deactivateEvents( ):Void { /* Implemented by EventDispatchet.initialize */ }
	
	/**
	* Turn event dispatching on
	*/
	public function activateEvents( ):Void { /* Implemented by EventDispatchet.initialize */ }
	
	/**
	* Add an object of function as a listener to an event
	* 
	* @param	eventName
	* @param	listener
	* @param 	scope if listener is a function, scope will be a reference for "this" inside the listener
	*/
	public function addEventListener( eventName:String, listener:Object, scope:Object ):Void { /* Implemented by EventDispatchet.initialize */ }
	
	/**
	* Remove a listener from the listeners list. If eventName is passed, the listener will be removed only for 
	* one specific event
	* 
	* @param	listener
	* @param	eventName [Optional]. Name of the event that listener should be removed
	*/
	public function removeEventListener( listener:Object, eventName:String ):Void { /* Implemented by EventDispatchet.initialize */ }
	
	/**
	* Clear listeners list
	* @param eventName If eventName is passed, only the listeners of eventName will be removed. Otherwise, all listener for all events will be removed
	*/
	public function removeAllEventListeners( eventName:String ):Void { /* Implemented by EventDispatchet.initialize */ }
	
	/** Determines whether or not an object has listeners for a specific type of event.
	* 
	* @param	eventName
	* @return
	*/
	public function hasEventListener( eventName:String ):Boolean { /* Implemented by EventDispatchet.initialize */ return false; }
	
	/** Determines whether or not an object or any of its parent containers have listeners for a specific type event. 
	* This is much like hasEventListener but this method checks the current object as well as all objects 
	* that might be affected from the propagation of the event.
	* 
	* @param	eventName
	* @return
	*/
	public function willTrigger( eventName:String ):Boolean { /* Implemented by EventDispatchet.initialize */ return false; }

}
