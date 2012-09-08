import mx.transitions.OnEnterFrameBeacon;
import com.xfactorstudio.xml.xpath.types.Func;

class com.netoleal.timeline.TimelineControl {
	
	public var onFrame:Function;
	public var onReach:Function;
	public var onFirstFrame:Function;
	public var onLastFrame:Function;
	
	private var mc:MovieClip;
		
	private var targetFrame:Number;
	private var onEnterFrame:Function;
	
	private var isOnFirstFrame:Boolean;
	private var isOnLastFrame:Boolean;
	private var isOnTargetFrame:Boolean;
	
	private var loopFrom:Number;
	private var loopTo:Number;
	
	private var looping:Boolean;
	private var yoyo:Boolean;
	private var _frame:Number = 0;
	
	private var frameFunctions:Object;
	
	private var speed:Number;
	
	/**
	* Contructor
	* 
	* @param	mcToControl - MovieClip instance to control
	* @param	speed - A speed factor to use in animations
	*/
	function TimelineControl( mcToControl:MovieClip, speed:Number ) {
		
		if( mcToControl == undefined ){
			trace( "[TimelineControl] >> ERROR - mcToControl not specified!" );
			return;
		}
		
		//trace( mcToControl );
		
		this.mc = mcToControl;
		OnEnterFrameBeacon.init( );
		_global.MovieClip.addListener( this );
		
		if(speed) {
			this.speed = speed;
		} else {
			this.speed = 1;
		}
		
		this.frameFunctions = new Object;
		this.onEnterFrame = this.enterFrame;
	}
	
	/**
	* Add a function to be fired at a frame
	* 
	* @param	frameNumber Number of the frame
	* @param	frameFunction Function to be executed
	* @param	scope Function scope
	* @param	args Arguments for function execution if needed
	* @param	removeAfterExec Define if function should be removed after execution
	*/
	public function addFrameFunction( frameNumber:Number, frameFunction:Function, scope:Object, args:Array, removeAfterExec:Boolean ):Void {
		if( this.frameFunctions[ frameNumber ] == undefined ) {
			this.frameFunctions[ frameNumber ] = new Array();
		}
			
		this.frameFunctions[ frameNumber ].push( { frameFunction: frameFunction, scope: scope, args: args, removeAfterExec : removeAfterExec } );
	}
	
	/**
	* Add a function to be fired just one time at a frame
	* 
	* @param	frameNumber Number of the frame
	* @param	frameFunction Function to be executed
	* @param	scope Function scope
	* @param	args Arguments for function execution if needed
	*/
	/**
	* @author Fernando Kreigne
	* @since 12/08/2007
	*/
	public function addOneTimedFrameFunction( frameNumber:Number, frameFunction:Function, scope:Object, args:Array ):Void {
		this.addFrameFunction( frameNumber, frameFunction, scope, args, true );
	}
	
	/**
	* Stop calling a function at a frame
	* 
	* @param	frameNumber
	* @param	frameFunction Optional
	*/
	public function removeFrameFunction( frameNumber:Number, frameFunction:Function ):Void {

		if( this.frameFunctions[ frameNumber ] != undefined ) {
			//trace( "[TimeLineControl] I will remove a function from frame " + frameNumber + ", ok?" );
			var fnReg:Object;
			
			for(var n = 0, t = this.frameFunctions[ frameNumber ].length; n < t; n++ ){
				fnReg = this.frameFunctions[ frameNumber ][ n ];
				
				if( fnReg.frameFunction == frameFunction || frameFunction == undefined ){
					this.frameFunctions[ frameNumber ].splice( n , 1 );
				}
			}
		}
		
	}
	
	/**
	* Stop calling a specific function or all functions at all frames
	* 
	* @param	frameFunction Optional
	*/
	public function removeAllFramesFunction( frameFunction:Function ):Void {
		var currentFrameFunctions:Array;
		
		for( var frameName:String in this.frameFunctions ) {
			//trace( "[TimeLineControl] I will remove all functions from frame " + frameName + ", ok?" );
			if( frameName != undefined ) {
				//trace( "[TimeLineControl] Really removing all functions from frame " + frameName + "!" );
				
				currentFrameFunctions = this.frameFunctions[ frameName ];
				
				var fnReg:Function;
			
				for(var n = 0, t = currentFrameFunctions.length; n < t; n++ ){
					//trace( "[TimeLineControl] There goes " + currentFrameFunctions.length + " functions from frame " + frameName + "..." );
					fnReg = currentFrameFunctions[ n ];
					
					if( fnReg.frameFunction == frameFunction || frameFunction == undefined ){
						this.removeFrameFunction( Number( frameName ), fnReg );
					}
				}
			}
		}
		
	}
	
	/**
	* Animate the timeline with a specifc range. 
	* If frames are omitted, the loop will be between 1 and totalFrames
	* 
	* @param	fromFrame start frame to loop
	* @param	toFrame end frame to loop
	*/
	public function loop( fromFrame:Number, toFrame:Number, isYoyo:Boolean ):Void {
		
		this.isOnFirstFrame = false;
		this.isOnLastFrame = false;
		this.isOnTargetFrame = false;
				
		this.loopFrom = (fromFrame == undefined || fromFrame == null )? 1 : fromFrame;
		this.loopTo = ( toFrame == undefined || toFrame == null )? this.mc._totalframes : toFrame;
		this.yoyo = ( isYoyo == undefined || isYoyo == false )? false: true;
		
		this.gotoAndStop( loopFrom );
		this.looping = true;
		this.targetFrame = loopTo;
		
	}
	
	/**
	* Same functionality of gotoAndPlay method from MovieClip class
	* 
	* @param	frame frame to start playing
	*/
	public function gotoAndPlay( frame:Object ):Void {
		this.isOnFirstFrame = false;
		this.isOnLastFrame = false;
		this.isOnTargetFrame = false;
		
		this.looping = false;
		this.mc.gotoAndPlay( frame );
		
	}
	
	/**
	* Same functionality of gotoAndStop method from MovieClip class
	* 
	* @param	frame frame to jump to and stop
	*/
	public function gotoAndStop( frame:Object ):Void {
		this.isOnFirstFrame = false;
		this.isOnLastFrame = false;
		this.isOnTargetFrame = false;
		
		this.looping = false;
		this.targetFrame = null;
		this.mc.gotoAndStop( frame );
		
	}
	
	/**
	* Stop timeline animation
	* 
	* @param	none
	*/
	public function stop( Void ):Void {
		
		this.looping = false;
		this.targetFrame = null;
		this.mc.stop( );
		
	}
	
	/**
	* Play timeline animation normally
	* 
	* @param	none
	*/
	public function play( Void ):Void {
		this.isOnFirstFrame = false;
		this.isOnLastFrame = false;
		this.isOnTargetFrame = false;
		
		this.looping = false;
		this.mc.play( );
	}
		
	/**
	* Return the timeline MovieClip
	* 
	* @return
	*/
	public function get targetMovieClip( ):MovieClip {
		return this.mc;
	}
	
	/**
	* Play backwards the timeline to a frame.
	* 
	*/
	public function playBackwards( ):Void {
		
		this.animateToFrame( 1 );
		
	}
	
	/**
	* Goto a specific frame animating.
	* 
	* @param	number
	*/
	public function animateToFrame( number:Number , callback:Function, scope:Object, args:Array):Void {
		this.isOnFirstFrame = false;
		this.isOnLastFrame = false;
		this.isOnTargetFrame = false;
		
		this.looping = false;
		this.mc.stop( );
		this.targetFrame = number;
		
		if(callback) {
			this.addFrameFunction(number, callback, scope, args, true);
		}
	}
	
	/**
	* Returns the current frame of timeline
	* 
	* @return
	*/
	public function get _currentframe( ):Number {
		return this.mc._currentframe;
	}
	
	/**
	* Returns total frame of timeline
	* 
	* @return
	*/
	public function get _totalframes( ):Number {
		return this.mc._totalframes;
	}
	
	/**
	* Return the speed
	* 
	* @return
	*/
	public function get _speed():Number {
		return this.speed;
	}
	
	/**
	* Set speed. 
	* Exemple: If you set _speed = 2, the timeline will run twice faster.
	* 
	* @param	speed
	*/
	public function set _speed(speed:Number):Void {
		this.speed = Math.ceil(speed);
	}
	
	/**
	* Handle for enterFrame
	* 
	* @param	Void
	*/
	private function enterFrame( Void ):Void {
		
		if( this._frame != this._currentframe ){
			this._frame = this._currentframe;
			this.onFrame( this._frame );
			
			this.execFrameFunction(this._currentframe);
		}
		
		if( this.targetFrame != null ) {
			var factor:Number = ( this.targetFrame > this.mc._currentframe )? this.speed : -(this.speed);
			
			/**
			* @author Fernando Kreigne
			* @since 26/05/2007
			*/
			// adjusts the factor (speed)
			if(factor > 0) {
				if((this.mc._currentframe + factor) > this.targetFrame) {
					factor = (this.targetFrame - this.mc._currentframe);
				}
			} else {
				if((this.mc._currentframe + factor) < this.targetFrame) {
					factor = (this.targetFrame - this.mc._currentframe);
				}
			}
			
			if( this.mc._currentFrame != this.targetFrame ){
				this.isOnTargetFrame = false;
				this.mc.gotoAndStop( this.mc._currentframe + factor );
			}
			
			if( this.mc._currentFrame == this.targetFrame ){
				if( !this.isOnTargetFrame ){
					this.onReach( this.mc._currentframe );
					this.isOnTargetFrame = true;
					this.targetFrame = null;
				}	
				if( this.looping ){
					
					if( !this.yoyo ){
						
						this.gotoAndStop( this.loopFrom );
						this.looping = true;
						this.targetFrame = this.loopTo;
						
					} else {
						
						this.targetFrame = ( this._currentframe == this.loopFrom )? this.loopTo: this.loopFrom;
						
					}
				}
			}	
		}
		
		//Check if is on first frame
		if( this.mc._currentframe == 1 ) {
			if( !this.isOnFirstFrame ){
				this.onFirstFrame( );
				this.isOnFirstFrame = true;
			}
		} else {
			this.isOnFirstFrame = false;
		}
		
		//Check if is on last frame
		if( this.mc._currentframe == this.mc._totalframes ){
			if( !this.isOnLastFrame ){
				this.onLastFrame( );
				this.isOnLastFrame = true;
			}
		} else {
			this.isOnLastFrame = false;
		}
		
	}
	
	/**
	* Exec functions of desired frame
	* @param	frameNumber	desired frame
	* @param	removeAfterExec	remove functions from frame after exec
	*/
	public function execFrameFunction( frameNumber:Number , removeAfterExec:Boolean ) {
		removeAfterExec = removeAfterExec || false;
		
		var fnReg:Object;
		
		if( !this.frameFunctions[ frameNumber ].length ) return;
		
		for(var n = 0, t = this.frameFunctions[ frameNumber ].length; n < t; n++ ){
			fnReg = this.frameFunctions[ frameNumber ][ n ];
			fnReg.frameFunction.apply( fnReg.scope, fnReg.args );
			
			/**
			* @author Fernando Kreigne
			* @since 12/08/2007
			*/
			if( fnReg.removeAfterExec ) {
				this.removeFrameFunction( frameNumber, fnReg.frameFunction );
			}
		}
		
		if( removeAfterExec ) {
			this.frameFunctions[ frameNumber ] = new Array;
		}
	}
}
