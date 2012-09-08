/**
* USAGE ===================================
* 

import com.netoleal.utils.IntervalManager;
import com.netoleal.utils.Interval;

var obj:Object = new Object;
obj.testProperty = "Testing";

var interval:Interval = IntervalManager.start( testInterval, obj, 200, [ 10, "hi" ], 3 );

function testInterval( arg1:Number, arg2:String ):Void {
	
	trace( [ arg1, arg2 ] );
	trace( this.testProperty );
	
	if( interval.getLoopNumber( ) == 2 ){
		interval.stop( );
	}
	
}

* 
* 
*/

import com.netoleal.utils.Interval;

class com.netoleal.utils.IntervalManager {
	
	private function IntervalManager( Void ){
		// Static class - private constructor
	}
	
	/**
	* Start looping and return a reference for interval object
	* 
	* @param	callback Function to be called
	* @param	scope This object inside the callback
	* @param	delay Delay between callback calls
	* @param	args Arguments for callback
	* @param	loops number of time to execute callback. If null, a infinite loop will be created
	* @return An Interval object
	*/
	public static function start( callback:Function, scope:Object, delay:Number, args:Array, loops:Number ):Interval {
		var interval:Interval = new Interval( callback, scope, delay, args );
		interval.start( loops );
		return interval;
	}
	
	/**
	* Stop interval
	* 
	* @param	interval
	*/
	public static function stop( interval:Interval ):Void {
		interval.stop( );
	}
	
}