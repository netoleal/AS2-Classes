import com.netoleal.events.Dispatcher;
import com.netoleal.events.TextFileEvent;
import com.netoleal.loaders.LoadingProgress;
import mx.utils.Delegate;
import com.netoleal.utils.Interval;

class com.netoleal.loaders.TextFileLoader extends Dispatcher
{
	private var ld:LoadVars;
	private var id:Number;
	private var interval:Interval;
	private var _url:String;
	
	function TextFileLoader()
	{
		super( );
		this.ld = new LoadVars();
		this.interval = new Interval( this.checkLoading, this );
	}
	
	/**
	* Load a text file
	* 
	* @param	file
	*/
	public function load( file:String ):Void {
		this._url = file;
		
		this.ld.load( file );
		this.interval.start( );
		this.ld.onLoad = Delegate.create( this, this.onLoadLV );
	}
	
	/**
	* File URL
	* 
	* @return
	*/
	public function get url( ):String {
		return this._url;
	}
	
	private function checkLoading( ):Void {
		var prog:LoadingProgress = new LoadingProgress( this.ld.getBytesLoaded( ), this.ld.getBytesTotal( ) );
		var ev:TextFileEvent = new TextFileEvent( TextFileEvent.PROGRESS );
		ev.progress = prog;
		
		this.dispatchEvent( ev );
	}
	
	private function onLoadLV( success:Boolean ):Void {
		var ev:TextFileEvent;
		
		this.interval.stop( );
		delete this.ld.onLoad;
		
		if( !success ) {
			ev = new TextFileEvent( TextFileEvent.ERROR );
			ev.errorMessage = "Error loading file";
			this.dispatchEvent( ev );
		} else {
			ev = new TextFileEvent( TextFileEvent.LOAD );
			ev.textContent = unescape( ld.toString( ) );
			this.dispatchEvent( ev );
		}
		
	}
	
	public function getData( ):LoadVars {
		return this.ld;
	}
	
}
