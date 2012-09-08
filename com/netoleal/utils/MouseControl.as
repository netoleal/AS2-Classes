import mx.utils.Delegate;

class com.netoleal.utils.MouseControl {
	private var _moving:Boolean;
	private static var _instance:MouseControl;
	
	private var _control:MovieClip;
	private var _prevX:Number;
	private var _prevY:Number;
	
	public static var onStop:Function;
	public static var onStart:Function;
	public static var onMove:Function;
	
	private static var _cursors:Object;
	private static var _activecursor:MovieClip;
	private static var _activeCursorKey:String;
	
	private var broadcastMessage:Function;
	private var addListener:Function;
	private var removeListener:Function;
	
	private static var _velocity:Number;
	private static var _velocityx:Number;
	private static var _velocityy:Number;
	
	private function MouseControl(){
		//Contrutor privado para SingleTon
		
		AsBroadcaster.initialize(this);
		_control = _root.createEmptyMovieClip("$_MouseControl_control", -0xFFFF);
		_control.onEnterFrame = Delegate.create(this, verificaMovimento);
		_control.onMouseMove = Delegate.create(this, moveMouse);
	}
	
	public static function addObjectListener(listener:Object):Void{
		getInstance().addListener(listener);
	}
	
	public static function removeObjectListener(listener:Object):Void{
		
		getInstance().removeListener(listener);
	}
	
	public static function registerCursor(name:String, instance:MovieClip):Void{
		if(_cursors == undefined)_cursors = new Object();
		_cursors[name] = instance;
		instance._visible = false;
	}
	
	public static function changeCursor(name:String):Void{
		delete _activecursor.onMouseMove;
		_activecursor._visible = false;
		
		Mouse.hide();
		_activecursor = _cursors[name];
		_activeCursorKey = name;
		
		_activecursor._visible = true;
		_activecursor.swapDepths(_activecursor._parent.getNextHighestDepth());
		_activecursor.onMouseMove = Delegate.create(MouseControl, moveEventCursor);
		_activecursor._x = _activecursor._parent._xmouse;
		_activecursor._y = _activecursor._parent._ymouse;
	}
	
	public static function getActiveCursorKey( Void ):String {
		return _activeCursorKey;
	}
	
	private static function moveEventCursor():Void{
		_activecursor._x = _activecursor._parent._xmouse;
		_activecursor._y = _activecursor._parent._ymouse;
		updateAfterEvent();
	}
	
	public static function restoreCursor():Void{
		delete _activecursor.onMouseMove;
		_activecursor._visible = false;
		_activeCursorKey = null;
		Mouse.show();
	}
	
	public static function initialize():MouseControl{
		return getInstance();
	}
	
	private function verificaMovimento():Void{
		if(_prevX != undefined){
			if(_root._xmouse == _prevX && _root._ymouse == _prevY && _moving){
				_moving = false;
				onStop();
				broadcastMessage("onStop");
			}else{					
				var distx:Number = (_root._xmouse - _prevX);
				var disty:Number = (_root._ymouse - _prevY);
				
				var dist:Number = Math.sqrt(Math.pow(distx, 2) + Math.pow(disty, 2));
				
				_velocity = dist;
				_velocityx = distx;
				_velocityy = disty;
			}
			
		}
		_prevX = _root._xmouse;
		_prevY = _root._ymouse;
	}
	
	public static function get xvelocity():Number{
		return _velocityx;
	}
	
	public static function get yvelocity():Number{
		return _velocityy;
	}
	
	public static function get velocity():Number{
		return _velocity;
	}
	
	private function moveMouse():Void{
		if(!_moving){
			onStart();
			broadcastMessage("onStart");
			_moving = true;
		}
		onMove();
		broadcastMessage("onMove");
	}
	
	public static function getInstance():MouseControl{
		if(_instance == undefined){
			_instance = new MouseControl();
		}
		return _instance;
	}
}