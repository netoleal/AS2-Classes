
class com.netoleal.utils.ClassUtils {
	/**
	* Copy a class prototype to another object instance
	* 
	* @param	OriginalClass Class containing members to be copied to target
	* @param 	targetObject an object to receive members from OriginalClass
	*/
	public static function copyPrototype( OriginalClass:Function, targetObject:Object, showWarnings:Boolean ):Void {
		var proto:Object = OriginalClass.prototype;
		
		_global.ASSetPropFlags( proto, null, 6, true );
		
		for( var p in proto ) {
			if( p != "__constructor__" && p != "__proto__" && p != "constructor" ) {
				if( targetObject.__proto__[ p ] != undefined && showWarnings ) {
					trace( "[ClassUtils] !!WARNING!! member '" + p + "' in " + targetObject + " OVERRIDED by ClassUtils.copyPrototype" );
				}
				targetObject.__proto__[ p ] = proto[ p ];
			}
		}
		
		_global.ASSetPropFlags( proto, null, 0, true );
	}
	
	/**
	* Copy a class members to another object instance
	* 
	* @param	OriginalClass Class containing members to be copied to target
	* @param 	targetObject an object to receive members from OriginalClass
	*/
	public static function copyMembers( OriginalClass:Function, targetObject:Object, showWarnings:Boolean ):Void {
		var proto:Object = OriginalClass.prototype;
		
		_global.ASSetPropFlags( proto, null, 6, true );
		
		for( var p in proto ) {
			if( p != "__constructor__" && p != "__proto__" && p != "constructor" ) {
				if( targetObject[ p ] != undefined && showWarnings ) {
					trace( "[ClassUtils] !!WARNING!! member '" + p + "' in " + targetObject + " OVERRIDED by ClassUtils.copyMembers" );
				}
				targetObject[ p ] = proto[ p ];
			}
		}
		
		_global.ASSetPropFlags( proto, null, 0, true );
	}
}
