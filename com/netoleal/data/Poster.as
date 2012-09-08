import com.netoleal.events.EventDispatcher;
import mx.utils.Delegate;
import com.netoleal.events.Dispatcher;
import com.netoleal.events.PosterEvent;

class com.netoleal.data.Poster extends EventDispatcher
{
	
	private var lvSend:LoadVars;
	private var lvReceive:LoadVars;
		
	function Poster()
	{
		super( );
		
		this.lvReceive = new LoadVars();
		this.lvSend = new LoadVars();
	}
	
	/**
	* Send all values informed on "data" to a url.
	* 
	* @param	url url of the server file that will receive the data
	* @param	data object containing keys and values to be sent to server.
	*/
	public function send( url:String, data:Object ):Void {
		
		this.clear( );
		for( var n in data ){
			this.lvSend[ n ] = data[ n ];
		}
		
		this.lvReceive.onLoad = Delegate.create( this, this.onLoadEvent );
		this.lvSend.sendAndLoad( url, this.lvReceive, "POST" );
	}
	
	/**
	* Listen to lvReceive.onLoad
	* 
	* @param	success
	*/
	private function onLoadEvent( success:Boolean ):Void {
		var ev:PosterEvent;
		
		if( success ){
			delete this.lvReceive.onLoad;
			
			ev = new PosterEvent( PosterEvent.SENT );
			ev.result = this.lvReceive;
			
			this.dispatchEvent( ev );
		} else {
			ev = new PosterEvent( PosterEvent.ERROR );
			ev.errorMessage = "Error sending data";
			
			this.dispatchEvent( ev );
		}
	}
	
	public function getData( ):Object {
		return this.lvReceive;
	}
	
	private function clear( ):Void {
		for( var n in this.lvSend ) {
			delete this.lvSend[ n ];
		}
	}
}
