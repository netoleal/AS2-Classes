/**
* @author Neto Leal
* 6/7/2007 16:24
* 
*/

import com.netoleal.events.Event;
import com.netoleal.utils.ClassUtils;
import mx.utils.Delegate;

class com.netoleal.events.EventDispatcher {
	
	private var __listeners:Object;
	private var __initialized:Boolean;
	private var __active:Boolean;
	
	private var __scope:Object;
	
	private static var _staticDispatcher:EventDispatcher;
	
	function EventDispatcher() {
		__scope = this;
	}
	
	/**
	* Create Dispatcher's members in a target
	* 
	* @param	target
	*/
	public static function initialize( target:Object ):Void {
		ClassUtils.copyMembers( EventDispatcher, target );
		
		target.__scope = target;
	}
	
	/**
	* Initialization
	*/
	private function __init( ):Void {
		if( EventDispatcher._staticDispatcher == undefined ){
			if( __scope != EventDispatcher._staticDispatcher ) {
				EventDispatcher._staticDispatcher = new EventDispatcher( );
			}
		}
		
		if( __scope.__initialized ) return;
		
		__scope.__listeners = new Object( );
		__scope.__initialized = true;
		__scope.__active = true;
	}
	
	/**
	* Turn event dispatching off
	*/
	public function deactivateEvents( ):Void {
		__scope.__active = false;
	}
	
	/**
	* Turn event dispatching on
	*/
	public function activateEvents( ):Void {
		__scope.__active = true;
	}
	
	/**
	* Add an object of function as a listener to an event
	* 
	* @param	eventName
	* @param	listener
	* @param 	scope if listener is a function, scope will be a reference for "this" inside the listener
	*/
	public function addEventListener( eventName:String, listener:Object, scope:Object ):Void {
		if( !__scope.__initialized ) __scope.__init( );
		
		if( __scope.__listeners[ eventName ] == undefined ) __scope.__listeners[ eventName ] = new Array( );
		__scope.__listeners[ eventName ].push( ( typeof( listener ) == "function" )? Delegate.create( scope, Function( listener ) ) : listener );
		
		if( __scope != EventDispatcher._staticDispatcher ) {
			EventDispatcher._staticDispatcher.addEventListener( eventName, listener );
		}
	}
	
	/**
	* Remove a listener from the listeners list. If eventName is passed, the listener will be removed only for 
	* one specific event
	* 
	* @param	listener
	* @param	eventName [Optional]. Name of the event that listener should be removed
	*/
	public function removeEventListener( listener:Object, eventName:String ):Void {
		if( eventName != null && eventName != undefined && eventName != "" ){
			__scope.removeListenerFromEvent( listener, eventName );
		} else {
			for( eventName in __scope.__listeners ){
				__scope.removeListenerFromEvent( listener, eventName );
			}
		}
		if( __scope != EventDispatcher._staticDispatcher ) {
			EventDispatcher._staticDispatcher.removeEventListener( listener, eventName );
		}
	}
	
	/**
	* Clear listeners list
	* @param eventName If eventName is passed, only the listeners of eventName will be removed. Otherwise, all listener for all events will be removed
	*/
	public function removeAllEventListeners( eventName:String ):Void {
		
		if( eventName != null && eventName != undefined ) {
			delete __scope.__listeners[ eventName ];
			__scope.__listeners[ eventName ] = new Array( );
		} else {
			delete __scope.__listeners;
			__scope.__listeners = new Object( );
		}
		
		if( __scope != EventDispatcher._staticDispatcher ) {
			EventDispatcher._staticDispatcher.removeAllEventListeners( eventName );
		}
	}
	
	/**
	* Remove a listener from the listeners list of an event.
	* 
	* @param	listener
	* @param	eventName
	*/
	private function removeListenerFromEvent( listener:Object, eventName:String ):Void {
		var ar:Array = __scope.__listeners[ eventName ].concat( );
		var n:Number = 0;
		var t:Number = ar.length;
		
		while( n < t ){
			if( ar[ n ] == listener ) {
				ar.splice( n, 1 );
				t--;
			} else n++;
		}
		
		__scope.__listeners[ eventName ] = ar;
	}
	
	/**
	* Broadcast an event
	* 
	* @param	eventObject
	*/
	private function dispatchEvent( eventObject:Event ):Void {
		
		if( !__scope.__active ) return;
		
		eventObject.target = __scope;
		var ar:Array = __scope.__listeners[ eventObject.type ];
		var n:Number = 0;
		var t:Number = ar.length;
		var listener;
		
		while( n < t ){
			listener = ar[ n ];
			
			if( typeof( listener ) == "movieclip" || typeof( listener ) == "object" ){
				listener[ eventObject.type ]( eventObject );
			} else if (typeof( listener ) == "function" ) {
				listener( eventObject );
			}
			
			n++;
		}
	}
	
	/** Determines whether or not an object has listeners for a specific type of event.
	* 
	* @param	eventName
	* @return
	*/
	public function hasEventListener( eventName:String ):Boolean {
		return ( __scope.__listeners[ eventName ] != undefined || __scope.__listeners[ eventName ].length > 0 );
	}
	
	/** Determines whether or not an object or any of its parent containers have listeners for a specific type event. 
	* This is much like hasEventListener but this method checks the current object as well as all objects 
	* that might be affected from the propagation of the event.
	* 
	* @param	eventName
	* @return
	*/
	public function willTrigger( eventName:String ):Boolean {
		return EventDispatcher._staticDispatcher.hasEventListener( eventName );
	}
}
