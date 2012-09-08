import com.netoleal.events.UIDispatcher;
import com.netoleal.events.SimpleUIEvent;

class com.netoleal.display.SimpleDisplayObject extends UIDispatcher {
	
	private var childCount:Number = 0;
	private var childs:Object = new Object;
	
	function SimpleDisplayObject( ) { }
	
	private var className:String = "display.SimpleDisplayObject";
	
	private function enterFrame( ):Void {
		this.dispatchEvent( new SimpleUIEvent( SimpleUIEvent.ENTER_FRAME ) );
	}
	
	//public function toString( ):String {
		//return this.className + "_instance: " + MovieClip( this )._name;
	//}
	
	/**
	* Stop broadcasting enterframe event
	*/
	public function stopEnterFrameBroadcasting( ):Void {
		delete this.onEnterFrame;
	}
	
	/**
	* Start broadcasting enterframe event
	*/
	public function startEnterFrameBroadcasting( ):Void {
		MovieClip( this ).onEnterFrame = this.enterFrame;
	}
	
	/**
	* Trace a message with className before consoleText
	* @param	args any arguments to be traced
	*/
	private function console( args:Object ):Void {
		var tab:String = "";
		if( String( arguments[ arguments.length - 1 ] ).indexOf( "\t" ) == 0 ){
			tab = String( arguments.pop( ) );
		}
		trace( tab + [ "[", "] " ].join( className ) + " " + arguments.join( ", " ) );
	}
	
	/**
	* Add a new instance of DisplayObject at this container.
	* 
	* @param	childType A class reference. This class must to have a static member called "linkage" to this method works.
	* 			getLinkage must return a string containg the linkage identifier of exported object
	* @param	initObj Object containing initial props for attached Object
	* @return
	*/
	public function addChild( childType:Function, initObj:Object ):SimpleDisplayObject {
		var d:Number = MovieClip( this ).getNextHighestDepth( );
		return this.addChildAt( childType, d, initObj );
	}
	
	/**
	* Add a new instance of DisplayObject at this container on a specifc depth.
	* 
	* @param	childType childType A class reference. This class must to have a static member called "getLinkage" to this method works.
	* getLinkage must return a string containg the linkage identifier of exported object
	* @param	depth 
	* @param	initObj Object containing initial props for attached Object
	* @return
	*/
	public function addChildAt( childType:Function, depth:Number, initObj:Object ):SimpleDisplayObject {
		// TODO: Check if it can become too slow...
		Object.registerClass( childType.linkage, childType );
		
		var mc:MovieClip = MovieClip( this ).attachMovie( childType.linkage, "child_" + ( ++ this.childCount ), depth, initObj );
		
		mc.childId = this.childCount;
		
		this.childs[ this.childCount ] = mc; 
		
		return SimpleDisplayObject( mc );
	}
	
	/**
	* Remove a child instance
	* 
	* @param	childInstance
	*/
	public function removeChild( childInstance:MovieClip ):Void {
		
		this.childs[ childInstance.childId ] = null;
		delete this.childs[ childInstance.childId ];
		
		childInstance.removeMovieClip( );
	}
	
	/**
	* Remove all child instances
	* 
	*/
	public function removeAllChilds( ):Void {
		for( var c:String in this.childs ) {
			this.removeChild( this.childs[ c ] );
		}
	}
}
