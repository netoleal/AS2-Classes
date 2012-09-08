import com.netoleal.interfaces.IValidation;
import com.netoleal.interfaces.IIterator;
import com.netoleal.iterators.AscendingArrayIterator;

class com.netoleal.validators.NotEmptyValidation implements IValidation {
	
	private var texts:Array;
	
	function NotEmptyValidation( ) { }
	
	/**
	* Create validation parameters.
	* 
	* @param	args An array contaning texts to validate
	*/
	public function create( args:Array ):Void{
		this.texts = args.concat( );
	}
	
	/**
	* Return if all texts are not empty
	* 
	* @return
	*/
	public function validate( ):Boolean {
		var it:IIterator = new AscendingArrayIterator( this.texts );
		var text:String;
		
		while( it.hasNext( ) ){
			text = it.next( );
			
			if( text.split( " " ).join( "" ).length == 0 ){
				return false;
			}
		}
		
		return true;
	}
}
