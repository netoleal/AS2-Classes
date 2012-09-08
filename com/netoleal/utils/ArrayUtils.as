
class com.netoleal.utils.ArrayUtils
{
	private function ArrayUtils() {
		// STATIC CLASS. SHOULD NOT BE INSTANTIATED
	}
	
	/**
	* Randomize array items without modify the original array.
	* 
	* @param	targetArray - a array to randomize
	* @return a new array instance with the same members of targetArray but randomized.
	*/
	public static function randomize( targetArray:Array ):Array {
		var ar:Array = targetArray.concat( );
		
		var aux:Array = new Array( );
		var n:Number;
		
		while( ar.length > 0 ){
			n = Math.round( Math.random() * ( ar.length - 1 ) );
			aux.push( ar[ n ] );
			
			ar.splice(n, 1 );
		}
		
		return aux;
	}
}
