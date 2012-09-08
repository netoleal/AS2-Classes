
//Basic class for events
class com.netoleal.events.Event {
	
	public static var COMPLETE:String = "complete";
	public static var ERROR:String = "error";
	
	private var _type:String;
	private var _target:Object;
	
	//Constructor
	public function Event(sType:String){
		_type = sType;
	}
	
	public function get type( ):String{
		return _type;
	}
	
	public function set target(value:Object):Void{
		_target = value;
	}
	
	public function get target( ):Object{
		return _target;
	}
	
}