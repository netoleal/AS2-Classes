
class com.netoleal.fms.NetStreamStatus
{
	/**
	* Data is not being received quickly enough to fill the buffer. Data flow is interrupted until the buffer refills, 
	* at which time a NetStream.Buffer.Full message is sent and the stream begins playing again.
	*/
	public static var BUFFER_EMPTY:String = "NetStream.Buffer.Empty";
	
	/**
	* The buffer is full and the stream begins playing.
	*/
	public static var BUFFER_FULL:String = "NetStream.Buffer.Full";
	
	/**
	* An error has occurred for a reason other than those listed elsewhere in this table, 
	* such as the subscriber trying to use the seek command to move to a particular location in the 
	* recorded stream, but with invalid parameters.
	* 
	* This information object also has a description property, which is a string that provides a more 
	* specific reason for the failure.
	*/
	public static var FAILED:String = "NetStream.Failed";
	
	/**
	* The subscriber has paused playback.
	*/
	public static var PAUSE_NOTIFY:String = "NetStream.Pause.Notify";
	
	/**
	* Playback has completed.
	*/
	public static var PLAY_COMPLETE:String = "NetStream.Play.Complete";
	
	/**
	* An error has occurred in playback for a reason other than those listed elsewhere in this table, 
	* such as the subscriber not having read access.
	*/
	public static var PLAY_FAILED:String = "NetStream.Play.Failed";
	
	/**
	* Data is playing behind the normal speed.
	*/
	public static var PLAY_INSUFFICIENT_BW:String = "NetStream.Play.InsufficientBW";
	
	/**
	* Publishing has begun; this message is sent to all subscribers.
	*/
	public static var PLAY_PUBLISH_NOTIFY:String = "NetStream.Play.InsufficientBW";
	
	/**
	* The playlist has reset (pending play commands have been flushed).
	*/
	public static var PLAY_RESET:String = "NetStream.Play.Reset";
	
	/**
	* Playback has started.
	*/
	public static var PLAY_START:String = "NetStream.Play.Start";
	
	/**
	* Playback has stopped.
	*/
	public static var PLAY_STOP:String = "NetStream.Play.Stop";
	
	/**
	* The client tried to play a live or recorded stream that does not exist.
	*/
	public static var PLAY_STREAM_NOT_FOUND:String = "NetStream.Play.StreamNotFound";
	
	/**
	* The subscriber is switching from one stream to another in a playlist.
	*/
	public static var PLAY_SWITCH:String = "NetStream.Play.Switch";
	
	/**
	* Publishing has stopped; this message is sent to all subscribers.
	*/
	public static var PLAY_UNPUBLISH_NOTIFY:String = "NetStream.Play.UnpublishNotify";
	
	/**
	* The client tried to publish a stream that is already being published by someone else.
	*/
	public static var PUBLISH_BAD_NAME:String = "NetStream.Publish.BadName";
	
	/**
	* The publisher of the stream has been idling for too long.
	*/
	public static var PUBLISH_IDLE:String = "NetStream.Publish.Idle";
	
	/**
	* Publishing has started.
	*/
	public static var PUBLISH_START:String = "NetStream.Publish.Start";
	
	/**
	* An error has occurred in recording for a reason other than those listed elsewhere in this table; 
	* for example, the disk is full
	*/
	public static var RECORD_FAILED:String = "NetStream.Record.Failed";
	
	/**
	* The client tried to record a stream that is still playing, or the client tried to record (overwrite) 
	* a stream that already exists on the server with read-only status.
	*/
	public static var RECORD_NOACCESS:String = "NetStream.Record.NoAccess";
	
	/**
	* Recording has started.
	*/
	public static var RECORD_START:String = "NetStream.Record.Start";
	
	/**
	* Recording has stopped.
	*/
	public static var RECORD_STOP:String = "NetStream.Record.Stop";
	
	/**
	* The subscriber tried to use the seek command to move to a particular location in 
	* the recorded stream, but failed.
	*/
	public static var SEEK_FAILED:String = "NetStream.Seek.Failed";
	
	/**
	* The subscriber has used the seek command to move to a particular location in the recorded stream.
	*/
	public static var SEEK_NOTIFY:String = "NetStream.Seek.Notify";
	
	/**
	* The subscriber has resumed playback.
	*/
	public static var UNPAUSE_NOTIFY:String = "NetStream.Unpause.Notify";
	
	/**
	* Publishing has stopped.
	*/
	public static var UNPUBLISH_SUCCESS:String = "NetStream.Unpublish.Success";
	
	
	/**
	* Represents a status change
	*/
	public static var STATUSLEVEL_STATUS		:String = "status";
	
	/**
	* Represents an error
	*/
	public static var STATUSLEVEL_ERROR			:String = "error";
	
	/**
	* Represents a warning
	*/
	public static var STATUSLEVEL_WARNING		:String = "warning";
	
	public var description:String;
	public var code:String;
	public var level:String;
}
