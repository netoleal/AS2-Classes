
class com.netoleal.utils.StringUtils
{
	function StringUtils()
	{
		
	}
	
	public static function leftZero( num:Number, charCount:Number ):String {
		var charDif:Number = charCount - String( num ).length;
		if( charDif <= 0 ) return String( num );
		
		return String( Math.pow( 10, charDif ) ).substr( 1 ) + num;
	}
	
	public static function isUpperCase( theText:String ):Boolean {
		var n:Number;
		var t:Number = theText.length;
		for( n = 0; n < t; n++ ){
			if( theText.charAt( n ) != theText.charAt( n ).toUpperCase( ) ){
				return false;
			}
		}
		
		return true;
	}
	
	/**
	* Format an url as absolute format like "http://www.domain.com"
	* 
	* @param	theURL URL to be formatted
	* @param	protocolPrefix Optional parameter. Prefix to be used before url. Default if "http://"
	* @return The formatted url
	*/
	public static function absoluteURLFormat( theURL:String, protocolPrefix:String ):String {
		var prefixs:Array = [ "http://", "https://", "ftp://" ];
		var n:Number;
		var t:Number = prefixs.length;
		var prefix:String;
		
		protocolPrefix = ( protocolPrefix == null || protocolPrefix == undefined || protocolPrefix == "" )? "http://": protocolPrefix;
		theURL = trim( theURL );
		
		for( n = 0; n < t; n++ ){
			prefix = prefixs[ n ];
			if( theURL.substr( 0, prefix.length ).toLowerCase( ) == prefix ){
				return theURL;
			}
		}
		
		return protocolPrefix + theURL;
	}
	
	/**
	* Format an url as basic url format like "www.domain.com"
	* 
	* @param	theURL
	* @return
	*/
	public static function basicURLFormat( theURL:String ):String {
		var ar:Array = theURL.split( "//" );
		if( ar.length > 1 ){
			ar.shift( );
			return ar.join( "//" );
		} else {
			return theURL;
		}
	}
	
	public static function isLowerCase( theText:String ):Boolean {
		var n:Number;
		var t:Number = theText.length;
		for( n = 0; n < t; n++ ){
			if( theText.charAt( n ) != theText.charAt( n ).toLowerCase( ) ){
				return false;
			}
		}
		
		return true;
	}
	
	public static function trim( theText:String ):String {
		return rightTrim( leftTrim( theText ) );
	}

	public static function leftTrim( theText:String ):String {
		var l:Number = 0;
		while( checkSpace( theText.charAt( l ) ) ) l++;
		return theText.substr( l );
	}

	public static function rightTrim( theText:String ):String {
		var r:Number = theText.length - 1;
		while( checkSpace( theText.charAt( r ) ) ) r--;
		return theText.substring( 0, r + 1);
	}
	
	private static function checkSpace( char:String ):Boolean {
		return char == " " || char == "\t" || char == "\n";
	}
}
