/**
* 
* Class BatchMovieClipLoader V0.1
* By Neto Leal - 13/5/2007 00:52
* 
* Usage Example
* 
* var batch:BatchMovieClipLoader
* var processID:Number = batch.createProcess( );
* 
* batch.addFileToProcess( processID, "img1.jpg", mc1 );
* batch.addFileToProcess( processID, "img2.jpg", mc2 );
* batch.addFileToProcess( processID, "img3.jpg", mc3 );
* batch.addFileToProcess( processID, "img4.jpg", mc4 );
* batch.addFileToProcess( processID, "img5.jpg", mc5 );
* 
* batch.startLoadingProcess( processID );
* 
* batch.onLoadProgress = function( process:LoadingProcess ):Void {
* 
* 	trace( process.getBytesLoaded( ) );
* 	trace( process.getBytesTotal( ) );
* 	trace( process.getBytesProgress( ) );
* 
* };
* 
* batch.onLoadComplete = function( process:LoadingProcess ):Void {
* 	trace( "All files from process " + process.ID + " LOADED" );
* };
* 
* batch.onTargetLoaded = function( process:LoadingProcss, target:MovieClip ):Void {
* 	trace( "target: " + target + " was loaded on process: " + process.ID );
* }
* 
*/

import mx.utils.Delegate;
import com.netoleal.desenv.TestConsole;
import com.netoleal.loaders.LoadingProcess;

class com.netoleal.loaders.BatchMovieClipLoader {
	
	public var onLoadProgress:Function;
	public var onLoadComplete:Function;
	public var onTargetLoaded:Function;
	
	private var processes:Array;
	
	private var className:String = "BatchMovieClipLoader";
	private var console:Function;
	
	function BatchMovieClipLoader() {
		
		TestConsole.init( this );
		
		this.processes = new Array( );
	}
	
	/**
	* Create a loading process
	* 
	* @return
	*/
	public function createProcess( ):Number {
		var process:LoadingProcess = new LoadingProcess( );
		var id:Number = this.processes.push( process );
		
		process.ID = id;
		process.onLoadProgress = Delegate.create( this, processLoadProgress );
		process.onLoadComplete = Delegate.create( this, processLoadComplete );
		process.onTargetLoaded = Delegate.create( this, processTargetLoaded );
		
		console( "Process " + id + " created" );
		
		return id;
	}
	
	private function processTargetLoaded( process:LoadingProcess, target:MovieClip ):Void {
		
		this.onTargetLoaded( process, target );
		
	}
	
	private function processLoadProgress( process:LoadingProcess ):Void {
		
		this.onLoadProgress( process );
		
	}
	
	private function processLoadComplete( process:LoadingProcess ):Void {
		
		this.onLoadComplete( process );
		
	}
	
	/**
	* Add a file to a process
	* 
	* @param	processID
	* @param	url
	* @param	container
	*/
	public function addFileToProcess( processID:Number, url:String, container:MovieClip ):Void {
		var process:LoadingProcess = getProcessByID( processID );
		process.addFile( url, container );
	}
	
	/**
	* start loading
	* 
	* @param	processID
	*/
	public function startLoadingProcess( processID:Number ):Void {
		var process:LoadingProcess = getProcessByID( processID );
		process.startLoading( );
	}
	
	/**
	* Get a process by a ID returned by startProcess method
	* 
	* @param	processID
	* @return
	*/
	public function getProcessByID( processID:Number ):LoadingProcess {
		return this.processes[ processID - 1 ];
	}
}
