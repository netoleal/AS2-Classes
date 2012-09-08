import mx.utils.Delegate;
import com.netoleal.loaders.LoaderListener;
import com.netoleal.loaders.LoadingProgress;
import com.netoleal.utils.Broadcaster;

class com.netoleal.loaders.QueuedMovieClipLoader extends Broadcaster {
	private var maxQueue:Number;
	
	private var activeDownloads:Array;
	private var pendingDownloads:Array;
	
	private var loader:MovieClipLoader;
	private var listener:Object;
	
	function QueuedMovieClipLoader( maximumSimultaneous:Number ) {
		
		super( );
		
		this.maxQueue = maximumSimultaneous;
		this.activeDownloads = new Array();
		this.pendingDownloads = new Array();
		
		this.loader = new MovieClipLoader( );
		this.listener = new LoaderListener;
		
		this.listener.onLoadInit = Delegate.create( this, this.loadInitEvent );
		this.listener.onLoadError = Delegate.create( this, this.loadErrorEvent );
		this.listener.onLoadComplete = Delegate.create( this, this.loadCompleteEvent );
		this.listener.onLoadProgress = Delegate.create( this, this.loadProgressEvent );
		this.listener.onLoadStart = Delegate.create( this, this.loadStartEvent );
		
		this.loader.addListener( this.listener );
	}
	
	/**
	* Wrapper to MovieClipLoader.loadClip with queuing
	* 
	* @param	url
	* @param	target
	*/
	public function loadClip( url:String, target:MovieClip ):Void {
		
		var downloadObject:Object = { url: url, target: target };
		this.removeDownloadFromActives( target );
		
		if( this.maxQueue != null && this.maxQueue != undefined && this.activeDownloads.length >= this.maxQueue ){
			this.pendingDownloads.push( downloadObject );
		} else {
			this.activeDownloads.push( downloadObject );
			trace( "\t\t\t[QueuedMovieClipLoader] loadClip ( " + url + ", " + target._name + " );" );
			this.loader.loadClip( url, target );
		}
		
	}
	
	/**
	* Get the number of current active downloads
	* 
	* @param	Void
	* @return
	*/
	public function getCurrentDownloadsCount( Void ):Number {
		return this.activeDownloads.length;
	}
	
	/**
	* Return the loading progress of a target
	* 
	* @param	target
	* @return
	*/
	public function getProgress( target:MovieClip ):LoadingProgress {
		var pg:Object = this.loader.getProgress( target );
		
		return new LoadingProgress( pg.bytesLoaded, pg.bytesTotal );
	}
	
	/**
	* Unload a target
	* 
	* @param	target
	*/
	public function unloadClip( target:MovieClip ):Void {
		
		this.removeDownloadFromActives( target );
		this.removeDownloadFromPending( target );
		
		this.loader.unloadClip( target );
	}
	
	/**
	* Listen to MovieClipLoader.onLoadInit
	* 
	* @param	target
	*/
	private function loadInitEvent( target:MovieClip ):Void {
		
		this.broadcastMessage( "onLoadInit", target );
		
		this.removeDownloadFromActives( target );
		if( this.activeDownloads.length < this.maxQueue && this.pendingDownloads.length > 0 ){
			
			var pending:Object = this.pendingDownloads[ 0 ];
			this.removeDownloadFromPending( pending.target );
			this.loadClip( pending.url, pending.target );
			
		}
	}
	
	/**
	* Listen to MovieClipLoader.onLoadError
	* 
	* @param	target
	*/
	private function loadErrorEvent( target:MovieClip ):Void {
		
		this.removeDownloadFromActives( target );
		this.broadcastMessage( "onLoadError", target );
		
	}
	
	/**
	* Listen to MovieClipLoader.onLoadComplete
	* 
	* @param	target
	*/
	private function loadCompleteEvent( target:MovieClip ):Void {
		
		this.broadcastMessage( "onLoadComplete", target );
		
	}
	
	/**
	* Remove from active downloads list
	* 
	* @param	target
	*/
	private function removeDownloadFromActives( target:MovieClip ):Void {
		
		this.removeDownloadFromList( target, this.activeDownloads );
		
	}
	
	/**
	* Remove from pending downloads list
	* 
	* @param	target
	*/
	private function removeDownloadFromPending( target:MovieClip ):Void {
		
		this.removeDownloadFromList( target, this.pendingDownloads );
		
	}
	
	private function removeDownloadFromList( target:MovieClip, list:Array ):Void {
		
		var n:Number = 0;
		var t:Number = list.length;
		var i:Number;
		var downloadObject:Object;
		
		while( n++ < t ){
			i = n - 1;
			downloadObject = list[ i ];
			if( downloadObject.target == target ){
				list.splice( i, 1 );
				return;
			}
		}
	}
	
	/**
	* Listen to MovieClipLoader.onLoadProgress
	* 
	* @param	target
	*/
	private function loadProgressEvent( target:MovieClip, bytesLoaded:Number, bytesTotal:Number ):Void {
		
		this.broadcastMessage( "onLoadProgress", target, bytesLoaded, bytesTotal );
		
	}
	
	/**
	* Listen to MovieClipLoader.onLoadSart
	* 
	* @param	target
	*/
	private function loadStartEvent( target:MovieClip ):Void {
		this.broadcastMessage ("onLoadStart", target );
	}
}

