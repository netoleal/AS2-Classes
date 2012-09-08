class com.netoleal.core.Assets {
	
	private static var _listeners:Array;
	
	public static var addListener:Function;
	public static var removeListener:Function;
	public static var broadcastMessage:Function;
	
	public static var instances:Object;
	private static var initialized:Boolean;
	
	
	
	/**
	* There's no constructor (static class)
	* 
	**/
	function Assets() {
		throw new Error ("Assets is a static class and should not be instantiated.");
	}
	
	
	
	/**
	* Initializes the Module
	* 
	*/
	public static function init (force:Boolean):Void  {
		if(!Assets.initialized || force) {
			trace ("[Assets] init();");
			
			Assets.instances = new Object;
			Assets.initialized = true;
		}
	}
	
	
	
	/**
	* Returns the instance by it's key
	* 
	* @param	key
	* @return
	* 
	*/
	public static function getInstance (key:String):Object {
		return Assets.instances[key];
	}
	
	
	
	/**
	* Adds a new instance, following the given key and value
	* 
	* @param	key
	* @param	value
	*/
	public static function addInstance (key:String, value:Object):Void {
		Assets.instances[key] = value;
	}
	
	
	
	/**
	* Remove the intance according the given key
	* 
	* @param	key
	*/
	public static function removeInstance (key:String):Void  {
		delete Assets.instances[key];
	}
	
	
	
	/**
	* Add some MoviClip (library linked) to some instance with options to set
	* it as a new instance, also including the initialization of the item
	* 
	* @param	idLinkage
	* @param	newInstanceKey
	* @param	targetInstanceKey
	* @param	data {
	* 				name:String,
	* 				depth:Number,
	* 				init:Object
	* 			}
	*/
	public static function addLinkedInstance (idLinkage:String, newInstanceKey:String, targetInstanceKey:String, extendClass:Function, data:Object):Object  {
		var target_mc:Object;
		var name:String;
		var depth:Number;
		var message:String;
		var added:MovieClip;
		
		target_mc = Assets.getInstance(targetInstanceKey);
		if (typeof(target_mc) != "movieclip") {
			message += "\r\r!!! WARNING !!!\r";
			message += "[Assets.addLinkedInstance()]:\r";
			message += "The given `targetInstanceKey` ("+ targetInstanceKey +") should ";
			message += "be a refference for a MovieClip instance item.\r\r";
			trace(message);
		}
		
		if (extendClass instanceof Function) {
			Object.registerClass(idLinkage, extendClass);
		}
		
		depth = (isNaN(data.depth) ? target_mc.getNextHighestDepth() : data.depth);
		name = (data.name == undefined ? (newInstanceKey +"_AT_"+ targetInstanceKey) : data.name);
		
		added = target_mc.attachMovie(idLinkage, name, depth, data.init);
		Assets.addInstance(newInstanceKey, added);
		
		return Assets.getInstance(newInstanceKey);
	}
	
}
