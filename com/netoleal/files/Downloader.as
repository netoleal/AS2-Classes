/**
* Class Downloader
* 
* @description composite class for download os files. Uses FileReference class as core.
* 
*/

import flash.net.FileReference;
import mx.utils.Delegate;

class com.netoleal.files.Downloader
{
	
	public var onUpdate:Function;
	public var onDialogError:Function;
	public var onComplete:Function;
	public var onCancel:Function;
	public var onOpenDialog:Function;
	public var onStart:Function;
	
	private var file:FileReference;
	private var listener:Object;
	
	private var progress:Number;
	private var _id:Object;
	
	/**
	* Constructor
	* 
	* @param	id - Optional. An ID to identifier the instance between others.
	*/
	function Downloader( id:Object )
	{
		this.file = new FileReference( );
		this.listener = new Object( );
		
		this.listener.onProgress = Delegate.create( this, list_onProgress );
		this.listener.onCancel = Delegate.create( this, list_onCancel );
		this.listener.onComplete = Delegate.create( this, list_onComplete );
		this.listener.onOpen = Delegate.create( this, list_onOpen );
		this.listener.onStart = Delegate.create( this, list_onSelect );
		
		this.file.addListener( this.listener );
		
		this.setID( id );
	}
	
	/**
	* Set an ID to downloader. Usefull to multiples instances of downloader with same calback methods
	* 
	* @param	value
	*/
	public function setID( value:Object ):Void {
		this._id = value;
	}
	
	/**
	* Return the ID
	* 
	* @return
	*/
	public function getID( ):Object {
		return this._id;
	}
	
	/**
	* Download a specific file from server
	* 
	* @param	fileURL
	*/
	public function download( fileURL:String ):Void {
		
		if( !this.file.download( fileURL ) ){
			trace(" [Downloader] ERROR downloading" );
			onDialogError( fileURL );
		} else {
			trace( "[Downloader] download initialized" );
		}
		
	}
	
	/**
	* Cancel the download operation
	* 
	* @param	Void
	*/
	public function cancel( Void ):Void {
		this.file.cancel( );
	}
	
	/**
	* Returns the download progress
	* 
	* @param	Void
	* @return
	*/
	public function getProgress( Void ):Number {
		return this.progress;
	}
	
	/**
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* LISTENER EVENTS
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*/
	
	/**
	* Event for progress
	* 
	* @param	file
	* @param	bytesLoaded
	* @param	bytesTotal
	*/
	private function list_onProgress( file:FileReference, bytesDownloaded:Number, bytesTotal:Number ):Void{
		progress = bytesDownloaded / bytesTotal * 100;
		
		this.onUpdate( this, bytesDownloaded, bytesTotal );
	}
	
	/**
	* Fired when user select a file and starts downloading
	* 
	* @param	file
	*/
	private function list_onSelect( file:FileReference ):Void {
		trace( "[Downloader] onStart( )" );
		this.onStart( this );
	}
	
	/**
	* Fired when user cancels download dialog
	* 
	* @param	file
	*/
	private function list_onCancel( file:FileReference ):Void {
		this.onCancel( this );
	}
	
	/**
	* Fires when download is finished
	* 
	* @param	file
	*/
	private function list_onComplete( file:FileReference ):Void {
		trace( "[Downloader] onComplete( )" );
		this.onComplete( this );
	}
	
	/**
	* Fires when "Save file" dialog opens
	* 
	* @param	file
	*/
	private function list_onOpen( file:FileReference ):Void{
		trace( "[Downloader] onOpenDialog( )" );
		this.onOpenDialog( this );
	}
	
}
