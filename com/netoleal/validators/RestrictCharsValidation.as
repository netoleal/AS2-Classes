import com.netoleal.interfaces.IValidation;

class com.netoleal.validators.RestrictCharsValidation implements IValidation {
	
	private var args:Array;
	
	function RestrictCharsValidation( ) { }
	
	/**
	* Create validation parameters
	* 
	* @param	args An array containing all validation parameters
	* Example:
	* 	restrictValidation.create( [
	* 									"a", "abc",
	* 									50, "01234" ] );
	* 
	* In this case the validation will fail because 50 has the "5" character that isn't in the restriction "01234".
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
		var n:Number;
		var t:Number = this.args.length;
		
		var text:String;
		var chars:String;
		
		for( n = 0; n < t; n += 2 ){
			text = String( this.args[ n ] );
			chars = String( this.args[ n + 1 ] );
			
			if( !checkText( text, chars ) ){
				return false;
			}
		}
		
		return true;
	}
	
	private function checkText( text:String, chars:String ):Boolean {
		var n:Number;
		var t:Number = text.length;
		
		for( n = 0; n < t; n++ ){
			if( chars.indexOf( text.charAt( n ) ) == -1 ){
				return false;
			}
		}
		
		return true;
	}
}
