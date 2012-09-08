import com.netoleal.interfaces.IIterator;
import com.netoleal.interfaces.IValidation;
import com.netoleal.iterators.AscendingArrayIterator;

class com.netoleal.validators.IsSetValidation implements IValidation {
	
	private var args:Array;
	
	function IsSetValidation() { }
	
	/**
	* Create validation parameters
	* 
	* @param	args
	*/
	public function create( args:Array ):Void {
		this.args = args.concat( );
	}
	
	/**
	* Perform validation
	* 
	* @return
	*/
	public function validate( ):Boolean {
		var it:IIterator = new AscendingArrayIterator( this.args );
		var value:Object;
		
		while( it.hasNext( ) ){
			value = it.next( );
			
			if( value == null || value == undefined ){
				return false;
			}
		}
		
		return true;
	}
	
}
