
class com.netoleal.fms.NetConnectionStatus {
	
	/**
	* The connection attempt succeeded.
	*/
	public static var STATUSCODE_SUCCESS		:String = "NetConnection.Connect.Success";
	
	/**
	* The client does not have permission to connect to the application, or the application 
	* expected different parameters from those that were passed, or the application specifically rejected the client.
	* 
	* This information object also has an application property, which contains the value returned by the 
	* application.rejectConnection() server-side method.
	*/
	public static var STATUSCODE_REJECTED		:String = "NetConnection.Connect.Rejected";
	
	/**
	* The application name specified during the connection attempt was not found on the server.
	*/
	public static var STATUSCODE_INVALID_APP	:String = "NetConnection.Connect.InvalidApp";
	
	/**
	* The connection attempt failed; for example, the server is not running.
	*/
	public static var STATUSCODE_FAILED			:String = "NetConnection.Connect.Failed";
	
	/**
	* The connection was successfully closed.
	*/
	public static var STATUSCODE_CLOSED			:String = "NetConnection.Connect.Closed";
	
	/**
	* The application has been shut down (for example, if the application is out of memory resources and must be 
	* shut down to prevent the server from crashing) or the server has been shut down.
	*/
	public static var STATUSCODE_APP_SHUTDOWN	:String = "NetConnection.Connect.AppShutdown";
	
	/**
	* The NetConnection.call () method was not able to invoke the server-side method or command.*
	*/
	public static var STATUSCODE_CALL_FAILED	:String = "NetConnection.Call.Failed";
	
	
	/**
	* Represents a status change
	*/
	public static var STATUSLEVEL_STATUS		:String = "status";
	
	/**
	* Represents an error
	*/
	public static var STATUSLEVEL_ERROR			:String = "error";
	
	public var description:String;
	public var code:String;
	public var level:String;
	
}
