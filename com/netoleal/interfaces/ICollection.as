import com.netoleal.interfaces.IIterator;

interface com.netoleal.interfaces.ICollection {
	
	public function addItem( item:Object ):Void;
	public function removeItem( item:Object ):Void;
	public function getItemAt( index:Number ):Object;
	public function iterator( ):IIterator;
	public function clone( ):ICollection;
	public function count( ):Number;
	
}
