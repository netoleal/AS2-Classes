import mx.utils.Delegate;

class com.netoleal.media.Mp3Control
{
	public var onLoad:Function;
	public var onUpdate:Function;
	public var onComplete:Function;
	public var onID3:Function;
	
	private var _sound:Sound;
	private var _stream:Boolean;
	private var _scope:Object;
	
	private var _interval:Number;
	
	private var _pausePoint:Number;
	private var _paused:Boolean;
	
	function Mp3Control( scope:Object, isStream:Boolean )
	{
		_scope = scope;
		_stream = isStream;
	}
	
	public function load( path:String ):Void {
		_sound = new Sound( _scope );
		_sound.loadSound( path, _stream );
		
		_sound.onLoad = Delegate.create( this, loadEvent );
		_sound.onSoundComplete = Delegate.create( this, completeEvent );
		
		_paused = false;
		createInterval( );
	}
	
	public function play( Void ):Void {
		if( paused ) unpause( );
		else {
			_sound.start( );
			_paused = false;
			createInterval( );
		}
	}
	
	public function setVolume( percent:Number ):Void {
		_sound.setVolume( percent );
	}
	
	public function getVolume( Void ):Number {
		return _sound.getVolume( );
	}
	
	public function stop( Void ):Void {
		_sound.stop( );
		_paused = false;
		cancelInterval( );
	}
	
	public function pause( Void ):Void {
		if( paused ) return;
		
		cancelInterval( );
		_paused = true;
		_pausePoint = position;
		_sound.stop ();
	}
	
	public function unpause( Void ):Void {
		if( !paused ) return;
		
		createInterval( );
		_paused = false;
		_sound.start( _pausePoint / 1000 );
	}
	
	public function get paused( ):Boolean {
		return _paused;
	}
	
	public function seek( seconds:Number ):Void {
		_sound.stop( );
		_sound.start( seconds );
		createInterval( );
	}
	
	public function get id3( ):Object {
		return _sound.id3;
	}
	
	public function get duration( ):Number {
		return _sound.duration;
	}
	
	public function get position( ):Number {
		return _sound.position;
	}
	
	public function get loadProgress( ):Object {
		return {bytesLoaded: _sound.getBytesLoaded, bytesTotal: _sound.getBytesTotal};
	}
	
	public function get progress( ):Number {
		return _sound.position / _sound.duration * 100 ;
	}
	
	private function id3Event( Void ):Void {
		onID3( _sound.id3 );
	}
	
	private function loadEvent( Void ):Void {
		onLoad( );
	}
	
	private function completeEvent( Void ):Void {
		onComplete( );
	}
	
	private function checkProgress( Void ):Void {
		onUpdate( { time: _sound.position, duration: _sound.duration, percent: progress } );
	}
	
	private function createInterval( Void ):Void {
		cancelInterval( );
		_interval = setInterval( this, "checkProgress", 50 );
	}
	
	private function cancelInterval( Void ):Void {
		if( _interval != null ){
			clearInterval( _interval );
		}
		
		_interval = null;
	}
}
