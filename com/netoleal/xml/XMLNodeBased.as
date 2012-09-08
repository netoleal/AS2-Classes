
class com.netoleal.xml.XMLNodeBased {
	
	private var _node:XMLNode;
	
	public function XMLNodeBased( xNode:XMLNode ){
		_node = xNode;
	}
	
	public function get node( ):XMLNode {
		return _node.cloneNode( true );
	}
	
	public function get attributes( ):Object {
		return _node.attributes;
	}
	
	public function toString( ):String {
		return "[XMLNodeBased -> " + _node + "]";
	}
}
