import com.netoleal.interfaces.ICollection;
import com.netoleal.interfaces.IIterator;
import com.netoleal.iterators.AscendingArrayIterator;

class com.netoleal.collections.AbstractCollection implements ICollection {
	
	private var _items:Array;
	
	function AbstractCollection() {
		this._items = new Array();
	}
	
	/**
	* Add an item
	* 
	* @param	item
	*/
	public function addItem( item:Object ):Void {
		this._items.push( item );
	}
	
	/**
	* Remove an item
	* 
	* @param	item
	*/
	public function removeItem( item:Object ):Void {
		var it:AscendingArrayIterator = new AscendingArrayIterator( this._items );
		while( it.hasNext( ) ){
			if( it.next( ) == item ){
				this._items.splice( it.index( ), 1 );
				return;
			}
		}
	}
	
	/**
	* Get items iterator
	* 
	* @return
	*/
	public function iterator( ):IIterator {
		return new AscendingArrayIterator( this._items );
	}
	
	/**
	* Clone the collection
	* 
	* @return
	*/
	public function clone( ):ICollection {
		var col:ICollection = new AbstractCollection( );
		var it:IIterator = this.iterator( );
		while( it.hasNext( ) ){
			col.addItem( it.next( ) );
		}
		
		return col;
	}
	
	/**
	* Get an item at a index
	* 
	* @param	index
	* @return
	*/
	public function getItemAt( index:Number ):Object {
		return this._items[ index ];
	}
	
	/**
	* Get the length of the collection
	* 
	* @return
	*/
	public function count( ):Number {
		return this._items.length;
	}
}
