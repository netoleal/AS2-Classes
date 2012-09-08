import com.netoleal.desenv.TestConsole;
import com.netoleal.events.Event;
import com.netoleal.events.EventDispatcher;
import mx.utils.Delegate;
/**
* com.netoleal.xml.XMLDispatcher
*
* @author Neto Leal
* @version 0.1
*/

dynamic class com.netoleal.xml.XMLDispatcher extends EventDispatcher {

	private var _xml:XML;
	private var className:String = "xml.XMLDispatcher";
	private var console:Function;
	
	public function XMLDispatcher( xmlString:String ) {
		TestConsole.init( this );
		
		_xml = new XML( xmlString );
		_xml.ignoreWhite = true;
		_xml.onLoad = Delegate.create( this, onLoad );
	}
	
	public function load( url:String ):Void {
		_xml.load( url );
	}
	
	public function get firstChild( ):XMLNode {
		return _xml.firstChild;
	}
	
	private function getXMLDocument( ):XML {
		return new XML( _xml.cloneNode( true ).toString( ) );
	}
	
	private function onLoad( success:Boolean ):Void {
		if( success ){
			this.dispatchEvent( new Event( Event.COMPLETE ) );
		} else {
			this.dispatchEvent( new Event( Event.ERROR ) );
		}
	}
	
}