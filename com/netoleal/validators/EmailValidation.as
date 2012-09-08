import com.netoleal.interfaces.IIterator;
import com.netoleal.interfaces.IValidation;
import com.netoleal.iterators.AscendingArrayIterator;

// Email validation logic from http://www.svendens.be/blog/archives/9
// All rights reserved to original author: Sven Dens.

class com.netoleal.validators.EmailValidation implements IValidation {
	
	private var emails:Array;
	
	private var i:Number;
	private var j:Number;
	private var l:Number; 
	private var foundPoint;
	
	function EmailValidation( ) { }
	
	/**
	* Create validation parameters
	* 
	* @param	args An array containing all emails to be validated
	*/
	public function create( args:Array ):Void {
		this.emails = args.concat( );
	}
	
	/**
	* Perform validation
	* TODO: implement me
	* @return
	*/
	public function validate( ):Boolean {
		
		var it:IIterator = new AscendingArrayIterator( this.emails );
		var email:String;
		
		while( it.hasNext( ) ){
			email = it.next( );
			if( !checkEmail( email ) ){
				return false;
			}
		}
		
		return true;
	}
	
	public function checkEmail (e:String):Boolean {
		foundPoint = false;
		l = e.length;
		i = checkChars(e, 0, l);
		
		if(i <= 0) { return false; }
		j=i;

		while (i < l && e.charAt(i) == ".") {
			i++;
			j = checkChars(e, i, l);
			if (j == i) { return false; }
			i = j;
		}
		
		if (e.charAt(i) != "@"){
			return false;
		}

		do {
			i = j+1;
			j = checkChars(e, i, l);
			
			if (j == i) {
				return false;
			} else if (j == l) {
				j -= i;
				if(foundPoint && j>=2 && checkFirstLevelDomainChars(e, i, l)){
					return true;
				} else {
					return false;
				}
			}
			foundPoint = (e.charAt(j) == ".");
		} 
		while (i < l && foundPoint);
		return false;
	}
	
	private function checkChars (s:String, i:Number, l:Number):Number {
		while (i < l && ("_-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").indexOf(s.charAt(i)) != -1){
			i++;
		}
		return i;
	}
	
	private function checkFirstLevelDomainChars (s:String, i:Number, l:Number):Boolean {
		while (i < l && ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").indexOf(s.charAt(j)) != -1) {
			i++;
		}
		return (i == l);
	}
}
