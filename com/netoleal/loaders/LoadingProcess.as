import com.netoleal.desenv.TestConsole;
import com.netoleal.loaders.LoadingRecord;
import com.netoleal.loaders.LoaderListener;
import com.netoleal.loaders.QueuedMovieClipLoader;
import mx.utils.Delegate;

class com.netoleal.loaders.LoadingProcess
{
	public var onLoadProgress:Function;
	public var onLoadComplete:Function;
	public var onTargetLoaded:Function;
	
	private var loader:QueuedMovieClipLoader;
	private var listener:LoaderListener;
	private var records:Object;
	
	public var ID:Number;
	
	private var className:String = "LoadingProcess";
	private var console:Function;
	
	function LoadingProcess()
	{
		
		TestConsole.init( this );
		
		this.loader = new QueuedMovieClipLoader( );
		this.listener = new LoaderListener( );
		
		this.loader.addListener( listener );
		
		this.listener.onLoadProgress = Delegate.create( this, loadProgressEvent );
		this.listener.onLoadInit = Delegate.create( this, loadCompleteEvent );
		
		this.records = new Object( );
	}
	
	/**
	* Start loading process
	* 
	* @param	Void
	*/
	public function startLoading( Void ):Void {
		
		console( "Process " + this.ID + " started" );
		
		var rec:LoadingRecord;
		
		for( var p in this.records ){
			rec = this.records[ p ];
			//console( "Starting to load: " + rec.url + " to " + rec.container + " | process: " + this.ID );
			this.loader.loadClip( rec.url, rec.container );
		}
		
	}
	
	/**
	* Get total bytes from loading process
	* 
	* @param	Void
	* @return
	*/
	public function getBytesTotal( Void ):Number {
		var total:Number = 0;
		var rec:LoadingRecord;
		
		for( var n in this.records ) {
			rec = this.records[ n ];
			
			if( ! isNaN( rec.bytesTotal ) ) total += rec.bytesTotal;
		}
		
		return total;
	}
	
	/**
	* Get bytes loaded from loading process
	* 
	* @param	Void
	* @return
	*/
	public function getBytesLoaded( Void ):Number {
		var total:Number = 0;
		var rec:LoadingRecord;
		
		for( var n in this.records ) {
			rec = this.records[ n ];
			
			if( ! isNaN( rec.bytesLoaded ) ) total += rec.bytesLoaded;
		}
		
		return total;
	}
	
	/**
	* Get progress percentage from loading process
	* 
	* @param	Void
	* @return
	*/
	public function getBytesProgress( Void ):Number {
		var total:Number = 0;
		var loaded:Number = 0;
		var rec:LoadingRecord;
		
		for( var n in this.records ) {
			rec = this.records[ n ];
			
			if( ! isNaN( rec.bytesLoaded ) ) loaded += rec.bytesLoaded;
			if( ! isNaN( rec.bytesTotal ) ) total += rec.bytesTotal;
		}
		
		return loaded / total * 100;
	}
	
	/**
	* Callback handler for MovieClipLoader
	* 
	* @param	target
	* @param	bytesLoaded
	* @param	bytesTotal
	*/
	private function loadProgressEvent( target:MovieClip, bytesLoaded:Number, bytesTotal:Number ):Void {
		var rec:LoadingRecord = this.getRecord( target );
		rec.bytesLoaded = bytesLoaded;
		rec.bytesTotal = bytesTotal;
		
		this.onLoadProgress( this );
	}
	
	/**
	* Callback handler for MovieClipLoader
	* 
	* @param	target
	*/
	private function loadCompleteEvent( target:MovieClip ):Void {
		var rec:LoadingRecord = this.getRecord( target );
		rec.loaded = true;
		
		//console( "target " + target._name + " on process " + this.ID + " loaded" );
		
		if( this.loaded ) {
			this.onLoadComplete( this );
		}
		
		this.onTargetLoaded( this, target );
	}
	
	/**
	* Return true if process is terminated, false if not.
	* 
	* @return
	*/
	public function get loaded( ):Boolean {
		var rec:LoadingRecord;
		
		for( var n in this.records ){
			rec = this.records[ n ];
			if( !rec.loaded ){
				return false;
			}
		}
		
		return true;
		
	}
	
	/**
	* Get a loading record for a target
	* 
	* @param	target
	* @return
	*/
	public function getRecord( target:MovieClip ):LoadingRecord {
		return this.records[ formatKey( target ) ];
	}
	
	/**
	* Add a file to process
	* 
	* @param	url
	* @param	container
	*/
	public function addFile( url:String, container:MovieClip ):Void {
		//console( "addFile( " + url + ", " + container._name + " ) to process " + this.ID );
		
		this.records[ this.formatKey( container ) ] = new LoadingRecord( url, container );
	}
	
	/**
	* Remove a file from process
	* 
	* @param	container
	*/
	public function removeFileByContainer( container:MovieClip ):Void {
		delete this.records[ formatKey( container ) ];
	}
	
	private function formatKey( mc:MovieClip ):String {
		var path:Array = new Array( );
		while( mc._parent != undefined ){
			path.push( mc._name );
			mc = mc._parent;
		}
		
		return path.join("");
	}
	
	public function toString( ):String {
		return "[LoadingProcess " + this.ID + "]";
	}
}
