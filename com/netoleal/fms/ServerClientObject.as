
class com.netoleal.fms.ServerClientObject {
	
	/**
	* A list of access levels to which the client has write access.
	*/
	public var writeAccess:String;
	
	/**
	* The user agent type of the client (which is typically the Flash Player version), but may be set to any legal key value.
	*/
	public var virtualKey:String; 
	
	/**
	* Read-only; the URI specified by the client to connect to this application instance.
	*/
	public var uri:String;
	
	/**
	* Read-only; a Boolean value indicating whether an Internet connection is secure (true) or not (false).
	*/
	public var secure:String;
	
	/**
	* Read-only; the URL of the SWF file or server where this connection originated.
	*/
	public var referrer:String;
	
	/**
	* A list of access levels to which the client has read access.
	*/
	public var readAccess:String;
	
	/**
	* Read-only; the protocol used by the client to connect to the server.
	*/
	public var protocol:String;
	
	
	public var pageUrl:String;
	
	/**
	* Read-only; the IP address of the Flash client.
	*/
	public var ip: String;
	
	/**
	* Read-only; the version and platform of the Flash client.
	*/
	public var agent: String;
	
}
