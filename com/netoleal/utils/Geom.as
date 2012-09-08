
class com.netoleal.utils.Geom {
	
	public static function toRadians(v:Number):Number{
		return v / 180 * Math.PI;
	}
	
	public static function toDegrees(v:Number):Number{
		return v * 180 / Math.PI;
	}
}