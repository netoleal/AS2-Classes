import com.netoleal.events.SliderEvent;
import com.netoleal.v6.fx.listeners.MotionListener;
import com.robertpenner.easing.Quart;
import mx.utils.Delegate;
import com.netoleal.events.Dispatcher;
import com.netoleal.v6.fx.AnimatedMovieClip;
import com.netoleal.desenv.TestConsole;

class com.netoleal.controllers.SliderController extends Dispatcher {
	
	private var track:MovieClip;
	private var tracker:MovieClip;
	
	private var min:Number = 0;
	private var max:Number = 100;
	
	private var oldTrackerOnPress:Function;
	private var oldTrackerOnRelease:Function;
	private var oldTrackerOnReleaseOutside:Function;
	
	private var className:String = "controllers.SliderController";
	private var console:Function;
	
	/**
	* Constructor
	* 
	* @param	track MovieClip usead as track for slider. Registration must be left
	* @param	tracker MovieClip that will be dragged by user. Registration must be left
	*/
	function SliderController( track:MovieClip, tracker:MovieClip) {
		
		super( );
		
		TestConsole.init( this );
		
		this.console( "created!" );
		
		this.track = track;
		this.tracker = tracker;
		
		this.oldTrackerOnPress = this.tracker.onPress;
		this.oldTrackerOnRelease = this.tracker.onRelease;
		this.oldTrackerOnReleaseOutside = this.tracker.onReleaseOutside;
		
		AnimatedMovieClip.inherit( this.tracker );
		
		this.init( );
	}
	
	/**
	* Get current value between 0 and 100
	* 
	* @return
	*/
	public function getValue( ):Number {
		var x:Number = this.tracker._x - this.track._x;
		var xMax:Number = this.track._width - this.tracker._width;
		
		return x / xMax * 100;
	}
	
	public function setValue( percentage:Number ):Void {
		
		percentage = Math.min( 100, Math.max( 0, percentage ) );
		
		var xMax:Number = this.track._width - this.track._width;
		var x:Number = this.track._x + ( percentage * xMax / 100 );
		
		var motion:MotionListener = AnimatedMovieClip( this.tracker ).move( x, this.tracker._y, 350, Quart.easeOut );
		motion.onUpdate = Delegate.create( this, this.onMouseMove );
	}
	
	/**
	* Initalize
	*/
	private function init( ):Void {
		
		this.tracker._x = Math.min( Math.max( tracker._x, track._x + tracker._width ), track._x + track._width - tracker._width );
		
		this.tracker.onPress = Delegate.create( this, this.dragTracker );
		this.tracker.onRelease = Delegate.create( this, this.stopDragTracker );
		this.tracker.onReleaseOutside = Delegate.create( this, this.releaseOutsideTracker );
		
	}
	
	private function releaseOutsideTracker( ):Void {
		this.oldTrackerOnReleaseOutside( );
		this.stopDragTracker( );
	}
	
	/**
	* Start dragging tracker
	*/
	private function dragTracker( ):Void {
		
		var xMin:Number = this.track._x;
		var xMax:Number = this.track._x + this.track._width - this.tracker._width;
		
		this.tracker.startDrag( false, xMin, this.tracker._y, xMax, this.tracker._y );
		Mouse.addListener( this );
		
		this.oldTrackerOnPress( );
		this.dispatchEvent( new SliderEvent( SliderEvent.START_CHANGE ) );
		
	}
	
	/**
	* Stop dragging tracker
	*/
	private function stopDragTracker( ):Void {
		this.tracker.stopDrag( );
		Mouse.removeListener( this );
		this.oldTrackerOnRelease( );
		
		this.dispatchEvent( new SliderEvent( SliderEvent.STOP_CHANGE ) );
	}
	
	private function onMouseMove( ):Void {
		
		this.dispatchEvent( new SliderEvent( SliderEvent.CHANGE ) );
		updateAfterEvent( );
	}
}
