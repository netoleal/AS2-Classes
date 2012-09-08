import com.netoleal.iterators.AscendingArrayIterator;

class com.netoleal.xml.XMLUtil {
	private function XMLUtil( Void ) {
		throw new Error("Static class. Should not be instantiated");
	}
	
	public static function getNodeByName(parentNode:XMLNode, name:String):XMLNode {
		var it:AscendingArrayIterator = new AscendingArrayIterator( parentNode.childNodes );
		var node:XMLNode;
		
		while( it.hasNext() ){
			node = it.next( );
			if( node.nodeName.toLowerCase() == name.toLowerCase() ){
				return node;
			}
		}
		
		return undefined;
	}
	
	public static function getChildNames( node:XMLNode ):Array {
		var ar:Array = new Array( );
		var it:AscendingArrayIterator = new AscendingArrayIterator( node.childNodes );
		
		while( it.hasNext( ) ){
			ar.push( XMLNode( it.next( ) ).nodeName );
		}
		
		return ar;
	}
	
	public static function getNodeGroupByAttribute(parentNode:XMLNode, nodeName:String, attributeName:String, value:String, matchDifferent:Boolean, Type:Function):Array{
		var childs:Array = parentNode.childNodes;
		var it:AscendingArrayIterator = new AscendingArrayIterator( childs );
		var childNode:XMLNode;
		var result:Array = new Array( );
		
		while( it.hasNext( ) ){
			childNode = it.next( );
			
			if(childNode.nodeName.toLowerCase( ) == nodeName.toLowerCase( )){
				if((matchDifferent && childNode.attributes[attributeName] != value) || 
				(!matchDifferent && childNode.attributes[attributeName] == value) || attributeName == ""){
					if(Type != undefined){
						result.push( new Type( childNode ) );
					}else{
						result.push( childNode );
					}
				}
			}
		}
		
		return result;
	}
	
	public static function getNodeContentByName(parentNode:XMLNode, name:String):String {
		var node:XMLNode = getNodeByName(parentNode, name);
		return node.firstChild.nodeValue;
	}
	
	public static function fillTypedArrayByXMLNode(parentNode:XMLNode, nodeName:String, Type:Function, filterAttribute:String, filterValue:String):Array {
		
		var node:XMLNode;
		node = (nodeName == "" || nodeName == null)? parentNode: XMLUtil.getNodeByName( parentNode, nodeName );
		
		var result:Array = new Array( );
		
		if( node.childNodes == undefined ) return result;
			
		var it:AscendingArrayIterator = new AscendingArrayIterator( node.childNodes );
		var childNode:XMLNode;
		
		while( it.hasNext( ) ){
			childNode = it.next( );
			if( ( filterAttribute == undefined && filterValue == undefined ) || childNode.attributes[ filterAttribute ] == filterValue ){
				result.push( new Type( childNode ) );
			}
		}
		
		return result;
	}
}
