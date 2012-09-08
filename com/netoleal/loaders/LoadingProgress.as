
class com.netoleal.loaders.LoadingProgress {
	
	private var _bytesLoaded:Number;
	private var _bytesTotal:Number;
	
	public function LoadingProgress( loaded:Number, total:Number ){
		this._bytesLoaded = loaded;
		this._bytesTotal = total;
	}
	
//{ GETTER-SETTER
	/**
	* Total bytes of loading progress
	*  
	*  @return Number
	*/
	public function get bytesTotal():Number {
		return this._bytesTotal;
	}
	/**
	* loaded bytes of loading progress
	*  
	*  @return Number
	*/
	public function get bytesLoaded():Number {
		return this._bytesLoaded;
	}
	
	/**
	* Percentage of loading process
	* 
	* @return
	*/
	public function get percentage( ):Number {
		return this.bytesLoaded / this.bytesTotal * 100;
	}
//}
	
}