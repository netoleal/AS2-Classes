import com.netoleal.desenv.TestConsole;
import com.netoleal.display.SimpleDisplayObject;
import com.netoleal.utils.Interval;
import com.netoleal.fx.listeners.MotionListener;
import com.robertpenner.easing.Linear;
import com.robertpenner.easing.Quart;
import de.alex_uhlmann.animationpackage.animation.Alpha;
import de.alex_uhlmann.animationpackage.animation.AnimationCore;
import de.alex_uhlmann.animationpackage.animation.IAnimatable;
import de.alex_uhlmann.animationpackage.animation.Move;
import de.alex_uhlmann.animationpackage.animation.Blur;
import com.netoleal.events.UIDispatcher;
import de.alex_uhlmann.animationpackage.animation.Scale;
import flash.filters.BlurFilter;

class com.netoleal.fx.AnimatedMovieClip extends SimpleDisplayObject {
	
	private var className:String = "AnimatedMovieClip";
	private var console:Function;
	
	private var __alpha:Alpha;
	private var __move:Move;
	private var __blur:Blur;
	private var __scale:Scale;
	
	function AnimatedMovieClip()
	{
		super( );
		
		this.init( );
	}
	
	public static function inherit( targetMC:MovieClip ):Void {
		trace( "[AnimatedMovieClip] inherit( " + targetMC + " )" );
		
		var proto:Object = AnimatedMovieClip.prototype;
		_global.ASSetPropFlags( proto, null, 6, true );
		for( var p in proto ) {
			if( p != "__constructor__" && p != "__proto__" ) {
				if( targetMC.__proto__[ p ] != undefined ) {
					trace( "[AnimatedMovieClip] !!WARNING!! member '" + p + "' in " + targetMC + " OVERRIDED by AnimatedMovieClip.inherit" );
				}
				targetMC.__proto__[ p ] = proto[ p ];
			}
		}
		targetMC.init( );
		_global.ASSetPropFlags( proto, null, 0, true );
	}
	
	private function init( ):Void {
		TestConsole.init( this );
		
		this.__alpha = new Alpha( this );
		this.__alpha.animationStyle( 300, Quart.easeOut );
		
		var blurFilter:BlurFilter = new BlurFilter( 100, 100 );
		
		this.__blur = new Blur( this, blurFilter );
		
		this.__move = new Move( this );
		this.__scale = new Scale( this );
	}
	
	public function scale( xScale:Number, yScale:Number, duration:Number, equation:Function, delay:Number, endCallback:Function ):MotionListener {
		if( this.__scale.isTweening( ) ) this.__scale.stop( );
		
		equation = ( equation == undefined || equation == null )? Linear.easeNone: equation;
		delay = ( delay == undefined )? 0: delay;
		
		xScale = ( xScale == null )? this._xscale: xScale;
		yScale = ( yScale == null )? this._yscale: yScale;
		
		var interval:Interval = new Interval( this.__scale.run, this.__scale, delay, [ xScale, yScale, duration, equation, endCallback ] );
		interval.start( 1 );
		
		return this.createListener( this.__scale );
	}
	
	public function blur( percentAmount:Number, duration:Number, equation:Function, delay:Number ):MotionListener {
		if( this.__blur.isTweening( ) ) this.__blur.stop( );
		
		equation = ( equation == undefined || equation == null )? Linear.easeNone: equation;
		delay = ( delay == undefined )? 0: delay;
		
		var interval:Interval = new Interval( this.__blur.animate, this.__blur, delay, [ this.__blur.getCurrentPercentage( ), percentAmount ] );
		interval.start( 1 );
		
		return this.createListener( this.__blur );
	}
	
	public function move( xTo:Number, yTo:Number, duration:Number, equation:Function, delay:Number, endCallback:Function ):MotionListener {
		if( this.__move.isTweening( ) ) this.__move.stop( );
		
		//console( "move( " + arguments + " )" );
		
		equation = ( equation == undefined || equation == null )? Linear.easeNone: equation;
		delay = ( delay == undefined )? 0: delay;
		
		var interval:Interval = new Interval( this.__move.run, this.__move, delay, [ xTo, yTo, duration, equation, endCallback ] );
		interval.start( 1 );
		
		this.__move.addEventListener( "onEnd", this );
		
		return this.createListener( this.__move );
	}
	
	public function fadeTo( value:Number, delay:Number, endCallback:Function ):MotionListener {
		if( this.__alpha.isTweening( ) ) this.__alpha.stop( );
		
		//console( "fadeTo( " + arguments + " )" );
		
		var interval:Interval = new Interval( this.__alpha.run, this.__alpha, delay, [ value, 300, endCallback ] );
		interval.start( 1 );
		
		this.__alpha.addEventListener( "onEnd", this );
		
		return this.createListener( this.__alpha );
	}
	
	public function fadeOut( endCallback:Function ):MotionListener {
		return this.fadeTo( 0, 0, endCallback );
	}
	
	public function fadeIn( endCallback:Function ):MotionListener {
		return this.fadeTo( 100, 0, endCallback );
	}
	
	private function onEnd( event:Object ):Void {
		
		AnimationCore( event.target ).removeAllEventListeners( );
		
	}
	
	private function createListener( animationTarget:AnimationCore ):MotionListener {
		
		var listener:MotionListener = new MotionListener( );
		
		animationTarget.addEventListener( "onStart", listener );
		animationTarget.addEventListener( "onUpdate", listener );
		animationTarget.addEventListener( "onEnd", listener );
		
		return listener;
		
	}
}
