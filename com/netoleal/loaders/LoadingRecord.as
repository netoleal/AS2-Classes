
class com.netoleal.loaders.LoadingRecord
{
	public var bytesLoaded:Number;
	public var bytesTotal:Number;
	
	public var loaded:Boolean;
	
	private var _url:String;
	private var _container:MovieClip;
	
	public function LoadingRecord( pURL:String, pContainer:MovieClip ){
		this.loaded = false;
		
		this._url = pURL;
		this._container = pContainer;
	}
	
	public function get url( ):String {
		return this._url;
	}
	
	public function get container( ):MovieClip {
		return this._container;
	}
	
	public function get bytesProgress( ):Number {
		
		return this.bytesLoaded / this.bytesTotal * 100;
	}
	
}
