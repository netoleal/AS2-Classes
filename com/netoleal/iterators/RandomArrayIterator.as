import com.netoleal.interfaces.IIterator;
import com.netoleal.iterators.AscendingArrayIterator;
import com.netoleal.utils.ArrayUtils;

class com.netoleal.iterators.RandomArrayIterator implements IIterator {
	
	private var _completeArray:Array;
	private var _indexes:Array;
	private var _index:Number;
	
	private var _indexesIterator:IIterator;
	
	private var isInfinity:Boolean = false;
	
	function RandomArrayIterator( targetArray:Array ){
		
		this._completeArray = targetArray.concat( );
		this.populateIndexesArray( );
		
	}
	
	private function populateIndexesArray( Void ):Void {
		var ar:Array = new Array();
		var it:IIterator = new AscendingArrayIterator( this._completeArray );
		var temp:Object;
		
		while( it.hasNext( ) ){
			temp = it.next( );
			ar.push( it.index( ) );
		}
		
		this._indexes = ArrayUtils.randomize( ar );
		this._indexesIterator = new AscendingArrayIterator( this._indexes );
	}
	
	/**
	* Set if iteration is endless.
	* Default is false.
	* 
	* @param	trueIfInfinity
	*/
	public function setInfinity( trueIfInfinity:Boolean ):Void {
		this.isInfinity = ( trueIfInfinity != null && trueIfInfinity != undefined )? trueIfInfinity: false;
	}
	
	public function hasNext( ):Boolean {
		return this._indexesIterator.hasNext( ) || this.isInfinity;
	}
	
	public function next( ){
		if( !this._indexesIterator.hasNext( ) && this.isInfinity ){
			this.populateIndexesArray( );
		}
		return this._completeArray[ this._indexesIterator.next( ) ];
	}
	
	public function current( ){
		return this._completeArray[ this._indexesIterator.current( ) ];
	}
	
	public function first( ){
		return this._completeArray[ this._indexesIterator.first( ) ];
	}
	
	public function last( ){
		return this._completeArray[ this._indexesIterator.last( ) ];
	}
	
	public function index( ):Number{
		return this._indexes[ this._indexesIterator.index( ) ];
	}
}
