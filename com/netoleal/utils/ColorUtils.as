
class com.netoleal.utils.ColorUtils {
	
	/**
	* Method from com.nybras.colibri.Tween
	* 
	* @param	rgb
	* @return
	*/
	public static function rgb2hex (rgb:Array):Number {
		return (rgb[0] << 16 | rgb[1] << 8 | rgb[2]);
	}
	
	/**
	* Method from com.nybras.colibri.Tween
	* 
	* @param	hex
	* @return
	*/
	public static function hex2rgb (hex:Number):Array {
		return new Array(
			(hex >> 16),
			(hex >> 8 & 0xFF),
			(hex & 0xFF)
		);
	}
}
