
class com.netoleal.utils.Interval
{
	private var id:Number;
	private var delay:Number = 50;
	
	private var loopCount:Number;
	private var nLoops:Number;
	
	private var callback:Function;
	private var args:Array;
	private var scope:Object;
	
	/**
	* 
	* @param	callbackFunction Function to be called between intervals
	* @param	args
	* @param	scope
	* @param	delay Interval delay. Default is 50 milliseconds
	*/
	function Interval( callbackFunction:Function, scope:Object, delay:Number, args:Array ) {
		if( delay != null ){
			this.delay = delay;
		}
		
		this.callback = callbackFunction;
		this.args = [ ].concat( args );
		this.scope = scope;
	}
	
	/**
	* Start calling callbackFunction
	* 
	* @param	loops [Optional]. Number of times to call the function
	*/
	public function start( loops:Number ):Void {
		this.nLoops = loops;
		this.loopCount = 0;
		
		this.stop( );
		this.id = setInterval( this, "intervalHandler", this.delay );
	}

	private function intervalHandler( callback:Function ):Void {
		this.loopCount++;
		this.callback.apply( this.scope, this.args );
		
		if( this.nLoops != null && this.loopCount >= this.nLoops ) {
			this.stop( );
		}
	}
	
	/**
	* Stop looping
	* 
	* @return
	*/
	public function stop( ):Void {
		if( this.id != null ){
			clearInterval( this.id );
		}
		
		this.id = null;
	}
	
	/**
	* Return the id from setInterval of this interval
	* 
	* @return
	*/
	public function getID( ):Number {
		return this.id;
	}
	
	/**
	* Get the loop number
	* 
	* @return
	*/
	public function getLoopNumber( ):Number {
		return this.loopCount;
	}
}
