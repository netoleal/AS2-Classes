import flash.display.BitmapData;
import com.netoleal.utils.Geom;
import flash.geom.Rectangle;

class com.netoleal.drawing.PixelDrawing {
	
	//Passed by constructor
	private var _target:MovieClip;
	private var _depth:Number;
	private var _width:Number;
	private var _height:Number;
	
	//Utils
	private var bmp:BitmapData;
	private var mcBmp:MovieClip;
	
	private var px:Number;
	private var py:Number;
	
	//Setted by public methods
	private var lineColor:Number = 0xFF000000;
	private var lineThickness:Number = 1;
	private var eraserThickness:Number = 1;
	private var eraserWidth:Number = 1;
	private var eraserHeight:Number = 1;
	
	/**
	* Constructor
	* 
	* @param	targetToBitmap - MovieClip that will receive a bitmap
	* @param	depth - Depth of Bitmap inside targetToBitmap
	*/
	function PixelDrawing ( targetToBitmap:MovieClip, width:Number, height:Number, depth:Number ) {
		
		if( targetToBitmap == undefined || targetToBitmap == null ){
			trace( "[PixelDrawing] WARNING: targetToBitmap not informed of undefined" );
		}
		
		this._width = width;
		this._height = height;
		
		this._target = targetToBitmap;
		this._depth = depth || targetToBitmap.getNextHighestDepth( );
		
		this.init( );
	}
	
	public function get width( ):Number {
		return this._width;
	}
	
	public function get height( ):Number {
		return this._height;
	}
	
	private function init( ):Void {
		
		this.mcBmp = this._target.createEmptyMovieClip( "$_dpi_AT_" + getTimer( ), this._depth );
		this.bmp = new BitmapData( this._width, this._height, true, 0xFFFFFFFF );
		this.mcBmp.attachBitmap( bmp, 1 );
		this.mcBmp.blendMode = "multiply";
		
		this.moveTo( 0, 0 );
		
	}
	
	/**
	* Configure eraser thickness
	* 
	* @param	value
	*/
	public function setEraserThickness( value:Number ):Void {
		this.eraserThickness = value;
	}
	
	/**
	* Erase an area 
	* 
	* @param	x
	* @param	y
	*/
	public function erase( x:Number, y:Number ):Void {
		this.bmp.fillRect( new Rectangle( x, y, this.eraserThickness, this.eraserThickness ), 0x0 );
		
		this.px = x;
		this.py = y;
	}
	
	/**
	* Set line Style
	* 
	* @param	thickness
	* @param	color
	*/
	public function lineStyle( thickness:Number, colorARGB:Number ):Void {
		this.lineColor = colorARGB;
		this.lineThickness = thickness;
	}
	
	/**
	* Move the brush to x, y position
	* 
	* @param	x
	* @param	y
	*/
	public function moveTo( x:Number, y:Number ):Void {
		this.px = x;
		this.py = y;
	}
	
	/**
	* Draw a line to x, y coordinates
	* 
	* @param	x
	* @param	y
	*/
	public function lineTo( x:Number, y:Number ):Void {
		var radius:Number = Math.sqrt( Math.pow( this.px - x, 2 ) + Math.pow( this.py - y, 2 ) );
		var angle:Number = Math.atan2( this.py - y, this.px - x );
		
		var cx:Number;
		var cy:Number;
		
		var rThick:Number = this.lineThickness / 2;
		var r:Number = 0;
		
		while( 0 <= radius-- ){
			
			cx = this.px + ( Math.cos( angle ) * radius );
			cy = this.py + ( Math.sin( angle ) * radius );
			
			if( this.lineThickness > 1 ){
				this.bmp.fillRect( new Rectangle( cx, cy, this.lineThickness, this.lineThickness ), this.lineColor );
			} else {
				this.bmp.setPixel( cx, cy, this.lineColor );
			}
			
		}
		
		this.px = x;
		this.py = y;
	}
	
	public function toString( ):String {
		return "[com.netoleal.drawing.PixelDrawing]";
	}
	
}
