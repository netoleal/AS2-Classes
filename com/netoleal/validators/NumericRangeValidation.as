import com.netoleal.interfaces.IIterator;
import com.netoleal.interfaces.IValidation;
import com.netoleal.iterators.AscendingArrayIterator;

class com.netoleal.validators.NumericRangeValidation implements IValidation {
	
	private var numbers:Array;
	
	function NumericRangeValidation( ) { }
	
	/**
	* Create validation parameters
	* 
	* @param	args An array containing all numbers with their ranges
	* Example:
	*	numericRange.create( [ 	10, 
	* 								5, 20, 
	* 							36,
	* 								24, 60,
	* 							80,
	* 								90, 100
	* 						] );
	* 
	* 	The validation will compare 10 between 5 and 20, 36 between 24, 60 and 80 between 90 and 100. 
	* 	In this case the result is false because 80 is not between 90 and 100.
	*/
	public function create( args:Array ):Void {
		
		var n:Number;
		var t:Number = args.length;
		
		var num:Number;
		var rMin:Number;
		var rMax:Number;
		
		var record:Object;
		this.numbers = new Array();
		
		for( n = 0; n < t; n += 3 ) {
			num = args[ n ];
			rMin = args[ n + 1 ];
			rMax = args[ n + 2 ];
			
			record = { num: num, min: rMin, max: rMax };
			this.numbers.push( record );
		}
	}
	
	/**
	* Perform validation
	* 
	* @return
	*/
	public function validate( ):Boolean {
		
		var it:IIterator = new AscendingArrayIterator( this.numbers );
		var record:Object;
		
		while( it.hasNext( ) ){
			record = it.next( );
			
			if( record.num < record.min || record.num > record.max ){
				return false;
			}
			
		}
		
		return true;
	}
	
}
