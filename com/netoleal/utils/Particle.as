import mx.utils.Delegate;
import mx.transitions.OnEnterFrameBeacon;

class com.netoleal.utils.Particle extends com.bit101.Particle {
	public var onMove:Function;
	
	private var _xclip:MovieClip;
	private var _yclip:MovieClip;
	
	private var _tx:Number;
	private var _ty:Number;
	
	private var _fx:Number = 0;
	private var _fy:Number = 0;
	
	private var _efElastic:Object;
	private var _efEasing:Object;
	
	private var _tye:Number;
	private var _txe:Number;
	
	private var _elast:Number = 0.6;
	private var _ease:Number = 4;
	private var _easeElastic:Boolean = false;
	
	public function Particle(){
		OnEnterFrameBeacon.init();
		
		_efElastic = {};
		_efElastic.onEnterFrame = Delegate.create(this, enterFrame);
		
		_efEasing = {};
		_efEasing.onEnterFrame = Delegate.create(this, enterFrameEasing);
		
		_global.MovieClip.addListener(_efElastic);
		
	}
	
	private function enterFrame():Void{
		if(_xclip != undefined)	_tx = _xclip._x;			
		if(_tx != undefined) 	_x += _fx = _fx * _elast + (_tx - _x) / _ease;
		
		if(_yclip != undefined) _ty = _yclip._y;
		if(_ty != undefined) 	_y += _fy = _fy * _elast + (_ty - _y) / _ease;
		
		onMove();
	}
	
	public function get elasticidade():Number{
		return _elast;
	}
	
	public function set elasticidade(v:Number):Void{
		_elast = v;
	}
	
	public function get ease():Number{
		return _ease;
	}
	
	public function set ease(v:Number):Void{
		_ease = v;
	}
	
	private function enterFrameEasing():Void{
		if(_tye != undefined){
			if(_easeElastic) _y += _fy = _fy * _elast + (_tye - _y) / _ease;
			else _y += (_tye - _y) / _ease;
		}
		
		if(_txe != undefined){
			if(_easeElastic) _x += _fx = _fx * _elast + (_txe - _x) / _ease;
			else _x += (_txe - _x) / _ease;
		}
		
		if(Math.round(_y) == Math.round(_tye) && !_easeElastic){
			_y = _tye;
			_tye = undefined;
		}
		
		if(Math.round(_x) == Math.round(_txe) && !_easeElastic){
			_x = _txe;
			_txe = undefined;
		}
		
		if(_tye == undefined && _txe == undefined){
			_global.MovieClip.removeListener(_efEasing);
		}
		
		onMove();
	}
	
	public function set springXClip(value:MovieClip):Void{
		_txe = null;
		_xclip = value;
	}
	
	public function get springXClip():MovieClip{
		return _xclip;
	}
	
	public function set springYClip(value:MovieClip):Void{
		_tye = null;
		_yclip = value;
	}
	
	public function get springYClip():MovieClip{
		return _yclip;
	}
	
	public function set easeElastic(v:Boolean):Void{
		_easeElastic = v;
	}
	
	public function get easeEleastic():Boolean{
		return _easeElastic;
	}
	
	public function gotoY(y:Number):Void{
		_tye = y;
		_global.MovieClip.addListener(_efEasing);
	}
	
	public function gotoX(x:Number):Void{
		_txe = x;
		_global.MovieClip.addListener(_efEasing);
	}
	
	public function cancelGotoY():Void{
		_tye = null;
		_global.MovieClip.removeListener(_efEasing);
	}
	
	public function cancelGotoX():Void{
		_txe = null;
		_global.MovieClip.removeListener(_efEasing);
	}
}