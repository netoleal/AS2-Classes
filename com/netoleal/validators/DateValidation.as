import com.netoleal.interfaces.IIterator;
import com.netoleal.interfaces.IValidation;
import com.netoleal.iterators.AscendingArrayIterator;

class com.netoleal.validators.DateValidation implements IValidation {
	
	private var dates:Array;
	
	function DateValidation()
	{
		
	}
	
	/**
	* Create validation parameters;
	* 
	* @param	args An array containing all dates to be validated.
	* Example:
	* 	dateValidation.create( [
	* 								20, 5, 2000,
	* 								35, 6, 2999
	* 							] );
	* 
	* 	In this case, two dates will be tested. 
	* 	The validation result will be false, because 35/6/2999 is not a valid date.
	*/
	public function create( args:Array ):Void {
		var n:Number;
		var t:Number = args.length;
		
		var day		:Number;
		var month	:Number;
		var year 	:Number;
		
		var record:Object;
		this.dates = new Array();
		
		for( n = 0; n < t; n += 3 ){
			day 	= args[ n ];
			month 	= args[ n + 1 ];
			year 	= args[ n + 2 ];
			
			record = { day: day, month: month - 1, year: year };
			this.dates.push( record );
		}
	}
	
	/**
	* Perform validation
	* 
	* @return
	*/
	public function validate( ):Boolean {
		var it:IIterator = new AscendingArrayIterator( this.dates );
		var dateRecord:Object;
		var date:Date;
		
		while( it.hasNext( ) ){
			dateRecord = it.next( );
			date = new Date( dateRecord.year, dateRecord.month, dateRecord.day, 0, 0, 0, 0 );
			
			if( date.getDate( ) != dateRecord.day || date.getMonth( ) != dateRecord.month || date.getFullYear( ) != dateRecord.year ){
				return false;
			}
		}
		
		return true;
	}
}
