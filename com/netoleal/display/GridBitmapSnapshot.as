import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;

class com.netoleal.display.GridBitmapSnapshot {
	private var source:MovieClip;
	
	private var console:Function;
	private var className:String = "GridBitmapSnapshot";
	
	function GridBitmapSnapshot( sourceMovieClip:MovieClip ) {
		this.source = sourceMovieClip;
	}
	
	/**
	* Takes a bitmap snapshot from sourceMovieClip by slicing on lines and columns.
	* 
	* @param	container the MovieClip instance that will receive the created MovieClips
	* @param	lines number of lines
	* @param	columns number of columns
	* @param	[startDepth] Initial depth for MovieClips. Default is getNextHighestDepth( ) of container
	* @param	[renderFunction] Function to be called on each MovieClip creation
	*/
	public function takeSnapshot( container:MovieClip, lines:Number, columns:Number, startDepth:Number, renderFunction:Function ):Void{
		
		if( startDepth == undefined || startDepth == null ) startDepth = container.getNextHighestDepth( );
		
		var l:Number; //line
		var c:Number; //column
		
		var matrix:Matrix;
		var rect:Rectangle;
		var bmp:BitmapData;
		var color:ColorTransform;
		
		var depth:Number = startDepth;
		var mc:MovieClip;
		
		var colW:Number = Math.round( this.source._width / columns );
		var linH:Number = Math.round( this.source._height / lines );
		
		for( l = 0; l < lines; l++ ){
			for( c = 0; c < columns; c++ ){
				
				matrix = new Matrix( );
				matrix.translate( - ( c * colW ), - ( l * linH ) );
				
				rect = new Rectangle( 0, 0, colW, linH );
				
				bmp = new BitmapData( colW, linH, true, 0x000000 );
				bmp.draw( this.source, matrix, color, 1, rect, false );
				
				mc = container.createEmptyMovieClip( "_snapshot_cell_line" + l + "_col" + c, depth++ );
				mc._x = c * colW;
				mc._y = l * linH;
				
				mc.attachBitmap( bmp, 1 );
				
				renderFunction( mc, l, c, bmp );
			}
		}
	}
}